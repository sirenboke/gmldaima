self.twitch_chat_disconnect = function()
{
    if (global.isTwitch == 1)
    {
        if (global.IRC_socket > -1)
        {
            network_destroy(global.IRC_socket);
            global.IRC_socket = -1;
        }
        
        if (ds_exists(global.Chat_list, ds_type_list))
        {
            gml_Script_scr_ds_list_destroy(global.Chat_list);
            global.Chat_list = -1;
        }
        
        if (global.Twitch_debuglog)
            gml_Script_twitch_log("TCP socket closed; disconnected from chat.");
    }
};
