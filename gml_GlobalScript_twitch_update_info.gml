self.twitch_update_info = function()
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
            var headers = gml_Script_scr_ds_map_create();
            ds_map_add(headers, "Client-ID", global.Client_ID);
            ds_map_add(headers, "Accept", "application/vnd.twitchtv.v3+json");
            var req = http_request("https://api.twitch.tv/kraken/streams/" + string(channel_id) + "/", "GET", headers, "");
            gml_Script_scr_ds_map_destroy(headers);
            ds_map_add(global.Update_list, req, channel_id);
        }
    }
};
