self.scr_kick_reconnect = function()
{
    if (global.kick_socket > -1)
    {
        network_destroy(global.kick_socket);
        global.kick_socket = -1;
    }
    
    if (instance_exists(obj_kick))
        instance_destroy(obj_kick);
    
    gml_Script_instance_create(x, y, obj_kick);
};
