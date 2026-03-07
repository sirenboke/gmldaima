if (gml_Script_live_call())
    return global.live_result;

if (alarm[11] == -1)
{
    if (instance_exists(player))
    {
        if (myTurn == false || obj_gameControl.showPlayers == 0 || room == r_seasonEnd || room == r_corrupted)
        {
        }
        else
        {
            image_index = 1;
            image_speed = 0;
            
            if (player.myAura > 0)
                draw_sprite_ext(player.spr_aura, 0, x, y, 4, 4, global.auraRot, c_white, 1);
            
            if (sprite_exists(player.avatar))
                draw_sprite_ext(player.avatar, 0, x, y - 20, 0.5, 0.5, 0, c_white, 1);
            
            draw_set_halign(fa_center);
            draw_set_valign(fa_middle);
            
            if (player.myAura > 0)
            {
                draw_set_font(f_mid);
                gml_Script_scr_textoutline(x, y - 56, "Aura Power: " + gml_Script_scr_bigNumber(round(player.auraBonus[player.myAura])) + "%", 16777215, 0, 20, 10000);
            }
            
            if (player.specialized == 0)
                draw_sprite_ext(player.myAbilityInfo[3], player.myAbilityInfo[5] - 1, x - 25, y + 50, 1, 1, 0, c_white, 1);
            else
                draw_sprite_ext(player.myAbilityInfo[3], 0, x - 25, y + 50, 1, 1, 0, c_white, 1);
            
            draw_set_font(f_special);
            
            if (player.specialized == 0)
                draw_sprite_ext(spr_rank, player.myAbilityInfo[4] - 1, x - 45, y + 50, 2, 2, 0, c_white, 1);
            else
                gml_Script_scr_textoutline(x - 25, y + 65, "lv." + string(player.myAbilityInfo[4]), 16777215, 0, 20, 100);
            
            draw_sprite_ext(spr_blackbar, 0, x - 45, (y + 50) - 20 - 2, 39, 1, 0, c_white, 1);
            
            if (player.myAbilityInfo[4] < global.maxAbilityLevel || player.specialized != 0)
                draw_sprite_ext(spr_xpbarsmall, 0, (x - 45) + 2, (y + 50) - 20 - 2, (player.myAbilityInfo[7] / player.myAbilityInfo[8]) * 35, 1, 0, c_white, 1);
            else if (player.specialized == 0)
                draw_sprite_ext(spr_energybarsmall, 0, (x - 45) + 2, (y + 50) - 20 - 2, 35, 1, 0, c_white, 1);
            
            draw_sprite_ext(spr_autoIcon, player.autoAbility, (x - 25) + 12, (y + 50) - 12, 1, 1, 0, c_white, 1);
            draw_sprite_ext(spr_potionTier, 0, x, y + 100, 1, 1, 0, c_white, 1);
            draw_sprite_ext(spr_potion, 1, x, y + 100, 1, 1, 0, c_white, 1);
            draw_sprite_ext(spr_autoIcon, player.autoPot, x + 12, (y + 100) - 12, 1, 1, 0, c_white, 1);
            gml_Script_scr_textoutline(x, y + 115, string(player.myTier + 1), 16777215, 0, 20, 200);
            var _relicSprite = spr_uniqueItem;
            
            if (player.myRelicSlots <= 1)
            {
                if (player.uniqueItemCorruption[player.uniqueSlot[1]] != 1)
                    _relicSprite = spr_uniqueItem_corrupted;
                
                draw_sprite_ext(_relicSprite, player.uniqueSlot[1], x + 25, y + 50, 1, 1, 0, c_white, 1);
                
                if (player.uniqueSlot[1] > 0)
                {
                    gml_Script_scr_textoutline(x + 25, y + 65, "lv." + string(player.uniqueItemLevel[player.uniqueSlot[1]]), 16777215, 0, 20, 100);
                    
                    if (_relicSprite == spr_uniqueItem_corrupted)
                        gml_Script_scr_textoutline(x + 25, y + 47, "[x" + string(player.uniqueItemCorruption[player.uniqueSlot[1]]) + "]", 16777215, 0, 20, 100);
                }
                
                gml_Script_scr_textoutline(x + 25, y + 30, "(1/1)", 16777215, 0, 20, 100);
            }
            else if (global.showRelic <= player.myRelicSlots)
            {
                if (player.uniqueItemCorruption[player.uniqueSlot[global.showRelic]] != 1)
                    _relicSprite = spr_uniqueItem_corrupted;
                
                draw_sprite_ext(_relicSprite, player.uniqueSlot[global.showRelic], x + 25, y + 50, 1, 1, 0, c_white, 1);
                
                if (player.uniqueSlot[global.showRelic] > 0)
                {
                    gml_Script_scr_textoutline(x + 25, y + 65, "lv." + string(player.uniqueItemLevel[player.uniqueSlot[global.showRelic]]), 16777215, 0, 20, 100);
                    
                    if (_relicSprite == spr_uniqueItem_corrupted)
                        gml_Script_scr_textoutline(x + 25, y + 47, "[x" + string(player.uniqueItemCorruption[player.uniqueSlot[global.showRelic]]) + "]", 16777215, 0, 20, 100);
                }
                
                gml_Script_scr_textoutline(x + 25, y + 30, "(" + string(global.showRelic) + "/" + string(player.myRelicSlots) + ")", 16777215, 0, 20, 100);
            }
            else
            {
                if (player.uniqueItemCorruption[player.uniqueSlot[1]] != 1)
                    _relicSprite = spr_uniqueItem_corrupted;
                
                draw_sprite_ext(_relicSprite, player.uniqueSlot[1], x + 25, y + 50, 1, 1, 0, c_white, 1);
                
                if (player.uniqueSlot[1] > 0)
                {
                    gml_Script_scr_textoutline(x + 25, y + 65, "lv." + string(player.uniqueItemLevel[player.uniqueSlot[1]]), 16777215, 0, 20, 100);
                    
                    if (_relicSprite == spr_uniqueItem_corrupted)
                        gml_Script_scr_textoutline(x + 25, y + 47, "[x" + string(player.uniqueItemCorruption[player.uniqueSlot[1]]) + "]", 16777215, 0, 20, 100);
                }
                
                gml_Script_scr_textoutline(x + 25, y + 30, "(1/" + string(player.myRelicSlots) + ")", 16777215, 0, 20, 100);
            }
            
            draw_set_font(f_mid);
            draw_set_halign(fa_left);
            draw_set_valign(fa_middle);
            draw_sprite_ext(spr_subStar, player.sub, x - 230, y - 138, 1, 1, 0, c_white, 1);
            var _displayName = player.name;
            
            if (string_pos("ascended ", _displayName) == 1)
            {
                var _oldName = string_delete(_displayName, 1, 9);
                var _cutPos = string_last_pos(" ", _oldName) + 4;
                _displayName = "# " + string_copy(_oldName, 1, _cutPos) + "...";
            }
            
            gml_Script_scr_textoutline(x - 215, y - 140, string(_displayName) + " (lv." + gml_Script_scr_bigNumber(player.level) + ")", textColor, 0, 20, 500);
            draw_set_halign(fa_center);
            draw_set_font(f_special);
            draw_set_font(f_mid);
            draw_set_halign(fa_right);
            draw_set_valign(fa_middle);
            displayGold = gml_Script_scr_bigNumber(floor(player.mygold));
            displayFood = gml_Script_scr_bigNumber(floor(player.myfood));
            displayHonor = gml_Script_scr_bigNumber(floor(player.honorPoints));
            draw_set_halign(fa_left);
            draw_set_valign(fa_middle);
            draw_sprite_ext(spr_honor, 2, x - 215, y + 137, 1, 1, 0, c_white, 1);
            gml_Script_scr_textgradient(x - 205, y + 135, string(displayGold), 65535, 4235519, undefined, 20, 1000);
            draw_sprite_ext(spr_underworldIcons, 2, (x - 215) + string_width(displayGold) + 30, y + 138, 0.5, 0.5, 0, c_white, 1);
            gml_Script_scr_textgradient((x - 205) + 30 + string_width(displayGold), y + 135, gml_Script_scr_bigNumber(player.myGems), 16777215, 16777215, undefined, 20, 1000);
            draw_sprite_ext(spr_food, 0, x - 215, y + 157, 0.5, 0.5, 0, c_white, 1);
            gml_Script_scr_textgradient(x - 205, y + 155, string(displayFood), 16777215, 16777215, undefined, 20, 1000);
            draw_sprite_ext(spr_honor, 1, (x - 215) + 30 + string_width(string(displayFood)), y + 158, 1, 1, 0, c_white, 1);
            gml_Script_scr_textgradient((x - 205) + 30 + string_width(string(displayFood)), y + 155, string(displayHonor), 16777215, 12632256, undefined, 20, 1000);
            draw_sprite_ext(spr_talentscroll, 1, x - 215, y + 185, 0.5, 0.5, 0, c_white, 1);
            gml_Script_scr_textgradient(x - 205, y + 175, gml_Script_scr_bigNumber(floor(player.skillPoints)), 16777215, 12632256, undefined, 20, 1000);
            
            if (player.specialized > 0)
            {
                draw_sprite_ext(spr_specialPoint, 0, (x - 215) + 30 + string_width(gml_Script_scr_bigNumber(floor(player.skillPoints))), y + 176, 0.5, 0.5, 0, c_white, 1);
                gml_Script_scr_textgradient((x - 205) + 30 + string_width(gml_Script_scr_bigNumber(floor(player.skillPoints))), y + 175, gml_Script_scr_bigNumber(floor(player.specialPoints[player.myAbilityInfo[0]])), 16777215, 12632256, undefined, 20, 1000);
            }
            
            draw_set_halign(fa_right);
            draw_sprite_ext(spr_resourceBonus, 0, x + 215, y + 135, 1, 1, 0, c_white, 1);
            draw_sprite_ext(spr_xpBonus, 0, x + 215, y + 155, 1, 1, 0, c_white, 1);
            
            if (player.alarm[8] != -1)
            {
                gml_Script_scr_textgradient(x + 200, y + 135, "(+20%[x] for " + string(round(player.alarm[8] / room_speed / 60)) + "m)", 16777215, 12632256, undefined, 20, 1000);
                gml_Script_scr_textgradient((x + 200) - string_width(" (+20%[x] for " + string(round(player.alarm[8] / room_speed / 60)) + "m)"), y + 135, "+" + gml_Script_scr_bigNumber(round((player.myMultiplier[4] - 1) * 100)) + "%[x]", 16777215, 12632256, undefined, 20, 1000);
            }
            else
            {
                gml_Script_scr_textgradient(x + 200, y + 135, "+" + gml_Script_scr_bigNumber(round((player.myMultiplier[4] - 1) * 100)) + "%[x]", 16777215, 16777215, 16777215, 16777215, 20, 1000);
            }
            
            if (player.alarm[9] != -1)
            {
                gml_Script_scr_textgradient(x + 200, y + 155, "(+20%[x] for " + string(round(player.alarm[9] / room_speed / 60)) + "m)", 16777215, 12632256, undefined, 20, 1000);
                gml_Script_scr_textgradient((x + 200) - string_width(" (+20%[x] for " + string(round(player.alarm[9] / room_speed / 60)) + "m)"), y + 155, "+" + gml_Script_scr_bigNumber(round((player.myMultiplier[2] - 1) * 100)) + "%[x]", 16777215, 12632256, undefined, 20, 1000);
            }
            else
            {
                gml_Script_scr_textgradient(x + 200, y + 155, "+" + gml_Script_scr_bigNumber(round((player.myMultiplier[2] - 1) * 100)) + "%[x]", 16777215, 12632256, undefined, 20, 1000);
            }
            
            gml_Script_scr_textgradient(x + 225, y + 175, "Build " + string(player.build) + "/" + string(player.myBuildSlots) + " (" + string(player.buildName) + ")", 16777215, 16777215, undefined, 20, 1000);
            draw_set_halign(fa_left);
            
            for (var i = 0; i <= 9; i++)
            {
                if (player.myItemInfo[i][0] <= 7)
                {
                    spr_itemType[i] = spr_newItems;
                    spr_index[i] = player.myItemInfo[i][0];
                }
                else
                {
                    spr_itemType[i] = spr_newItems_tier2;
                    spr_index[i] = player.myItemInfo[i][0] - 7;
                }
                
                if (player.myItemInfo[i][6] != 0)
                {
                    gemType[i] = player.myItemInfo[i][6];
                    gemSize[i] = player.myItemInfo[i][7] + 1;
                    
                    if (gemType[i] == 1)
                        gemType[i] = spr_itemGem_1;
                    
                    if (gemType[i] == 2)
                        gemType[i] = spr_itemGem_2;
                    
                    if (gemType[i] == 3)
                        gemType[i] = spr_itemGem_3;
                    
                    if (gemType[i] == 4)
                        gemType[i] = spr_itemGem_4;
                    
                    if (gemType[i] == 5)
                        gemType[i] = spr_itemGem_5;
                    
                    if (gemType[i] == 6)
                        gemType[i] = spr_itemGem_6;
                }
                else
                {
                    gemType[i] = spr_itemGem;
                    gemSize[i] = 0;
                }
            }
            
            draw_sprite_ext(spr_item_color, spr_index[3], x - 205, y - 80, 1, 1, 0, c_white, 1);
            draw_sprite_ext(spr_itemType[3], 3, x - 205, y - 80, 1, 1, 0, c_white, 1);
            draw_sprite_ext(gemType[3], gemSize[3], x - 205, y - 80, 2, 2, 0, c_white, 1);
            draw_sprite_ext(spr_item_color, spr_index[8], x - 210, (y - 40) + 4, 1, 1, 0, c_white, 1);
            draw_sprite_ext(spr_itemType[8], 8, x - 210, (y - 40) + 4, 1, 1, 0, c_white, 1);
            draw_sprite_ext(gemType[8], gemSize[8], x - 210, (y - 40) + 4, 2, 2, 0, c_white, 1);
            draw_sprite_ext(spr_item_color, spr_index[6], x - 215, y + 8, 1, 1, 0, c_white, 1);
            draw_sprite_ext(spr_itemType[6], 6, x - 215, y + 8, 1, 1, 0, c_white, 1);
            draw_sprite_ext(gemType[6], gemSize[6], x - 215, y + 8, 2, 2, 0, c_white, 1);
            draw_sprite_ext(spr_item_color, spr_index[7], x - 210, y + 40 + 12, 1, 1, 0, c_white, 1);
            draw_sprite_ext(spr_itemType[7], 7, x - 210, y + 40 + 12, 1, 1, 0, c_white, 1);
            draw_sprite_ext(gemType[7], gemSize[7], x - 210, y + 40 + 12, 2, 2, 0, c_white, 1);
            draw_sprite_ext(spr_item_color, spr_index[0], x - 205, y + 80 + 16, 1, 1, 0, c_white, 1);
            draw_sprite_ext(spr_itemType[0], 0, x - 205, y + 80 + 16, 1, 1, 0, c_white, 1);
            draw_sprite_ext(gemType[0], gemSize[0], x - 205, y + 80 + 16, 2, 2, 0, c_white, 1);
            draw_sprite_ext(spr_item_color, spr_index[9], x + 205, y + 80 + 16, 1, 1, 0, c_white, 1);
            draw_sprite_ext(spr_itemType[9], 9, x + 205, y + 80 + 16, 1, 1, 0, c_white, 1);
            draw_sprite_ext(gemType[9], gemSize[9], x + 205, y + 80 + 16, 2, 2, 0, c_white, 1);
            draw_sprite_ext(spr_item_color, spr_index[5], x + 205, y - 80, 1, 1, 0, c_white, 1);
            draw_sprite_ext(spr_itemType[5], 5, x + 205, y - 80, 1, 1, 0, c_white, 1);
            draw_sprite_ext(gemType[5], gemSize[5], x + 205, y - 80, 2, 2, 0, c_white, 1);
            draw_sprite_ext(spr_item_color, spr_index[4], x + 210, (y - 40) + 4, 1, 1, 0, c_white, 1);
            draw_sprite_ext(spr_itemType[4], 4, x + 210, (y - 40) + 4, 1, 1, 0, c_white, 1);
            draw_sprite_ext(gemType[4], gemSize[4], x + 210, (y - 40) + 4, 2, 2, 0, c_white, 1);
            draw_sprite_ext(spr_item_color, spr_index[1], x + 215, y + 8, 1, 1, 0, c_white, 1);
            draw_sprite_ext(spr_itemType[1], 1, x + 215, y + 8, 1, 1, 0, c_white, 1);
            draw_sprite_ext(gemType[1], gemSize[1], x + 215, y + 8, 2, 2, 0, c_white, 1);
            draw_sprite_ext(spr_item_color, spr_index[2], x + 210, y + 40 + 12, 1, 1, 0, c_white, 1);
            draw_sprite_ext(spr_itemType[2], 2, x + 210, y + 40 + 12, 1, 1, 0, c_white, 1);
            draw_sprite_ext(gemType[2], gemSize[2], x + 210, y + 40 + 12, 2, 2, 0, c_white, 1);
            draw_sprite_ext(spr_blackbar2, 0, (x - 205) + 21, y - 100, 1, 40, 0, c_white, 1);
            
            if (player.myStatInfo[3][3] < player.myStatInfo[3][4])
                draw_sprite_ext(spr_xpbarsmall2, 0, (x - 205) + 21, y - 62, 1, -((player.myStatInfo[3][3] / player.myStatInfo[3][4]) * 36), 0, c_white, 1);
            else
                draw_sprite_ext(spr_energybarsmall2, 0, (x - 205) + 21, y - 62, 1, -36, 0, c_white, 1);
            
            draw_sprite_ext(spr_blackbar2, 0, (x - 210) + 21, (y - 60) + 4, 1, 40, 0, c_white, 1);
            
            if (player.myStatInfo[8][3] < player.myStatInfo[8][4])
                draw_sprite_ext(spr_xpbarsmall2, 0, (x - 210) + 21, (y - 22) + 4, 1, -((player.myStatInfo[8][3] / player.myStatInfo[8][4]) * 36), 0, c_white, 1);
            else
                draw_sprite_ext(spr_energybarsmall2, 0, (x - 210) + 21, (y - 22) + 4, 1, -36, 0, c_white, 1);
            
            draw_sprite_ext(spr_blackbar2, 0, (x - 215) + 21, (y - 20) + 8, 1, 40, 0, c_white, 1);
            
            if (player.myStatInfo[6][3] < player.myStatInfo[6][4])
                draw_sprite_ext(spr_xpbarsmall2, 0, (x - 215) + 21, y + 18 + 8, 1, -((player.myStatInfo[6][3] / player.myStatInfo[6][4]) * 36), 0, c_white, 1);
            else
                draw_sprite_ext(spr_energybarsmall2, 0, (x - 215) + 21, y + 18 + 8, 1, -36, 0, c_white, 1);
            
            draw_sprite_ext(spr_blackbar2, 0, (x - 210) + 21, y + 20 + 12, 1, 40, 0, c_white, 1);
            
            if (player.myStatInfo[7][3] < player.myStatInfo[7][4])
                draw_sprite_ext(spr_xpbarsmall2, 0, (x - 210) + 21, y + 58 + 12, 1, -((player.myStatInfo[7][3] / player.myStatInfo[7][4]) * 36), 0, c_white, 1);
            else
                draw_sprite_ext(spr_energybarsmall2, 0, (x - 210) + 21, y + 58 + 12, 1, -36, 0, c_white, 1);
            
            draw_sprite_ext(spr_blackbar2, 0, (x - 205) + 21, y + 60 + 16, 1, 40, 0, c_white, 1);
            
            if (player.myStatInfo[0][3] < player.myStatInfo[0][4])
                draw_sprite_ext(spr_xpbarsmall2, 0, (x - 205) + 21, y + 98 + 16, 1, -((player.myStatInfo[0][3] / player.myStatInfo[0][4]) * 36), 0, c_white, 1);
            else
                draw_sprite_ext(spr_energybarsmall2, 0, (x - 205) + 21, y + 98 + 16, 1, -36, 0, c_white, 1);
            
            draw_sprite_ext(spr_blackbar2, 0, (x + 205) - 21, y - 100, 1, 40, 0, c_white, 1);
            
            if (player.myStatInfo[5][3] < player.myStatInfo[5][4])
                draw_sprite_ext(spr_xpbarsmall2, 0, (x + 205) - 21, y - 62, 1, -((player.myStatInfo[5][3] / player.myStatInfo[5][4]) * 36), 0, c_white, 1);
            else
                draw_sprite_ext(spr_energybarsmall2, 0, (x + 205) - 21, y - 62, 1, -36, 0, c_white, 1);
            
            draw_sprite_ext(spr_blackbar2, 0, (x + 210) - 21, (y - 60) + 4, 1, 40, 0, c_white, 1);
            
            if (player.myStatInfo[4][3] < player.myStatInfo[4][4])
                draw_sprite_ext(spr_xpbarsmall2, 0, (x + 210) - 21, (y - 22) + 4, 1, -((player.myStatInfo[4][3] / player.myStatInfo[4][4]) * 36), 0, c_white, 1);
            else
                draw_sprite_ext(spr_energybarsmall2, 0, (x + 210) - 21, (y - 22) + 4, 1, -36, 0, c_white, 1);
            
            draw_sprite_ext(spr_blackbar2, 0, (x + 215) - 21, (y - 20) + 8, 1, 40, 0, c_white, 1);
            
            if (player.myStatInfo[1][3] < player.myStatInfo[1][4])
                draw_sprite_ext(spr_xpbarsmall2, 0, (x + 215) - 21, y + 18 + 8, 1, -((player.myStatInfo[1][3] / player.myStatInfo[1][4]) * 36), 0, c_white, 1);
            else
                draw_sprite_ext(spr_energybarsmall2, 0, (x + 215) - 21, y + 18 + 8, 1, -36, 0, c_white, 1);
            
            draw_sprite_ext(spr_blackbar2, 0, (x + 210) - 21, y + 20 + 12, 1, 40, 0, c_white, 1);
            
            if (player.myStatInfo[2][3] < player.myStatInfo[2][4])
                draw_sprite_ext(spr_xpbarsmall2, 0, (x + 210) - 21, y + 58 + 12, 1, -((player.myStatInfo[2][3] / player.myStatInfo[2][4]) * 36), 0, c_white, 1);
            else
                draw_sprite_ext(spr_energybarsmall2, 0, (x + 210) - 21, y + 58 + 12, 1, -36, 0, c_white, 1);
            
            draw_sprite_ext(spr_blackbar2, 0, (x + 205) - 21, y + 60 + 16, 1, 40, 0, c_white, 1);
            
            if (player.myStatInfo[9][3] < player.myStatInfo[9][4])
                draw_sprite_ext(spr_xpbarsmall2, 0, (x + 205) - 21, y + 98 + 16, 1, -((player.myStatInfo[9][3] / player.myStatInfo[9][4]) * 36), 0, c_white, 1);
            else
                draw_sprite_ext(spr_energybarsmall2, 0, (x + 205) - 21, y + 98 + 16, 1, -36, 0, c_white, 1);
            
            draw_set_halign(fa_right);
            draw_set_valign(fa_top);
            draw_set_font(f_mid_pixel);
            draw_set_font(f_big);
            draw_set_halign(fa_center);
            draw_set_valign(fa_middle);
            var _tier = [];
            
            for (var t = 0; t <= 9; t++)
                _tier[t] = string_repeat(".", player.myItemInfo[t][1]);
            
            gml_Script_scr_textoutline(x - 190 - 15, (y - 100) + 2, _tier[3], 16777215, 0, 0, 100);
            gml_Script_scr_textoutline(x - 195 - 15, (y - 60) + 6, _tier[8], 16777215, 0, 0, 100);
            gml_Script_scr_textoutline(x - 200 - 15, (y - 20) + 10, _tier[6], 16777215, 0, 0, 100);
            gml_Script_scr_textoutline(x - 195 - 15, y + 20 + 14, _tier[7], 16777215, 0, 0, 100);
            gml_Script_scr_textoutline(x - 190 - 15, y + 60 + 18, _tier[0], 16777215, 0, 0, 100);
            gml_Script_scr_textoutline((x + 220) - 15, (y - 100) + 2, _tier[5], 16777215, 0, 0, 100);
            gml_Script_scr_textoutline((x + 225) - 15, (y - 60) + 6, _tier[4], 16777215, 0, 0, 100);
            gml_Script_scr_textoutline((x + 230) - 15, (y - 20) + 10, _tier[1], 16777215, 0, 0, 100);
            gml_Script_scr_textoutline((x + 225) - 15, y + 20 + 14, _tier[2], 16777215, 0, 0, 100);
            gml_Script_scr_textoutline((x + 220) - 15, y + 60 + 18, _tier[9], 16777215, 0, 0, 100);
            draw_set_font(f_special);
            draw_set_halign(fa_left);
            draw_set_valign(fa_middle);
            draw_sprite_ext(spr_statIcons, 3, x - 170, y - 70, 1, 1, 0, c_white, 1);
            gml_Script_scr_textoutline(x - 180, y - 90, string(player.myItemInfo[3][5]), textColor, 0, 20, 300);
            gml_Script_scr_textoutline(x - 160, y - 70, string(player.myStatInfo[3][3]), textColor, 0, 20, 300);
            draw_sprite_ext(spr_statIcons, 8, x - 175, (y - 30) + 4, 1, 1, 0, c_white, 1);
            gml_Script_scr_textoutline(x - 185, (y - 50) + 4, string(player.myItemInfo[8][5]), textColor, 0, 20, 300);
            gml_Script_scr_textoutline(x - 165, (y - 30) + 4, gml_Script_scr_bigNumber(player.myStatInfo[8][3]), textColor, 0, 20, 300);
            draw_sprite_ext(spr_statIcons, 6, x - 180, y + 10 + 8, 1, 1, 0, c_white, 1);
            gml_Script_scr_textoutline(x - 190, (y - 10) + 8, string(player.myItemInfo[6][5]), textColor, 0, 20, 300);
            gml_Script_scr_textoutline(x - 170, y + 10 + 8, gml_Script_scr_bigNumber(player.myStatInfo[6][3]) + "/s", textColor, 0, 20, 300);
            draw_sprite_ext(spr_statIcons, 7, x - 175, y + 50 + 12, 1, 1, 0, c_white, 1);
            gml_Script_scr_textoutline(x - 185, y + 30 + 12, string(player.myItemInfo[7][5]), textColor, 0, 20, 300);
            gml_Script_scr_textoutline(x - 165, y + 50 + 12, gml_Script_scr_bigNumber(player.myStatInfo[7][3]) + "%", textColor, 0, 20, 300);
            draw_sprite_ext(spr_statIcons, 0, x - 170, y + 90 + 16, 1, 1, 0, c_white, 1);
            gml_Script_scr_textoutline(x - 180, y + 70 + 16, string(player.myItemInfo[0][5]), textColor, 0, 20, 300);
            gml_Script_scr_textoutline(x - 160, y + 90 + 16, gml_Script_scr_bigNumber(player.myStatInfo[0][3]), textColor, 0, 20, 300);
            draw_set_halign(fa_right);
            draw_sprite_ext(spr_statIcons, 5, x + 170, y - 70, 1, 1, 0, c_white, 1);
            gml_Script_scr_textoutline(x + 180, y - 90, string(player.myItemInfo[5][5]), textColor, 0, 20, 300);
            gml_Script_scr_textoutline(x + 160, y - 70, gml_Script_scr_bigNumber(player.myStatInfo[5][3]) + "%", textColor, 0, 20, 300);
            draw_sprite_ext(spr_statIcons, 4, x + 175, (y - 30) + 4, 1, 1, 0, c_white, 1);
            gml_Script_scr_textoutline(x + 185, (y - 50) + 4, string(player.myItemInfo[4][5]), textColor, 0, 20, 300);
            gml_Script_scr_textoutline(x + 165, (y - 30) + 5, gml_Script_scr_bigNumber(player.myStatInfo[4][3]), textColor, 0, 20, 300);
            draw_sprite_ext(spr_statIcons, 1, x + 180, y + 10 + 8, 1, 1, 0, c_white, 1);
            gml_Script_scr_textoutline(x + 190, (y - 10) + 8, string(player.myItemInfo[1][5]), textColor, 0, 20, 300);
            gml_Script_scr_textoutline(x + 170, y + 10 + 8, gml_Script_scr_bigNumber(player.myStatInfo[1][3]) + "/s", textColor, 0, 20, 300);
            draw_sprite_ext(spr_statIcons, 2, x + 175, y + 50 + 12, 1, 1, 0, c_white, 1);
            gml_Script_scr_textoutline(x + 185, y + 30 + 12, string(player.myItemInfo[2][5]), textColor, 0, 20, 300);
            gml_Script_scr_textoutline(x + 165, y + 50 + 12, string(player.myStatInfo[2][3]) + "%", textColor, 0, 20, 300);
            draw_sprite_ext(spr_statIcons, 9, x + 170, y + 90 + 16, 1, 1, 0, c_white, 1);
            gml_Script_scr_textoutline(x + 180, y + 70 + 16, string(player.myItemInfo[9][5]), textColor, 0, 20, 300);
            gml_Script_scr_textoutline(x + 160, y + 90 + 16, gml_Script_scr_bigNumber(player.myStatInfo[9][3]), textColor, 0, 20, 300);
            
            for (var _v = 0; _v < 4; _v++)
            {
                if (player.myVocationInfo[_v][0] > 8)
                {
                    draw_sprite_ext(spr_vocation_color, player.myVocationInfo[_v][0] - 1 - 7, (x - 48) + (_v * 32), y - 85, 1, 1, 0, c_white, 1);
                    draw_sprite_ext(spr_vocationIcons_t2, _v, (x - 48) + (_v * 32), y - 85, 1, 1, 0, c_white, 1);
                }
                else
                {
                    draw_sprite_ext(spr_vocation_color, player.myVocationInfo[_v][0] - 1, (x - 48) + (_v * 32), y - 85, 1, 1, 0, c_white, 1);
                    draw_sprite_ext(spr_vocationIcons, _v, (x - 48) + (_v * 32), y - 85, 1, 1, 0, c_white, 1);
                }
                
                if (player.action == (_v + 1))
                    draw_sprite_ext(spr_autoIcon, 1, (x - 48) + (_v * 32), (y - 85) + 15, 1, 1, 0, c_white, 1);
                else
                    draw_sprite_ext(spr_autoIcon, 0, (x - 48) + (_v * 32), (y - 85) + 15, 1, 1, 0, c_white, 1);
                
                if (player.myVocationInfo[_v][0] < player.maxVocationLevel)
                {
                    draw_sprite_ext(spr_blackbar, 0, (x - 48 - 15) + (_v * 32), y - 85 - 16, 30, 1, 0, c_white, 1);
                    draw_sprite_ext(spr_xpbarsmall, 0, (x - 48 - 13) + (_v * 32), y - 85 - 16, (player.myVocationInfo[_v][1] / player.myVocationInfo[_v][2]) * 26, 1, 0, c_white, 1);
                }
                else
                {
                    draw_sprite_ext(spr_energybarsmall, 0, (x - 48 - 13) + (_v * 32), y - 85 - 16, 26, 1, 0, c_white, 1);
                }
            }
            
            if (player.myPetID != 0)
            {
                draw_set_halign(fa_center);
                
                if (player.myPetID == 1)
                    c_pet = 16776960;
                
                if (player.myPetID == 2)
                    c_pet = 65280;
                
                if (player.myPetID == 3)
                    c_pet = 255;
                
                if (player.myPetID == 4)
                    c_pet = 65535;
                
                draw_sprite_ext(spr_petTemp, 0, x - 40, y - 40, 4, 4, 0, c_pet, 1);
                gml_Script_scr_textoutline(x - 40, y - 25, "(lv.  " + string(player.myPetInfo[player.myPetID][4]) + ")", 16777215, 0, 20, 10000);
            }
            
            draw_sprite_ext(spr_blackbar, 0, x - 150, y - 115, 300, 3, 0, c_white, 1);
            
            if (player.hp > 0)
                draw_sprite_ext(spr_hpbarsmall, 0, x - 148, y - 120, (player.hp / player.myStatInfo[8][3]) * 296, 1, 0, c_white, 1);
            
            if (player.xp < player.maxxp)
                draw_sprite_ext(spr_xpbarsmall, 0, x - 148, y - 115, (player.xp / player.maxxp) * 296, 1, 0, c_white, 1);
            else
                draw_sprite_ext(spr_xpbarsmall, 0, x - 148, y - 115, 296, 1, 0, c_white, 1);
            
            draw_sprite_ext(spr_energybarsmall, 0, x - 148, y - 110, (player.energy / player.maxEnergy) * 296, 1, 0, c_white, 1);
            
            for (var i = 1; i < 5; i += 1)
                draw_sprite_ext(spr_hpMeter, 0, (x - 148) + (59.2 * i), y - 115, 1, 4, 0, c_white, 1);
        }
    }
}
