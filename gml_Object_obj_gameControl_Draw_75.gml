if (gml_Script_live_call())
    return global.live_result;

draw_set_font(f_mid);
draw_set_valign(fa_middle);
draw_set_halign(fa_left);
global.auraRot -= 1;

if (global.auraRot <= 0)
    global.auraRot = 360;

show_debug_overlay(debug);

if (room == r_1 && global.raiding == false && global.enemyRaid == false && obj_raid.alarm[4] >= (room_speed * 60) && (obj_corruptedControl.alarm[0] >= (room_speed * 120) || obj_corruptedControl.alarm[0] == -1) && (obj_bossKey.alarm[0] >= (room_speed * 120) || (obj_bossKey.alarm[0] == -1 && global.portalPointsDisplay == global.portalPoints) || (obj_bossKey.alarm[0] <= 60 && global.raidCall == true)) && (obj_raid.alarm[9] >= (room_speed * 120) || obj_raid.alarm[9] == -1) && !instance_exists(obj_raidTransition))
    global.canRaid = true;
else
    global.canRaid = false;

if (room != r_seasonEnd)
{
    if (!instance_exists(obj_raidTransition) && !instance_exists(obj_stageTransition))
    {
        if (!audio_is_playing(theme))
        {
            var _canPlayTheme = true;
            var _volume = 0.1;
            
            if (room == r_1 && global.raiding == false)
            {
                if (global.stageType == "Forest" || global.stageType == "Grassland" || global.stageType == "Snow Trail")
                    theme = choose(s_maintheme1, s_maintheme2, s_maintheme3, s_maintheme4);
                
                if (global.stageType == "Dungeon")
                    theme = s_dungeon1;
                
                audio_sound_gain(theme, 0, 0);
                audio_sound_gain(theme, 0.1, 10000);
            }
            
            if (room == r_1 && global.raiding == true)
            {
                audio_sound_gain(theme, 0, 200);
                _canPlayTheme = false;
            }
            
            if (global.stageType == "Underworld")
            {
                theme = choose(s_underworld1, s_underworld2, s_underworld3, s_underworld4, s_underworld5, s_underworld6, s_underworld7);
                
                if (global.portalTower == 4 && global.onlyFinis == 1)
                    theme = m_finis_1;
            }
            
            if (global.stageType == "Corrupted Dimension")
            {
                theme = s_corrupted1;
                _volume = 1;
            }
            
            if (_canPlayTheme == true)
            {
                audio_sound_gain(theme, 0, 0);
                audio_sound_gain(theme, _volume, 10000);
                audio_play_sound(theme, 0, 0);
            }
        }
    }
    
    if (room == r_1 || room == global.room_underworld || room == r_corrupted)
    {
        if (displayFood != global.food)
        {
            var diff = global.food - displayFood;
            displayFood += (diff / 10);
            
            if ((global.food - displayFood) <= 1)
                displayFood = global.food;
        }
        
        if (displayGold != global.gold)
        {
            var diff = global.gold - displayGold;
            displayGold += (diff / 10);
            
            if ((global.gold - displayGold) <= 1)
                displayGold = global.gold;
        }
        
        if (displayTownHP != global.townHP)
        {
            var diff = global.townHP - displayTownHP;
            displayTownHP += (diff / 10);
            
            if ((global.townHP - displayTownHP) <= 1)
                displayTownHP = global.townHP;
        }
        
        if (displayGems != global.gems)
        {
            var diff = global.gems - displayGems;
            displayGems += (diff / 10);
            
            if ((global.gems - displayGems) <= 1)
                displayGems = global.gems;
        }
        
        if (displaySouls != global.souls)
        {
            var diff = global.souls - displaySouls;
            displaySouls += (diff / 10);
            
            if ((global.souls - displaySouls) <= 1)
                displaySouls = global.souls;
        }
        
        if (displayBloodgems != global.bloodgems)
        {
            var diff = global.bloodgems - displayBloodgems;
            displayBloodgems += (diff / 10);
            
            if ((global.bloodgems - displayBloodgems) <= 1)
                displayBloodgems = global.bloodgems;
        }
        
        draw_sprite(spr_HUDtop, 0, 0, 0);
        draw_set_valign(fa_middle);
        draw_set_halign(fa_left);
        draw_set_font(f_big);
        
        if (global.newUnderworld == true)
        {
            if (room == r_corrupted)
            {
                draw_set_font(f_midbig);
                
                if (global.premiumChannel == 1)
                {
                    draw_sprite_ext(spr_subStar, 1, 32, 24, 1.25, 1.25, 0, c_white, 1);
                    gml_Script_scr_textoutline(50, 25, "Corrupted Dimension", 16777215, 0, 34, 1600);
                }
                else
                {
                    gml_Script_scr_textoutline(20, 25, "Corrupted Dimension", 16777215, 0, 34, 1600);
                }
                
                draw_set_font(f_mid);
                gml_Script_scr_textoutline(20, 50, "Sector " + string(global.corruptedSector) + ":" + string(global.corruptedLevel), 16777215, 0, 34, 1600);
            }
            
            draw_set_font(f_big);
            
            if (room == global.room_underworld)
            {
                if (global.premiumChannel == 1)
                {
                    draw_sprite_ext(spr_subStar, 1, 32, 24, 1.25, 1.25, 0, c_white, 1);
                    gml_Script_scr_textoutline(50, 25, "Underworld", 16777215, 0, 34, 1600);
                }
                else
                {
                    gml_Script_scr_textoutline(20, 25, "Underworld", 16777215, 0, 34, 1600);
                }
                
                draw_set_font(f_mid);
                gml_Script_scr_textoutline(20, 50, "Level " + string(global.underworldLevel), 16777215, 0, 34, 1600);
                
                if (global.underworldLevel > 1)
                    gml_Script_scr_textoutline(20 + string_width("Level " + string(global.underworldLevel)) + 10, 50, "(+" + string(round((global.underworldLevel - 1) * 0.05 * (1 + (global.underworldLevel / 5)) * 100)) + "%[x] enemy HP)", 255, 0, 34, 600);
                
                draw_sprite_ext(spr_blackbar, 0, 20, 65, 200, 1, 0, c_white, 1);
                draw_sprite_ext(spr_xpbarsmall, 0, 22, 65, (global.underworldXP / global.underworldMaxXP) * 196, 1, 0, c_white, 1);
            }
            
            if (room == r_1)
            {
                if (global.premiumChannel == 1)
                {
                    draw_sprite_ext(spr_subStar, 1, 32, 24, 1.25, 1.25, 0, c_white, 1);
                    gml_Script_scr_textoutline(50, 25, global.townName, 16777215, 0, 34, 1600);
                }
                else
                {
                    gml_Script_scr_textoutline(20, 25, global.townName, 16777215, 0, 34, 1600);
                }
                
                draw_set_font(f_mid);
                gml_Script_scr_textoutline(20, 55, "Level " + string(global.townLevel), 16777215, 0, 34, 1600);
                draw_sprite_ext(spr_blackbar, 0, 100, 53, 200, 1, 0, c_white, 1);
                draw_sprite_ext(spr_blackbar, 0, 100, 58, 200, 1, 0, c_white, 1);
                draw_sprite_ext(spr_xpbarsmall, 0, 102, 58, (global.townXP / global.townMaxXP) * 196, 1, 0, c_white, 1);
                draw_sprite_ext(spr_hpbarsmall, 0, 102, 53, (displayTownHP / global.townMaxHP) * 196, 1, 0, c_white, 1);
                draw_set_font(f_special);
                draw_set_halign(fa_right);
                draw_set_halign(fa_left);
                draw_set_font(f_mid);
            }
        }
        else
        {
            if (global.premiumChannel == 1)
            {
                draw_sprite_ext(spr_subStar, 1, 32, 24, 1.25, 1.25, 0, c_white, 1);
                gml_Script_scr_textoutline(50, 25, global.townName, 16777215, 0, 34, 1600);
            }
            else
            {
                gml_Script_scr_textoutline(20, 25, global.townName, 16777215, 0, 34, 1600);
            }
            
            draw_set_font(f_mid);
            gml_Script_scr_textoutline(20, 50, "Level " + string(global.townLevel), 16777215, 0, 34, 1600);
            draw_sprite_ext(spr_blackbar, 0, 20, 65, 200, 1, 0, c_white, 1);
            draw_sprite_ext(spr_xpbarsmall, 0, 22, 65, (global.townXP / global.townMaxXP) * 196, 1, 0, c_white, 1);
        }
        
        if (room == r_1 || room == r_underworld_new || room == r_corrupted)
        {
            draw_set_font(f_mid);
            
            if (global.godsHonor < global.godsHonorMax && global.godsFavorStacks == 0)
            {
                gml_Script_scr_textoutline(700, 25, "Gods !!Favor Progress (" + string(floor((global.godsHonor / global.godsHonorMax) * 100)) + "%)", 16777215, 0, 34, 1600);
                draw_sprite_ext(spr_blackbar, 0, 700, 40, 330, 1, 0, c_white, 1);
                draw_sprite_ext(spr_bluebarsmall, 0, 702, 40, (global.godsHonor / global.godsHonorMax) * 326, 1, 0, c_white, 1);
            }
            else
            {
                if (obj_god.alarm[3] == -1)
                    gml_Script_scr_textoutline(700, 25, "Gods !!Favor starting in " + string(ceil(obj_god.alarm[0] / room_speed)) + "s (" + string(global.godsFavorStacks - 1) + " in queue)", 16777215, 0, 34, 1600);
                else
                    gml_Script_scr_textoutline(700, 25, "Gods !!Favor after " + string(round(obj_god.raidsLeft)) + " raids (" + string(global.godsFavorStacks - 1) + " in queue)", 16777215, 0, 34, 1600);
                
                draw_sprite_ext(spr_blackbar, 0, 700, 40, 330, 1, 0, c_white, 1);
                draw_sprite_ext(spr_energybarsmall, 0, 702, 40, 326, 1, 0, c_white, 1);
            }
            
            if (obj_god.alarm[1] == -1 && obj_god.alarm[2] == -1 && obj_god.alarm[3] == -1)
                gml_Script_scr_textoutline(700, 60, "Get !!Honor Points to increase progress", 12632256, 0, 34, 1500);
            
            if (obj_god.alarm[1] != -1)
            {
                if (room == r_1)
                    gml_Script_scr_textoutline(700, 60, "XP Rain: +" + gml_Script_scr_bigNumber(obj_build_train.amount * global.academyXpBonus) + " XP/s (" + string(round(obj_god.alarm[1] / room_speed)) + "s)", 16777215, 0, 34, 1500);
            }
            
            if (obj_god.alarm[2] != -1)
            {
                if (room == r_1)
                    gml_Script_scr_textoutline(700, 60, "Bonanza: +" + string((global.bonanzaBonus - 1) * 100) + "%[x] resource gain (" + string(round(obj_god.alarm[2] / room_speed)) + "s)", 16777215, 0, 34, 1500);
            }
            
            if (obj_god.alarm[3] != -1)
            {
                if (room == r_1)
                    gml_Script_scr_textoutline(700, 60, "Heaven's Power: +" + string(global.godsDmgBonus * 100) + "%[+] damage (" + string(round(obj_god.raidsLeft)) + " raids)", 16777215, 0, 34, 1500);
            }
        }
        
        draw_set_font(f_midbig);
        draw_set_halign(fa_right);
        draw_sprite(spr_HUDtop, 1, 320, 0);
        draw_sprite_ext(spr_blackbar, 0, 350, 25, 150, 4, 0, -1, 0.3);
        
        if (global.gold < global.maxGold)
        {
            draw_sprite_ext(spr_goldbar, 0, 350, 25, clamp((displayGold / global.maxGold) * 148, 0, 148), 3.2, 0, c_white, 1);
            draw_sprite_ext(spr_goldbar, 0, 350 + clamp((displayGold / global.maxGold) * 148, 0, 148), 25, clamp(((global.gold - displayGold) / global.maxGold) * 300, 0, 148), 3.2, 0, c_gray, 1);
            gml_Script_scr_textoutline(495, 25, gml_Script_scr_bigNumber(round(displayGold)), 16777215, 0, 34, 1680);
        }
        else
        {
            global.gold = global.maxGold;
            draw_sprite_ext(spr_redbar, 0, 350, 25, (global.gold / global.maxGold) * 148, 3.2, 0, c_white, 1);
            gml_Script_scr_textoutline(495, 25, gml_Script_scr_bigNumber(round(displayGold)), 16777215, 0, 34, 1680);
        }
        
        shader_set(sh_grayscale);
        draw_sprite_ext(spr_classIcons, 1, 354, 25, 1, 1, 0, c_dkgray, 0.4);
        shader_reset();
        draw_sprite(spr_classIcons, 1, 350, 25);
        draw_sprite_ext(spr_blackbar, 0, 520, 25, 150, 4, 0, -1, 0.3);
        
        if (global.food < global.maxFood)
        {
            draw_sprite_ext(spr_foodbar, 0, 520, 25, clamp((displayFood / global.maxFood) * 148, 0, 148), 3.2, 0, c_white, 1);
            draw_sprite_ext(spr_foodbar, 0, 520 + clamp((displayFood / global.maxFood) * 148, 0, 148), 25, clamp(((global.food - displayFood) / global.maxFood) * 148, 0, 148), 3.2, 0, c_gray, 1);
            gml_Script_scr_textoutline(665, 25, gml_Script_scr_bigNumber(round(displayFood)), 16777215, 0, 34, 1680);
        }
        else
        {
            global.food = global.maxFood;
            draw_sprite_ext(spr_redbar, 0, 520, 25, (global.food / global.maxFood) * 148, 3.2, 0, c_white, 1);
            gml_Script_scr_textoutline(665, 25, gml_Script_scr_bigNumber(displayFood), 16777215, 0, 34, 1680);
        }
        
        shader_set(sh_grayscale);
        draw_sprite_ext(spr_classIcons, 2, 524, 25, 1, 1, 0, c_dkgray, 0.4);
        shader_reset();
        draw_sprite(spr_classIcons, 2, 520, 25);
        draw_sprite(spr_HUDtop, 1, 680, 0);
        draw_sprite_ext(spr_blackbar, 0, 350, 55, 100, 4, 0, -1, 0.3);
        shader_set(sh_grayscale);
        draw_sprite_ext(spr_underworldIcons, 2, 354, 55, 1, 1, 0, c_dkgray, 0.4);
        shader_reset();
        draw_sprite(spr_underworldIcons, 2, 350, 55);
        gml_Script_scr_textoutline(445, 55, gml_Script_scr_bigNumber(floor(displayGems)), 16777215, 0, 34, 1680);
        
        if (global.witchBuilt == 1)
        {
            draw_sprite_ext(spr_blackbar, 0, 470, 55, 100, 4, 0, -1, 0.3);
            shader_set(sh_grayscale);
            draw_sprite_ext(spr_underworldIcons, 0, 474, 55, 1, 1, 0, c_dkgray, 0.4);
            shader_reset();
            draw_sprite(spr_underworldIcons, 0, 470, 55);
            gml_Script_scr_textoutline(565, 55, gml_Script_scr_bigNumber(floor(displaySouls)), 16777215, 0, 34, 1680);
            
            if (global.portalTower > 1)
            {
                draw_sprite_ext(spr_blackbar, 0, 590, 55, 80, 4, 0, -1, 0.3);
                shader_set(sh_grayscale);
                draw_sprite_ext(spr_underworldIcons, 1, 594, 55, 1, 1, 0, c_dkgray, 0.4);
                shader_reset();
                draw_sprite(spr_underworldIcons, 1, 590, 55);
                gml_Script_scr_textoutline(665, 55, gml_Script_scr_bigNumber(floor(displayBloodgems)), 16777215, 0, 34, 1680);
            }
        }
        
        draw_sprite(spr_HUDright, 0, room_width - 500, 0);
        
        if (room != r_corrupted)
        {
            draw_set_halign(fa_right);
            draw_set_font(f_mid);
            gml_Script_scr_textoutline((room_width - 250) + 235, 90, "Next: " + string(global.cardTurnNext) + " (" + string(ceil(alarm[5] / room_speed)) + "s)", 16777215, 0, 20, 500);
            
            if (showPlayers == 0)
            {
                draw_set_valign(fa_middle);
                draw_set_halign(fa_center);
                draw_set_font(f_big);
                
                if ((global.cardTurn - ds_list_size(global.list_notafk) - 1) >= 0)
                    gml_Script_scr_textgradient(room_width - 250, 120, customDisplayTab[global.cardTurn - ds_list_size(global.list_notafk) - 1], 16777215, 12632256, undefined, 34, 600);
                
                if ((global.cardTurn - ds_list_size(global.list_notafk) - 1) == 0)
                {
                    draw_set_font(f_mid);
                    draw_set_halign(fa_left);
                    gml_Script_scr_textoutline(room_width - 485, 155, "Damage Bonus: +" + string(round(global.globalDamageBonus * 100)) + "%[+]", 16777215, 0, 34, 600);
                    gml_Script_scr_textoutline(room_width - 485, 175, "Damage Resistance: +" + string(round(global.globalResistanceBonus * 100)) + "%[+]", 16777215, 0, 34, 600);
                    gml_Script_scr_textoutline(room_width - 485, 195, "Gold Bonus: +" + string(round((global.globalGoldBonus - 1) * 100)) + "%[x]", 16777215, 0, 34, 600);
                    gml_Script_scr_textoutline(room_width - 485, 215, "Food Bonus: +" + string(round((global.globalFoodBonus - 1) * 100)) + "%[x]", 16777215, 0, 34, 600);
                    gml_Script_scr_textoutline(room_width - 485, 235, "XP Bonus: +" + string(round((global.globalXPBonus - 1) * 100)) + "%[x]", 16777215, 0, 34, 600);
                    draw_set_font(f_special);
                    draw_set_halign(fa_right);
                    draw_set_font(f_mid);
                    gml_Script_scr_textoutline(room_width - 15, 135, "Test Values:", 16777215, 0, 34, 600);
                    gml_Script_scr_textoutline(room_width - 15, 155, "100 -> " + string(round(100 * (1 + global.globalDamageBonus))), 16777215, 0, 34, 600);
                    gml_Script_scr_textoutline(room_width - 15, 175, "100 -> " + string(round(100 * (1 + global.globalResistanceBonus))), 16777215, 0, 34, 600);
                    gml_Script_scr_textoutline(room_width - 15, 195, "100 -> " + string(round(100 * global.globalGoldBonus)), 16777215, 0, 34, 600);
                    gml_Script_scr_textoutline(room_width - 15, 215, "100 -> " + string(round(100 * global.globalFoodBonus)), 16777215, 0, 34, 600);
                    gml_Script_scr_textoutline(room_width - 15, 235, "100 -> " + string(round(100 * global.globalXPBonus)), 16777215, 0, 34, 600);
                    draw_set_halign(fa_left);
                    gml_Script_scr_textoutline(room_width - 485, 260, "Mythical creatures found: ", 16777215, 0, 34, 600);
                    
                    for (var i = 0; i < 4; i++)
                    {
                        shader_set(sh_grayscale);
                        draw_sprite_ext(spr_djinns, global.djinnOrder[3 - i], room_width - 465, 300 + (i * 35), 1, 1, 0, c_dkgray, 1);
                        shader_reset();
                        
                        if (global.djinnInfo[global.djinnOrder[3 - i]][0] == 1)
                        {
                            gml_Script_scr_textgradient(room_width - 435, 290 + (i * 35), string(global.djinnInfo[global.djinnOrder[3 - i]][1]) + ": " + string_replace(global.djinnInfo[global.djinnOrder[3 - i]][3], "*", global.djinnInfo[global.djinnOrder[3 - i]][2]), global.djinnInfo[global.djinnOrder[3 - i]][4], global.djinnInfo[global.djinnOrder[3 - i]][5], undefined, 20, 600);
                            draw_sprite_ext(spr_djinns, global.djinnOrder[3 - i], room_width - 465, 300 + (i * 35), 1, 1, 0, c_white, 1);
                        }
                        else
                        {
                            gml_Script_scr_textgradient(room_width - 435, 290 + (i * 35), "Locked", 4210752, undefined, undefined, 20, 400);
                        }
                    }
                }
                
                if ((global.cardTurn - ds_list_size(global.list_notafk) - 1) == 1)
                {
                    var l = 0;
                    var c = 0;
                    var _color = 16777215;
                    draw_set_font(f_mid);
                    draw_set_halign(fa_center);
                    draw_set_valign(fa_top);
                    gml_Script_scr_textoutline(room_width - 250, 140, "Players who haven't reached a milestone get 2x its effect!", 16777215, 0, 20, 460);
                    draw_set_halign(fa_left);
                    draw_set_font(f_special_old);
                    
                    for (var m = 0; m < 8; m += 1)
                    {
                        draw_sprite_ext(spr_milestone_none, 0, (room_width - 460) + (230 * c), 220 + (50 * l), 0.5, 0.5, 0, c_white, 1);
                        
                        if (global.milestone[m][4] == 1)
                            draw_sprite_ext(global.milestone[m][3], global.milestone[m][5], (room_width - 460) + (230 * c), 220 + (50 * l), 0.5, 0.5, 0, c_white, 1);
                        
                        if (global.milestone[m][4] == 0)
                            _color = 8421504;
                        else
                            _color = 16777215;
                        
                        draw_set_valign(fa_middle);
                        gml_Script_scr_textoutline((room_width - 430) + (230 * c), 205 + (50 * l), global.milestone[m][0], _color, 0, 10, 250);
                        gml_Script_scr_textoutline((room_width - 430) + (230 * c), 220 + (50 * l), global.milestone[m][1], _color, 0, 10, 250);
                        gml_Script_scr_textoutline((room_width - 430) + (230 * c), 235 + (50 * l), global.milestone[m][2], _color, 0, 10, 250);
                        l += 1;
                        
                        if (l >= 4)
                        {
                            l = 0;
                            c += 1;
                        }
                    }
                }
                else if ((global.cardTurn - ds_list_size(global.list_notafk) - 1) == 2)
                {
                    var l = 0;
                    var c = 0;
                    var _color = 16777215;
                    draw_set_font(f_mid);
                    draw_set_halign(fa_center);
                    draw_set_valign(fa_top);
                    gml_Script_scr_textoutline(room_width - 250, 140, "Players who haven't reached a milestone get 2x its effect!", 16777215, 0, 20, 460);
                    draw_set_halign(fa_left);
                    draw_set_font(f_special_old);
                    
                    for (var m = 8; m <= global.maxMilestones; m += 1)
                    {
                        draw_sprite_ext(spr_milestone_none, 0, (room_width - 460) + (230 * c), 220 + (50 * l), 0.5, 0.5, 0, c_white, 1);
                        
                        if (global.milestone[m][4] == 1)
                            draw_sprite_ext(global.milestone[m][3], global.milestone[m][5], (room_width - 460) + (230 * c), 220 + (50 * l), 0.5, 0.5, 0, c_white, 1);
                        
                        if (global.milestone[m][4] == 0)
                            _color = 8421504;
                        else
                            _color = 16777215;
                        
                        draw_set_valign(fa_middle);
                        gml_Script_scr_textoutline((room_width - 430) + (230 * c), 205 + (50 * l), global.milestone[m][0], _color, 0, 10, 250);
                        gml_Script_scr_textoutline((room_width - 430) + (230 * c), 220 + (50 * l), global.milestone[m][1], _color, 0, 10, 250);
                        gml_Script_scr_textoutline((room_width - 430) + (230 * c), 235 + (50 * l), global.milestone[m][2], _color, 0, 10, 250);
                        l += 1;
                        
                        if (l >= 5)
                        {
                            l = 0;
                            c += 1;
                        }
                    }
                }
                
                if ((global.cardTurn - ds_list_size(global.list_notafk) - 1) == 3)
                {
                    draw_set_font(f_mid);
                    draw_set_halign(fa_center);
                    draw_set_valign(fa_top);
                    gml_Script_scr_textoutline(room_width - 250, 140, "Get your items with !redeem(item ID)*(amount)", 16777215, 0, 20, 460);
                    var l = 0;
                    var c = 0;
                    
                    for (var m = 0; m < 3; m += 1)
                    {
                        if (m < (array_length(global.honorItem) - 1))
                        {
                            if (global.honorItem[m + 1][0] != "none")
                            {
                                draw_sprite_ext(global.honorItem[m + 1][3], m, (room_width - 250 - 150) + (150 * l), 260, 1, 1, 0, c_white, 1);
                                gml_Script_scr_textoutline((room_width - 250 - 150) + (150 * l), 180, "ID: " + string(m + 1), 16777215, 0, 20, 140);
                                gml_Script_scr_textgradient((room_width - 250 - 150) + (150 * l), 310, "Cost: " + string(global.honorItem[m + 1][1]) + "      (lv." + string(global.honorItem[m + 1][2]) + ")", 16777215, 16777215, undefined, 20, 240);
                                draw_sprite_ext(spr_honor, 1, (room_width - 250 - 150) + (150 * l) + (string_width(global.honorItem[m + 1][1]) / 2), 322, 1, 1, 0, c_white, 1);
                                gml_Script_scr_textgradient((room_width - 250 - 150) + (150 * l), 330, string(global.honorItem[m + 1][0]), 16777215, 16777215, undefined, 20, 140);
                            }
                            
                            l += 1;
                        }
                    }
                }
                
                if ((global.cardTurn - ds_list_size(global.list_notafk) - 1) == 4)
                {
                    draw_set_font(f_mid);
                    draw_set_halign(fa_center);
                    draw_set_valign(fa_top);
                    gml_Script_scr_textoutline(room_width - 250, 140, "Get your items with !redeem(item ID)*(amount)", 16777215, 0, 20, 460);
                    var l = 0;
                    var c = 0;
                    
                    for (var m = 0; m < 3; m += 1)
                    {
                        if (m < (array_length(global.honorItem) - 1))
                        {
                            if (global.honorItem[m + 4][0] != "none")
                            {
                                draw_sprite_ext(global.honorItem[m + 4][3], m + 3, (room_width - 250 - 150) + (150 * l), 260, 1, 1, 0, c_white, 1);
                                gml_Script_scr_textoutline((room_width - 250 - 150) + (150 * l), 180, "ID: " + string(m + 4), 16777215, 0, 20, 140);
                                gml_Script_scr_textgradient((room_width - 250 - 150) + (150 * l), 310, "Cost: " + string(global.honorItem[m + 4][1]) + "      (lv." + string(global.honorItem[m + 4][2]) + ")", 16777215, 16777215, undefined, 20, 240);
                                draw_sprite_ext(spr_honor, 1, (room_width - 250 - 150) + (150 * l) + (string_width(global.honorItem[m + 4][1]) / 2), 322, 1, 1, 0, c_white, 1);
                                gml_Script_scr_textgradient((room_width - 250 - 150) + (150 * l), 330, string(global.honorItem[m + 4][0]), 16777215, 16777215, undefined, 20, 140);
                            }
                            
                            l += 1;
                        }
                    }
                }
                
                if ((global.cardTurn - ds_list_size(global.list_notafk) - 1) == 5)
                {
                    draw_set_font(f_mid);
                    draw_set_halign(fa_center);
                    draw_set_valign(fa_top);
                    gml_Script_scr_textoutline(room_width - 250, 140, "Get your items with !redeem(item ID)*(amount)", 16777215, 0, 20, 460);
                    var l = 0;
                    var c = 0;
                    
                    for (var m = 0; m < 3; m += 1)
                    {
                        if (m < (array_length(global.honorItem) - 1))
                        {
                            if (global.honorItem[m + 7][0] != "none")
                            {
                                draw_sprite_ext(global.honorItem[m + 7][3], m + 6, (room_width - 250 - 150) + (150 * l), 260, 1, 1, 0, c_white, 1);
                                gml_Script_scr_textoutline((room_width - 250 - 150) + (150 * l), 180, "ID: " + string(m + 7), 16777215, 0, 20, 140);
                                gml_Script_scr_textgradient((room_width - 250 - 150) + (150 * l), 310, "Cost: " + string(global.honorItem[m + 7][1]) + "      (lv." + string(global.honorItem[m + 7][2]) + ")", 16777215, 16777215, undefined, 20, 240);
                                draw_sprite_ext(spr_honor, 1, (room_width - 250 - 150) + (150 * l) + (string_width(global.honorItem[m + 7][1]) / 2), 322, 1, 1, 0, c_white, 1);
                                gml_Script_scr_textgradient((room_width - 250 - 150) + (150 * l), 330, string(global.honorItem[m + 7][0]), 16777215, 16777215, undefined, 20, 140);
                            }
                            
                            l += 1;
                        }
                    }
                }
                
                if ((global.cardTurn - ds_list_size(global.list_notafk) - 1) == 6)
                {
                    draw_set_font(f_mid);
                    draw_set_halign(fa_center);
                    draw_set_valign(fa_top);
                    gml_Script_scr_textoutline(room_width - 250, 140, "Get your items with !redeem(item ID)*(amount)", 16777215, 0, 20, 460);
                    var l = 0;
                    var c = 0;
                    
                    for (var m = 0; m < 3; m += 1)
                    {
                        if (m < (array_length(global.honorItem) - 1))
                        {
                            if (global.honorItem[m + 10][0] != "none")
                            {
                                draw_sprite_ext(global.honorItem[m + 10][3], m + 9, (room_width - 250 - 150) + (150 * l), 260, 1, 1, 0, c_white, 1);
                                gml_Script_scr_textoutline((room_width - 250 - 150) + (150 * l), 180, "ID: " + string(m + 10), 16777215, 0, 20, 140);
                                gml_Script_scr_textgradient((room_width - 250 - 150) + (150 * l), 310, "Cost: " + string(global.honorItem[m + 10][1]) + "      (lv." + string(global.honorItem[m + 10][2]) + ")", 16777215, 16777215, undefined, 20, 240);
                                draw_sprite_ext(spr_honor, 1, (room_width - 250 - 150) + (150 * l) + (string_width(global.honorItem[m + 10][1]) / 2), 322, 1, 1, 0, c_white, 1);
                                gml_Script_scr_textgradient((room_width - 250 - 150) + (150 * l), 330, string(global.honorItem[m + 10][0]), 16777215, 16777215, undefined, 20, 140);
                            }
                            
                            l += 1;
                        }
                    }
                }
                
                if ((global.cardTurn - ds_list_size(global.list_notafk) - 1) == 7)
                {
                    draw_set_font(f_mid);
                    draw_set_halign(fa_center);
                    draw_set_valign(fa_top);
                    gml_Script_scr_textoutline(room_width - 250, 140, "Get your items with !redeem(item ID)*(amount)", 16777215, 0, 20, 460);
                    var l = 0;
                    var c = 0;
                    
                    for (var m = 0; m < 3; m += 1)
                    {
                        if (m < (array_length(global.honorItem) - 1))
                        {
                            if (global.honorItem[m + 13][0] != "none")
                            {
                                draw_sprite_ext(global.honorItem[m + 13][3], m + 12, (room_width - 250 - 150) + (150 * l), 260, 1, 1, 0, c_white, 1);
                                gml_Script_scr_textoutline((room_width - 250 - 150) + (150 * l), 180, "ID: " + string(m + 13), 16777215, 0, 20, 140);
                                gml_Script_scr_textgradient((room_width - 250 - 150) + (150 * l), 310, "Cost: " + string(global.honorItem[m + 13][1]) + "      (lv." + string(global.honorItem[m + 13][2]) + ")", 16777215, 16777215, undefined, 20, 240);
                                draw_sprite_ext(spr_honor, 1, (room_width - 250 - 150) + (150 * l) + (string_width(global.honorItem[m + 13][1]) / 2), 322, 1, 1, 0, c_white, 1);
                                gml_Script_scr_textgradient((room_width - 250 - 150) + (150 * l), 330, string(global.honorItem[m + 13][0]), 16777215, 16777215, undefined, 20, 140);
                            }
                            
                            l += 1;
                        }
                    }
                }
                
                if ((global.cardTurn - ds_list_size(global.list_notafk) - 1) == 8)
                {
                    draw_set_font(f_mid);
                    draw_set_halign(fa_center);
                    draw_set_valign(fa_top);
                    gml_Script_scr_textgradient(room_width - 250, 140, "Obtain Corruption Shards in the Corrupted Dimension", undefined, undefined, undefined, 20, 480);
                    
                    with (obj_corruptedControl)
                    {
                        draw_set_halign(fa_center);
                        draw_set_valign(fa_middle);
                        draw_set_font(f_mid);
                        var _total = 0;
                        
                        for (var r = 0; r <= global.maxCorruptedRewards; r++)
                        {
                            if (corruptedReward[r][3] > 0)
                            {
                                var _rewardText = "";
                                var _rewardValue = "";
                                
                                if (string_pos("%", corruptedReward[r][1]) != 0)
                                    _rewardValue = string(gml_Script_scr_bigNumber(corruptedReward[r][0] * corruptedReward[r][3] * 100));
                                else
                                    _rewardValue = string(gml_Script_scr_bigNumber(corruptedReward[r][0] * corruptedReward[r][3]));
                                
                                _rewardText = string_replace(corruptedReward[r][1], "*", _rewardValue);
                                draw_set_halign(fa_left);
                                gml_Script_scr_textshadow(room_width - 480, 190 + (_total * 20), "(x" + string(corruptedReward[r][3]) + ") " + string(corruptedReward[r][2]));
                                draw_set_halign(fa_right);
                                gml_Script_scr_textshadow(room_width - 20, 190 + (_total * 20), _rewardText);
                                _total += 1;
                            }
                        }
                    }
                }
            }
            
            draw_sprite(spr_bar, 1, room_width - 500, room_height - 660);
        }
        else
        {
            with (obj_corruptedControl)
            {
                draw_set_halign(fa_center);
                draw_set_valign(fa_middle);
                draw_set_font(f_big);
                gml_Script_scr_textgradient(room_width - 250, 100, "Corruption Shards:");
                draw_set_font(f_mid);
                var _total = 0;
                
                for (var r = 0; r <= global.maxCorruptedRewards; r++)
                {
                    if (corruptedReward[r][3] > 0)
                    {
                        var _rewardText = "";
                        var _rewardValue = "";
                        
                        if (string_pos("%", corruptedReward[r][1]) != 0)
                            _rewardValue = string(gml_Script_scr_bigNumber(corruptedReward[r][0] * corruptedReward[r][3] * 100));
                        else
                            _rewardValue = string(gml_Script_scr_bigNumber(corruptedReward[r][0] * corruptedReward[r][3]));
                        
                        _rewardText = string_replace(corruptedReward[r][1], "*", _rewardValue);
                        draw_set_halign(fa_left);
                        gml_Script_scr_textshadow(room_width - 480, 150 + (_total * 20), "(x" + string(corruptedReward[r][3]) + ") " + string(corruptedReward[r][2]));
                        draw_set_halign(fa_right);
                        gml_Script_scr_textshadow(room_width - 20, 150 + (_total * 20), _rewardText);
                        _total += 1;
                    }
                }
                
                draw_set_halign(fa_center);
                gml_Script_scr_textshadow(room_width - 250, 240 + (_total * 20), "Obtain Corruption Shards by restoring corruption throughout the Shattered Islands", 12632256, undefined, 20, 240);
            }
        }
        
        draw_set_font(f_mid);
        
        if (global.dev == 1)
            gml_Script_scr_textoutline(100, 90, "DEV MODE", 255, 0, 20, 200);
        
        if (room == r_1)
        {
            if (instance_exists(obj_build_guildhall))
            {
                chestRot += 1;
                
                if (chestRot > 100 && chestRot < 110)
                {
                    if (chestRot < 105)
                        _chestRot1 += 2;
                    
                    if (chestRot >= 105)
                        _chestRot1 -= 2;
                    
                    if (_chestRot1 <= 0)
                        _chestRot1 = 0;
                }
                
                if (chestRot > 120 && chestRot < 130)
                {
                    if (chestRot < 125)
                        _chestRot2 -= 2;
                    
                    if (chestRot >= 125)
                        _chestRot2 += 2;
                    
                    if (_chestRot2 >= 0)
                        _chestRot2 = 0;
                }
                
                if (chestRot > 130 && chestRot < 140)
                {
                    if (chestRot < 135)
                        _chestRot3 += 2;
                    
                    if (chestRot >= 135)
                        _chestRot3 -= 2;
                    
                    if (_chestRot3 <= 0)
                        _chestRot3 = 0;
                }
                
                if (chestRot >= 300)
                    chestRot = 0;
                
                draw_set_font(f_mid);
                
                if (alarm[3] == -1)
                {
                    draw_sprite_ext(spr_guildChest, 0, room_width - 380, room_height - 510, 2, 2, 0, c_white, 1);
                    draw_sprite_ext(spr_guildChest, 0, room_width - 250, room_height - 510, 2, 2, 0, c_white, 1);
                    draw_sprite_ext(spr_guildChest, 0, room_width - 120, room_height - 510, 2, 2, 0, c_white, 1);
                }
                else
                {
                    draw_sprite_ext(spr_guildChest, 1, room_width - 380, room_height - 510, 2, 2, _chestRot1, c_white, 1);
                    draw_sprite_ext(spr_guildChest, 1, room_width - 250, room_height - 510, 2, 2, _chestRot2, c_white, 1);
                    draw_sprite_ext(spr_guildChest, 1, room_width - 120, room_height - 510, 2, 2, _chestRot3, c_white, 1);
                }
                
                if (obj_build_guildhall.level >= 10)
                {
                    draw_set_valign(fa_middle);
                    draw_set_halign(fa_center);
                    gml_Script_scr_textoutline(room_width - 380, room_height - 605, string(global.cmdPrefix) + "chest1*#", 16777215, 0, 20, 600);
                    gml_Script_scr_textoutline(room_width - 250, room_height - 605, string(global.cmdPrefix) + "chest2*#", 16777215, 0, 20, 600);
                    gml_Script_scr_textoutline(room_width - 120, room_height - 605, string(global.cmdPrefix) + "chest3*#", 16777215, 0, 20, 600);
                    draw_sprite_ext(spr_blackbar, 0, room_width - 440, room_height - 504, 380, 2, 0, c_white, 1);
                    
                    if (alarm[3] > 0)
                        draw_sprite_ext(spr_manabarsmall, 0, room_width - 400 - 38, room_height - 501, (alarm[3] / chestDuration) * 376, 1, 0, c_white, 1);
                    
                    if (alarm[4] > 0)
                        draw_sprite_ext(spr_questbar, 0, room_width - 400 - 38, room_height - 506, 376 - ((alarm[4] / chestTimer) * 376), 1, 0, c_white, 1);
                    else
                        draw_sprite_ext(spr_hpbarsmall, 0, room_width - 400 - 38, room_height - 506, 376, 1, 0, c_white, 1);
                    
                    if (alarm[4] == -1)
                    {
                        if (alarm[3] == -1)
                        {
                            gml_Script_twitch_chat_say("/color GoldenRod");
                            gml_Script_twitch_chat_say_direct("/me You can now open your Reward Chests!");
                            gml_Script_twitch_chat_say("/color FireBrick");
                            global.rewardChestProgress = 0;
                            alarm[3] = chestDuration;
                        }
                    }
                    
                    draw_set_halign(fa_center);
                    gml_Script_scr_textoutline(room_width - 250, room_height - 625, "Chests' Value: " + gml_Script_scr_bigNumber(round(global.rewardChestProgress)) + " (Last: " + gml_Script_scr_bigNumber(lastChestValue) + ")", 65535, 0, 20, 500);
                    draw_set_font(f_mid);
                    
                    if (alarm[3] <= 0)
                    {
                    }
                    else
                    {
                        draw_set_halign(fa_center);
                        gml_Script_scr_textoutline(room_width - 250, room_height - 645, "?chest [" + string(0 + floor(obj_build_guildhall.level / 10)) + " keys, ~" + string(round((alarm[3] / chestDuration) * 24)) + "h left]", 16777215, 0, 20, 600);
                        draw_set_halign(fa_left);
                        draw_set_font(f_mid);
                        draw_sprite_ext(spr_black, 0, room_width - 420, room_height - 565 - 12, 30 + string_width("x" + gml_Script_scr_bigNumber(global.chestReward[1][2])), 24, 0, c_white, 0.7);
                        draw_sprite_ext(spr_underworldIcons, 2, room_width - 420, room_height - 565, 1, 1, 0, c_white, 1);
                        gml_Script_scr_textoutline(room_width - 400, room_height - 565, "x" + gml_Script_scr_bigNumber(global.chestReward[1][2]), 16777215, 0, 20, 1000);
                        draw_sprite_ext(spr_black, 0, room_width - 420, room_height - 535 - 12, 30 + string_width(gml_Script_scr_bigNumber(global.chestReward[1][1] * global.globalGoldBonus)), 24, 0, c_white, 0.7);
                        draw_sprite_ext(spr_questIcon, 7, room_width - 420, room_height - 535, 2, 2, 0, c_white, 1);
                        gml_Script_scr_textoutline(room_width - 400, room_height - 535, gml_Script_scr_bigNumber(global.chestReward[1][1] * global.globalGoldBonus), 16777215, 0, 20, 1000);
                        draw_sprite_ext(spr_black, 0, room_width - 290, room_height - 565 - 12, 30 + string_width("x" + gml_Script_scr_bigNumber(global.chestReward[2][2])), 24, 0, c_white, 0.7);
                        draw_sprite(spr_talentscroll, 0, room_width - 290, (room_height - 565) + 16);
                        gml_Script_scr_textoutline(room_width - 270, room_height - 565, "x" + gml_Script_scr_bigNumber(global.chestReward[2][2]), 16777215, 0, 20, 1000);
                        draw_sprite_ext(spr_black, 0, room_width - 290, room_height - 535 - 12, 30 + string_width(gml_Script_scr_bigNumber(global.chestReward[2][1])), 24, 0, c_white, 0.7);
                        draw_sprite_ext(spr_questIcon, 5, room_width - 290, room_height - 535, 2, 2, 0, c_white, 1);
                        gml_Script_scr_textoutline(room_width - 270, room_height - 535, gml_Script_scr_bigNumber(global.chestReward[2][1] * global.globalXPBonus), 16777215, 0, 20, 1000);
                        draw_sprite_ext(spr_black, 0, room_width - 120, room_height - 575 - 12, 30 + string_width("x" + gml_Script_scr_bigNumber(global.chestReward[3][3])), 24, 0, c_white, 0.7);
                        draw_sprite(spr_uniqueItem, global.chestReward[3][1], room_width - 120, room_height - 575);
                        gml_Script_scr_textoutline(room_width - 100, room_height - 575, "x" + gml_Script_scr_bigNumber(global.chestReward[3][3]), 16777215, 0, 20, 1000);
                        draw_sprite_ext(spr_black, 0, room_width - 120, room_height - 530 - 12, 30 + string_width("x" + gml_Script_scr_bigNumber(global.chestReward[3][4])), 24, 0, c_white, 0.7);
                        draw_sprite(spr_uniqueItem, global.chestReward[3][2], room_width - 120, room_height - 530);
                        gml_Script_scr_textoutline(room_width - 100, room_height - 530, "x" + gml_Script_scr_bigNumber(global.chestReward[3][4]), 16777215, 0, 20, 1000);
                        draw_set_font(f_mid);
                    }
                }
                else
                {
                    draw_set_font(f_mid);
                    draw_set_halign(fa_center);
                    draw_sprite_ext(spr_black, 0, room_width - 492, room_height - 652, 484, 158, 0, c_white, 0.8);
                    gml_Script_scr_textoutline(room_width - 250, room_height - 560, "REWARD CHESTS\nUnlocked at Guild Hall level 10", 16777215, 0, 20, 380);
                }
            }
            else
            {
                draw_set_font(f_mid);
                draw_set_halign(fa_center);
                draw_sprite_ext(spr_black, 0, room_width - 492, room_height - 557, 484, 116, 0, c_white, 0.8);
                gml_Script_scr_textoutline(room_width - 250, room_height - 520, "QUESTS\nUnlocked with Guild Hall", 16777215, 0, 20, 380);
            }
        }
    }
    
    draw_set_valign(fa_top);
    
    if (room == r_underworld)
    {
        if (global.portalStage == 8)
        {
            if (audio_is_playing(theme))
                audio_stop_sound(theme);
        }
        
        if (global.portalStage == 8 && !instance_exists(obj_raidTransition))
        {
            if (!audio_is_playing(s_underworldBoss))
            {
                audio_sound_gain(theme, 0, 5000);
                audio_sound_gain(s_underworldBoss, 0, 0);
                audio_play_sound(s_underworldBoss, 1, 1);
                audio_sound_gain(s_underworldBoss, 0.7, 10000);
            }
        }
        
        draw_sprite(spr_underworldHP, 0, room_width - 500, 500);
        draw_sprite(spr_underworldIcons, 0, (room_width - 500) + 50, 547);
        draw_set_font(f_big);
        draw_set_halign(fa_left);
        gml_Script_scr_textoutline((room_width - 500) + 75, 527, gml_Script_scr_bigNumber(floor(global.souls)), 16777215, 0, 20, 200);
        gml_Script_scr_textoutline((room_width - 500) + 75, 563, gml_Script_scr_bigNumber(floor(global.soulsProd)) + "/min", 16776960, 0, 20, 200);
        gml_Script_scr_textoutline((room_width - 500) + 75, 597, gml_Script_scr_bigNumber(floor(global.underworldXPProd * global.globalXPBonus)) + "/min", 16711935, 0, 20, 200);
        gml_Script_scr_textoutline((room_width - 500) + 75, 633, gml_Script_scr_bigNumber(floor(global.underworldGoldProd * global.globalGoldBonus)) + "/min", 65535, 0, 20, 200);
    }
    
    if (room == r_underworld_new)
    {
        if (global.portalTower == global.maxPortalTower)
        {
            if (!audio_is_playing(s_underworldBoss))
            {
                audio_sound_gain(theme, 0, 5000);
                audio_sound_gain(s_underworldBoss, 0, 0);
                audio_play_sound(s_underworldBoss, 1, 1);
                audio_sound_gain(s_underworldBoss, 0.7, 10000);
            }
        }
    }
    
    draw_set_halign(fa_right);
    draw_set_valign(fa_middle);
    draw_sprite(spr_HUDtop, 1, 1040, 0);
    draw_sprite_ext(spr_classIcons, 3, 1100, 40, 2, 2, 0, c_white, 1);
    draw_sprite_ext(spr_character_icons, 0, 1180, 27, 1.5, 1.5, 0, c_white, 1);
    draw_sprite_ext(spr_character_icons, 1, 1230, 27, 1.5, 1.5, 0, c_white, 1);
    draw_sprite_ext(spr_character_icons, 2, 1280, 27, 1.5, 1.5, 0, c_white, 1);
    draw_sprite_ext(spr_character_icons, 3, 1330, 27, 1.5, 1.5, 0, c_white, 1);
    draw_sprite_ext(spr_character_icons, 4, 1380, 27, 1.5, 1.5, 0, c_white, 1);
    draw_set_font(f_big);
    gml_Script_scr_textoutline(1140, 55, string(global.totalPlayers - global.totalAscensionLevel) + "/" + string(global.maxPlayers), 16777215, 0, 34, 500);
    draw_set_font(f_mid);
    gml_Script_scr_textoutline(1205, 35, string(global.warriorNumber), 16777215, 0, 20, 500);
    gml_Script_scr_textoutline(1255, 35, string(global.rogueNumber), 16777215, 0, 20, 500);
    gml_Script_scr_textoutline(1305, 35, string(global.farmerNumber), 16777215, 0, 20, 500);
    gml_Script_scr_textoutline(1355, 35, string(global.rangerNumber), 16777215, 0, 20, 500);
    gml_Script_scr_textoutline(1405, 35, string(global.wizardNumber), 16777215, 0, 20, 500);
    draw_set_halign(fa_left);
    
    if (global.isTwitch == 1)
        gml_Script_scr_textoutline(1155, 58, "twitch.tv/" + string(global.channelName), 16777215, 0, 20, 500);
    
    if (global.isKick == 1)
        gml_Script_scr_textoutline(1155, 58, "kick.com/" + string_replace_all(global.channelName, "_", "-"), 16777215, 0, 20, 500);
}

