import socket
import threading
import logging
import time
from typing import Dict, Optional, Set

logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s - %(levelname)s - %(message)s",
)
logger = logging.getLogger(__name__)


class IRCClient:
    """Tracks connection state for a single connected IRC client."""

    def __init__(self, conn: socket.socket, addr):
        self.conn = conn
        self.addr = addr
        self.nick: Optional[str] = None
        self.user: Optional[str] = None
        self.password: Optional[str] = None
        self.channels: Set[str] = set()
        self.registered: bool = False
        self.buffer: str = ""

    def send(self, message: str) -> None:
        """Send an IRC message line to the client (appends CRLF)."""
        try:
            self.conn.sendall((message + "\r\n").encode("utf-8"))
            logger.debug("Sent to %s: %s", self.nick or self.addr, message)
        except OSError as exc:
            logger.error("Error sending to %s: %s", self.nick or self.addr, exc)


class IRCServer:
    """
    A complete IRC server for GameMaker game clients.

    Implements the IRC handshake (PASS / NICK / USER), standard welcome
    messages (001–004, MOTD), JOIN, PRIVMSG broadcast, and PING/PONG
    heartbeat as required by RFC 1459.
    """

    SERVER_NAME = "irc.local"
    SERVER_VERSION = "0.4"

    # Named constants for magic numbers
    _LISTEN_BACKLOG = 50
    _RECV_BUFFER_SIZE = 4096

    def __init__(
        self,
        host: str = "0.0.0.0",
        port: int = 6667,
        ping_interval: int = 60,
    ) -> None:
        # ping_interval: seconds between server-initiated PINGs
        self.host = host
        self.port = port
        self.ping_interval = ping_interval
        self._lock = threading.Lock()
        self._clients: Dict[socket.socket, IRCClient] = {}
        self._nick_map: Dict[str, IRCClient] = {}
        self._channels: Dict[str, Set[str]] = {}  # channel -> set of nicks
        self.running = False

    # ------------------------------------------------------------------
    # Server lifecycle
    # ------------------------------------------------------------------

    def start(self) -> None:
        """Bind and listen; blocks until *self.running* is set to False."""
        self.running = True
        server_sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        server_sock.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
        server_sock.bind((self.host, self.port))
        server_sock.listen(self._LISTEN_BACKLOG)
        server_sock.settimeout(1.0)
        logger.info("IRC server listening on %s:%d", self.host, self.port)

        ping_thread = threading.Thread(
            target=self._ping_loop, daemon=True, name="ping-loop"
        )
        ping_thread.start()

        try:
            while self.running:
                try:
                    conn, addr = server_sock.accept()
                except socket.timeout:
                    continue
                except OSError:
                    if self.running:
                        raise
                    break

                client = IRCClient(conn, addr)
                with self._lock:
                    self._clients[conn] = client
                logger.info("New connection from %s", addr)

                t = threading.Thread(
                    target=self._handle_client,
                    args=(client,),
                    daemon=True,
                    name=f"client-{addr}",
                )
                t.start()
        finally:
            server_sock.close()
            logger.info("IRC server stopped")

    def stop(self) -> None:
        """Signal the server to stop accepting connections."""
        self.running = False

    # ------------------------------------------------------------------
    # Per-client I/O loop
    # ------------------------------------------------------------------

    def _handle_client(self, client: IRCClient) -> None:
        """Receive raw bytes, split on newlines, and dispatch each command."""
        try:
            while self.running:
                try:
                    data = client.conn.recv(self._RECV_BUFFER_SIZE)
                except OSError:
                    break
                if not data:
                    break

                client.buffer += data.decode("utf-8", errors="replace")

                while "\n" in client.buffer:
                    line, client.buffer = client.buffer.split("\n", 1)
                    line = line.rstrip("\r")
                    if line:
                        self._dispatch(client, line)
        finally:
            self._disconnect_client(client)

    # ------------------------------------------------------------------
    # Command dispatcher
    # ------------------------------------------------------------------

    def _dispatch(self, client: IRCClient, raw: str) -> None:
        """Parse one IRC line and call the matching handler."""
        logger.info("From %s: %s", client.nick or client.addr, raw)

        parts = raw.split(" ", 2)
        command = parts[0].upper()

        handlers = {
            "PASS": self._handle_pass,
            "NICK": self._handle_nick,
            "USER": self._handle_user,
            "JOIN": self._handle_join,
            "PRIVMSG": self._handle_privmsg,
            "PING": self._handle_ping,
            "PONG": self._handle_pong,
            "QUIT": self._handle_quit,
        }

        handler = handlers.get(command)
        if handler:
            handler(client, raw, parts)
        else:
            logger.debug("Unhandled command from %s: %s", client.addr, command)

    # ------------------------------------------------------------------
    # Command handlers
    # ------------------------------------------------------------------

    def _handle_pass(
        self, client: IRCClient, _raw: str, parts: list
    ) -> None:
        """Store the password; no reply is required before NICK/USER."""
        # NOTE: The password is stored as plain text for protocol compatibility
        # only. This local development server does not enforce authentication.
        if len(parts) >= 2:
            client.password = parts[1]
            logger.info("PASS received from %s", client.addr)

    def _handle_nick(
        self, client: IRCClient, _raw: str, parts: list
    ) -> None:
        """Register or change a client's nickname."""
        if len(parts) < 2:
            client.send(
                f":{self.SERVER_NAME} 431 * :No nickname given"
            )
            return

        nick = parts[1]

        with self._lock:
            existing = self._nick_map.get(nick)
            if existing is not None and existing is not client:
                client.send(
                    f":{self.SERVER_NAME} 433 * {nick} "
                    ":Nickname is already in use"
                )
                return

            if client.nick and client.nick in self._nick_map:
                del self._nick_map[client.nick]

            client.nick = nick
            self._nick_map[nick] = client

        logger.info("Nick registered: %s (%s)", nick, client.addr)
        self._try_complete_registration(client)

    def _handle_user(
        self, client: IRCClient, _raw: str, parts: list
    ) -> None:
        """Handle the USER command; also attempts to complete registration."""
        if len(parts) >= 2:
            client.user = parts[1]
            logger.info(
                "USER received from %s: %s", client.addr, client.user
            )
        self._try_complete_registration(client)

    def _handle_join(
        self, client: IRCClient, _raw: str, parts: list
    ) -> None:
        """Add the client to one or more channels."""
        if not client.registered:
            client.send(f":{self.SERVER_NAME} 451 * :You have not registered")
            return
        if len(parts) < 2:
            client.send(
                f":{self.SERVER_NAME} 461 "
                f"{client.nick} JOIN :Not enough parameters"
            )
            return

        for channel_name in parts[1].split(","):
            if not channel_name.startswith("#"):
                channel_name = "#" + channel_name
            self._join_channel(client, channel_name)

    def _handle_privmsg(
        self, client: IRCClient, raw: str, parts: list
    ) -> None:
        """Forward a PRIVMSG to a channel or a specific nick."""
        if not client.registered:
            client.send(f":{self.SERVER_NAME} 451 * :You have not registered")
            return

        # Re-split so the trailing text is preserved intact.
        msg_parts = raw.split(" ", 2)
        if len(msg_parts) < 3:
            client.send(
                f":{self.SERVER_NAME} 411 {client.nick} "
                ":No recipient given (PRIVMSG)"
            )
            return

        target = msg_parts[1]
        text = msg_parts[2].lstrip(":")

        irc_line = (
            f":{client.nick}!{client.nick}@{self.SERVER_NAME}"
            f" PRIVMSG {target} :{text}"
        )

        if target.startswith("#"):
            self._broadcast_channel(target, irc_line, exclude=client)
        else:
            with self._lock:
                dest = self._nick_map.get(target)
            if dest:
                dest.send(irc_line)
            else:
                client.send(
                    f":{self.SERVER_NAME} 401 {client.nick} "
                    f"{target} :No such nick/channel"
                )

        logger.info(
            "PRIVMSG %s -> %s: %s", client.nick, target, text
        )

    def _handle_ping(
        self, client: IRCClient, _raw: str, parts: list
    ) -> None:
        """Respond to a client PING with a matching PONG."""
        token = parts[1] if len(parts) >= 2 else self.SERVER_NAME
        client.send(f":{self.SERVER_NAME} PONG {self.SERVER_NAME} :{token}")
        logger.info("PING->PONG exchange with %s", client.nick or client.addr)

    def _handle_pong(
        self, client: IRCClient, _raw: str, _parts: list
    ) -> None:
        """Acknowledge a PONG from the client (heartbeat reply)."""
        logger.info(
            "PONG received from %s", client.nick or client.addr
        )

    def _handle_quit(
        self, client: IRCClient, _raw: str, parts: list
    ) -> None:
        """Gracefully disconnect a client."""
        reason = parts[1].lstrip(":") if len(parts) >= 2 else "Client quit"
        logger.info(
            "%s quit: %s", client.nick or client.addr, reason
        )
        self._disconnect_client(client)

    # ------------------------------------------------------------------
    # Registration
    # ------------------------------------------------------------------

    def _try_complete_registration(self, client: IRCClient) -> None:
        """
        Send the welcome sequence once a client supplies a nickname.

        The game client only sends PASS + NICK (no USER), so registration
        is triggered as soon as a NICK is known.  A USER command will also
        trigger this path if the NICK was already set.
        """
        if client.registered or not client.nick:
            return
        client.registered = True
        self._send_welcome(client)

    def _send_welcome(self, client: IRCClient) -> None:
        """Emit the standard IRC welcome sequence (001–004 + MOTD)."""
        nick = client.nick
        srv = self.SERVER_NAME
        ver = self.SERVER_VERSION

        client.send(
            f":{srv} 001 {nick} "
            f":Welcome to the IRC Network {nick}!{nick}@{srv}"
        )
        client.send(
            f":{srv} 002 {nick} "
            f":Your host is {srv}, running version {ver}"
        )
        client.send(
            f":{srv} 003 {nick} "
            ":This server was created for local development"
        )
        client.send(
            f":{srv} 004 {nick} {srv} {ver} o o"
        )
        # MOTD
        client.send(f":{srv} 375 {nick} :- {srv} Message of the day -")
        client.send(f":{srv} 372 {nick} :- IRC server {ver} ready.")
        client.send(f":{srv} 376 {nick} :End of /MOTD command.")

        logger.info("Welcome sequence sent to %s", nick)

    # ------------------------------------------------------------------
    # Channel helpers
    # ------------------------------------------------------------------

    def _join_channel(self, client: IRCClient, channel: str) -> None:
        """Add *client* to *channel* and send the required JOIN replies."""
        with self._lock:
            if channel not in self._channels:
                self._channels[channel] = set()
            self._channels[channel].add(client.nick)
            client.channels.add(channel)
            names = " ".join(self._channels[channel])

        prefix = f":{client.nick}!{client.nick}@{self.SERVER_NAME}"
        client.send(f"{prefix} JOIN {channel}")

        # No topic set
        client.send(
            f":{self.SERVER_NAME} 331 {client.nick} {channel} :No topic is set"
        )
        # NAMES reply
        client.send(
            f":{self.SERVER_NAME} 353 {client.nick} = {channel} :{names}"
        )
        client.send(
            f":{self.SERVER_NAME} 366 {client.nick} {channel} "
            ":End of /NAMES list"
        )
        logger.info("%s joined %s", client.nick, channel)

    def _broadcast_channel(
        self,
        channel: str,
        message: str,
        exclude: Optional[IRCClient] = None,
    ) -> None:
        """Send *message* to every client in *channel* except *exclude*."""
        with self._lock:
            recipients = [
                self._nick_map[nick]
                for nick in self._channels.get(channel, set())
                if nick in self._nick_map
                and self._nick_map[nick] is not exclude
            ]
        for c in recipients:
            c.send(message)

    # ------------------------------------------------------------------
    # Heartbeat loop
    # ------------------------------------------------------------------

    def _ping_loop(self) -> None:
        """Periodically send PING to all registered clients."""
        while self.running:
            time.sleep(self.ping_interval)
            with self._lock:
                clients = list(self._clients.values())
            for client in clients:
                if client.registered:
                    try:
                        client.send(
                            f"PING :{self.SERVER_NAME}"
                        )
                        logger.debug("PING sent to %s", client.nick)
                    except OSError:
                        pass

    # ------------------------------------------------------------------
    # Cleanup
    # ------------------------------------------------------------------

    def _disconnect_client(self, client: IRCClient) -> None:
        """Remove a client from all internal state and close its socket."""
        with self._lock:
            if client.nick and client.nick in self._nick_map:
                del self._nick_map[client.nick]

            for channel in list(client.channels):
                nicks = self._channels.get(channel)
                if nicks is not None:
                    nicks.discard(client.nick)
                    if not nicks:
                        del self._channels[channel]

            self._clients.pop(client.conn, None)

        try:
            client.conn.close()
        except OSError:
            pass

        logger.info("Disconnected: %s (%s)", client.nick or "?", client.addr)


if __name__ == "__main__":
    server = IRCServer(host="0.0.0.0", port=6667)
    try:
        server.start()
    except KeyboardInterrupt:
        logger.info("Shutting down IRC server")
        server.stop()
