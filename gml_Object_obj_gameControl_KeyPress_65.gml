if (global.dev == 1 && global.console == false)
{
    if (global.academyBuilt == 0)
    {
        global.academyBuilt = 1;
        global.townMaxHP += 25;
        global.townHP += 25;
        gml_Script_twitch_chat_say_direct("/me Building academy! Knowledge for everyone!...");
        
        with (gml_Script_instance_create(obj_academy.x, obj_academy.y, obj_buildingTimer))
        {
            ini_open(string(global.platformDir) + "Village Data/Data.ini");
            ini_write_real("Buildings", "Academy", 1);
            ini_close();
            build = obj_build_academy;
            timer = 3;
            alarm[0] = 2;
        }
        
        show_debug_message("Initial pos X:" + string(obj_academy.x) + " Y:" + string(obj_academy.y));
        
        with (obj_academy)
            instance_destroy();
    }
    else
    {
        global.academyBuilt = 0;
        gml_Script_instance_create(obj_build_academy.x, obj_build_academy.y, obj_academy);
        show_debug_message("Ending pos X:" + string(obj_build_academy.x) + " Y:" + string(obj_build_academy.y));
        
        with (obj_build_academy)
            instance_destroy();
    }
    
    if (global.wellBuilt == 0)
    {
        global.wellBuilt = 1;
        global.townMaxHP += 25;
        global.townHP += 25;
        gml_Script_scr_playsound(choose(s_buy1, s_buy2, s_buy3), 0.9, 1.1, 1);
        gml_Script_twitch_chat_say_direct("/me Building well! I guess throwing coins in it will do something...");
        
        with (gml_Script_instance_create(obj_well.x, obj_well.y, obj_buildingTimer))
        {
            ini_open(string(global.platformDir) + "Village Data/Data.ini");
            ini_write_real("Buildings", "Well", 1);
            ini_close();
            build = obj_build_well;
            timer = 3;
            sprite_index = spr_blank;
            alarm[0] = room_speed * timer;
            
            with (gml_Script_instance_create(400, 75, obj_float))
            {
                type = 8;
                value = obj_well.wellCost;
                text = "-" + gml_Script_scr_bigNumber(value) + "g";
                c1 = 255;
                c2 = 128;
                parent = type;
            }
        }
        
        with (obj_well)
            instance_destroy();
    }
}
