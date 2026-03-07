self.twitch_stream_get_info = function(arg0)
{
    if (ds_map_find_value(global.Stream_list, arg0) == undefined)
    {
        var map = gml_Script_scr_ds_map_create();
        ds_map_add(global.Stream_list, arg0, map);
        ds_map_add(map, "name", "");
        ds_map_add(map, "game", "");
        ds_map_add(map, "url", "");
        ds_map_add(map, "status", false);
        ds_map_add(map, "viewers", "0");
        ds_map_add(map, "views", "0");
        ds_map_add(map, "followers", "0");
        ds_map_add(map, "thumb_url", "");
        ds_map_add(map, "thumb", -1);
    }
    
    var headers = gml_Script_scr_ds_map_create();
    ds_map_add(headers, "Client-ID", global.Client_ID);
    ds_map_add(headers, "Accept", "application/vnd.twitchtv.v3+json");
    var req = http_request("https://api.twitch.tv/kraken/streams/" + string(arg0) + "/", "GET", headers, "");
    gml_Script_scr_ds_map_destroy(headers);
    ds_map_add(global.Update_list, req, arg0);
};
