self.scr_saveString = function(arg0, arg1)
{
    var _buffer = buffer_create(string_byte_length(arg0) + 1, buffer_fixed, 1);
    buffer_write(_buffer, buffer_string, arg0);
    buffer_save(_buffer, arg1);
    buffer_delete(_buffer);
};

self.scr_loadString = function(arg0)
{
    var _buffer = buffer_load(arg0);
    var _string = buffer_read(_buffer, buffer_string);
    buffer_delete(_buffer);
    return _string;
};
