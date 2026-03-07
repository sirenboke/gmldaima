if (room != r_seasonEnd)
{
    if (room == global.room_underworld)
    {
        if (alarm[0] != -1)
            alarm[0] += 1;
        
        if (alarm[1] != -1)
            alarm[1] += 1;
        
        if (alarm[2] != -1)
            alarm[2] += 1;
        
        if (alarm[3] != -1)
            alarm[3] += 1;
    }
    
    var _gainHonor = random_range(0.1, 1) / 3600;
    
    if (room == r_1)
        global.godsHonor += _gainHonor;
    
    if (global.godsHonor >= global.godsHonorMax)
    {
        global.godsHonor -= global.godsHonorMax;
        global.godsFavorStacks += 1;
        ini_open(string(global.platformDir) + "Core Data/Permanent.ini");
        ini_write_real("God", "Favor Max", global.godsHonorMax + (global.godLevel / 10));
        ini_write_real("God", "Favor Stacks", global.godsFavorStacks);
        ini_write_real("God", "Favor Progress", global.godsHonor);
        ini_close();
    }
    
    if (global.godsFavorStacks > 0)
    {
        if (alarm[1] == -1 && alarm[2] == -1 && alarm[3] == -1)
        {
            if (alarm[0] == -1)
                alarm[0] = room_speed * 120;
        }
        else if (alarm[0] == -1)
        {
            alarm[0] = 1 + max(alarm[1], alarm[2], alarm[3]);
        }
    }
    
    gml_Script_scr_alarm_step();
    
    if (alarm[0] == (room_speed * 119))
    {
        gml_Script_twitch_chat_say("/color GoldenRod");
        gml_Script_scr_playsound(s_favorAlarm, 1, 1.2, 1);
        
        if (obj_fog.night == false)
            gml_Script_twitch_chat_say_direct("/me The sky is clear, the air is fresh, the sun shines bright...");
        else
            gml_Script_twitch_chat_say_direct("/me Theres plenty of shooting stars tonight...");
        
        gml_Script_twitch_chat_say("/color FireBrick");
    }
    
    if (alarm[1] != -1)
    {
        if (room == r_1)
        {
            with (obj_player)
            {
                var _xprain = (obj_build_train.amount / room_speed) * (1 + global.corruptionShardEffect[7]);
                gml_Script_scr_player_reward(_xprain, 0);
                gml_Script_scr_player_abilityXP(id, (2 * (1 + global.corruptionShardEffect[7])) / room_speed);
                
                for (var _v = 1; _v < 5; _v++)
                    actionPoints[_v] = 0;
                
                if (state == UnknownEnum.Value_4)
                {
                    actionPoints[1] = (0.5 + global.miningVP) * (1 + global.corruptionShardEffect[7]);
                    
                    if (class == "farmer")
                        actionPoints[1] = 2 + global.miningVP;
                }
                
                if (state == UnknownEnum.Value_3)
                {
                    actionPoints[2] = (0.5 + global.farmingVP) * (1 + global.corruptionShardEffect[7]);
                    
                    if (class == "farmer")
                        actionPoints[2] = 2 + global.farmingVP;
                }
                
                if (state == UnknownEnum.Value_7)
                    actionPoints[3] = (0.5 + (obj_build_inn.level / 10)) * (1 + global.corruptionShardEffect[7]);
                
                if (state == UnknownEnum.Value_8)
                {
                    if (global.enemyRaid == true)
                        actionPoints[3] = (0.5 + (obj_build_inn.level / 10)) * (1 + global.corruptionShardEffect[7]);
                    
                    actionPoints[4] = (0.5 + global.raidingVP) * (1 + global.corruptionShardEffect[7]);
                }
                
                for (var _v2 = 1; _v2 < 5; _v2++)
                {
                    if (actionPoints[_v2] > 0 && (action > 0 && action < 5))
                    {
                        actionPoints[_v2] /= room_speed / 2;
                        
                        if (myVocationInfo[_v2 - 1][0] < maxVocationLevel)
                            myVocationInfo[_v2 - 1][1] += (actionPoints[action] * vpBonus);
                        else
                            myVocationInfo[_v2 - 1][1] = -1;
                        
                        show_debug_message("XP Rain VP/s (" + string(global.actionText[_v2]) + "): +" + string((actionPoints[_v2] * room_speed) / 2) + " (" + string(actionPoints[_v2]) + "/tick).");
                    }
                }
            }
            
            with (obj_warrior)
            {
                if (alarm[0] == -1)
                    xp += (global.ostage * (1 + (global.ostage / 100)) * player.myMultiplier[2] * global.academyXpBonus * (1 + global.corruptionShardEffect[7]));
            }
            
            part_emitter_region(global.light_partsys, global.xprainpart_emitter, -50, room_width, -100, 0, 1, 0);
            part_emitter_stream(global.light_partsys, global.xprainpart_emitter, global.rainpart2, 20);
            
            with (obj_warrior)
            {
                if (alarm[0] == -1)
                {
                    with (gml_Script_instance_create(x, y - (height / 3), obj_float))
                    {
                        type = 0;
                        value = global.ostage * (1 + (global.ostage / 100)) * other.player.myMultiplier[2] * global.academyXpBonus * (1 + global.corruptionShardEffect[7]);
                        text = "+" + string(value) + "xp";
                        c1 = 16711935;
                        c2 = 8388736;
                        parent = other.id;
                    }
                }
            }
        }
    }
    
    if (alarm[2] != -1)
    {
        part_emitter_region(global.light_partsys, global.bonanzapart_emitter, 0, room_width - 500, 0, room_height - 300, 1, 0);
        part_emitter_stream(global.light_partsys, global.bonanzapart_emitter, global.aura_part, 20);
    }
    
    if (alarm[3] != -1)
    {
        part_emitter_region(global.light_partsys, global.heavenpower_emitter, 0, room_width - 500, 0, room_height - 300, 1, 0);
        part_emitter_stream(global.light_partsys, global.heavenpower_emitter, global.aura_part_red, 20);
    }
}

enum UnknownEnum
{
    Value_3 = 3,
    Value_4,
    Value_7 = 7,
    Value_8
}
