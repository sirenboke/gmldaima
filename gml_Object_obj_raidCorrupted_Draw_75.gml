if (global.stageType == "Corrupted Dimension")
{
    draw_set_valign(fa_middle);
    draw_sprite(spr_HUDtop, 0, 0, room_height - 340);
    
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
        
        if (!instance_exists(obj_raidCorruptedResults))
        {
            draw_sprite_ext(spr_blackbar, 0, ((room_width / 2) + 300) - 203, room_height - 251, 406, 3, 0, c_white, 1);
            
            if (global.portalTimer < global.portalTimerMax)
            {
                global.portalTimer += ((1 / room_speed) * global.challenge_bloodRain);
                draw_sprite_ext(spr_manabarsmall, 0, ((room_width / 2) + 300) - 199, room_height - 246, (global.portalTimer / global.portalTimerMax) * 398, 1, 0, c_white, 1);
            }
            else
            {
                draw_sprite_ext(spr_enemyhpbarsmall, 0, ((room_width / 2) + 300) - 199, room_height - 246, 398, 1, 0, c_white, 1);
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
    }
    
    global.warriorBonusAmount = power(1 + (global.warriorBonus / 20), 1.5) - 1;
    global.rogueBonusAmount = power(1 + (global.rogueBonus / 8), 1.5) - 1;
    global.rangerBonusAmount = power(global.rangerBonus, 1.5) / 7;
    global.wizardBonusAmount = power(1 + (global.wizardBonus / 10), 1.5) - 1;
    draw_set_halign(fa_left);
    draw_set_valign(fa_middle);
    draw_set_font(f_mid);
    draw_sprite_ext(spr_black, 0, 20, room_height - 300, 30 + string_width(string_hash_to_newline("+" + string(global.warriorBonusAmount) + "     | " + "+" + string(global.rogueBonusAmount) + "     | " + "+" + string(global.rangerBonusAmount) + "%     | " + "+" + string(global.wizardBonusAmount))), 20, 0, c_white, 0.8);
    gml_Script_scr_textoutline(20, room_height - 315, "Party Bonuses (" + string(global.raiders) + " Raiders [Ranged: " + string(ds_list_size(global.raidList1)) + " | Melee: " + string(ds_list_size(global.raidList0)) + "]):", 16777215, 0, 20, 1000);
    gml_Script_scr_textoutline(25, room_height - 290, "+" + string(global.warriorBonusAmount) + "     | " + "+" + string(global.rogueBonusAmount) + "     | " + "+" + string(global.rangerBonusAmount) + "%     | " + "+" + string(global.wizardBonusAmount), 16777215, 0, 20, 1000);
    draw_sprite_ext(spr_statusIcons, 6, 35 + string_width(string_hash_to_newline("+" + string(global.warriorBonusAmount))), room_height - 290, 1, 1, 0, c_white, 1);
    draw_sprite_ext(spr_statusIcons, 0, 35 + string_width(string_hash_to_newline("+" + string(global.warriorBonusAmount) + "     | " + "+" + string(global.rogueBonusAmount))), room_height - 290, 1, 1, 0, c_white, 1);
    draw_sprite_ext(spr_statusIcons, 3, 35 + string_width(string_hash_to_newline("+" + string(global.warriorBonusAmount) + "     | " + "+" + string(global.rogueBonusAmount) + "     | " + "+" + string(global.rangerBonusAmount) + "%")), room_height - 290, 1, 1, 0, c_white, 1);
    draw_sprite_ext(spr_statusIcons, 9, 35 + string_width(string_hash_to_newline("+" + string(global.warriorBonusAmount) + "     | " + "+" + string(global.rogueBonusAmount) + "     | " + "+" + string(global.rangerBonusAmount) + "%     | " + "+" + string(global.wizardBonusAmount))), room_height - 290, 1, 1, 0, c_white, 1);
    
    if (global.raiding == true && alarm[1] == -1)
    {
        draw_set_font(f_midbig);
        draw_set_halign(fa_center);
        gml_Script_scr_textshadow((room_width / 2) + 300, room_height - 270 - 45, "Sector " + string(global.corruptedSector) + ":" + string(global.corruptedLevel), 16777215, 0, 34, 1620);
        gml_Script_scr_textshadow((room_width / 2) + 300, room_height - 290, "Blood Rain Timer:", 16777215, 0, 34, 1620);
    }
}
