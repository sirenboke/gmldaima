global.kick_socket = network_create_socket(network_socket_tcp);
global.socket_buffers = gml_Script_scr_ds_map_create();
network_connect_raw(global.kick_socket, "127.0.0.1", 8081);
show_debug_message("[GML] Conectando al servidor TCP...");
