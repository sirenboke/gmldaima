if (global.dev == 1 && global.console == false)
{
    if (global.blacksmithBuilt == 0)
    {
        global.blacksmithBuilt = 1;
        global.townMaxHP += 25;
        global.townHP += 25;
        gml_Script_twitch_chat_say_direct("/me Building forge! The blacksmith will be able to upgrade some of your items!");
        
        with (gml_Script_instance_create(obj_blacksmith.x, obj_blacksmith.y, obj_buildingTimer))
        {
            ini_open(string(global.platformDir) + "Village Data/Data.ini");
            ini_write_real("Buildings", "Forge", 1);
            ini_close();
            build = obj_build_forge;
            timer = 3;
            alarm[0] = room_speed * timer;
        }
        
        with (obj_blacksmith)
            instance_destroy();
    }
}
