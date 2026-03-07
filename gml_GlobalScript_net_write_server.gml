self.net_write_server = function()
{
    var _buffer = buffer_create(1, buffer_grow, 1);
    buffer_seek(_buffer, buffer_seek_start, 0);
    
    for (a = 0; a < argument_count; a += 2)
        buffer_write(_buffer, argument[a], argument[a + 1]);
    
    network_send_packet(global.clientSocket, _buffer, buffer_tell(_buffer));
    buffer_delete(_buffer);
    show_debug_message("Buffer sent!");
};
