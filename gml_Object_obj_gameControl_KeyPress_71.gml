if (global.dev == 1 && global.console == false)
{
    if (global.guildsBuilt == 0)
    {
        global.guildsBuilt = 1;
        global.townMaxHP += 25;
        global.townHP += 25;
        gml_Script_twitch_chat_say_direct("/me Building guilds! You complete quests, guilds reward you!");
        
        with (gml_Script_instance_create(obj_guilds.x, obj_guilds.y, obj_buildingTimer))
        {
            ini_open(string(global.platformDir) + "Village Data/Data.ini");
            ini_write_real("Buildings", "Guild Hall", 1);
            ini_close();
            build = obj_build_guildhall;
            timer = 3;
            alarm[0] = room_speed * timer;
        }
        
        with (obj_guilds)
            instance_destroy();
    }
}
