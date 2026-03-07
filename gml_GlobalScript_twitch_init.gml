self.twitch_init = function(arg0)
{
    global.Update_autochck = false;
    global.Update_interval = room_speed * 15;
    global.Twitch_debuglog = true;
    global.Twitch_debugnum = "";
    global.Client_ID = arg0;
    global.Stream_list = gml_Script_scr_ds_map_create();
    global.Update_list = gml_Script_scr_ds_map_create();
    global.Thumb_list = gml_Script_scr_ds_map_create();
    global.Chat_list = -1;
    global.IRC_socket = -1;
    global.IRC_channel = "";
    global.IRC_name = "";
    global.IRC_oauth = "";
    global.Update_timeleft = global.Update_interval;
    
    if (global.Twitch_debuglog)
    {
        for (var version = 0; file_exists(working_directory + "\\debug_log" + string(global.Twitch_debugnum) + ".ini"); version++)
        {
            if (version > 0)
                global.Twitch_debugnum = "_" + string(version);
        }
    }
};
