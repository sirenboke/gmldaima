var _id = ds_map_find_value(async_load, "id");
var _type = ds_map_find_value(async_load, "type");
var _buffer = ds_map_find_value(async_load, "buffer");

if (_type == 3)
{
    var _msg = buffer_read(_buffer, buffer_string);
    
    if (!variable_global_exists("socket_buffers"))
        global.socket_buffers = gml_Script_scr_ds_map_create();
    
    if (!ds_map_exists(global.socket_buffers, _id))
        ds_map_add(global.socket_buffers, _id, "");
    
    ds_map_set(global.socket_buffers, _id, ds_map_find_value(global.socket_buffers, _id) + _msg);
    var _lines = string_split(ds_map_find_value(global.socket_buffers, _id), "\n");
    ds_map_set(global.socket_buffers, _id, _lines[array_length(_lines) - 1]);
    
    for (var i = 0; i < (array_length(_lines) - 1); i++)
    {
        var _line = string_trim(_lines[i]);
        
        if (_line == "")
            continue;
        
        if (_id == global.kick_socket)
        {
            var _data;
            
            try
            {
                _data = json_parse(_line);
            }
            catch (e)
            {
                show_debug_message("Kick -> ERROR JSON: " + _line);
                continue;
            }
            
            if (__yy_continueEx120)
            {
            }
            else
            {
                if (__yy_breakEx120)
                    break;
                
                if (is_struct(_data))
                {
                    var _user = variable_struct_exists(_data, "user") ? _data.user : "";
                    var _text = variable_struct_exists(_data, "text") ? _data.text : "";
                    var _timestamp = variable_struct_exists(_data, "timestamp") ? _data.timestamp : "";
                    
                    if (_user != "" && _text != "")
                    {
                        show_debug_message("Kick -> " + _user + ": " + _text);
                        gml_Script_scr_commands(string_lower(_user), _text);
                    }
                }
            }
        }
    }
}
