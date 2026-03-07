if (room == r_1)
{
    if (global.extraRewardsTimer >= global.extraRewardsTimerMax)
    {
        if (global.raiding == true && !instance_exists(obj_enemy) && !instance_exists(obj_warrior) && !instance_exists(obj_raidResults))
        {
            alarm[3] = room_speed;
            
            with (gml_Script_instance_create(room_width / 2, room_height - 300, obj_raidResults))
            {
                result = 1;
                alarm[0] = room_speed;
            }
        }
    }
    
    draw_sprite(spr_HUDtop, 0, 0, room_height - 340);
    
    if (alarm[4] == (room_speed * 60) && global.raiding == false && global.raidCall == false)
    {
        if (!gml_Script_sound_isplaying(s_trumpet))
        {
            gml_Script_scr_playsound(s_horn, 1, 1.4, 0.7);
            global.stage = round(random_range(1 + (global.stage / 4), global.stage + 5));
            gml_Script_twitch_chat_say("/color Red");
            gml_Script_twitch_chat_say_direct("/me Enemy troops detected nearby! Prepare to " + string(global.cmdPrefix) + "defend the town! [" + gml_Script_scr_bigNumber(global.stage) + "]");
            gml_Script_twitch_chat_say("/color FireBrick");
        }
    }
    
    if (global.cameraMove == true && global.raiding == false && !instance_exists(obj_bigBoss1))
    {
        with (obj_raidObject)
            x -= (bgSpd / 10);
        
        with (obj_raidBackground)
            x -= (bgSpd / 10);
        
        with (obj_float)
        {
            if (y > (room_height - 300))
                x -= (bgSpd / 10);
        }
    }
    
    if (global.inFinalWar == false)
    {
        if (alarm[4] < (room_speed * 180) && (obj_bossKey.alarm[0] < (room_speed * 120) && obj_bossKey.alarm[0] != -1))
        {
            alarm[4] = room_speed * 180;
            
            if (global.raiding == false && global.raidCall == false)
                global.stage = global.ostage;
        }
        
        if (alarm[4] < (room_speed * 500) && obj_twitch.alarm[0] < (room_speed * 120))
        {
            alarm[4] = room_speed * 500;
            
            if (global.raiding == false && global.raidCall == false)
                global.stage = global.ostage;
        }
        
        if (alarm[9] != -1 && (global.raiding == true || global.raidCall == true))
        {
            if (alarm[9] <= (room_speed * 60))
                alarm[9] = room_speed * 60;
        }
    }
    else
    {
        alarm[4] = room_speed * 1000;
    }
    
    if (global.arenaCall == false)
    {
        draw_set_valign(fa_middle);
        
        if (global.raiding == true)
        {
            if (!instance_exists(obj_combatGraphs))
            {
                var _last = 0;
                draw_sprite_ext(spr_black, 0, (room_width / 2) - 472, room_height - 330, 220, 60, 0, c_white, 0.5);
                draw_sprite_ext(spr_whitebar, 0, (room_width / 2) - 462, room_height - 305, 204, 1.2, 0, c_black, 1);
                
                for (var t = 0; t < global.damageTypes; t++)
                {
                    draw_sprite_ext(spr_whitebar, 0, ((room_width / 2) - 460) + _last, room_height - 305, (ds_grid_get_sum(global.combatStats1, t + 2, 0, t + 2, global.raidNumber) / ds_grid_get_sum(global.combatStats1, 1, 0, 1, global.raidNumber)) * 200, 1, 0, c_dmgType[t + 1], 1);
                    _last += ((ds_grid_get_sum(global.combatStats1, t + 2, 0, t + 2, global.raidNumber) / ds_grid_get_sum(global.combatStats1, 1, 0, 1, global.raidNumber)) * 200);
                }
                
                draw_set_font(f_special);
                draw_set_halign(fa_right);
                gml_Script_scr_textoutline(((room_width / 2) - 460) + 200, room_height - 320, gml_Script_scr_bigNumber(ds_grid_get_sum(global.combatStats1, 1, 0, 1, global.raidNumber)), 16777215, 0, 20, 500);
                draw_set_halign(fa_left);
                gml_Script_scr_textoutline((room_width / 2) - 460, room_height - 320, "Damage Dealt:", 16777215, 0, 20, 500);
                
                for (var i = 0; i < 3; i++)
                {
                    if (ds_grid_get(global.combatStats1, 1, i) > 0)
                    {
                        draw_sprite_ext(spr_whitebar, 0, (room_width / 2) - 462, (room_height - 275) + (i * 25), 204, 1.2, 0, c_black, 1);
                        _last = 0;
                        
                        for (var t = 0; t < global.damageTypes; t++)
                        {
                            draw_sprite_ext(spr_whitebar, 0, ((room_width / 2) - 460) + _last, (room_height - 275) + (i * 25), (ds_grid_get(global.combatStats1, t + 2, i) / ds_grid_get_sum(global.combatStats1, 1, 0, 1, global.raidNumber)) * 200, 1, 0, c_dmgType[t + 1], 1);
                            _last += ((ds_grid_get(global.combatStats1, t + 2, i) / ds_grid_get_sum(global.combatStats1, 1, 0, 1, global.raidNumber)) * 200);
                        }
                        
                        draw_set_halign(fa_left);
                        var _displayName = string(ds_grid_get(global.combatStats1, 0, i));
                        
                        if (string_pos("ascended ", _displayName) == 1)
                        {
                            var _oldName = string_delete(_displayName, 1, 9);
                            _displayName = "# " + string_delete(_oldName, 16, 100) + "...";
                        }
                        
                        gml_Script_scr_textoutline((room_width / 2) - 460, (room_height - 290) + (i * 25), string(_displayName) + ":", 16777215, 0, 20, 500);
                        draw_set_halign(fa_right);
                        gml_Script_scr_textoutline(((room_width / 2) - 460) + 200, (room_height - 290) + (i * 25), gml_Script_scr_bigNumber(ds_grid_get(global.combatStats1, 1, i)), 16777215, 0, 20, 500);
                    }
                }
                
                _last = 0;
                draw_sprite_ext(spr_black, 0, (room_width / 2) - 172, room_height - 330, 220, 60, 0, c_white, 0.5);
                draw_sprite_ext(spr_whitebar, 0, (room_width / 2) - 162, room_height - 305, 204, 1.2, 0, c_black, 1);
                
                for (var t = 0; t < global.damageTypes; t++)
                {
                    draw_sprite_ext(spr_whitebar, 0, ((room_width / 2) - 160) + _last, room_height - 305, (ds_grid_get_sum(global.combatStats2, t + 2, 0, t + 2, global.raidNumber) / ds_grid_get_sum(global.combatStats2, 1, 0, 1, global.raidNumber)) * 200, 1, 0, c_dmgType[t + 1], 1);
                    _last += ((ds_grid_get_sum(global.combatStats2, t + 2, 0, t + 2, global.raidNumber) / ds_grid_get_sum(global.combatStats2, 1, 0, 1, global.raidNumber)) * 200);
                }
                
                draw_set_font(f_special);
                draw_set_halign(fa_right);
                gml_Script_scr_textoutline(((room_width / 2) - 160) + 200, room_height - 320, gml_Script_scr_bigNumber(ds_grid_get_sum(global.combatStats2, 1, 0, 1, global.raidNumber)), 16777215, 0, 20, 500);
                draw_set_halign(fa_left);
                gml_Script_scr_textoutline((room_width / 2) - 160, room_height - 320, "Damage Received:", 16777215, 0, 20, 500);
                
                for (var i = 0; i < 3; i++)
                {
                    if (ds_grid_get(global.combatStats2, 1, i) > 0)
                    {
                        draw_sprite_ext(spr_whitebar, 0, (room_width / 2) - 162, (room_height - 275) + (i * 25), 204, 1.2, 0, c_black, 1);
                        _last = 0;
                        
                        for (var t = 0; t < global.damageTypes; t++)
                        {
                            draw_sprite_ext(spr_whitebar, 0, ((room_width / 2) - 160) + _last, (room_height - 275) + (i * 25), (ds_grid_get(global.combatStats2, t + 2, i) / ds_grid_get_sum(global.combatStats2, 1, 0, 1, global.raidNumber)) * 200, 1, 0, c_dmgType[t + 1], 1);
                            _last += ((ds_grid_get(global.combatStats2, t + 2, i) / ds_grid_get_sum(global.combatStats2, 1, 0, 1, global.raidNumber)) * 200);
                        }
                        
                        draw_set_halign(fa_left);
                        var _displayName = string(ds_grid_get(global.combatStats2, 0, i));
                        
                        if (string_pos("ascended ", _displayName) == 1)
                        {
                            var _oldName = string_delete(_displayName, 1, 9);
                            _displayName = "# " + string_delete(_oldName, 16, 100) + "...";
                        }
                        
                        gml_Script_scr_textoutline((room_width / 2) - 160, (room_height - 290) + (i * 25), string(_displayName) + ":", 16777215, 0, 20, 500);
                        draw_set_halign(fa_right);
                        gml_Script_scr_textoutline(((room_width / 2) - 160) + 200, (room_height - 290) + (i * 25), gml_Script_scr_bigNumber(ds_grid_get(global.combatStats2, 1, i)), 16777215, 0, 20, 500);
                    }
                }
            }
            
            if (!instance_exists(obj_raidResults) && !instance_exists(obj_raidPortalResults))
            {
                global.raidTime += (1 / room_speed);
                draw_sprite_ext(spr_blackbar, 0, ((room_width / 2) + 300) - 203, room_height - 251, 406, 3, 0, c_white, 1);
                
                if (global.extraRewardsTimer < global.extraRewardsTimerMax)
                {
                    global.extraRewardsTimer += (1 / room_speed);
                    draw_sprite_ext(spr_manabarsmall, 0, ((room_width / 2) + 300) - 199, room_height - 246, (global.extraRewardsTimer / global.extraRewardsTimerMax) * 398, 1, 0, c_white, 1);
                }
                else
                {
                    draw_set_font(f_mid);
                    draw_set_halign(fa_center);
                    draw_sprite_ext(spr_enemyhpbarsmall, 0, ((room_width / 2) + 300) - 199, room_height - 246, 398, 1, 0, c_white, 1);
                    draw_sprite_ext(spr_black, 0, ((room_width / 2) + 290) - (string_width("Blood Rain: -" + gml_Script_scr_bigNumber(global.rainDmg) + " HP/s") / 2), room_height - 244, string_width("Blood Rain DMG: " + gml_Script_scr_bigNumber(global.rainDmg)) + 20, 25, 0, c_white, 0.5);
                    gml_Script_scr_textgradient((room_width / 2) + 300, room_height - 235, "Blood Rain: -" + gml_Script_scr_bigNumber(global.rainDmg) + " HP/s", 255, 128);
                    
                    if (global.inFinalWar == false)
                    {
                        if (!instance_exists(obj_deathRain))
                            gml_Script_instance_create(x, y, obj_deathRain);
                    }
                }
                
                draw_sprite_ext(spr_xpbarsmall, 0, ((room_width / 2) + 300) - 199, room_height - 254, (global.raidKills / maxEnemies) * 398, 2, 0, c_white, 1);
            }
            
            draw_set_font(f_mid);
            draw_set_halign(fa_right);
            
            if (!instance_exists(obj_raidResults))
            {
                draw_sprite_ext(spr_black, 0, room_width - 280 - string_width("Raid Items: " + string(global.displayRaidItems) + "/" + string(10 + (global.hunterGuildLevel * 2))), room_height - 260, 220, 80, 0, c_white, 0.8);
                draw_set_font(f_special);
                gml_Script_scr_textshadow(room_width - 320, room_height - 200, "Last drop:", 16777215, 0, 34, 1620);
            }
            else
            {
                draw_sprite_ext(spr_black, 0, room_width - 280 - string_width("Raid Items: " + string(global.displayRaidItems) + "/" + string(10 + (global.hunterGuildLevel * 2))), room_height - 260, 220, 40, 0, c_white, 0.8);
            }
            
            draw_set_font(f_mid);
            gml_Script_scr_textshadow(room_width - 260, room_height - 240, "Raid Items: " + string(global.displayRaidItems) + "/" + string(10 + (global.hunterGuildLevel * 2)), 16777215, 0, 34, 1620);
        }
        
        global.warriorBonusAmount = power(1 + (global.warriorBonus / 20), 1.5) - 1;
        global.rogueBonusAmount = power(1 + (global.rogueBonus / 8), 1.5) - 1;
        global.rangerBonusAmount = power(global.rangerBonus, 1.5) / 7;
        global.wizardBonusAmount = power(1 + (global.wizardBonus / 10), 1.5) - 1;
        draw_set_halign(fa_left);
        draw_set_valign(fa_middle);
        draw_set_font(f_mid);
        draw_sprite_ext(spr_black, 0, 20, room_height - 300, 30 + string_width(string_hash_to_newline("+" + string(global.warriorBonusAmount) + "     | " + "+" + string(global.rogueBonusAmount) + "     | " + "+" + string(global.rangerBonusAmount) + "%     | " + "+" + string(global.wizardBonusAmount))), 20, 0, c_white, 0.8);
        gml_Script_scr_textgradient(20, room_height - 315, "Party Bonuses (" + string(global.raiders) + " Raiders [Ranged: " + string(ds_list_size(global.raidList1)) + " | Melee: " + string(ds_list_size(global.raidList0)) + "]):", undefined, undefined, undefined, 20, 1000);
        gml_Script_scr_textoutline(25, room_height - 290, "+" + string(global.warriorBonusAmount) + "     | " + "+" + string(global.rogueBonusAmount) + "     | " + "+" + string(global.rangerBonusAmount) + "%     | " + "+" + string(global.wizardBonusAmount), 16777215, 0, 20, 1000);
        draw_sprite_ext(spr_statusIcons, 6, 35 + string_width(string_hash_to_newline("+" + string(global.warriorBonusAmount))), room_height - 290, 1, 1, 0, c_white, 1);
        draw_sprite_ext(spr_statusIcons, 0, 35 + string_width(string_hash_to_newline("+" + string(global.warriorBonusAmount) + "     | " + "+" + string(global.rogueBonusAmount))), room_height - 290, 1, 1, 0, c_white, 1);
        draw_sprite_ext(spr_statusIcons, 3, 35 + string_width(string_hash_to_newline("+" + string(global.warriorBonusAmount) + "     | " + "+" + string(global.rogueBonusAmount) + "     | " + "+" + string(global.rangerBonusAmount) + "%")), room_height - 290, 1, 1, 0, c_white, 1);
        draw_sprite_ext(spr_statusIcons, 9, 35 + string_width(string_hash_to_newline("+" + string(global.warriorBonusAmount) + "     | " + "+" + string(global.rogueBonusAmount) + "     | " + "+" + string(global.rangerBonusAmount) + "%     | " + "+" + string(global.wizardBonusAmount))), room_height - 290, 1, 1, 0, c_white, 1);
        
        if (alarm[1] == -1 && global.raiding == false && global.enemyRaid == false && alarm[4] > (room_speed * 60))
        {
            draw_set_font(f_midbig);
            draw_set_halign(fa_center);
            
            if (obj_bossKey.alarm[1] == -1)
            {
                if ((global.ostage % 50) != 0)
                    gml_Script_scr_textgradient(room_width / 2, room_height - 270 - 45, "No active " + string(global.cmdPrefix) + "raid# (Raid " + gml_Script_scr_bigNumber(global.ostage) + ")", 16777215, 12632256, undefined, 34, 1620);
                
                if ((global.ostage % 50) == 0 && (global.ostage % 250) != 0 && (global.ostage % 1000) != 0)
                {
                    if (gml_Script_scr_alarm_get(50 + (global.ostage / 50)) == -1)
                        gml_Script_scr_textgradient(room_width / 2, room_height - 270 - 45, "Territory Boss " + string(global.ostage / 50) + " " + string(global.cmdPrefix) + "raid# (Raid " + gml_Script_scr_bigNumber(global.ostage) + ")", 16777215, 12632256, undefined, 34, 1620);
                    else
                        gml_Script_scr_textgradient(room_width / 2, room_height - 270 - 45, "No active " + string(global.cmdPrefix) + "raid# (Raid " + gml_Script_scr_bigNumber(global.ostage) + ")", 16777215, 12632256, undefined, 34, 1620);
                }
                else if ((global.ostage % 250) == 0 && (global.ostage % 1000) != 0)
                {
                    if (gml_Script_scr_alarm_get(50 + (global.ostage / 50)) == -1)
                        gml_Script_scr_textgradient(room_width / 2, room_height - 270 - 45, "Biome Boss " + string(global.ostage / 250) + " " + string(global.cmdPrefix) + "raid# (Raid " + gml_Script_scr_bigNumber(global.ostage) + ")", 16777215, 12632256, undefined, 34, 1620);
                    else
                        gml_Script_scr_textgradient(room_width / 2, room_height - 270 - 45, "No active " + string(global.cmdPrefix) + "raid# (Raid " + gml_Script_scr_bigNumber(global.ostage) + ")", 16777215, 12632256, undefined, 34, 1620);
                }
                else if ((global.ostage % 1000) == 0)
                {
                    if (gml_Script_scr_alarm_get(50 + (global.ostage / 50)) == -1)
                        gml_Script_scr_textgradient(room_width / 2, room_height - 270 - 45, "Legendary Boss " + string(global.ostage / 1000) + " " + string(global.cmdPrefix) + "raid# (Raid " + gml_Script_scr_bigNumber(global.ostage) + ")", 16777215, 12632256, undefined, 34, 1620);
                    else
                        gml_Script_scr_textgradient(room_width / 2, room_height - 270 - 45, "No active " + string(global.cmdPrefix) + "raid# (Raid " + gml_Script_scr_bigNumber(global.ostage) + ")", 16777215, 12632256, undefined, 34, 1620);
                }
                
                if (!instance_exists(obj_raidResults) && alarm[2] == -1)
                {
                    draw_set_halign(fa_center);
                    draw_set_font(f_mid);
                    var _biomeTier = 1;
                    
                    if (global.ostage > 500)
                        _biomeTier += 1;
                    
                    if (global.ostage > 1000)
                        _biomeTier += 1;
                    
                    if (global.ostage > 1500)
                        _biomeTier += 1;
                    
                    if (global.ostage > 2000)
                        _biomeTier += 1;
                    
                    var _raidReward;
                    _raidReward[0][0] = 0;
                    _raidReward[0][1] = spr_talentscrollIcon;
                    _raidReward[0][2] = 1 + floor(global.townLevel / 4);
                    _raidReward[0][3] = 100;
                    _raidReward[0][4] = 0.75;
                    
                    if ((global.ostage % 50) == 0 && gml_Script_scr_alarm_get(50 + floor(global.ostage / 50)) == -1)
                    {
                        _raidReward[0][2] = (15 + global.townLevel + floor((global.ostage / 50) * 5)) * _biomeTier;
                        _raidReward[1][0] = specialRaid[floor(global.ostage / 50)][1];
                        _raidReward[1][1] = spr_uniqueItem;
                        _raidReward[1][2] = 1;
                        _raidReward[1][3] = 20;
                        _raidReward[1][4] = 0.75;
                        _raidReward[2][0] = specialRaid[floor(global.ostage / 50)][2];
                        _raidReward[2][1] = spr_uniqueItem;
                        _raidReward[2][2] = 1;
                        _raidReward[2][3] = 20;
                        _raidReward[2][4] = 0.75;
                        _raidReward[3][0] = specialRaid[floor(global.ostage / 50)][3];
                        _raidReward[3][1] = spr_uniqueItem;
                        _raidReward[3][2] = 1;
                        _raidReward[3][3] = 20;
                        _raidReward[3][4] = 0.75;
                        
                        if ((global.ostage % 250) == 0)
                        {
                            for (var i = 1; i <= 3; i++)
                                _raidReward[i][3] = 33;
                            
                            _raidReward[4][0] = 1;
                            _raidReward[4][1] = spr_honorShopItems;
                            _raidReward[4][2] = round((global.ostage / 50) * 2) * _biomeTier;
                            _raidReward[4][3] = 100;
                            _raidReward[4][4] = 0.3;
                            
                            if ((global.ostage % 1000) == 0)
                            {
                                _raidReward[4][2] = round((global.ostage / 50) * 3) * (_biomeTier + 1);
                                _raidReward[0][2] = (15 + global.townLevel + floor((global.ostage / 50) * 5)) * (_biomeTier + 1);
                            }
                        }
                    }
                    else
                    {
                    }
                    
                    var _xposRR = room_width / 2;
                    var _xposW = 0;
                    var _yposRR = room_height - 285;
                    var _rewardsAmount = array_length(_raidReward);
                    _xposW += (20 * _rewardsAmount);
                    draw_set_font(f_special);
                    draw_set_halign(fa_right);
                    
                    for (var ii = 0; ii < _rewardsAmount; ii++)
                    {
                        if (_raidReward[ii][2] > 0)
                        {
                            draw_sprite_ext(_raidReward[ii][1], _raidReward[ii][0], ((_xposRR + 35) - _xposW) + (string_width("Completion Rewards:") / 2) + (ii * 50), _yposRR, _raidReward[ii][4], _raidReward[ii][4], 0, c_white, 1);
                            
                            if (_raidReward[ii][3] < 100)
                                gml_Script_scr_textgradient(((_xposRR + 45) - _xposW) + (string_width("Completion Rewards:") / 2) + (ii * 50) + 10, _yposRR + 15, string(_raidReward[ii][3]) + "%", 16777215, 16777215, 0, 34, 1620);
                            
                            if (_raidReward[ii][2] > 1)
                                gml_Script_scr_textgradient(((_xposRR + 45) - _xposW) + (string_width("Completion Rewards:") / 2) + (ii * 50) + 10, _yposRR + 15, "x" + gml_Script_scr_bigNumber(_raidReward[ii][2]), 16777215, 16777215, 0, 34, 1620);
                        }
                    }
                    
                    draw_set_halign(fa_center);
                    draw_set_font(f_mid);
                    gml_Script_scr_textgradient(_xposRR - _xposW, _yposRR + 5, "Completion Rewards:", undefined, undefined, undefined, 34, 1620);
                    
                    for (var i = 0; i < _rewardsAmount; i++)
                    {
                        if (i < 4)
                        {
                        }
                        else
                        {
                        }
                        
                        if (_raidReward[i][3] != 100)
                        {
                        }
                    }
                }
                
                if (global.ostage >= 50)
                {
                    draw_sprite_ext(spr_black, 0, (room_width / 2) - 150, room_height - 260, 300, 260, 0, c_white, 0.8);
                    var _xx = room_width / 2;
                    var _yy = room_height - 165;
                    
                    for (var i = 1; i <= floor(global.ostage / 50); i++)
                    {
                        if (i == territoryBossesDisplayMain)
                        {
                            var _scale = 2;
                            var _bossColor = 8421504;
                            var _border = 0;
                            var _tier = 0;
                            var _prev = territoryBossesDisplayMain - 1;
                            
                            if (_prev <= 0)
                                _prev = array_length(specialRaid) - 1;
                            
                            var _next = territoryBossesDisplayMain + 1;
                            
                            if (_next > floor(global.ostage / 50))
                                _next = 1;
                            
                            draw_set_font(f_special);
                            
                            if (_prev > 0 && _prev != territoryBossesDisplayMain)
                            {
                                _tier = 0;
                                _border = 0;
                                
                                if ((_prev % 5) == 0)
                                {
                                    _border = 1;
                                    _tier += 1;
                                }
                                
                                if ((_prev % 20) == 0)
                                {
                                    _border = 2;
                                    _tier += 1;
                                }
                                
                                if (_prev > 10)
                                    _tier += 1;
                                
                                if (_prev > 20)
                                    _tier += 1;
                                
                                if (_prev > 30)
                                    _tier += 1;
                                
                                if (_prev > 40)
                                    _tier += 1;
                                
                                if (_prev > 50)
                                    _tier += 1;
                                
                                _tier = clamp(_tier, 0, 5);
                                
                                if (gml_Script_scr_alarm_get(50 + _prev) == -1)
                                {
                                    _bossColor = 8421504;
                                    draw_set_color(c_maroon);
                                }
                                else
                                {
                                    _bossColor = 4210752;
                                    draw_set_color(c_black);
                                }
                                
                                draw_ellipse(_xx - 80 - 30, _yy - 30, (_xx - 80) + 30, _yy + 30, 0);
                                draw_sprite_ext(spr_enemy_bossIcons, specialRaid[_prev][4], _xx - 80, _yy, _scale + 0.4, _scale + 0.4, 0, _bossColor, 1);
                                draw_sprite_ext(spr_enemyBorder, _border, _xx - 80, _yy, 1.5, 1.5, 0, c_gray, 1);
                                draw_sprite_ext(spr_enemyTier, 5 + _tier, _xx - 80, _yy, 1.5, 1.5, 0, c_dkgray, 1);
                                draw_set_font(f_mid);
                                gml_Script_scr_textgradient(_xx - 80, _yy - 30, string(_prev * 50), 12632256, 4210752, undefined, 34, 1620);
                                draw_set_font(f_special);
                                
                                if (gml_Script_scr_alarm_get(50 + _prev) != -1)
                                    gml_Script_scr_textoutline(_xx - 80, _yy + 30, "~" + string(ceil(gml_Script_scr_alarm_get(50 + _prev) / room_speed / 60)) + "m", 8421504, 0, 34, 1620);
                            }
                            
                            if (_next <= floor(global.ostage / 50) && _next != territoryBossesDisplayMain && _next != _prev)
                            {
                                _tier = 0;
                                _border = 0;
                                
                                if ((_next % 5) == 0)
                                {
                                    _border = 1;
                                    _tier += 1;
                                }
                                
                                if ((_next % 20) == 0)
                                {
                                    _border = 2;
                                    _tier += 1;
                                }
                                
                                if (_next > 10)
                                    _tier += 1;
                                
                                if (_next > 20)
                                    _tier += 1;
                                
                                if (_next > 30)
                                    _tier += 1;
                                
                                if (_next > 40)
                                    _tier += 1;
                                
                                if (_next > 50)
                                    _tier += 1;
                                
                                _tier = clamp(_tier, 0, 5);
                                
                                if (gml_Script_scr_alarm_get(50 + _next) == -1)
                                {
                                    _bossColor = 8421504;
                                    draw_set_color(c_maroon);
                                }
                                else
                                {
                                    _bossColor = 4210752;
                                    draw_set_color(c_black);
                                }
                                
                                draw_ellipse((_xx + 80) - 30, _yy - 30, _xx + 80 + 30, _yy + 30, 0);
                                draw_sprite_ext(spr_enemy_bossIcons, specialRaid[_next][4], _xx + 80, _yy, _scale + 0.4, _scale + 0.4, 0, _bossColor, 1);
                                draw_sprite_ext(spr_enemyBorder, _border, _xx + 80, _yy, 1.5, 1.5, 0, c_gray, 1);
                                draw_sprite_ext(spr_enemyTier, 5 + _tier, _xx + 80, _yy, 1.5, 1.5, 0, c_dkgray, 1);
                                draw_set_font(f_mid);
                                gml_Script_scr_textgradient(_xx + 80, _yy - 30, string(_next * 50), 12632256, 4210752, undefined, 34, 1620);
                                draw_set_font(f_special);
                                
                                if (gml_Script_scr_alarm_get(50 + _next) != -1)
                                    gml_Script_scr_textoutline(_xx + 80, _yy + 30, "~" + string(ceil(gml_Script_scr_alarm_get(50 + _next) / room_speed / 60)) + "m", 8421504, 0, 34, 1620);
                            }
                            
                            _scale = 3;
                            _border = 0;
                            _tier = 0;
                            _bossColor = 16777215;
                            
                            if ((territoryBossesDisplayMain % 5) == 0)
                            {
                                _border = 1;
                                _tier += 1;
                            }
                            
                            if ((territoryBossesDisplayMain % 20) == 0)
                            {
                                _border = 2;
                                _tier += 1;
                            }
                            
                            if (territoryBossesDisplayMain > 10)
                                _tier += 1;
                            
                            if (territoryBossesDisplayMain > 20)
                                _tier += 1;
                            
                            if (territoryBossesDisplayMain > 30)
                                _tier += 1;
                            
                            if (territoryBossesDisplayMain > 40)
                                _tier += 1;
                            
                            if (territoryBossesDisplayMain > 50)
                                _tier += 1;
                            
                            _tier = clamp(_tier, 0, 5);
                            
                            if (gml_Script_scr_alarm_get(50 + territoryBossesDisplayMain) == -1)
                            {
                                _bossColor = 16777215;
                                draw_set_color(c_red);
                            }
                            else
                            {
                                _bossColor = 8421504;
                                draw_set_color(c_black);
                            }
                            
                            draw_ellipse(_xx - 40, _yy - 40, _xx + 40, _yy + 40, 0);
                            draw_sprite_ext(spr_enemy_bossIcons, specialRaid[territoryBossesDisplayMain][4], _xx, _yy, _scale, _scale, 0, _bossColor, 1);
                            draw_sprite_ext(spr_enemyBorder, _border, _xx, _yy, 2, 2, 0, c_white, 1);
                            draw_sprite_ext(spr_enemyTier, 5 + _tier, _xx, _yy - 40, 2, 2, 0, c_white, 1);
                            draw_set_font(f_midbig);
                            gml_Script_scr_textgradient(_xx, _yy - 40, string(territoryBossesDisplayMain * 50), 16777215, 12632256, 0, 34, 1620);
                            draw_set_font(f_midbig);
                            
                            if (gml_Script_scr_alarm_get(50 + territoryBossesDisplayMain) != -1)
                                gml_Script_scr_textgradient(_xx, _yy, "~" + string(ceil(gml_Script_scr_alarm_get(50 + territoryBossesDisplayMain) / room_speed / 60)) + "m", 16777215, 12632256, 0, 34, 1620);
                            
                            var _dropChance = 20;
                            
                            if ((territoryBossesDisplayMain % 5) == 0)
                                _dropChance = 33;
                            
                            var _biomeTier = 1;
                            
                            if (territoryBossesDisplayMain > 10)
                                _biomeTier += 1;
                            
                            if (territoryBossesDisplayMain > 20)
                                _biomeTier += 1;
                            
                            if (territoryBossesDisplayMain > 30)
                                _biomeTier += 1;
                            
                            if (territoryBossesDisplayMain > 40)
                                _biomeTier += 1;
                            
                            var _territoryReward;
                            _territoryReward[0][0] = 0;
                            _territoryReward[0][1] = spr_talentscrollIcon;
                            _territoryReward[0][2] = (15 + global.townLevel + floor(territoryBossesDisplayMain * 5)) * _biomeTier;
                            _territoryReward[0][3] = 100;
                            _territoryReward[0][4] = 1;
                            _territoryReward[1][0] = specialRaid[floor(territoryBossesDisplayMain)][1];
                            _territoryReward[1][1] = spr_uniqueItem;
                            _territoryReward[1][2] = 1;
                            _territoryReward[1][3] = 20;
                            _territoryReward[1][4] = 1;
                            _territoryReward[2][0] = specialRaid[floor(territoryBossesDisplayMain)][2];
                            _territoryReward[2][1] = spr_uniqueItem;
                            _territoryReward[2][2] = 1;
                            _territoryReward[2][3] = 20;
                            _territoryReward[2][4] = 1;
                            _territoryReward[3][0] = specialRaid[floor(territoryBossesDisplayMain)][3];
                            _territoryReward[3][1] = spr_uniqueItem;
                            _territoryReward[3][2] = 1;
                            _territoryReward[3][3] = 20;
                            _territoryReward[3][4] = 1;
                            
                            if ((territoryBossesDisplayMain % 5) == 0)
                            {
                                for (var z = 1; z <= 3; z++)
                                    _territoryReward[z][3] = 33;
                                
                                _territoryReward[4][0] = 1;
                                _territoryReward[4][1] = spr_honorShopItems;
                                _territoryReward[4][2] = round(territoryBossesDisplayMain * _biomeTier * 2);
                                _territoryReward[4][3] = 100;
                                _territoryReward[4][4] = 0.4;
                                
                                if ((territoryBossesDisplayMain % 20) == 0)
                                {
                                    _territoryReward[4][2] = round(territoryBossesDisplayMain * (_biomeTier + 1) * 3);
                                    _territoryReward[0][2] = (15 + global.townLevel + floor(territoryBossesDisplayMain * 5)) * (_biomeTier + 1);
                                }
                            }
                            
                            draw_set_font(f_mid);
                            var _reAmount = array_length(_territoryReward);
                            var _xpos = ((50 * _reAmount) / 2) - 25;
                            
                            for (var ii = 0; ii < _reAmount; ii++)
                            {
                                if (_territoryReward[ii][2] > 0)
                                {
                                    draw_sprite_ext(_territoryReward[ii][1], _territoryReward[ii][0], (_xx - _xpos) + (ii * 50), _yy + 30 + 55, _territoryReward[ii][4], _territoryReward[ii][4], 0, c_white, 1);
                                    
                                    if (ii > 0 && ii < 4)
                                        gml_Script_scr_textgradient((_xx - _xpos) + (ii * 50), _yy + 55 + 5, "R" + string(_territoryReward[ii][0]), 65535, 65535, undefined, undefined, undefined, 16776960, 16776960);
                                    
                                    if (_territoryReward[ii][3] < 100)
                                        gml_Script_scr_textgradient((_xx - _xpos) + (ii * 50), _yy + 55 + 65, string(_territoryReward[ii][3]) + "%", 16777215, 16777215, 0, 34, 1620);
                                    
                                    if (_territoryReward[ii][2] > 1)
                                        gml_Script_scr_textgradient((_xx - _xpos) + (ii * 50), _yy + 55 + 65, "x" + gml_Script_scr_bigNumber(_territoryReward[ii][2]), 16777215, 16777215, 0, 34, 1620);
                                }
                            }
                        }
                    }
                    
                    draw_set_font(f_midbig);
                    gml_Script_scr_textgradient(room_width / 2, room_height - 240, "?Territory Bosses:", undefined, undefined, undefined, 34, 1620);
                }
                
                draw_set_font(f_midbig);
            }
            else
            {
                gml_Script_scr_textgradient(room_width / 2, room_height - 270 - 45, "Dungeon Boss " + gml_Script_scr_bigNumber(global.bossStage), 255, 128, undefined, 34, 1620);
                gml_Script_scr_textgradient(room_width / 2, room_height - 285, "(" + string(global.cmdPrefix) + "boss / " + string(global.cmdPrefix) + "raid to join)", 16777215, 12632256, undefined, 34, 1620);
            }
        }
        
        if (alarm[4] < (room_speed * 60) && alarm[4] != -1 && global.raiding == false && global.raidCall == false)
        {
            draw_set_font(f_big);
            draw_set_halign(fa_center);
            draw_sprite(spr_enemyRaid, 0, room_width / 2, room_height - 150);
            gml_Script_scr_textoutlineBIG(room_width / 2, room_height - 165, "Enemy troops detected nearby! " + string(global.cmdPrefix) + "guard (" + string_format(alarm[4] / room_speed, 1, 0) + "s)", 16777215, 0, 32, 1620);
            draw_set_font(f_mid);
            gml_Script_scr_textoutline(room_width / 2, room_height - 130, "[" + gml_Script_scr_bigNumber(global.stage) + " difficulty]", 16777215, 0, 34, 1620);
        }
        
        if (alarm[1] != -1)
        {
            draw_set_font(f_midbig);
            draw_set_halign(fa_center);
            
            if (global.enemyRaid == false)
            {
                if (obj_bossKey.alarm[1] == -1)
                {
                    gml_Script_scr_textgradient(room_width / 2, room_height - 270 - 45, string(raidAnnounceText) + " starts in " + string_format(alarm[1] / room_speed, 1, 0) + "s", undefined, undefined, undefined, 34, 1620);
                    gml_Script_scr_textgradient(room_width / 2, room_height - 290, "Type " + string(global.cmdPrefix) + "raid to join!", undefined, undefined, undefined, 34, 1620);
                }
                else
                {
                    gml_Script_scr_textgradient(room_width / 2, room_height - 270 - 45, "Dungeon Boss raid " + gml_Script_scr_bigNumber(global.bossStage) + " starts in " + string_format(alarm[1] / room_speed, 1, 0) + "s", undefined, undefined, undefined, 34, 1620);
                    gml_Script_scr_textgradient(room_width / 2, room_height - 290, "Type " + string(global.cmdPrefix) + "raid to join!", undefined, undefined, undefined, 34, 1620);
                }
            }
            else
            {
                gml_Script_scr_textgradient(room_width / 2, room_height - 290, "Enemies arriving in " + string_format(alarm[1] / room_speed, 1, 0) + "s [" + gml_Script_scr_bigNumber(global.stage) + "]", undefined, undefined, undefined, 34, 1620);
            }
        }
        
        if (global.raiding == true && alarm[1] == -1)
        {
            draw_set_font(f_midbig);
            draw_set_halign(fa_center);
            
            if (global.enemyRaid == false)
            {
                if (global.finalWar == false)
                {
                    if (boss == false)
                        gml_Script_scr_textgradient((room_width / 2) + 300, room_height - 270 - 45, raidAnnounceText, undefined, undefined, undefined, 34, 1620);
                    else
                        gml_Script_scr_textgradient((room_width / 2) + 300, room_height - 270 - 45, "Dungeon Boss " + gml_Script_scr_bigNumber(global.stage), 16777215, 12632256, undefined, 34, 1620);
                    
                    gml_Script_scr_textgradient((room_width / 2) + 300, room_height - 285, "Time bonus:", 16777215, 12632256, undefined, 34, 1620);
                }
                else
                {
                    gml_Script_scr_textgradient((room_width / 2) + 300, room_height - 290, "Stage " + gml_Script_scr_bigNumber(round(global.stage)), undefined, undefined, undefined, 34, 1620);
                }
            }
            else
            {
                gml_Script_scr_textgradient((room_width / 2) + 300, room_height - 280, "Town under attack! [" + gml_Script_scr_bigNumber(global.stage) + "]", undefined, undefined, undefined, 34, 1620);
            }
            
            if (alarm[2] != -1)
                gml_Script_scr_textgradient(room_width / 2, room_height - 220, "Raid completed!", 65280, 32768, undefined, 20, 1620);
            
            if (alarm[3] != -1)
                gml_Script_scr_textgradient(room_width / 2, room_height - 220, "Raid failed...", 255, 128, undefined, 20, 1620);
            
            if (alarm[6] != -1)
                gml_Script_scr_textgradient(room_width / 2, room_height - 220, "Defense completed!", 65280, 32768, undefined, 20, 1620);
            
            if (alarm[5] != -1)
                gml_Script_scr_textgradient(room_width / 2, room_height - 220, "Defense failed...", 255, 128, undefined, 20, 1620);
        }
    }
    else if (global.inArena == true)
    {
        draw_set_font(f_big);
        draw_set_halign(fa_center);
        gml_Script_scr_textoutline(room_width / 2, room_height - 220, "Cheer for your challengers!", 16777215, 0, 20, 1620);
    }
    else
    {
        draw_set_font(f_big);
        draw_set_halign(fa_center);
        gml_Script_scr_textoutline(room_width / 2, room_height - 220, "PvP request being made...", 16777215, 0, 20, 1620);
    }
}
else
{
    if (alarm[4] < (room_speed * 180))
        alarm[4] = room_speed * 180;
    
    if (alarm[9] != -1 && alarm[9] <= (room_speed * 60))
        alarm[9] = room_speed * 60;
}
