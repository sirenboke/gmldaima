self.net_client_connections = function()
{
    var _id = ds_map_find_value(async_load, "id");
    
    if (_id != global.clientSocket)
        exit;
    
    var dataType = ds_map_find_value(async_load, "type");
    show_debug_message("Server event: " + string(dataType));
    
    switch (dataType)
    {
        case 3:
            var data = ds_map_find_value(async_load, "buffer");
            buffer_seek(global.buffer, buffer_seek_start, 0);
            gml_Script_net_client_events(data);
            break;
    }
};
