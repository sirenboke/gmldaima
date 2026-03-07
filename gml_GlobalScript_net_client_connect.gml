self.net_client_connect = function()
{
    global.clientSocket = network_create_socket(network_socket_tcp);
    global.serverIp = argument[0];
    global.clientConnected = network_connect_async(global.clientSocket, global.serverIp, argument[1]);
    global.buffer = buffer_create(1, buffer_grow, 1);
};
