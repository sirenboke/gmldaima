if (global.dev == 1 && global.console == false)
{
    if (global.witchBuilt == 0)
    {
        global.witchBuilt = 1;
        global.townMaxHP += 25;
        global.townHP += 25;
        gml_Script_twitch_chat_say_direct("/me Building Witch Hut!");
        
        with (gml_Script_instance_create(obj_witchHut.x, obj_witchHut.y, obj_buildingTimer))
        {
            ini_open(string(global.platformDir) + "Village Data/Data.ini");
            ini_write_real("Buildings", "Witch Build", 1);
            ini_close();
            build = obj_build_witchhut;
            timer = 3;
            alarm[0] = room_speed * timer;
        }
        
        with (obj_witchHut)
            instance_destroy();
    }
}
