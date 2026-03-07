draw_sprite_part(spr_statsBanner, 0, 0, 0, 212, extend, 20, room_height - 270);
draw_sprite_part(spr_statsBanner, 1, 0, 0, 212, extend, 242, room_height - 270);

if (extend < maxExtend && alarm[0] != -1)
    extend += 4;

if (extend >= maxExtend)
{
    extend = maxExtend;
    draw_set_valign(fa_top);
    draw_set_halign(fa_left);
    draw_set_font(f_mid);
    draw_set_halign(fa_center);
    gml_Script_scr_textoutline(20 + (sprite_width / 2), room_height - 265, "Damage Dealt:", 16777215, 0, 20, 500);
    gml_Script_scr_textoutline(20 + (sprite_width / 2) + 222, room_height - 265, "Damage Received:", 16777215, 0, 20, 500);
    draw_set_font(f_special_old);
    gml_Script_scr_textoutline(20 + (sprite_width / 2), room_height - 245, "Total: " + gml_Script_scr_bigNumber(totalCombatDamageDealt), 16777215, 0, 20, 500);
    gml_Script_scr_textoutline(242 + (sprite_width / 2), room_height - 245, "Total: " + gml_Script_scr_bigNumber(totalCombatDamageMitigated), 16777215, 0, 20, 500);
    draw_set_halign(fa_left);
    
    for (var cg = 0; cg < 3; cg += 1)
    {
        draw_set_halign(fa_left);
        
        if (ds_grid_get(damageDealtGrid, 1, cg) > 0)
        {
            var _displayName = string(ds_grid_get(damageDealtGrid, 0, cg));
            
            if (string_pos("ascended ", _displayName) == 1)
            {
                var _oldName = string_delete(_displayName, 1, 9);
                _displayName = "# " + string_delete(_oldName, 16, 100) + "...";
            }
            
            gml_Script_scr_textoutline(45, (room_height - 220) + (40 * cg), string(cg + 1) + ". " + string(_displayName) + " (" + string(floor((ds_grid_get(damageDealtGrid, 1, cg) / totalCombatDamageDealt) * 100)) + "%)", 16777215, 0, 20, 1000);
            _length = 0;
            
            for (var i = 0; i <= global.damageTypes; i++)
            {
                if (ds_grid_get(damageDealtGrid, i + 2, cg) > 0)
                {
                    draw_sprite_ext(spr_whitebar_gradient, 0, 45 + _length, (room_height - 188) + (40 * cg), floor((ds_grid_get(damageDealtGrid, i + 2, cg) / totalCombatDamageDealt) * 162), 2, 0, c_dmgType[i + 1], 1);
                    _length += floor((ds_grid_get(damageDealtGrid, i + 2, cg) / totalCombatDamageDealt) * 162);
                }
            }
            
            gml_Script_scr_textoutline(45, (room_height - 200) + (40 * cg), string(gml_Script_scr_bigNumber(ds_grid_get(damageDealtGrid, 1, cg))), 16777215, 0, 20, 600);
        }
        
        draw_set_halign(fa_left);
        
        if (ds_grid_get(damageMitigatedGrid, 1, cg) > 0)
        {
            var _displayName = string(ds_grid_get(damageMitigatedGrid, 0, cg));
            
            if (string_pos("ascended ", _displayName) == 1)
            {
                var _oldName = string_delete(_displayName, 1, 9);
                _displayName = "# " + string_delete(_oldName, 16, 100) + "...";
            }
            
            gml_Script_scr_textoutline(267, (room_height - 220) + (40 * cg), string(cg + 1) + ". " + string(_displayName) + " (" + string(floor((ds_grid_get(damageMitigatedGrid, 1, cg) / totalCombatDamageMitigated) * 100)) + "%)", 16777215, 0, 20, 1000);
            _length = 0;
            
            for (var i = 0; i <= global.damageTypes; i++)
            {
                if (ds_grid_get(damageMitigatedGrid, i + 2, cg) > 0)
                {
                    draw_sprite_ext(spr_whitebar_gradient, 0, 267 + _length, (room_height - 188) + (40 * cg), floor((ds_grid_get(damageMitigatedGrid, i + 2, cg) / totalCombatDamageMitigated) * 162), 2, 0, c_dmgType[i + 1], 1);
                    _length += floor((ds_grid_get(damageMitigatedGrid, i + 2, cg) / totalCombatDamageMitigated) * 162);
                }
            }
            
            gml_Script_scr_textoutline(267, (room_height - 200) + (40 * cg), string(gml_Script_scr_bigNumber(ds_grid_get(damageMitigatedGrid, 1, cg))), 16777215, 0, 20, 600);
        }
    }
}

if (alarm[0] == -1)
{
    extend -= 4;
    
    if (extend <= 0)
    {
        gml_Script_scr_ds_grid_destroy(damageDealtGrid);
        gml_Script_scr_ds_grid_destroy(damageMitigatedGrid);
        ds_grid_clear(global.combatStats1, 0);
        ds_grid_clear(global.combatStats2, 0);
        
        with (obj_player)
        {
            for (var i = 0; i <= global.damageTypes; i++)
            {
                combatDamageDealt[i] = 0;
                combatDamageReceived[i] = 0;
                combatDamageMitigated[i] = 0;
            }
            
            myDamageDealt = 0;
            myDamageMitigated = 0;
            tempNumber = 0;
        }
        
        instance_destroy();
    }
}
