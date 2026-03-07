self.twitch_stream_get_thumbnail = function(arg0, arg1)
{
    var channel_info = ds_map_find_value(global.Stream_list, arg0);
    
    if (channel_info != undefined)
    {
        var thumb_url = ds_map_find_value(channel_info, "thumb_url");
        
        if (thumb_url != undefined)
        {
            var tw, th;
            
            switch (arg1)
            {
                case 0:
                    tw = 80;
                    th = 45;
                    break;
                
                case 1:
                    tw = 320;
                    th = 180;
                    break;
                
                case 2:
                    tw = 640;
                    th = 360;
                    break;
            }
            
            thumb_url = string_replace(thumb_url, "{width}", string(tw));
            thumb_url = string_replace(thumb_url, "{height}", string(th));
            var thm_req = http_get_file(thumb_url, working_directory + "\\" + string(arg0) + "-thumb.jpg");
            ds_map_add(global.Thumb_list, thm_req, arg0);
        }
    }
};
