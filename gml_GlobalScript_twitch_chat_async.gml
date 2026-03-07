self.twitch_chat_async = function()
{
    if (global.isTwitch == 1)
    {
        var _id = ds_map_find_value(async_load, "id");
        
        if (_id != global.IRC_socket)
            exit;
        
        var dataType = ds_map_find_value(async_load, "type");
        show_debug_message("Twitch event: " + string(dataType));
        
        switch (dataType)
        {
            case 3:
                var net_buff = ds_map_find_value(async_load, "buffer");
                var net_size = buffer_get_size(net_buff);
                buffer_seek(net_buff, buffer_seek_start, 0);
                var data_list = gml_Script_scr_ds_list_create();
                
                while (buffer_tell(net_buff) < net_size)
                {
                    var str = buffer_read(net_buff, buffer_string);
                    ds_list_add(data_list, str);
                }
                
                for (var i = 0; i < ds_list_size(data_list); i++)
                {
                    var str = ds_list_find_value(data_list, i);
                    show_debug_message(str);
                    
                    if (string_pos("PRIVMSG", str) != 0)
                    {
                        var pos_start = 2;
                        var pos_end = string_pos("!", str);
                        var name = string_copy(str, pos_start, pos_end - pos_start);
                        pos_start = string_pos(string(global.IRC_channel + " :"), str);
                        pos_end = string_length(str);
                        var data = string_copy(str, pos_start + string_length(global.IRC_channel + " :"), pos_end - pos_start);
                        gml_Script_scr_commands(name, data);
                        
                        if (!ds_exists(global.Chat_list, ds_type_list))
                            global.Chat_list = gml_Script_scr_ds_list_create();
                        
                        ds_list_insert(global.Chat_list, 0, string(name) + ": " + string(data));
                        gml_Script_twitch_log("Chat message received!");
                        gml_Script_twitch_log(string(name) + ": " + string(data));
                    }
                    else if (string_pos("PING", str) != 0)
                    {
                        net_buff = buffer_create(128, buffer_fixed, 1);
                        buffer_seek(net_buff, buffer_seek_start, 0);
                        buffer_write(net_buff, buffer_string, "PING tmi.twitch.tv\r\n");
                        network_send_raw(global.IRC_socket, net_buff, buffer_get_size(net_buff));
                        buffer_delete(net_buff);
                        gml_Script_twitch_log("Heartbeat message received!");
                        global.checkChat = 300;
                    }
                    else if (string_pos("PONG", str) != 0)
                    {
                        gml_Script_twitch_log("Heartbeat reply received!");
                        gml_Script_twitch_log(str);
                    }
                    else if (string_pos("NOTICE", str) != 0)
                    {
                        var pos_start = string_pos(string(global.IRC_channel + " :"), str);
                        var pos_end = string_length(str);
                        var data = string_copy(str, pos_start + string_length(global.IRC_channel + " :"), pos_end - pos_start);
                        
                        if (global.IRC_socket > -1)
                        {
                            global.IRC_socket = -1;
                            network_destroy(global.IRC_socket);
                        }
                        
                        gml_Script_twitch_log("Error notice received!");
                        gml_Script_twitch_log(data);
                    }
                    else
                    {
                        gml_Script_twitch_log("Unknown data received!");
                        gml_Script_twitch_log(str);
                    }
                }
                
                gml_Script_scr_ds_list_destroy(data_list);
                break;
        }
    }
};
