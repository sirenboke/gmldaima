self.scr_death_enemy = function(arg0)
{
    if (alarm[0] != -1)
        exit;
    
    if (!variable_instance_exists(id, "value"))
        value = level * tier;
    
    if (resurrect == 0 && alarm[7] > 1)
    {
        hp = myStatInfo[8][3];
        alarm[7] -= room_speed;
        show_debug_message("Undying Faith duration reduced by lethal hit.");
        
        if (alarm[7] < 1)
            alarm[7] = 1;
    }
    
    if (resurrect == 0 && (alarm[7] == -1 || alarm[7] <= 1))
    {
        if ((class == "boss" || class == "alpha") && instance_number(obj_enemy) > 1)
            show_debug_message("Cant kill boss before all other enemies!");
        
        dead = true;
        var gemDrop = 0;
        var tpDrop = 0;
        
        with (gml_Script_instance_create(x, room_height - 20, obj_enemyDeath))
        {
            image_xscale = other.image_xscale;
            image_yscale = other.image_yscale;
            sprite_index = other.spr_dead;
            image_speed = 0.02 * global.roomSpeed;
        }
        
        with (obj_tempStat)
        {
            if (player == other.id)
                instance_destroy();
        }
        
        with (obj_warrior)
            fightKills += 1;
        
        if (instance_exists(arg0))
        {
            var _player = arg0.player;
            var _r25value = gml_Script_scr_relicEffect(_player, 0, 25);
            
            if (_r25value > 0)
            {
                gml_Script_scr_playsound(s_armored, 1, 1, 1);
                
                with (instance_create_depth(x, y - (height / 2), depth - 1, obj_raidAnimation))
                {
                    sprite_index = spr_frostNova2;
                    image_angle = irandom(359);
                    image_xscale = 1.5;
                    image_yscale = 1.5;
                    spd = room_speed / 2;
                    color = 128;
                    alpha = 0.9;
                    fade = true;
                    fadeSpeed = 1;
                    dmg = other.myStatInfo[8][2] * _r25value;
                    player = _player;
                    alarm[2] = room_speed / 1.5;
                }
            }
            
            with (arg0)
            {
                if (class == "warrior" && specialized == 1)
                {
                    gml_Script_scr_statChange(myStatInfo[0][3] * 0.01, undefined, 0, 4, undefined, 1);
                    gml_Script_scr_statChange(myStatInfo[7][3] * 0.01, undefined, 7, 4, undefined, 1);
                    speedBuff += 0.3;
                }
            }
        }
        
        if (global.inFinalWar == false)
        {
            if (class == "boss")
            {
                with (obj_player)
                {
                    if (getRaidItems == true)
                        gml_Script_scr_addDiaryProgress(8, 1);
                }
                
                var _amount = 1 + floor(global.stage / 200) + floor(ds_list_size(global.rewardList) / 5);
                
                if (obj_raid.boss == true)
                {
                    with (obj_bossKey)
                    {
                        spr_key = choose(spr_bossKey1, spr_bossKey2, spr_bossKey3, spr_bossKey4);
                        alarm[1] = -1;
                    }
                    
                    with (obj_keyFrag)
                        instance_destroy();
                    
                    with (obj_keyFrag2)
                        instance_destroy();
                    
                    var extra = global.hunterGuildLevel - 1;
                    tpDrop = round(irandom_range(3, 5) + (global.stage / 50)) * tier;
                    
                    repeat (tpDrop)
                    {
                        with (gml_Script_instance_create(x, y, obj_scroll))
                            status = 1;
                    }
                    
                    repeat (irandom_range(6, 9) + (global.stage / 10) + extra)
                        gml_Script_instance_create(x, y, obj_item);
                    
                    _amount += 2;
                    _amount += tier;
                    gemDrop = round(2 + (global.stage / 50) + irandom(global.stage / 100)) * tier;
                    
                    repeat (gemDrop)
                    {
                        with (gml_Script_instance_create(x, y, obj_gem))
                            status = 1;
                    }
                    
                    gml_Script_twitch_chat_say_direct("/me " + string(name) + " dropped " + gml_Script_scr_bigNumber(tpDrop) + " room00Talent and " + gml_Script_scr_bigNumber(gemDrop) + " room00Gem !");
                    gml_Script_scr_playsound(s_gem, 1, 1.1, 1);
                    global.keyFrags = 1;
                    global.bossTier = 0;
                    ini_open(string(global.platformDir) + "Village Data/Data.ini");
                    ini_write_real("Boss", "Key Fragments", 1);
                    ini_write_real("Boss", "Key Level", 0);
                    ini_write_real("Boss", "Boss Tier", 0);
                    ini_close();
                }
                
                var _portalPoints = clamp((value * (1 + ((tier - 1) * 10))) / 50, 1, 10000);
                
                if (room == r_1)
                {
                    if (global.portalPoints < global.portalMaxPoints)
                        global.portalPoints += _portalPoints;
                }
                
                var _dropChance = 100;
                var _chooseRelic = irandom_range(1, myRelicSlots);
                
                if (obj_raid.raidType == 1 && obj_raid.boss == false)
                {
                    _dropChance = 60;
                    tpDrop = round(15 + global.townLevel + floor((global.stage / 50) * 5)) * clamp(tier, 1, 6);
                    gml_Script_twitch_chat_say_direct("/me " + string(name) + " dropped " + gml_Script_scr_bigNumber(tpDrop) + " room00Talent !");
                    
                    repeat (tpDrop)
                    {
                        with (gml_Script_instance_create(x, y, obj_scroll))
                            status = 1;
                    }
                }
                
                if (obj_raid.raidType > 1)
                {
                    tpDrop = round(15 + global.townLevel + floor((global.stage / 50) * 5)) * clamp(tier - 1, 1, 6);
                    
                    repeat (tpDrop)
                    {
                        with (gml_Script_instance_create(x, y, obj_scroll))
                            status = 1;
                    }
                    
                    _dropChance = 100;
                    gemDrop = round((global.stage / 50) * obj_raid.raidType) * clamp(tier - 1, 1, 6);
                    
                    repeat (gemDrop)
                    {
                        with (gml_Script_instance_create(x, y, obj_gem))
                            status = 1;
                    }
                    
                    gml_Script_twitch_chat_say_direct("/me " + string(name) + " dropped " + gml_Script_scr_bigNumber(tpDrop) + " room00Talent and " + gml_Script_scr_bigNumber(gemDrop) + " room00Gem !");
                    gml_Script_scr_playsound(s_gem, 1, 1.1, 1);
                }
                
                if (_dropChance >= irandom(99))
                {
                    if (room != r_corrupted)
                    {
                        with (gml_Script_instance_create(x, y, obj_uniqueItem))
                        {
                            amount = _amount;
                            itemID = other.uniqueSlot[_chooseRelic];
                        }
                    }
                }
                
                show_debug_message("TPs and Gems dropped by Boss: " + string(tpDrop) + " and " + string(gemDrop));
            }
        }
        
        if (room == r_1 && global.inFinalWar == false)
        {
            xpOrbs = 5 + round((value * (1 + ((tier - 1) * 10))) / 10);
            
            if (xpOrbs < 20)
            {
                repeat (xpOrbs)
                {
                    with (gml_Script_instance_create(random_range(x - (length / 10), x + (length / 10)), random_range(y - (height / 2) - 10, (y - (height / 2)) + 10), obj_xpOrb))
                        value = 1;
                }
            }
            else
            {
                repeat (20)
                {
                    with (gml_Script_instance_create(random_range(x - (length / 10), x + (length / 10)), random_range(y - (height / 2) - 10, (y - (height / 2)) + 10), obj_xpOrb))
                        value = other.xpOrbs / 20;
                }
            }
            
            with (gml_Script_instance_create(x, y, obj_goldDrop2))
                value = ceil((other.value * (1 + ((other.tier - 1) * 10))) / 3);
            
            var _portalPoints = clamp(value / 200, 1, 10000);
            
            if (room == r_1)
            {
                if (global.portalPoints < global.portalMaxPoints)
                    global.portalPoints += _portalPoints;
            }
            
            if (global.raidItems < (10 + (global.hunterGuildLevel * 2)))
            {
                var extra = global.hunterGuildLevel - 1;
                dropItem = irandom(99);
                
                if (dropItem < (6 + (global.totalPlayers / 2) + (global.stage / 10) + extra))
                    gml_Script_instance_create(x, y, obj_item);
            }
        }
        
        if (type == "demon" && global.witchBuilt == 1)
        {
            with (gml_Script_instance_create(470, 55, obj_float))
            {
                type = 17;
                value = 1;
                text = "+" + gml_Script_scr_bigNumber(round(value));
                c1 = 16777215;
                c2 = 16776960;
                parent = type;
                alarm[1] = 1;
            }
            
            global.souls += (1 * global.soulBonus * (1 + global.corruptionShardEffect[5]));
        }
        
        if (room == global.room_underworld)
        {
            if (class == "alpha")
            {
                global.bloodgems += 1;
                
                with (gml_Script_instance_create(x, y, obj_auraItem))
                {
                    if (global.newUnderworld == false)
                    {
                        name = global.auraInfo[global.randAura][0];
                        type = global.randAura;
                    }
                    else
                    {
                        name = global.auraInfo[0][0];
                        type = 0;
                    }
                }
                
                if (room != r_corrupted)
                {
                    with (gml_Script_instance_create(x, y, obj_uniqueItem))
                    {
                        amount = 2 + floor(ds_list_size(global.rewardList) / 5) + other.tier;
                        itemID = other.uniqueSlot[1];
                    }
                }
                
                with (obj_player)
                {
                    if (ds_list_find_index(global.rewardList, name) != -1)
                    {
                        if (global.newUnderworld == false)
                        {
                            if (level >= 200)
                            {
                                ini_open(string(global.platformDir) + string(myCharDir) + "Data.ini");
                                
                                if (gotAura[global.randAura] == 1)
                                {
                                    auraBonus[global.randAura] += 5 * auraPowerBonus;
                                    ini_write_real("Build", "Aura " + string(global.randAura) + " Bonus", auraBonus[global.randAura]);
                                }
                                
                                if (gotAura[global.randAura] == 0)
                                {
                                    gotAura[global.randAura] = 1;
                                    auraBonus[global.randAura] += 5 * auraPowerBonus;
                                    ini_write_real("Build", "Got Aura " + string(global.randAura), 1);
                                    ini_write_real("Build", "Aura " + string(global.randAura) + " Bonus", auraBonus[global.randAura]);
                                }
                                
                                ini_close();
                            }
                        }
                        else
                        {
                            ini_open(string(global.platformDir) + string(myCharDir) + "Data.ini");
                            
                            for (var i = 1; i <= global.totalAuras; i++)
                            {
                                gotAura[i] = 1;
                                auraBonus[i] += 5 * auraPowerBonus;
                                ini_write_real("Build", "Got Aura " + string(i), 1);
                                ini_write_real("Build", "Aura " + string(i) + " Bonus", auraBonus[i]);
                            }
                            
                            ini_close();
                        }
                    }
                }
                
                if (global.gotWitch == 1)
                {
                    gml_Script_twitch_chat_say("/color BlueViolet");
                    
                    if (soulType < 5)
                    {
                        global.bossSouls[soulType] += 1;
                        
                        if (global.bossSouls[soulType] == 1)
                            global.bossSoulsBonuses += 1;
                        
                        if (room == r_underworld)
                            gml_Script_twitch_chat_say_direct("/me You captured a fragment of " + string(name) + "'s soul! The witch will recreate its cycle of life, giving you passive rewards over time. Additionally, everyone on the Underworld obtained " + string(global.auraInfo[global.randAura][0]) + "! (Aura " + string(global.randAura) + ")");
                        
                        if (room == r_underworld_new)
                        {
                            if (global.portalTower < 4)
                                gml_Script_twitch_chat_say_direct("/me You defeated the Underworld Guardian " + string(name) + " on Tower #" + string(global.portalTower) + " [+1 Blood Gem] The mythical creature that was captive in this Tower is now free! (" + string(global.djinnInfo[global.djinnOrder[global.portalTower - 1]][1]) + ": " + string_replace(global.djinnInfo[global.djinnOrder[global.portalTower - 1]][3], "*", global.djinnInfo[global.djinnOrder[global.portalTower - 1]][2]) + ")");
                            
                            if (global.portalTower == 4)
                            {
                                gml_Script_twitch_chat_say_direct("/me You defeated the Underworld Guardian " + string(name) + " on Tower #" + string(global.portalTower) + " [+1 Blood Gem] ... Here is where the last mythical creature would have been, but we rescued the others just in time!");
                                gml_Script_twitch_chat_say("/me ...");
                                
                                with (gml_Script_instance_create(x, y, obj_cinematic))
                                {
                                    alarm[0] = room_speed;
                                    sequence = "finis start";
                                }
                                
                                global.onlyFinis = 1;
                                ini_open(string(global.platformDir) + "Village Data/Data.ini");
                                ini_write_real("Underworld", "Only Finis", global.onlyFinis);
                                ini_close();
                            }
                        }
                        
                        if (soulType == 4)
                        {
                            with (obj_player)
                            {
                                if (diaryQuest[42][0] == 50)
                                    gml_Script_scr_addDiaryProgress(9, 1);
                            }
                        }
                    }
                    else
                    {
                        if (global.finisKills == 0)
                        {
                            global.bloodgems += 1;
                            gml_Script_twitch_chat_say_direct("/me You made it... You defeated " + string(name) + ", the most powerful known creature... Where will this take you? Is your world free of evilness now? [+100%[+] power to all Auras, +250 room00Gem , +2 Blood Gems].");
                            gml_Script_twitch_chat_say_direct("/me ... The Red Portal emanates a strong energy pulse, teleporting you back to the Overworld.");
                        }
                        else
                        {
                            if (global.finisKills == 1)
                            {
                                gml_Script_twitch_chat_say_direct("/me You defeated the Hollow version of Finis (v" + string(global.finisKills) + ") [+1 Blood Gem]... You can now go through the Red Portal into the Corrupted Dimension... good luck (entering in 24h).");
                            }
                            else if (global.redPortalOpen == false)
                            {
                                if (global.redPortalCost > 1)
                                    global.redPortalCost -= 1;
                                
                                if (global.redPortalCost <= 0)
                                {
                                    global.redPortalCost = 0;
                                    gml_Script_twitch_chat_say_direct("/me You defeated another Hollow version of Finis (v" + string(global.finisKills) + ") [+1 Blood Gem]... It is getting stronger each time you defeat it! By defeating Hollow Finis Vitae again you completed the Red Portal ritual! (entering in 24h)");
                                }
                                else
                                {
                                    gml_Script_twitch_chat_say_direct("/me You defeated another Hollow version of Finis (v" + string(global.finisKills) + ") [+1 Blood Gem]... It is getting stronger each time you defeat it! By defeating Hollow Finis Vitae, the Red Portal ritual progressed, and it is now missing " + string(global.redPortalCost) + " Blood Gems to be completed.");
                                }
                            }
                            else
                            {
                                gml_Script_twitch_chat_say_direct("/me You defeated another Hollow version of Finis (v" + string(global.finisKills) + ") [+1 Blood Gem]... It is getting stronger each time you defeat it! The Red Portal ritual is completed and you will be entering the Corrupted Dimension soon, remember to join with !redportal.");
                            }
                            
                            ini_open(string(global.platformDir) + "Village Data/Data.ini");
                            
                            if (global.unlockCorrupted == 0)
                            {
                                if (obj_corruptedControl.alarm[0] == -1)
                                    obj_corruptedControl.alarm[0] = room_speed * 86400;
                                
                                global.redPortalOpen = true;
                                global.unlockCorrupted = 1;
                                ini_write_real("Corrupted Dimension", "Unlocked", global.unlockCorrupted);
                                obj_seasonControl.alarm[4] = room_speed;
                                
                                with (obj_gameControl)
                                {
                                    customDisplayTab[8] = "Corruption Shards";
                                    customTabs = array_length(customDisplayTab) - 1;
                                }
                            }
                            
                            ini_write_real("Corrupted Dimension", "Portal Ritual", global.redPortalCost);
                            ini_write_real("Corrupted Dimension", "Red Portal Timer", obj_corruptedControl.alarm[0]);
                            ini_close();
                        }
                        
                        global.finisKills += 1;
                        
                        if (global.finisKills == 1)
                            global.bossSoulsBonuses += 3;
                        
                        if (instance_exists(obj_enemySpawner))
                        {
                            with (obj_enemySpawner)
                                instance_destroy();
                        }
                        
                        ini_open(string(global.platformDir) + "Village Data/Data.ini");
                        ini_write_real("Underworld", "Final Boss HP", 0);
                        ini_write_real("Underworld", "Finis Kills", global.finisKills);
                        obj_portal.bossHP = 0;
                        ini_close();
                        
                        with (obj_player)
                        {
                            if (ds_list_find_index(global.rewardList, name) != -1)
                            {
                            }
                            
                            if (global.finisKills == 1)
                            {
                                if (ascended == false)
                                {
                                    myGems += 250;
                                    achievement[4] += 1;
                                    
                                    for (var a = 1; a <= global.totalAuras; a += 1)
                                    {
                                        gotAura[a] = 1;
                                        auraBonus[a] += 100 * auraPowerBonus;
                                        
                                        if (auraBonus[myAura] >= 50)
                                        {
                                            if (global.milestone[4][4] == 0)
                                            {
                                                with (gml_Script_instance_create(room_width / 2, room_height / 2, obj_showMilestone))
                                                {
                                                    type = 4;
                                                    icon = 0;
                                                    name = other.name;
                                                }
                                            }
                                        }
                                        
                                        if (auraBonus[myAura] >= 200)
                                        {
                                            if (global.milestone[5][4] == 0)
                                            {
                                                with (gml_Script_instance_create(room_width / 2, room_height / 2, obj_showMilestone))
                                                {
                                                    type = 5;
                                                    icon = 1;
                                                    name = other.name;
                                                }
                                            }
                                        }
                                        
                                        if (auraBonus[myAura] >= 500)
                                        {
                                            if (global.milestone[6][4] == 0)
                                            {
                                                with (gml_Script_instance_create(room_width / 2, room_height / 2, obj_showMilestone))
                                                {
                                                    type = 6;
                                                    icon = 2;
                                                    name = other.name;
                                                }
                                            }
                                        }
                                        
                                        if (auraBonus[myAura] >= 1000)
                                        {
                                            if (global.milestone[7][4] == 0)
                                            {
                                                with (gml_Script_instance_create(room_width / 2, room_height / 2, obj_showMilestone))
                                                {
                                                    type = 7;
                                                    icon = 3;
                                                    name = other.name;
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            
                            if (diaryQuest[42][0] == 50)
                                gml_Script_scr_addDiaryProgress(9, 1);
                            
                            if (diaryQuest[43][0] == 51)
                                gml_Script_scr_addDiaryProgress(9, 1);
                        }
                    }
                    
                    gml_Script_twitch_chat_say("/color FireBrick");
                }
                
                global.randAura = irandom_range(1, global.totalAuras);
            }
        }
        
        with (obj_enemy)
        {
            if (myNumber > other.myNumber)
                myNumber -= 1;
        }
        
        global.enemyNumber -= 1;
        
        with (obj_player)
        {
            if (state == UnknownEnum.Value_8)
                gml_Script_scr_addDiaryProgress(-1, other.level);
        }
        
        if (instance_exists(obj_quest))
        {
            if (obj_quest.questType == "kill")
            {
                obj_quest.progress += level;
                
                with (obj_warrior)
                {
                    if (myRaidNumber <= 0)
                    {
                        enemyLevel = other.level;
                        
                        with (player)
                        {
                            if ((reputation + other.enemyLevel) < questReputation)
                            {
                                reputation += other.enemyLevel;
                            }
                            else
                            {
                                with (gml_Script_instance_create(x, y, obj_blueOrb))
                                {
                                    xx = obj_build_guildhall.x;
                                    yy = obj_build_guildhall.y - 30;
                                    type = "kill";
                                }
                                
                                reputation = 0;
                                
                                if (reputationCompleted == false)
                                    achievement[24] += 1;
                                
                                reputationCompleted = true;
                                questReputation *= 1.5;
                                tickxpvalue = 6 + obj_build_train.level + ((maxxp / 20 / level) * (1 + (obj_build_train.level / 20)));
                                gml_Script_scr_player_reward(tickxpvalue, 0);
                            }
                        }
                    }
                }
            }
        }
        
        if (instance_exists(obj_warrior))
        {
            target = instance_nearest(x, y, obj_warrior);
            
            if (arg0 != -1)
            {
                with (arg0)
                {
                    if ((stamina + 10) > maxStamina)
                        stamina = maxStamina;
                    else
                        stamina += 10;
                }
            }
            
            with (obj_warrior)
            {
                if (myRaidNumber == 0)
                {
                    if (gml_Script_scr_alarm_get(2) != -1)
                        gml_Script_scr_w1s2_retrigger();
                    
                    if ((stamina + 10) > maxStamina)
                        stamina = maxStamina;
                    else
                        stamina += 10;
                    
                    if (equippedUniqueItem[10] == 1 || equippedUniqueItem[11] == 1 || equippedUniqueItem[12] == 1 || player.myPetEquippedRelic[myPetID][10] == 1 || player.myPetEquippedRelic[myPetID][11] == 1 || player.myPetEquippedRelic[myPetID][12] == 1)
                        simStacks += 1;
                    
                    var _relicValue = gml_Script_scr_relicEffect(player, 0, 10);
                    
                    if (_relicValue > 0)
                    {
                        _relicValue = myStatInfo[0][2] * _relicValue;
                        
                        if (myStatInfo[0][3] < myStatInfo[0][5])
                        {
                            simDmg += _relicValue;
                            gml_Script_scr_statChange(_relicValue, undefined, 0, undefined, undefined, 1);
                        }
                        
                        gml_Script_scr_alarm_start(12, room_speed * 6, gml_Script_scr_sim_end);
                    }
                    
                    _relicValue = gml_Script_scr_relicEffect(player, 0, 11);
                    
                    if (_relicValue > 0)
                    {
                        _relicValue = myStatInfo[8][2] * _relicValue;
                        
                        if (myStatInfo[8][3] < myStatInfo[8][5])
                        {
                            simHP += _relicValue;
                            gml_Script_scr_statChange(_relicValue, undefined, 8, undefined, undefined, 1);
                        }
                        
                        gml_Script_scr_alarm_start(12, room_speed * 6, gml_Script_scr_sim_end);
                    }
                    
                    _relicValue = gml_Script_scr_relicEffect(player, 0, 12);
                    
                    if (_relicValue > 0)
                    {
                        _relicValue = myStatInfo[9][2] * _relicValue;
                        
                        if (myStatInfo[9][3] < myStatInfo[9][5])
                        {
                            simInt += _relicValue;
                            gml_Script_scr_statChange(_relicValue, undefined, 9, undefined, undefined, 1);
                        }
                        
                        gml_Script_scr_alarm_start(12, room_speed * 6, gml_Script_scr_sim_end);
                    }
                    
                    if (player.myAura > 0)
                    {
                        player.auraBonus[player.myAura] += 0.002 * player.auraPowerBonus;
                        
                        if (player.auraBonus[player.myAura] >= 50)
                        {
                            if (global.milestone[4][4] == 0)
                            {
                                with (gml_Script_instance_create(room_width / 2, room_height / 2, obj_showMilestone))
                                {
                                    type = 4;
                                    icon = 0;
                                    name = other.name;
                                }
                            }
                        }
                        
                        if (player.auraBonus[player.myAura] >= 200)
                        {
                            if (global.milestone[5][4] == 0)
                            {
                                with (gml_Script_instance_create(room_width / 2, room_height / 2, obj_showMilestone))
                                {
                                    type = 5;
                                    icon = 1;
                                    name = other.name;
                                }
                            }
                        }
                        
                        if (player.auraBonus[player.myAura] >= 500)
                        {
                            if (global.milestone[6][4] == 0)
                            {
                                with (gml_Script_instance_create(room_width / 2, room_height / 2, obj_showMilestone))
                                {
                                    type = 6;
                                    icon = 2;
                                    name = other.name;
                                }
                            }
                        }
                        
                        if (player.auraBonus[player.myAura] >= 1000)
                        {
                            if (global.milestone[7][4] == 0)
                            {
                                with (gml_Script_instance_create(room_width / 2, room_height / 2, obj_showMilestone))
                                {
                                    type = 7;
                                    icon = 3;
                                    name = other.name;
                                }
                            }
                        }
                    }
                }
            }
        }
        
        if (summoned == 0)
            global.raidKills += 1;
        
        global.raidXP += ((value * (1 + ((tier - 1) * 10))) / 1.1);
        
        if (class == "boss")
            global.raidXP *= 6;
        
        if (class == "boss")
            global.raidGold *= 2;
        
        global.creditsKills += 1;
        
        if (type == "final")
        {
            if (instance_exists(obj_enemy))
            {
                with (obj_enemy)
                {
                    if (id != other.id)
                        gml_Script_scr_death_enemy(arg0);
                }
            }
        }
        
        instance_destroy();
        
        if (instance_exists(obj_deathRain))
        {
            if (global.rainDmg >= 1)
                global.rainDmg *= 0.9;
            
            if (global.rainArmor >= 0.03)
                global.rainArmor = 0.03;
        }
        
        if (global.inFinalWar == false)
        {
            if (instance_number(obj_enemy) <= 0 && global.raidEnd == true)
            {
                gml_Script_scr_clearDeathRain();
                gml_Script_scr_playsound(s_raidWin, 0.8, 1.2, 0.5);
                
                if (global.enemyRaid == false)
                {
                    with (obj_raid)
                    {
                        if (global.stageType == "Dungeon")
                            alarm[2] = room_speed * 680;
                        else if (room == r_1)
                            alarm[2] = room_speed * 680;
                    }
                }
                else if (room == r_1)
                {
                    with (obj_raid)
                        alarm[6] = room_speed * 10;
                }
                
                if (room == r_1)
                {
                    with (gml_Script_instance_create(room_width / 2, room_height - 300, obj_raidResults))
                    {
                        result = 0;
                        global.raidXP += (10 + (global.stage * 6 * (1 + (global.stage / 30))));
                        global.raidGold += (2 + (global.stage * 5 * (1 + (global.stage / 10))));
                        
                        if (global.keyFragsTier < 14)
                        {
                            var _dropKey = 0;
                            
                            if (obj_raid.boss == true)
                                _dropKey = 3;
                            else
                                _dropKey = irandom(3);
                            
                            if (global.enemyRaid == true)
                                _dropKey = 0;
                            
                            if (_dropKey == 3)
                                gml_Script_instance_create(room_width / 2, room_height - 50, obj_keyFrag);
                            
                            if (global.keyFrags == 6)
                                gml_Script_twitch_chat_say_direct("/me SMOrc You completed the Dungeon Boss Key! Prepare for battle and type !boss whenever you're ready or collect more key fragments to increase the Dungeon Tier! SMOrc");
                        }
                        
                        if (instance_exists(obj_uniqueItem))
                            alarm[0] = room_speed * 30;
                        else
                            alarm[0] = room_speed * 10;
                    }
                }
                
                if (room == global.room_underworld)
                {
                    with (gml_Script_instance_create(room_width / 2, room_height - 300, obj_raidPortalResults))
                    {
                        result = 0;
                        global.raidXP += (10 + (global.stage * 5 * (1 + (global.stage / 60))));
                        global.raidGold += (10 + (global.stage * 5 * (1 + (global.stage / 100))));
                        alarm[0] = room_speed * 30;
                    }
                }
                
                if (room == r_corrupted)
                {
                    with (gml_Script_instance_create(room_width / 2, room_height - 300, obj_raidCorruptedResults))
                    {
                        result = 0;
                        alarm[0] = room_speed * 300;
                    }
                }
            }
            
            if (instance_number(obj_enemy) <= 1 && global.raidEnd == false)
            {
                if (room == r_1)
                    obj_raid.alarm[0] = 1;
                
                if (room == global.room_underworld)
                    obj_raidPortal.alarm[0] = 1;
                
                if (room == r_corrupted)
                    obj_raidCorrupted.alarm[0] = 1;
            }
        }
        else if (instance_number(obj_enemy) <= 1 && global.raidEnd == false)
        {
            if (room == r_1)
                obj_raid.alarm[10] = 1;
        }
    }
    else
    {
        if (alarm[7] == -1)
            alarm[7] = room_speed * resTimer;
        
        resurrect = 0;
    }
};

enum UnknownEnum
{
    Value_8 = 8
}
