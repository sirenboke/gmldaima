if (global.dev == 1 && global.console == false)
{
    if (global.shopBuilt == 0)
    {
        global.shopBuilt = 1;
        global.townMaxHP += 25;
        global.townHP += 25;
        gml_Script_twitch_chat_say_direct("/me Building shop! A hooded tiny creature is approaching the city...");
        
        with (gml_Script_instance_create(obj_shop.x, obj_shop.y, obj_buildingTimer))
        {
            ini_open(string(global.platformDir) + "Village Data/Data.ini");
            ini_write_real("Buildings", "Shop", 1);
            ini_close();
            build = obj_build_shop;
            timer = 3;
            alarm[0] = room_speed * timer;
        }
        
        with (obj_shop)
            instance_destroy();
    }
    else
    {
        global.shopBuilt = 0;
        gml_Script_instance_create(obj_build_shop.x, obj_build_shop.y, obj_shop);
        
        with (obj_build_shop)
            instance_destroy();
    }
}
