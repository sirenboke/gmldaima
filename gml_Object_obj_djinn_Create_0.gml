image_speed = 0;
path_start(path_djinn, 20, path_action_stop, 1);
type = global.djinnOrder[3];
image_index = type;
size = 7;
djinnFog = gml_Script_scr_surface_create(1420, 800, "djinnFog");
alpha = 0;
gml_Script_scr_playsound(s_favorTrigger, 1, 1, 0.5);

if (room == r_underworld_new)
    depth = obj_portal.depth - 1;
