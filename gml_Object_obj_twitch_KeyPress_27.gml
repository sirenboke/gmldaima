global.closing = true;
gml_Script_scr_savegame();

if (!instance_exists(obj_quit))
    gml_Script_instance_create(x, y, obj_quit);
else
    instance_destroy(obj_quit);
