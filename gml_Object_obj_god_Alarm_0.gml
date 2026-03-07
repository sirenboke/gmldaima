if (room == r_1)
{
    if (global.godsFavorStacks <= 0)
        exit;
    
    global.godsFavorStacks -= 1;
    ini_open(string(global.platformDir) + "Core Data/Permanent.ini");
    ini_write_real("God", "Favor Max", global.godsHonorMax + (global.godLevel / 10));
    ini_write_real("God", "Favor Stacks", global.godsFavorStacks);
    ini_write_real("God", "Favor Progress", global.godsHonor);
    ini_close();
    pick = choose(0, 1, 2);
    activeTimer = (room_speed * 120) + ((global.godLevel / 25) * 60 * room_speed);
    
    if (pick == 0)
    {
        alarm[1] = activeTimer;
        gml_Script_scr_playsound(s_favorTrigger, 1, 1.2, 1);
        gml_Script_twitch_chat_say("/color GoldenRod");
        gml_Script_twitch_chat_say_direct("/me Gods smile at you... [XP Rain ?Favor for " + string(round(activeTimer / room_speed)) + " seconds]");
        gml_Script_twitch_chat_say("/color FireBrick");
        global.xprainpart_emitter = part_emitter_create(global.light_partsys);
        
        with (gml_Script_instance_create(x, y, obj_displayText))
        {
            text1 = "XP Rain";
            text2 = "Earn XP per second";
            text3 = "(" + string(string(round(other.activeTimer / room_speed)) + "s)");
            c1 = 16711935;
        }
    }
    
    if (pick == 1)
    {
        alarm[2] = activeTimer;
        gml_Script_scr_playsound(s_favorTrigger, 1, 1.2, 1);
        global.bonanzaBonus = (2 + (global.godLevel / 25)) * (1 + global.corruptionShardEffect[7]);
        gml_Script_twitch_chat_say("/color GoldenRod");
        gml_Script_twitch_chat_say_direct("/me Gods send a little help to you... [!Bonanza ?Favor (+" + string((global.bonanzaBonus - 1) * 100) + "%[x] effect) for " + string(round(activeTimer / room_speed)) + " seconds]");
        gml_Script_twitch_chat_say("/color FireBrick");
        obj_build_mine.gemChance /= 2;
        gml_Script_scr_alarm_start(0, 1, gml_Script_scr_updateBuildings);
        global.bonanzapart_emitter = part_emitter_create(global.light_partsys);
        
        with (gml_Script_instance_create(x, y, obj_displayText))
        {
            text1 = "Bonanza";
            text2 = "Earn " + string((global.bonanzaBonus - 1) * 100) + "%[x] more Gold and Food from all sources and 2x chance of finding a gem while mining";
            text3 = "(" + string(string(round(other.activeTimer / room_speed)) + "s)");
            c1 = 4235519;
        }
    }
    
    if (pick == 2)
    {
        alarm[3] = activeTimer * 100;
        raidsLeft = round(2 + (global.godLevel / 20));
        gml_Script_scr_playsound(s_favorTrigger, 1, 1.2, 1);
        global.godsDmgBonus = (0.1 + (global.godLevel / 100)) * (1 + global.corruptionShardEffect[7]);
        
        with (obj_player)
            gml_Script_scr_alarm_start(6, 1, gml_Script_scr_updateStats);
        
        gml_Script_twitch_chat_say("/color GoldenRod");
        gml_Script_twitch_chat_say_direct("/me Gods smile at you... [Heaven's Power ?Favor for " + string(round(raidsLeft)) + " raids]");
        gml_Script_twitch_chat_say("/color FireBrick");
        global.heavenpower_emitter = part_emitter_create(global.light_partsys);
        
        with (gml_Script_instance_create(x, y, obj_displayText))
        {
            text1 = "Heaven's Power";
            text2 = "+" + string(global.godsDmgBonus * 100) + "%[+] damage output while in combat";
            text3 = "(" + string(string(round(other.raidsLeft)) + " raids)");
            c1 = 255;
        }
    }
    
    timer = room_speed * (random_range(5000, 10000) - (global.godLevel * 10));
    
    if (timer < (120 * room_speed))
        timer = room_speed * random_range(120, 300);
}
else
{
    alarm[0] = room_speed * 30;
}

if (room == r_seasonEnd)
    alarm[0] = -1;
