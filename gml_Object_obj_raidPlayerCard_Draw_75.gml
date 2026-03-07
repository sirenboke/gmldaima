if (gml_Script_live_call())
    return global.live_result;

with (obj_warrior)
{
    if (alarm[0] == -1 && global.raiding == true && !instance_exists(obj_raidResults) && state != UnknownEnum.Value_10)
    {
        if (round(displayHP) != round(hp))
        {
            var diff = hp - displayHP;
            displayHP += (diff / 10);
        }
        else
        {
            displayHP = hp;
        }
        
        if (myRaidNumber == 0)
        {
            if (stamina <= 20)
            {
                draw_set_font(f_special);
                draw_set_halign(fa_center);
                draw_set_valign(fa_middle);
                gml_Script_scr_textoutline(x, y - height, string(global.cmdPrefix) + "switch", 16777215, 0, 20, 2000);
            }
            
            gml_Script_scr_statColors();
            
            if (raidList == global.raidList1)
            {
                xx = 120;
            }
            else
            {
                xx = 360;
                
                if (ds_list_size(global.raidListRanged) <= 0)
                    xx = 120;
            }
            
            yy = room_height - 100;
            draw_sprite(spr_raidCard3, 0, xx, yy - 22);
            draw_sprite_ext(spr_black, 0, xx - 113, yy - 72, 226, 200, 0, c_white, 0.5);
            draw_sprite_ext(spr_blackbar, 0, xx - 81, yy - 122, 162, 0.5, 0, c_white, 0.5);
            draw_sprite_ext(spr_manabarsmall, 0, xx - 80, yy - 122, (other.alarm[0] / (room_speed * 5)) * 160, 0.5, 0, c_ltgray, 0.5);
            draw_set_valign(fa_middle);
            var totalStatus = 0;
            
            if (poisonStacks > 0)
            {
                totalStatus += 1;
                status[0][0] = poisonStacks;
                status[0][1] = string(status[0][0]) + "x";
                poisonTimer -= 1;
                status[0][2] = poisonTimer;
                status[0][3] = poisonTimerMax;
            }
            else
            {
                status[0][0] = 0;
            }
            
            if (bleedTimer > 0)
            {
                totalStatus += 1;
                status[1][0] = bleedTimer;
                status[1][1] = string(ceil(status[1][0])) + "s";
                status[1][2] = status[1][0];
                status[1][3] = bleedTimerMax;
            }
            else
            {
                status[1][0] = 0;
            }
            
            if (hemorrhageTimer > 0)
            {
                totalStatus += 1;
                status[4][0] = hemorrhageTimer;
                status[4][1] = string(ceil(status[4][0])) + "s";
                status[4][2] = status[4][0];
                status[4][3] = hemorrhageTimerMax;
            }
            else
            {
                status[4][0] = 0;
            }
            
            if (burnStacks > 0)
            {
                totalStatus += 1;
                status[2][0] = burnStacks;
                status[2][1] = string(status[2][0]) + "x";
                status[2][2] = burnTimer;
                status[2][3] = burnTimerMax;
            }
            else
            {
                status[2][0] = 0;
            }
            
            if (freezeStacks > 0)
            {
                totalStatus += 1;
                status[3][0] = freezeStacks;
                status[3][1] = string(status[3][0]) + "x";
                freezeTimer -= 1;
                status[3][2] = freezeTimer;
                status[3][3] = freezeTimerMax;
            }
            else
            {
                status[3][0] = 0;
            }
            
            var statusX = totalStatus * 34;
            var statusH = sprite_get_height(spr_statusDamage);
            draw_set_font(f_mid);
            draw_set_halign(fa_left);
            var ii = 0;
            
            for (var i = 0; i < 5; i++)
            {
                if (status[i][0] > 0)
                {
                    draw_sprite_ext(spr_statusDamage, i, (x - (statusX / 2)) + (ii * 34) + 16, room_height - 20, 1, 1, 0, c_white, 1);
                    draw_sprite_part_ext(spr_statusDamage, i, 0, 0, statusH, statusH - ((status[i][2] / status[i][3]) * statusH), ((x - (statusX / 2)) + (ii * 34) + 16) - (statusH / 2), room_height - 20 - (statusH / 2), 1, 1, c_black, 1);
                    ii += 1;
                }
            }
            
            ii = 0;
            
            for (var i = 0; i < 5; i++)
            {
                if (status[i][0] > 0)
                {
                    gml_Script_scr_textoutline((x - (statusX / 2)) + (ii * 34) + 17 + 2, room_height - 15, status[i][1], 16777215, 0, 20, 1000);
                    ii += 1;
                }
            }
            
            draw_sprite_ext(avi, player.classType, xx, yy - 95, 0.2, 0.2, 0, c_white, 1);
            draw_set_halign(fa_center);
            draw_sprite_ext(myAbilityInfo[3], myAbilityInfo[5] - 1, xx - 45, yy - 95, 1, 1, 0, c_gray, 1);
            draw_sprite_ext(spr_blackbar2, 0, xx - 70, yy - 95 - 20, 2, 40, 0, c_white, 1);
            
            if (myAbilityInfo[4] < global.maxAbilityLevel || player.specialized != 0)
                draw_sprite_ext(spr_xpbarsmall2, 0, xx - 72, (yy - 95) + 18, 1, -((player.myAbilityInfo[7] / player.myAbilityInfo[8]) * 36), 0, c_white, 1);
            else if (player.specialized == 0)
                draw_sprite_ext(spr_energybarsmall2, 0, xx - 72, (yy - 95) + 18, 1, -36, 0, c_white, 1);
            
            draw_sprite_ext(spr_manabarsmall2, 0, xx - 67, (yy - 95) + 18, 1, -((mana / maxmana) * 36), 0, c_white, 1);
            draw_set_font(f_mid);
            
            if (alarm[2] > 1)
            {
                draw_sprite_ext(myAbilityInfo[3], myAbilityInfo[5] - 1, xx - 45, yy - 95, 1, 1, 0, c_white, 1);
                draw_sprite_ext(spr_energybarsmall2, 0, xx - 67, (yy - 95) + 18, 1, -(alarm[2] / room_speed / skillTimer) * 36, 0, c_white, 1);
            }
            
            if (buffed > 0)
            {
                draw_sprite_ext(myAbilityInfo[3], myAbilityInfo[5] - 1, xx - 45, yy - 95, 1, 1, 0, c_white, 1);
                draw_sprite_ext(spr_energybarsmall2, 0, xx - 67, (yy - 95) + 18, 1, -((buffed / skillBuff) * 36), 0, c_white, 1);
            }
            
            if (castingAbility == true)
                draw_sprite_ext(spr_energybarsmall2, 0, xx - 67, (yy - 95) + 18, 1, -36 + ((gml_Script_scr_alarm_get(0) / abilityCastTime) * 36), 0, c_lime, 1);
            
            draw_set_font(f_special);
            
            if (player.specialized == 0)
                draw_sprite_ext(spr_rank, player.myAbilityInfo[4] - 1, xx - 86, yy - 95, 2, 2, 0, c_white, 1);
            else
                gml_Script_scr_textoutline(xx - 45, yy - 80, "lv." + string(player.myAbilityInfo[4]), 16777215, 0, 20, 100);
            
            draw_set_halign(fa_center);
            draw_set_valign(fa_middle);
            draw_sprite_ext(spr_potionTier, 0, xx + 90, yy - 95, 1, 1, 0, c_white, 1);
            
            if (potion > 0)
            {
                draw_sprite_ext(spr_potion, 1, xx + 90, yy - 95, 1, 1, 0, c_white, 1);
                gml_Script_scr_textoutline(xx + 90, yy - 115, string(global.cmdPrefix) + "pot", 16777215, 0, 20, 200);
                draw_set_font(f_mid);
                gml_Script_scr_textoutline(xx + 90, yy - 86, string(potion), 16777215, 0, 20, 200);
            }
            else
            {
                draw_sprite_ext(spr_potion, 0, xx + 90, yy - 95, 1, 1, 0, c_white, 1);
            }
            
            draw_set_halign(fa_center);
            draw_set_valign(fa_middle);
            draw_set_font(f_special);
            var _relicSprite = spr_uniqueItem;
            
            if (player.myRelicSlots <= 1)
            {
                if (player.uniqueItemCorruption[player.uniqueSlot[1]] != 1)
                    _relicSprite = spr_uniqueItem_corrupted;
                
                draw_sprite_ext(_relicSprite, player.uniqueSlot[1], xx + 45, yy - 95, 1, 1, 0, c_white, 1);
                
                if (player.uniqueSlot[1] > 0)
                {
                    gml_Script_scr_textoutline(xx + 45, yy - 80, "lv." + string(uniqueItemLevel[player.uniqueSlot[1]]), 16777215, 0, 20, 100);
                    
                    if (_relicSprite == spr_uniqueItem_corrupted)
                        gml_Script_scr_textoutline(xx + 45, yy - 95, "[x" + string(player.uniqueItemCorruption[player.uniqueSlot[1]]) + "]", 16777215, 0, 20, 100);
                }
            }
            else if (global.showRelic <= player.myRelicSlots)
            {
                if (player.uniqueItemCorruption[player.uniqueSlot[global.showRelic]] != 1)
                    _relicSprite = spr_uniqueItem_corrupted;
                
                draw_sprite_ext(_relicSprite, player.uniqueSlot[global.showRelic], xx + 45, yy - 95, 1, 1, 0, c_white, 1);
                
                if (player.uniqueSlot[global.showRelic] > 0)
                {
                    gml_Script_scr_textoutline(xx + 45, yy - 80, "lv." + string(uniqueItemLevel[player.uniqueSlot[global.showRelic]]), 16777215, 0, 20, 100);
                    
                    if (_relicSprite == spr_uniqueItem_corrupted)
                        gml_Script_scr_textoutline(xx + 45, yy - 95, "[x" + string(player.uniqueItemCorruption[player.uniqueSlot[global.showRelic]]) + "]", 16777215, 0, 20, 100);
                }
            }
            else
            {
                if (player.uniqueItemCorruption[player.uniqueSlot[1]] != 1)
                    _relicSprite = spr_uniqueItem_corrupted;
                
                draw_sprite_ext(_relicSprite, player.uniqueSlot[1], xx + 45, yy - 95, 1, 1, 0, c_white, 1);
                
                if (player.uniqueSlot[1] > 0)
                {
                    gml_Script_scr_textoutline(xx + 45, yy - 80, "lv." + string(uniqueItemLevel[player.uniqueSlot[1]]), 16777215, 0, 20, 100);
                    
                    if (_relicSprite == spr_uniqueItem_corrupted)
                        gml_Script_scr_textoutline(xx + 45, yy - 95, "[x" + string(player.uniqueItemCorruption[player.uniqueSlot[1]]) + "]", 16777215, 0, 20, 100);
                }
            }
            
            if (gml_Script_scr_alarm_get(12) != -1)
            {
                gml_Script_scr_textoutline(xx + 45, yy - 100, string(simStacks) + "x", 16777215, 0, 20, 100);
                draw_sprite_ext(spr_blackbar, 0, (xx + 45) - 20, yy - 112, 40, 1, 0, c_white, 1);
                draw_sprite_ext(spr_energybarsmall, 0, (xx + 45) - 18, yy - 112, (gml_Script_scr_alarm_get(12) / 6 / room_speed) * 36, 1, 0, c_white, 1);
            }
            
            draw_set_halign(fa_left);
            draw_set_font(f_mid);
            gml_Script_scr_textoutline((xx - 105) + string_width("[" + string(showNumber + 1) + "/" + string(totalListNumber) + "]"), yy - 145, string(player.displayName) + " (lv." + gml_Script_scr_bigNumber(level) + ")", 16777215, 0, 20, 500);
            draw_sprite_ext(spr_subStar, player.sub, xx + 100, yy - 148, 1, 1, 0, c_white, 1);
            gml_Script_scr_textoutline(xx - 110, yy - 145, "[" + string(showNumber + 1) + "/" + string(totalListNumber) + "]", 16777215, 0, 20, 500);
            
            if (other.show == 0)
            {
                draw_set_font(f_mid);
                draw_set_halign(fa_center);
                
                if (myAura > 0)
                {
                    draw_sprite_ext(player.spr_aura, 0, xx, yy, 2, 2, global.auraRot, c_white, 1);
                    gml_Script_scr_textoutline(xx, yy, gml_Script_scr_bigNumber(round(player.auraBonus[myAura])) + "%", 16777215, 0, 20, 100);
                }
                
                draw_set_font(f_special);
                draw_set_font(f_special);
                draw_set_halign(fa_left);
                
                for (var i = 0; i < 10; i++)
                {
                    var _xx = 0;
                    var _yy = i * 27;
                    var _offset = 0;
                    draw_set_halign(fa_left);
                    draw_set_valign(fa_middle);
                    
                    if (i > 4)
                    {
                        _xx = 196;
                        _yy = (i * 27) - 135;
                        _offset = 40;
                        draw_set_halign(fa_right);
                    }
                    
                    var _stat;
                    
                    if (i == 0)
                        _stat = 3;
                    
                    if (i == 1)
                        _stat = 8;
                    
                    if (i == 2)
                        _stat = 6;
                    
                    if (i == 3)
                        _stat = 7;
                    
                    if (i == 4)
                        _stat = 0;
                    
                    if (i == 5)
                        _stat = 5;
                    
                    if (i == 6)
                        _stat = 4;
                    
                    if (i == 7)
                        _stat = 1;
                    
                    if (i == 8)
                        _stat = 2;
                    
                    if (i == 9)
                        _stat = 9;
                    
                    if (player.myItemInfo[_stat][0] <= 7)
                    {
                        spr_itemType[_stat] = spr_newItems_small;
                        spr_index[_stat] = player.myItemInfo[_stat][0];
                    }
                    else
                    {
                        spr_itemType[_stat] = spr_newItems_tier2_small;
                        spr_index[_stat] = player.myItemInfo[_stat][0] - 7;
                    }
                    
                    if (player.myItemInfo[_stat][6] != 0)
                    {
                        gemType[_stat] = player.myItemInfo[_stat][6];
                        gemSize[_stat] = player.myItemInfo[_stat][7] + 1;
                        
                        if (gemType[_stat] == 1)
                            gemType[_stat] = spr_itemGem_1;
                        
                        if (gemType[_stat] == 2)
                            gemType[_stat] = spr_itemGem_2;
                        
                        if (gemType[_stat] == 3)
                            gemType[_stat] = spr_itemGem_3;
                        
                        if (gemType[_stat] == 4)
                            gemType[_stat] = spr_itemGem_4;
                        
                        if (gemType[_stat] == 5)
                            gemType[_stat] = spr_itemGem_5;
                        
                        if (gemType[_stat] == 6)
                            gemType[_stat] = spr_itemGem_6;
                    }
                    else
                    {
                        gemType[_stat] = spr_itemGem;
                        gemSize[_stat] = 0;
                    }
                    
                    if (other.alarm[0] > -1)
                    {
                        draw_sprite_ext(spr_item_color, spr_index[_stat], (xx - 100) + _xx, (yy - 55) + _yy, 0.6, 0.6, 0, c_white, 1);
                        draw_sprite_ext(spr_itemType[_stat], _stat, (xx - 100) + _xx, (yy - 55) + _yy, 1, 1, 0, c_white, 1);
                        draw_sprite_ext(gemType[_stat], gemSize[_stat], (xx - 100) + _xx, (yy - 55) + _yy, 1.25, 1.25, 0, c_white, 1);
                        draw_set_halign(fa_center);
                        draw_set_font(f_mid);
                        gml_Script_scr_textoutline((xx - 100) + _xx, ((yy - 55) + _yy) - 13, string_replace_all(player.myItemInfo[_stat][2], "I", "."), 16777215, 0, 0, 100);
                    }
                    else
                    {
                        draw_sprite_ext(spr_statIconsBig_white, _stat, (xx - 100) + _xx, (yy - 55) + _yy, 2, 2, 0, c_white, 1);
                    }
                    
                    draw_set_halign(fa_left);
                    draw_set_font(f_special);
                    
                    if (i > 4)
                        draw_set_halign(fa_right);
                    
                    if (_stat != 5 && _stat != 6)
                        gml_Script_scr_textoutline(((xx - 80) + _xx) - _offset, (yy - 55) + _yy, gml_Script_scr_bigNumber(myStatInfo[_stat][3]) + statSuffix[_stat], c_stat[_stat], 0, 20, 300);
                    
                    if (_stat == 5)
                        gml_Script_scr_textoutline(((xx - 80) + _xx) - _offset, (yy - 55) + _yy, gml_Script_scr_bigNumber(myStatInfo[_stat][3] * healReduction) + statSuffix[_stat], c_stat[_stat], 0, 20, 300);
                    
                    if (_stat == 6)
                        gml_Script_scr_textoutline(((xx - 80) + _xx) - _offset, (yy - 55) + _yy, gml_Script_scr_bigNumber(hpRegenHeal * healReduction) + statSuffix[_stat], c_stat[_stat], 0, 20, 300);
                }
            }
            else if (other.show == 1)
            {
                draw_set_font(f_special);
                draw_set_halign(fa_left);
                gml_Script_scr_textoutline(xx - 100, (yy + 15) - 70, "RES:", 16777215, 0, 20, 300);
                gml_Script_scr_textoutline(xx - 100, (yy + 15) - 50, "DMG:", 16777215, 0, 20, 300);
                gml_Script_scr_textoutline(xx - 100, (yy + 15) - 25, "Other", 16777215, 0, 20, 300);
                draw_sprite_ext(spr_black, 0, xx - 110, (yy + 15) - 10, 220, 2, 0, c_white, 0.5);
                draw_sprite_ext(spr_black, 0, xx + 60, (yy + 15) - 10, 2, 60, 0, c_white, 0.5);
                draw_sprite_ext(spr_resistanceIcons, 4, xx + 30, (yy + 15) - 25, 1, 1, 0, c_white, 1);
                draw_sprite_ext(spr_resistanceIcons, 5, xx + 90, (yy + 15) - 25, 1, 1, 0, c_white, 1);
                gml_Script_scr_textoutline(xx - 100, yy + 15 + 5, "CC:", 16777215, 0, 20, 300);
                gml_Script_scr_textoutline(xx - 100, yy + 15 + 35, "Debuffs:", 16777215, 0, 20, 300);
                var _myResistance, _myDamage;
                
                for (var i = 0; i <= global.damageTypes; i++)
                {
                    _myResistance[0][i] = string(round((1 - myResistance[0][i]) * 100)) + "%";
                    _myDamage[i] = string(round((myDamage[i] - 1) * 100)) + "%";
                }
                
                for (var i = 0; i <= 1; i++)
                {
                    _myResistance[1][i] = string(round((1 - myResistance[1][i]) * 100)) + "%";
                    _myResistance[2][i] = string(round((1 - myResistance[2][i]) * 100)) + "%";
                }
                
                draw_set_halign(fa_center);
                var _color;
                _color[0] = 12632256;
                _color[1] = 255;
                _color[2] = 16776960;
                _color[3] = 65535;
                
                for (var i = 0; i < 4; i++)
                {
                    draw_sprite_ext(spr_manabarsmall2, 0, (xx - 30) + (i * 40), (yy + 15) - 87, 6, 50, 0, _color[i], 1);
                    gml_Script_scr_textoutline((xx - 30) + (i * 40), (yy + 15) - 70, string(_myResistance[0][i]), c_dmgReduction[i], 0, 20, 300);
                    gml_Script_scr_textoutline((xx - 30) + (i * 40), (yy + 15) - 50, string(_myDamage[i]), c_dmgBuff[i], 0, 20, 300);
                }
                
                for (var i = 0; i < 2; i++)
                    gml_Script_scr_textoutline(xx + 30 + (i * 60), yy + 15 + 5, string(_myResistance[1][i]), c_ccReduction[i], 0, 20, 300);
                
                for (var i = 0; i < 2; i++)
                    gml_Script_scr_textoutline(xx + 30 + (i * 60), yy + 15 + 35, string(_myResistance[2][i]), c_debuffReduction[i], 0, 20, 300);
            }
            
            if (player.myVocationInfo[2][0] > 8)
            {
                draw_sprite_ext(spr_vocation_color, player.myVocationInfo[2][0] - 1 - 7, xx - 102, yy + 82, 1, 1, 0, c_white, 1);
                draw_sprite_ext(spr_vocationIcons_t2, 2, xx - 102, yy + 82, 1, 1, 0, c_white, 1);
            }
            else
            {
                draw_sprite_ext(spr_vocation_color, player.myVocationInfo[2][0] - 1, xx - 102, yy + 82, 1, 1, 0, c_white, 1);
                draw_sprite_ext(spr_vocationIcons, 2, xx - 102, yy + 82, 1, 1, 0, c_white, 1);
            }
            
            if (player.myVocationInfo[3][0] > 8)
            {
                draw_sprite_ext(spr_vocation_color, player.myVocationInfo[3][0] - 1 - 7, xx + 102, yy + 82, 1, 1, 0, c_white, 1);
                draw_sprite_ext(spr_vocationIcons_t2, 3, xx + 102, yy + 82, 1, 1, 0, c_white, 1);
            }
            else
            {
                draw_sprite_ext(spr_vocation_color, player.myVocationInfo[3][0] - 1, xx + 102, yy + 82, 1, 1, 0, c_white, 1);
                draw_sprite_ext(spr_vocationIcons, 3, xx + 102, yy + 82, 1, 1, 0, c_white, 1);
            }
            
            draw_sprite_ext(spr_blackbar2, 0, (xx - 102) + 18, yy + 82 + 15, 1, -30, 0, c_white, 1);
            
            if (player.myVocationInfo[2][0] < player.maxVocationLevel)
                draw_sprite_ext(spr_xpbarsmall2, 0, (xx - 102) + 18, yy + 82 + 13, 1, -((player.myVocationInfo[2][1] / player.myVocationInfo[2][2]) * 26), 0, c_white, 1);
            else
                draw_sprite_ext(spr_energybarsmall2, 0, (xx - 102) + 18, yy + 82 + 13, 1, -26, 0, c_white, 1);
            
            draw_sprite_ext(spr_blackbar2, 0, (xx + 102) - 18, yy + 82 + 15, 1, -30, 0, c_white, 1);
            
            if (player.myVocationInfo[3][0] < player.maxVocationLevel)
                draw_sprite_ext(spr_xpbarsmall2, 0, (xx + 102) - 18, yy + 82 + 13, 1, -((player.myVocationInfo[3][1] / player.myVocationInfo[3][2]) * 26), 0, c_white, 1);
            else
                draw_sprite_ext(spr_energybarsmall2, 0, (xx + 102) - 18, yy + 82 + 13, 1, -26, 0, c_white, 1);
            
            draw_sprite_ext(spr_blackbar, 0, xx - 81, yy + 82, 163, 5, 0, c_white, 1);
            draw_sprite_ext(spr_hpbar, 0, (xx - 81) + 2, yy + 82, clamp((displayHP / myStatInfo[8][3]) * 159, 0, 159), 2, 0, c_white, 1);
            
            if (hp > displayHP)
                draw_sprite_ext(spr_hpbar, 0, (xx - 81) + 2 + ((displayHP / myStatInfo[8][3]) * 159), yy + 82, clamp(((hp - displayHP) / myStatInfo[8][3]) * 159, 0, 159), 2, 0, c_gray, 1);
            else
                draw_sprite_ext(spr_redbar, 0, (xx - 81) + 2 + ((displayHP / myStatInfo[8][3]) * 159), yy + 82, clamp(((hp - displayHP) / myStatInfo[8][3]) * 159, 0, 159), 2, 0, c_ltgray, 1);
            
            if (shield > 0)
            {
                if (((shield / myStatInfo[8][3]) * 163) > 159)
                    draw_sprite_ext(spr_shieldbar, 0, ((xx - 81) + 163) - 2, yy + 82, -159, 2, 0, c_ltgray, 1);
                else
                    draw_sprite_ext(spr_shieldbar, 0, ((xx - 81) + 163) - 2, yy + 82, clamp(((-shield / myStatInfo[8][3]) * 163) + 4, -159, 0), 2, 0, c_ltgray, 1);
                
                if (decayableShield > 0 && shield > myStatInfo[8][3])
                {
                    var _decayRatio = min(decayableShield / shield, 1);
                    var _visualDecay = shield * _decayRatio;
                    var _decayWidth = clamp(((-_visualDecay / myStatInfo[8][3]) * 163) + 4, -159, 0);
                    var _decayColor = 4210752;
                    
                    if (((_visualDecay / myStatInfo[8][3]) * 163) > 159)
                        draw_sprite_ext(spr_shieldbar, 0, ((xx - 81) + 163) - 2, yy + 82, -159, 2, 0, _decayColor, 0.7);
                    else
                        draw_sprite_ext(spr_shieldbar, 0, ((xx - 81) + 163) - 2, yy + 82, _decayWidth, 2, 0, _decayColor, 0.7);
                }
            }
            
            if (xp < maxxp)
                draw_sprite_ext(spr_xpbarsmall, 0, (xx - 81) + 2, yy + 93, (xp / maxxp) * 159, 1, 0, c_white, 1);
            else
                draw_sprite_ext(spr_questbar, 0, (xx - 81) + 2, yy + 93, 159, 1, 0, c_white, 1);
            
            if (stamina > (maxStamina / 2))
                draw_sprite_ext(spr_manabarsmall, 0, (xx - 81) + 2, yy + 71, (stamina / maxStamina) * 159, 1, 0, c_yellow, 1);
            else if (stamina > (maxStamina / 10))
                draw_sprite_ext(spr_manabarsmall, 0, (xx - 81) + 2, yy + 71, (stamina / maxStamina) * 159, 1, 0, c_orange, 1);
            else if (stamina > 0)
                draw_sprite_ext(spr_manabarsmall, 0, (xx - 81) + 2, yy + 71, (stamina / maxStamina) * 159, 1, 0, c_red, 1);
            
            for (var i = 1; i < 5; i += 1)
                draw_sprite_ext(spr_hpMeter, 0, (xx - 82) + (32.6 * i), yy + 82, 1, 7, 0, c_white, 1);
            
            draw_set_font(f_special_old);
            draw_set_halign(fa_left);
            
            if (alarm[7] == -1)
                gml_Script_scr_textoutline(xx - 70, yy + 80, gml_Script_scr_bigNumber(hp), 16777215, 0, 20, 600);
            
            if (shield > 0)
            {
                draw_set_halign(fa_right);
                
                if (alarm[7] == -1)
                    gml_Script_scr_textoutline((xx - 81) + 153, yy + 80, gml_Script_scr_bigNumber(shield), 16777215, 0, 20, 600);
                
                draw_set_halign(fa_left);
            }
            
            if (alarm[7] != -1)
            {
                draw_sprite_ext(spr_blackbar, 0, xx - 81, yy + 82, 163, 3, 0, c_white, 0.5);
                gml_Script_scr_textoutline(xx - 70, yy + 80, "Undying Faith (" + string(round(alarm[7] / room_speed)) + "s)", 65535, 0, 20, 600);
            }
            
            draw_set_halign(fa_center);
            gml_Script_scr_textoutline(xx - 102, yy + 80, string(round((1 - myResistance[0][0]) * 100)) + "%", c_dmgReduction[0], 0, 20, 300);
            gml_Script_scr_textoutline(xx + 102, yy + 80, string(round((myDamage[0] - 1) * 100)) + "%", c_dmgBuff[0], 0, 20, 300);
        }
    }
}

enum UnknownEnum
{
    Value_10 = 10
}
