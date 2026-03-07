if (global.dev == 1 && global.console == false)
{
    if (global.keeperBuilt == 0)
    {
        global.keeperBuilt = 1;
        global.townMaxHP += 25;
        global.townHP += 25;
        gml_Script_twitch_chat_say("/me Building Creature Keeper!");
        
        with (gml_Script_instance_create(obj_creatureKeeper.x, obj_creatureKeeper.y, obj_build_creaturekeeper))
        {
            ini_open(string(global.platformDir) + "Village Data/Data.ini");
            ini_write_real("Buildings", "Creature Keeper", 1);
            ini_close();
            build = obj_build_creaturekeeper;
            timer = 3;
            alarm[0] = room_speed * timer;
        }
        
        with (obj_creatureKeeper)
            instance_destroy();
    }
    else
    {
        global.keeperBuilt = 0;
        gml_Script_instance_create(obj_build_creaturekeeper.x, obj_build_creaturekeeper.y, obj_creatureKeeper);
        
        with (obj_build_creaturekeeper)
            instance_destroy();
    }
}
