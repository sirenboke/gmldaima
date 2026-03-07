self.twitch_chat_connect = function(arg0, arg1, arg2)
{
    global.IRC_channel = "#" + string(arg0);
    global.IRC_name = arg1;
    global.IRC_oauth = arg2;
    
    if (ds_exists(global.Chat_list, ds_type_list))
        ds_list_clear(global.Chat_list);
    else
        global.Chat_list = gml_Script_scr_ds_list_create();
    
    if (global.IRC_socket == -1)
    {
        global.IRC_socket = network_create_socket_ext(0, 6667);
    }
    else
    {
        gml_Script_twitch_log("Failed to create new socket, socket already exists!");
        return -1;
    }
    
    if (global.IRC_socket < 0)
    {
        network_destroy(global.IRC_socket);
        global.IRC_socket = -1;
        gml_Script_twitch_log("Failed to create TCP socket");
        return -1;
    }
    else
    {
        gml_Script_twitch_log("TCP Socket created, attempting to connect...");
    }
    
    var address = network_resolve("irc.twitch.tv");
    gml_Script_twitch_log("Connecting to 'irc.twitch.tv' [" + string(address) + "]");
    var success = network_connect_raw(global.IRC_socket, "irc.twitch.tv", 6667);
    
    if (success < 0)
    {
        network_destroy(global.IRC_socket);
        global.IRC_socket = -1;
        gml_Script_twitch_log("Failed to connect to " + string(address) + " on port 6667");
        return -1;
    }
    else
    {
        gml_Script_twitch_log("Successfully connected to " + string(address) + " on port 6667");
    }
    
    var send_buff = buffer_create(128, buffer_fixed, 1);
    
    for (var i = 0; i < 3; i++)
    {
        var send_str;
        
        if (i == 0)
            send_str = "PASS " + string(global.IRC_oauth);
        else if (i == 1)
            send_str = "NICK " + string(global.IRC_name);
        else
            send_str = "JOIN " + string(global.IRC_channel);
        
        buffer_seek(send_buff, buffer_seek_start, 0);
        buffer_write(send_buff, buffer_string, string(send_str) + "\r\n");
        network_send_raw(global.IRC_socket, send_buff, buffer_get_size(send_buff));
    }
    
    buffer_delete(send_buff);
};
