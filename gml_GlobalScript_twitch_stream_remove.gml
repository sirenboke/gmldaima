self.twitch_stream_remove = function(arg0)
{
    var channel_info = ds_map_find_value(global.Stream_list, arg0);
    
    if (channel_info != undefined)
    {
        var spr = ds_map_find_value(channel_info, "thumb");
        
        if (spr != undefined)
        {
            if (sprite_exists(spr))
                sprite_delete(spr);
        }
        
        gml_Script_scr_ds_map_destroy(channel_info);
        
        for (var i = 0; i < ds_map_size(global.Update_list); i++)
        {
            var update_id;
            
            if (i == 0)
                update_id = ds_map_find_first(global.Update_list);
            else
                update_id = ds_map_find_next(global.Update_list, update_id);
            
            if (ds_map_find_value(global.Update_list, update_id) == arg0)
            {
                ds_map_delete(global.Update_list, update_id);
                break;
            }
        }
        
        for (var i = 0; i < ds_map_size(global.Thumb_list); i++)
        {
            var update_id;
            
            if (i == 0)
                update_id = ds_map_find_first(global.Thumb_list);
            else
                update_id = ds_map_find_next(global.Thumb_list, update_id);
            
            if (ds_map_find_value(global.Thumb_list, update_id) == arg0)
            {
                ds_map_delete(global.Thumb_list, update_id);
                break;
            }
        }
    }
};
