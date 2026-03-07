self.scr_death = function()
{
    if (dying == false)
    {
        if (argument[0] != "")
            killer = argument[0];
        else
            killer = "";
        
        if (argument[1] != "")
            killerLevel = argument[1];
        else
            killerLevel = 0;
        
        if (argument[2] != "")
            killerDmg = argument[2];
        else
            killerDmg = 0;
        
        if (argument[3] != "")
            killerTanked = argument[3];
        else
            killerTanked = 0;
        
        if (resurrect == 0 && alarm[7] > 1)
        {
            hp = myStatInfo[8][3];
            alarm[7] -= room_speed / 2;
            show_debug_message("Undying Faith duration reduced by lethal hit.");
            
            if (alarm[7] < 1)
                alarm[7] = 1;
        }
        
        if (resurrect == 0 && (alarm[7] == -1 || alarm[7] <= 1))
        {
            dying = true;
            var _ascended = player.ascended;
            
            with (gml_Script_instance_create(x, y, obj_warriorDeath))
            {
                image_xscale = other.image_xscale;
                image_yscale = other.image_yscale;
                sprite_index = other.spr_dead;
                image_speed = 0.02 * global.roomSpeed;
                ascended = _ascended;
            }
            
            show_debug_message("Died Pet ID: " + string(pet));
            
            if (raidList == global.raidList1)
            {
                if (instance_exists(obj_rangedLegs))
                {
                    with (obj_rangedLegs)
                        instance_destroy();
                    
                    with (obj_rangedTorso)
                        instance_destroy();
                }
            }
            
            with (player)
            {
                kills += other.fightKills;
                gml_Script_scr_addDiaryProgress(2, other.fightKills);
            }
            
            ini_open(string(global.platformDir) + string(player.myCharDir) + "Data.ini");
            ini_write_real("Stats", "Energy", 0);
            ini_write_real("Misc", "Kills", player.kills);
            ini_close();
            
            if (raidList == global.raidList0)
            {
                if (ascended == true)
                {
                    ds_list_delete(global.raidListMelee, ds_list_find_index(global.raidListMelee, "Z" + string(string(raidPos) + string(player.levelRaid) + string(name))));
                }
                else
                {
                    if (player.levelRaid < 10)
                        ds_list_delete(global.raidListMelee, ds_list_find_index(global.raidListMelee, string(string(raidPos) + "A" + string(player.levelRaid) + string(name))));
                    
                    if (player.levelRaid >= 10 && player.levelRaid <= 99)
                        ds_list_delete(global.raidListMelee, ds_list_find_index(global.raidListMelee, string(string(raidPos) + "B" + string(player.levelRaid) + string(name))));
                    
                    if (player.levelRaid >= 100 && player.levelRaid <= 999)
                        ds_list_delete(global.raidListMelee, ds_list_find_index(global.raidListMelee, string(string(raidPos) + "C" + string(player.levelRaid) + string(name))));
                    
                    if (player.levelRaid >= 1000 && player.levelRaid <= 9999)
                        ds_list_delete(global.raidListMelee, ds_list_find_index(global.raidListMelee, string(string(raidPos) + "D" + string(player.levelRaid) + string(name))));
                    
                    if (player.levelRaid >= 10000 && player.levelRaid <= 99999)
                        ds_list_delete(global.raidListMelee, ds_list_find_index(global.raidListMelee, string(string(raidPos) + "E" + string(player.levelRaid) + string(name))));
                    
                    if (player.levelRaid >= 100000)
                        ds_list_delete(global.raidListMelee, ds_list_find_index(global.raidListMelee, string(string(raidPos) + "F" + string(player.levelRaid) + string(name))));
                }
                
                global.xpGoto[0] = -2;
            }
            
            if (raidList == global.raidList1)
            {
                if (ascended == true)
                {
                    ds_list_delete(global.raidListRanged, ds_list_find_index(global.raidListRanged, "Z" + string(string(raidPos) + string(player.levelRaid) + string(name))));
                }
                else
                {
                    if (player.levelRaid < 10)
                        ds_list_delete(global.raidListRanged, ds_list_find_index(global.raidListRanged, string(string(raidPos) + "A" + string(player.levelRaid) + string(name))));
                    
                    if (player.levelRaid >= 10 && player.levelRaid <= 99)
                        ds_list_delete(global.raidListRanged, ds_list_find_index(global.raidListRanged, string(string(raidPos) + "B" + string(player.levelRaid) + string(name))));
                    
                    if (player.levelRaid >= 100 && player.levelRaid <= 999)
                        ds_list_delete(global.raidListRanged, ds_list_find_index(global.raidListRanged, string(string(raidPos) + "C" + string(player.levelRaid) + string(name))));
                    
                    if (player.levelRaid >= 1000 && player.levelRaid <= 9999)
                        ds_list_delete(global.raidListRanged, ds_list_find_index(global.raidListRanged, string(string(raidPos) + "D" + string(player.levelRaid) + string(name))));
                    
                    if (player.levelRaid >= 10000 && player.levelRaid <= 99999)
                        ds_list_delete(global.raidListRanged, ds_list_find_index(global.raidListRanged, string(string(raidPos) + "E" + string(player.levelRaid) + string(name))));
                    
                    if (player.levelRaid >= 100000)
                        ds_list_delete(global.raidListRanged, ds_list_find_index(global.raidListRanged, string(string(raidPos) + "F" + string(player.levelRaid) + string(name))));
                }
                
                global.xpGoto[1] = -2;
            }
            
            show_debug_message("Type size dead: " + string(ds_list_size(global.raidListRanged)));
            
            if (room == global.room_underworld)
            {
                ds_list_delete(global.raidListPortalName, ds_list_find_index(global.raidListPortalName, name));
                ds_list_delete(global.raidListPortalClass, ds_list_find_index(global.raidListPortalClass, name));
            }
            
            with (obj_warrior)
            {
                redirectDmg = 0;
                
                if (raidList == other.raidList)
                {
                    myRaidNumber -= 1;
                    
                    if (myRaidNumber < 0)
                        myRaidNumber = 0;
                    
                    if (myRaidNumber == 0)
                    {
                        alarm[11] = room_speed * 60;
                        raidAction = "fighting";
                        
                        if (class == "warrior" && specialized == 3)
                        {
                            if (myAbilityInfo[0] == 2 && myRaidNumber == 0)
                            {
                                mana = maxmana;
                                gml_Script_scr_castAbility();
                            }
                        }
                    }
                    
                    if (myRaidNumber > 0)
                        raidAction = "alive";
                    
                    if (myRaidNumber < 0)
                        raidAction = "defeated";
                }
                
                myDamage[0] = omyDamage[0];
                myResistance[0][0] = omyResistance[0][0];
                
                if (class == "warrior")
                {
                    with (obj_warrior)
                    {
                        if (raidList == global.raidList1)
                        {
                            if (myRaidNumber == 0)
                                myResistance[0][0] = omyResistance[0][0];
                        }
                    }
                }
                
                if (class == "archer")
                {
                    if (ds_list_size(global.raidListMelee) > 0)
                    {
                        myDamage[0] = omyDamage[0] + 0.1;
                        myResistance[0][0] = omyResistance[0][0];
                    }
                    else
                    {
                        myDamage[0] = omyDamage[0];
                        myResistance[0][0] = omyResistance[0][0] - 0.1;
                    }
                }
                
                if (class == "warrior" && myRaidNumber == 0)
                {
                    with (obj_warrior)
                    {
                        if (raidList == global.raidList1)
                        {
                            if (myRaidNumber == 0)
                                gml_Script_scr_statChange(0.1, -1, 11, undefined, undefined);
                        }
                    }
                }
            }
            
            if (global.inFinalWar == false)
            {
                with (obj_player)
                {
                    if (name == other.name)
                    {
                        raidAction = "defeated";
                        action = 0;
                        hp = 1;
                        energy = 0;
                        wasGuarding = false;
                        
                        if (room == r_1 && myTier > 0)
                        {
                            path_end();
                            state = UnknownEnum.Value_5;
                            target = obj_build_inn;
                            actionPath = path_add();
                            var w = 10;
                            var h = 15;
                            gotoX = irandom_range(target.x - w, target.x + w);
                            gotoY = irandom_range(target.y - h, target.y + h);
                            
                            if (mp_grid_path(global.gameGrid, actionPath, x, y, gotoX, gotoY, 1))
                                path_start(actionPath, 0.5 * global.roomSpeed, path_action_stop, 0);
                        }
                        else
                        {
                            state = UnknownEnum.Value_0;
                            
                            if (alarm[1] == -1)
                                alarm[1] = 1;
                        }
                    }
                }
            }
            
            if (instance_number(obj_warrior) <= 1)
            {
                with (obj_enemy)
                    immune = true;
                
                gml_Script_scr_playsound(s_raidLose, 0.8, 1.2, 0.5);
                global.extraRewardsTimer = global.extraRewardsTimerMax;
                
                if (global.inFinalWar == false)
                {
                    if (room == r_1)
                    {
                        if (global.enemyRaid == true)
                        {
                            with (obj_raid)
                                alarm[5] = room_speed * 10;
                            
                            with (gml_Script_instance_create(room_width / 2, room_height - 300, obj_raidResults))
                            {
                                result = 1;
                                global.raidGold -= (global.stage * 20);
                                global.raidXP /= 2;
                                global.raidHonor /= 4;
                                alarm[0] = room_speed * 11;
                            }
                        }
                        else
                        {
                            with (obj_raid)
                                alarm[3] = room_speed * 10;
                            
                            with (gml_Script_instance_create(room_width / 2, room_height - 300, obj_raidResults))
                            {
                                global.raidGold /= 2;
                                global.raidXP /= 2;
                                result = 1;
                                global.raidHonor /= 4;
                                alarm[0] = room_speed * 11;
                            }
                        }
                    }
                    
                    if (room == global.room_underworld)
                    {
                        defeated = true;
                        
                        with (gml_Script_instance_create(room_width / 2, room_height - 300, obj_raidPortalResults))
                        {
                            result = 1;
                            global.raidXP /= 2;
                            global.raidGold /= 2;
                            alarm[0] = room_speed * 10;
                        }
                    }
                    
                    if (room == r_corrupted)
                    {
                        defeated = true;
                        
                        with (gml_Script_instance_create(room_width / 2, room_height - 300, obj_raidCorruptedResults))
                        {
                            result = 1;
                            alarm[0] = room_speed * 10;
                        }
                    }
                }
                else
                {
                    audio_sound_gain(obj_raid.fightTheme, 0, 20000);
                    obj_seasonControl.alarm[1] = room_speed;
                    obj_raid.alarm[10] = -1;
                }
            }
            else if (instance_exists(obj_deathRain))
            {
                global.rainDmg = 10;
                global.rainArmor = 0.03;
            }
            
            player.readyRaid = 0;
            mainChar = false;
            instance_destroy();
            
            if (raidList == global.raidList0 && ds_list_size(global.raidListMelee) <= 0)
            {
                with (obj_warrior)
                    mainChar = true;
            }
            
            if (global.inFinalWar == true)
            {
                with (player)
                {
                    gml_Script_scr_permadeath();
                    state = UnknownEnum.Value_12;
                    
                    with (myCard)
                        instance_destroy();
                    
                    ds_list_delete(global.playerList, ds_list_find_index(global.playerList, name));
                    global.totalPlayers -= 1;
                    
                    if (class == "farmer")
                    {
                        global.farmerBonus -= (1 * (1 + myTier));
                        
                        if (global.farmerBonus < 0)
                            global.farmerBonus = 0;
                        
                        global.farmerNumber -= 1;
                    }
                    
                    if (class == "warrior")
                        global.warriorNumber -= 1;
                    
                    if (class == "rogue")
                        global.rogueNumber -= 1;
                    
                    if (class == "mage")
                        global.wizardNumber -= 1;
                    
                    if (class == "archer")
                        global.rangerNumber -= 1;
                    
                    ds_list_sort(global.playerList, true);
                    
                    if (obj_gameControl.showPlayers == 1)
                        obj_gameControl.alarm[5] = 1;
                    
                    ini_open(string(global.platformDir) + string(myAccDir) + "Account Data.ini");
                    ini_write_real("Honor", "Account Honor", honor);
                    ini_write_real("Honor", "Account Level", honorLevel);
                    ini_close();
                    ini_open(string(global.platformDir) + string(myAccDir) + "Character Data.ini");
                    
                    for (ui = 1; ui < (global.maxUniqueItems + 1); ui += 1)
                    {
                        ini_key_delete("Relics", "Got Unique Item " + string(ui));
                        ini_key_delete("Relics", "Unique Item " + string(ui) + " Level");
                        ini_key_delete("Relics", "Equipped Unique Item " + string(ui));
                    }
                    
                    ini_key_delete("Resources", "Gems");
                    ini_close();
                }
                
                if (global.chatSpam <= 1)
                {
                    if (killer != "Blood Rain")
                        gml_Script_twitch_chat_say("/me " + string(name) + " got defeated by " + string(killer) + " (lv." + gml_Script_scr_bigNumber(killerLevel) + "), receiving a lethal hit of " + gml_Script_scr_bigNumber(killerDmg) + " damage (survived " + gml_Script_scr_bigNumber(killerTanked) + " of it). You will be remembered.");
                    
                    if (killer == "Blood Rain")
                        gml_Script_twitch_chat_say("/me " + string(name) + " got defeated by " + string(killer) + " (" + gml_Script_scr_bigNumber(killerDmg) + " damage, survived " + gml_Script_scr_bigNumber(killerTanked) + " of it). You will be remembered.");
                }
            }
            else if (global.chatSpam <= 1)
            {
                if (killer != "Blood Rain")
                    gml_Script_twitch_chat_say("/me " + string(name) + " got defeated by " + string(killer) + " (lv." + gml_Script_scr_bigNumber(killerLevel) + "), receiving a lethal hit of " + gml_Script_scr_bigNumber(killerDmg) + " damage (survived " + gml_Script_scr_bigNumber(killerTanked) + " of it).");
                
                if (killer == "Blood Rain")
                    gml_Script_twitch_chat_say("/me " + string(name) + " got defeated by " + string(killer) + " (" + gml_Script_scr_bigNumber(killerDmg) + " damage, survived " + gml_Script_scr_bigNumber(killerTanked) + " of it).");
            }
        }
        else
        {
            if (alarm[7] == -1)
                alarm[7] = room_speed * resTimer;
            
            resurrect = 0;
        }
    }
};

enum UnknownEnum
{
    Value_0,
    Value_5 = 5,
    Value_12 = 12
}