draw_sprite_ext(spr_version, 0, room_width, 0, 2, 2, 0, c_white, 1);
draw_set_font(f_mid);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(c_black);
draw_text_transformed(room_width - 30, 32, "a v" + string(global.patch), 1, 1, 315);
draw_set_color(c_white);
draw_text_transformed(room_width - 30, 30, "a v" + string(global.patch), 1, 1, 315);

if (debug)
{
    draw_set_halign(fa_left);
    draw_sprite_ext(spr_black, 0, 0, 0, room_width, room_height, 0, c_white, 0.9);
    var _totalText = "Total Instances:";
    
    for (var i = 0; i < instance_count; i++)
    {
        var _obj;
        _obj[i] = instance_id_get(i);
        
        if (instance_exists(_obj[i]))
        {
            _obj[i] = _obj[i].object_index;
            var _text;
            _text[i] = object_get_name(_obj[i]);
            var _objAmount;
            _objAmount[i] = instance_number(_obj[i]);
            
            if (string_pos(string(_text[i]), _totalText) == 0 && _objAmount[i] > 1)
                _totalText += string_hash_to_newline("#Instance " + string(i) + " (" + string(_text[i]) + "): " + string(_objAmount[i]));
        }
    }
    
    draw_set_valign(fa_top);
    draw_text_ext(50, 310, string(_totalText), 20, 500);
    draw_set_valign(fa_middle);
    draw_text(50, 30, "Instances: " + string(instance_count));
    draw_text(50, 50, "Raid Objects: " + string(instance_number(obj_raidObject)));
    draw_text(50, 70, "Raid Background: " + string(instance_number(obj_raidBackground)));
    draw_text(50, 90, "Floating: " + string(instance_number(obj_float)) + " & " + string(instance_number(obj_float2)));
    draw_text(50, 110, "Lists: RL0: " + string(ds_list_size(global.raidList0)) + " | RL1: " + string(ds_list_size(global.raidList1)) + " | ML(1): " + string(ds_list_size(global.raidListMelee)) + " | RN(2): " + string(ds_list_size(global.raidListRanged)) + " | POP: " + string(ds_list_size(global.playerList)) + " | RW: " + string(ds_list_size(global.rewardList)));
    draw_text(50, 130, "Networking Instances: " + string(instance_number(obj_subControl)));
    draw_text(50, 150, "Player Cards: " + string(instance_number(obj_playerCard)));
    draw_text(50, 170, "OStage: " + string(global.ostage) + " | Stage: " + string(global.stage));
    
    if (room == r_1)
        draw_text(50, 190, "Can Raid: " + string(global.canRaid) + " (Raiding = " + string(global.raiding) + ", Enemy Raid = " + string(global.enemyRaid) + ", Enemy Raid Timer = " + string(obj_raid.alarm[4] / room_speed) + ", Portal Timer = " + string(obj_bossKey.alarm[0] / room_speed) + ", Portal Display = " + string(global.portalPointsDisplay) + "|" + string(global.portalPoints) + ", Final War Timer = " + string(obj_raid.alarm[9] / room_speed) + ", Transition = " + string(instance_exists(obj_raidTransition)) + ")");
    
    draw_text(50, 230, "Total Data Structures: " + string(global.ds_counter_total) + " | ~35");
    draw_text(50, 250, "Lists: " + string(global.ds_counter_list) + " | ~27");
    draw_text(50, 270, "Maps: " + string(global.ds_counter_map) + " | ~5");
    draw_text(50, 290, "Grids: " + string(global.ds_counter_grid) + " | ~3");
}

if (room != r_seasonEnd)
    draw_sprite(spr_bar, 1, room_width - 500, room_height - 268);
