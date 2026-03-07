self.twitch_free = function()
{
    if (global.isTwitch == 1)
    {
        if (ds_exists(global.Stream_list, ds_type_map))
        {
            for (var i = 0; i < ds_map_size(global.Stream_list); i++)
            {
                var channel_id;
                
                if (i == 0)
                    channel_id = ds_map_find_first(global.Stream_list);
                else
                    channel_id = ds_map_find_next(global.Stream_list, channel_id);
                
                if (channel_id != undefined)
                {
                    var channel_info = ds_map_find_value(global.Stream_list, channel_id);
                    
                    if (ds_exists(channel_info, ds_type_map))
                    {
                        var spr = ds_map_find_value(channel_info, "thumb");
                        
                        if (spr != undefined)
                        {
                            if (sprite_exists(spr))
                                sprite_delete(spr);
                        }
                        
                        gml_Script_scr_ds_map_destroy(channel_info);
                    }
                }
            }
        }
        
        if (ds_exists(global.Update_list, ds_type_map))
            gml_Script_scr_ds_map_destroy(global.Update_list);
        
        if (ds_exists(global.Stream_list, ds_type_map))
            gml_Script_scr_ds_map_destroy(global.Stream_list);
        
        if (ds_exists(global.Thumb_list, ds_type_map))
            gml_Script_scr_ds_map_destroy(global.Thumb_list);
        
        global.Update_timeleft = global.Update_interval;
        
        if (ds_exists(global.Chat_list, ds_type_list))
            gml_Script_scr_ds_list_destroy(global.Chat_list);
        
        if (global.IRC_socket > -1)
        {
            network_destroy(global.IRC_socket);
            global.IRC_socket = -1;
        }
        
        global.IRC_channel = "";
        global.IRC_name = "";
        global.IRC_oauth = "";
    }
};
