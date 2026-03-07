self.twitch_stream_find_value = function(arg0, arg1)
{
    var channel_info = ds_map_find_value(global.Stream_list, arg0);
    
    if (channel_info != undefined)
        return ds_map_find_value(channel_info, arg1);
};
