if (gml_Script_live_call())
    return global.live_result;

if (room == r_underworld)
{
    draw_self();
    draw_set_font(f_mid);
    draw_set_valign(fa_middle);
    draw_set_halign(fa_center);
    draw_sprite_ext(spr_finalSoul, global.maxPortalStage - 1, x, y, 2, 2, 0, c_white, 1);
    
    if (global.maxPortalStage >= 7)
    {
        if (!instance_exists(obj_finalBoss))
            gml_Script_scr_textoutline(x, y, string((bossHP / bossMaxHP) * 100) + "%", 16777215, 0, 20, 1000);
        else
            gml_Script_scr_textoutline(x, y, string((obj_finalBoss.hp / bossMaxHP) * 100) + "%", 16777215, 0, 20, 1000);
    }
}

if (room == r_underworld_new)
{
    draw_sprite_ext(spr_black, 0, 0, 0, room_width, room_height - 300, 0, c_white, 1);
    draw_sprite_ext(spr_underworldBackground, 0, 0, 480, 1, 1, 0, c_white, 1);
    draw_sprite_ext(spr_underworld_bg2, 0, 0, 480, 1, 1, 0, c_white, 1);
    draw_sprite_ext(spr_underworldTowerBorder, 2, 125, 80, 2, 2, 0, -1, 1);
    draw_set_font(f_big);
    draw_set_halign(fa_center);
    draw_set_valign(fa_top);
    draw_sprite_ext(spr_enemySpawner, image_index, 125, 280, -0.3, 0.3, 0, c_fuchsia, 1);
    var _width = 230;
    gml_Script_scr_textgradient(125, 100, "Outpost");
    
    if (global.portalTower <= global.maxPortalTower)
    {
        draw_sprite_ext(spr_underworldTowerBorder, 2, 1295, 80, 2, 2, 0, -1, 1);
        
        if (global.portalTower == global.maxPortalTower)
            gml_Script_scr_textgradient(1294, 100, "Red Portal", undefined, undefined, undefined, 30, 200);
        
        draw_sprite_ext(spr_enemySpawner, image_index, 1294, 280, 0.3, 0.3, 0, c_red, 1);
        draw_set_font(f_mid);
        
        if (global.unlockCorrupted == true)
        {
            gml_Script_scr_textgradient(1294, 135, "Corrupted Dimension", undefined, undefined, undefined, 30, 200);
            
            if (obj_corruptedControl.alarm[0] > 0)
            {
                var _timeLeft = "";
                
                if (obj_corruptedControl.alarm[0] > (room_speed * 60 * 60))
                    _timeLeft = "(" + string(round(obj_corruptedControl.alarm[0] / room_speed / 60 / 60)) + "h)";
                else if (obj_corruptedControl.alarm[0] > (room_speed * 60))
                    _timeLeft = "(" + string(round(obj_corruptedControl.alarm[0] / room_speed / 60)) + "m)";
                else
                    _timeLeft = "(" + string(round(obj_corruptedControl.alarm[0] / room_speed)) + "s)";
                
                gml_Script_scr_textgradient(1294, 310, "Entering in " + string(_timeLeft) + "...");
            }
            
            if (global.corruptedSector > 0)
            {
                gml_Script_scr_textgradient(1294, 340, "Currently in:", undefined, undefined, undefined, undefined, 200);
                gml_Script_scr_textgradient(1294, 360, "Sector " + string(global.corruptedSector) + ":" + string(global.corruptedLevel), undefined, undefined, undefined, undefined, 200);
            }
            
            if (global.redPortalCost > 0 && global.redPortalOpen == false)
            {
                gml_Script_scr_textgradient(1294, 405, "To access the Red Portal you must complete its ritual...", undefined, undefined, undefined, undefined, 200);
                gml_Script_scr_textgradient(1294, 490, "(Sacrifice " + string(global.redPortalCost) + " more Blood Gems or defeat Hollow Finis Vitae " + string(global.redPortalCost) + " more times to complete the ritual)", undefined, undefined, undefined, undefined, 200);
            }
            else
            {
                if (obj_corruptedControl.alarm[0] == -1)
                    gml_Script_scr_textgradient(1294, 405, "Type !redportal to access the Corrupted Dimension...", undefined, undefined, undefined, undefined, 200);
                
                gml_Script_scr_textgradient(1294, 490, "You have completed the ritual!", undefined, undefined, undefined, undefined, 200);
            }
            
            for (var bg = 0; bg < 5; bg++)
            {
                var c_ritual = 0;
                
                if (bg >= global.redPortalCost || global.redPortalOpen == true)
                    c_ritual = 16777215;
                
                draw_sprite_ext(spr_underworldIcons, 1, 1214 + (bg * 40), 190, 1, 1, 0, c_ritual, 1);
            }
        }
        else
        {
            gml_Script_scr_textgradient(1294, 320, "Defeat Hollow Finis Vitae to enter the Corrupted Dimension.", undefined, undefined, undefined, 20, 200);
        }
    }
    
    draw_set_font(f_mid);
    
    if (global.towerBuilding[0][1] != 0)
        gml_Script_scr_textgradient(125, 135, "Level " + string(global.towerBuilding[0][1]), 16777215);
    else
        gml_Script_scr_textgradient(125, 135, "!build outpost", 16777215);
    
    gml_Script_scr_textgradient(125, 290, "Outpost", undefined, undefined, undefined, 20, 200);
    var _barW = _width * 0.75;
    
    if (global.towerBuilding[0][1] >= 1)
    {
        draw_sprite_ext(spr_underworldBuildings2, 0, 80, 700, 1, 1, 0, -1, 1);
        draw_sprite_ext(spr_blackbar, 0, 125 - (_barW / 2), 320, _barW, 1, 0, -1, 1);
        draw_sprite_ext(spr_whitebar_gradient, 0, 125 - (_barW / 2), 320, _barW - ((alarm[5] / room_speed / global.towerBuilding[0][5]) * _barW), 1, 0, -1, 1);
        draw_sprite_ext(spr_resourceBonus, 2, (125 + (_barW / 2)) - 10, 320, 2, 2, 0, -1, 1);
        draw_set_font(f_special);
        gml_Script_scr_textgradient(125, 325, "(+" + gml_Script_scr_bigNumber(global.towerBuilding[0][4]) + "/" + string(global.towerBuilding[0][5] / 60 / 60) + "h)", 16777215, undefined, undefined, 20, 220);
    }
    else
    {
        draw_set_font(f_mid);
        gml_Script_scr_textgradient(125, 320, "Locked (lv.1)", 4210752, undefined, undefined, 20, 220);
    }
    
    if (global.towerBuilding[0][1] >= 5)
    {
        draw_sprite_ext(spr_blackbar, 0, 125 - (_barW / 2), 360, _barW, 1, 0, -1, 1);
        draw_sprite_ext(spr_whitebar_gradient, 0, 125 - (_barW / 2), 360, _barW - ((alarm[6] / room_speed / global.towerBuilding[0][8]) * _barW), 1, 0, -1, 1);
        draw_sprite_ext(spr_xpBonus, 1, (125 + (_barW / 2)) - 10, 360, 2, 2, 0, -1, 1);
        draw_set_font(f_special);
        gml_Script_scr_textgradient(125, 365, "(+" + gml_Script_scr_bigNumber(global.towerBuilding[0][7]) + "/" + string(global.towerBuilding[0][8] / 60 / 60) + "h)", 16777215, undefined, undefined, 20, 220);
    }
    else
    {
        draw_set_font(f_mid);
        gml_Script_scr_textgradient(125, 360, "Locked (lv.5)", 4210752, undefined, undefined, 20, 220);
    }
    
    if (global.towerBuilding[0][1] >= 10)
    {
        draw_sprite_ext(spr_blackbar, 0, 125 - (_barW / 2), 400, _barW, 1, 0, -1, 1);
        draw_sprite_ext(spr_whitebar_gradient, 0, 125 - (_barW / 2), 400, _barW - ((alarm[7] / room_speed / global.towerBuilding[0][11]) * _barW), 1, 0, -1, 1);
        draw_sprite_ext(spr_talentscrollIcon, 1, (125 + (_barW / 2)) - 10, 400, 1, 1, 0, -1, 1);
        draw_set_font(f_special);
        gml_Script_scr_textgradient(125, 405, "(+" + gml_Script_scr_bigNumber(global.towerBuilding[0][10]) + "/" + string(global.towerBuilding[0][11] / 60 / 60) + "h)", 16777215, undefined, undefined, 20, 220);
    }
    else
    {
        draw_set_font(f_mid);
        gml_Script_scr_textgradient(125, 400, "Locked (lv.10)", 4210752, undefined, undefined, 20, 220);
    }
    
    if (global.towerBuilding[0][1] >= 15)
    {
        draw_sprite_ext(spr_blackbar, 0, 125 - (_barW / 2), 440, _barW, 1, 0, -1, 1);
        draw_sprite_ext(spr_whitebar_gradient, 0, 125 - (_barW / 2), 440, _barW - ((alarm[8] / room_speed / global.towerBuilding[0][14]) * _barW), 1, 0, -1, 1);
        draw_sprite_ext(spr_underworldIcons, 2, (125 + (_barW / 2)) - 10, 440, 1, 1, 0, -1, 1);
        draw_set_font(f_special);
        gml_Script_scr_textgradient(125, 445, "(+" + gml_Script_scr_bigNumber(global.towerBuilding[0][13]) + "/" + string(global.towerBuilding[0][14] / 60 / 60) + "h)", 16777215, undefined, undefined, 20, 220);
    }
    else
    {
        draw_set_font(f_mid);
        gml_Script_scr_textgradient(125, 440, "Locked (lv.15)", 4210752, undefined, undefined, 20, 220);
    }
    
    if (global.towerBuilding[0][1] > 0)
    {
        draw_set_font(f_mid);
        gml_Script_scr_textgradient(125, 490, "!upg outpost", 16777215, undefined, undefined, 20, 220);
        var _upgCost1 = global.towerBuilding[0][2];
        var _upgCost2 = 0;
        var c_cost1 = 16777215;
        var c_cost2 = 16777215;
        
        if (global.towerBuilding[0][3] > 0)
            _upgCost2 = global.towerBuilding[0][3];
        
        var _upgCost1text = gml_Script_scr_bigNumber(_upgCost1);
        var _upgCost2text;
        
        if (_upgCost2 > 0)
            _upgCost2text = string(_upgCost2);
        
        if (global.souls < _upgCost1)
            c_cost1 = 255;
        
        if (global.bloodgems < _upgCost2)
            c_cost2 = 255;
        
        gml_Script_scr_textshadow(125, 520, string(_upgCost1text), c_cost1, undefined, 20, 220);
        draw_sprite_ext(spr_underworldIcons, 0, 125 + (string_width(_upgCost1text) / 2) + 20, 530, 1, 1, 0, -1, 1);
        
        if (_upgCost2 > 0)
        {
            gml_Script_scr_textshadow(125, 550, string(_upgCost2text), c_cost2, undefined, 20, 220);
            draw_sprite_ext(spr_underworldIcons, 1, 125 + (string_width(_upgCost2text) / 2) + 20, 560, 1, 1, 0, -1, 1);
        }
    }
    else
    {
        draw_set_font(f_mid);
        var c_cost = 16777215;
        var _upgCost1 = 50000000;
        
        if (global.gold < _upgCost1)
            c_cost = 255;
        
        gml_Script_scr_textgradient(125, 490, "Cost:", 16777215, undefined, undefined, 20, 220);
        gml_Script_scr_textshadow(125, 515, gml_Script_scr_bigNumber(_upgCost1), c_cost, undefined, undefined, 20, 220);
        draw_sprite_ext(spr_resourceBonus, 2, 125 + (string_width(gml_Script_scr_bigNumber(_upgCost1)) / 2) + 20, 527, 2, 2, 0, -1, 1);
    }
    
    for (var i = 1; i < global.maxPortalTower; i++)
    {
        var _color = 4210752;
        
        if (global.portalTower > i)
            _color = 16777215;
        
        if (i >= global.portalTower)
            draw_sprite_ext(spr_underworldTowerBorder, 0, 136 + (i * _width), 80, 2, 2, 0, -1, 1);
        
        if (i < global.portalTower)
            draw_sprite_ext(spr_underworldTowerBorder, 1, 136 + (i * _width), 80, 2, 2, 0, -1, 1);
        
        draw_set_font(f_big);
        gml_Script_scr_textgradient(136 + (i * _width), 100, "Tower " + string(i), 16777215);
        draw_set_font(f_mid);
        
        if (i == global.portalTower)
            shader_set(sh_grayscale);
        
        if (i < (global.maxPortalTower - 1))
            draw_sprite_ext(spr_djinns, global.djinnOrder[i - 1], 136 + (i * _width), 260, 2, 2, 0, _color, 1);
        
        if (i == global.portalTower)
            shader_reset();
        
        if (i < global.portalTower)
        {
            if (global.towerBuilding[i][4] > 0)
                gml_Script_scr_textgradient(136 + (i * _width), 135, "Level " + string(global.towerBuilding[i][4]), _color);
            else
                gml_Script_scr_textgradient(136 + (i * _width), 135, "!build tower" + string(i), _color);
            
            var _textSep = 0;
            
            if (i < 4)
            {
                gml_Script_scr_textgradient(136 + (i * _width), 180, global.djinnInfo[global.djinnOrder[i - 1]][1] + " (lv. 1)", 16777215);
                gml_Script_scr_textgradient(136 + (i * _width), 280, "(liberated)", 65280, 32768, undefined, 20, 200);
                var _djinnEffect = string_replace(global.djinnInfo[global.djinnOrder[i - 1]][3], "*", string(global.djinnInfo[global.djinnOrder[i - 1]][2]));
                gml_Script_scr_textgradient(136 + (i * _width), 310, "Granting:", 16777215, undefined, undefined, 20, 220);
                gml_Script_scr_textgradient(136 + (i * _width), 340, _djinnEffect, 16777215, undefined, undefined, 20, 220);
                _textSep += string_height_ext(_djinnEffect, 20, 220);
            }
            else if (global.onlyFinis == 1)
            {
                draw_sprite_ext(spr_finis_icon, 0, 136 + (i * _width), 240, 4, 4, 0, _color, 1);
                gml_Script_scr_textgradient(136 + (i * _width), 180, "Finis Vitae", 16777215);
                
                if (global.finisKills > 0)
                    gml_Script_scr_textgradient(136 + (i * _width), 280, "(defeated)", 65280, 32768, undefined, 20, 200);
                
                gml_Script_scr_textgradient(136 + (i * _width), 310, "The Ancient Guardian", 16777215, undefined, undefined, 20, 220);
                gml_Script_scr_textgradient(136 + (i * _width), 340, "Defeating it seems impossible...", 16777215, undefined, undefined, 20, 200);
            }
            
            var _upgCost1 = global.towerBuilding[i][5];
            var _upgCost2 = 0;
            var c_cost1 = 16777215;
            var c_cost2 = 16777215;
            
            if (global.towerBuilding[i][4] > 0)
            {
                gml_Script_scr_textgradient(136 + (i * _width), 410, global.towerBuilding[i][0], 16777215, undefined, undefined, 20, 220);
                
                if (global.towerBuilding[i][6] > 0)
                    _upgCost2 = global.towerBuilding[i][6];
                
                var _upgCost1text = gml_Script_scr_bigNumber(_upgCost1);
                var _upgCost2text;
                
                if (_upgCost2 > 0)
                    _upgCost2text = gml_Script_scr_bigNumber(_upgCost2);
                
                if (global.souls < _upgCost1)
                    c_cost1 = 255;
                
                if (global.bloodgems < _upgCost2)
                    c_cost2 = 255;
                
                gml_Script_scr_textgradient(136 + (i * _width), 490, "!upg tower " + string(i), 16777215, undefined, undefined, 20, 220);
                gml_Script_scr_textshadow(136 + (i * _width), 520, string(_upgCost1text), c_cost1, undefined, 20, 220);
                draw_sprite_ext(spr_underworldIcons, 0, 136 + (i * _width) + (string_width(_upgCost1text) / 2) + 20, 530, 1, 1, 0, -1, 1);
                
                if (_upgCost2 > 0)
                {
                    gml_Script_scr_textshadow(136 + (i * _width), 550, string(_upgCost2text), c_cost2, undefined, 20, 220);
                    draw_sprite_ext(spr_underworldIcons, 1, 136 + (i * _width) + (string_width(_upgCost2text) / 2) + 20, 560, 1, 1, 0, -1, 1);
                }
                
                _barW = _width * 0.75;
                draw_sprite_ext(spr_blackbar, 0, (136 + (i * _width)) - (_barW / 2), 440, _barW, 1, 0, -1, 1);
                draw_sprite_ext(spr_whitebar_gradient, 0, (136 + (i * _width)) - (_barW / 2), 440, _barW - ((alarm[i] / room_speed / global.towerBuilding[i][2]) * _barW), 1, 0, -1, 1);
                draw_set_font(f_special);
                gml_Script_scr_textgradient(136 + (i * _width), 450, "(+" + string(global.towerBuilding[i][1]) + "/" + string(global.towerBuilding[i][2] / 60 / 60) + "h)", 16777215, undefined, undefined, 20, 220);
            }
            else
            {
                draw_set_font(f_mid);
                gml_Script_scr_textgradient(136 + (i * _width), 410, "Can Build:", 16777215, undefined, undefined, 20, 220);
                gml_Script_scr_textgradient(136 + (i * _width), 440, global.towerBuilding[i][0], 16777215, undefined, undefined, 20, 220);
                var c_cost = 16777215;
                _upgCost1 = 100000000 * (i * 10);
                
                if (global.gold < _upgCost1)
                    c_cost = 255;
                
                gml_Script_scr_textgradient(136 + (i * _width), 490, "Cost:", 16777215, undefined, undefined, 20, 220);
                gml_Script_scr_textshadow(136 + (i * _width), 515, gml_Script_scr_bigNumber(_upgCost1), c_cost, undefined, undefined, 20, 220);
                draw_sprite_ext(spr_resourceBonus, 2, 136 + (i * _width) + (string_width(gml_Script_scr_bigNumber(_upgCost1)) / 2) + 20, 527, 2, 2, 0, -1, 1);
            }
        }
        else
        {
            draw_set_font(f_mid);
            gml_Script_scr_textgradient(136 + (i * _width), 280, "Locked", _color, undefined, undefined, undefined, 180);
            gml_Script_scr_textgradient(136 + (i * _width), 310, "Reach the final floor and defeat the Guardian to unlock", _color, undefined, undefined, undefined, 180);
            gml_Script_scr_textgradient(136 + (i * _width), 135, "(Floor " + string(global.portalFloor) + "/" + string(global.maxPortalFloor) + ")", 16777215);
        }
    }
    
    var _portalX = 0;
    var _portalY = 0;
    
    if (global.portalTower == 1)
    {
        _portalX = 45;
        _portalY = 205;
    }
    
    if (global.portalTower == 2)
    {
        _portalX = 400;
        _portalY = 230;
    }
    
    if (global.portalTower == 3)
    {
        _portalX = 560;
        _portalY = 210;
    }
    
    if (global.portalTower == 4)
    {
        _portalX = 780;
        _portalY = 220;
    }
    
    if (global.portalTower == 5)
    {
        _portalX = 1135;
        _portalY = 250;
    }
    
    draw_sprite_ext(spr_underworldBuildings2, 1, 0 + _portalX, 480 + _portalY, 1, 1, 0, -1, 1);
    
    if (surface_exists(global.underworldFog))
    {
        if (global.portalTower < global.maxPortalTower)
        {
            gml_Script_draw_set_blend_mode(bm_subtract);
            draw_surface(global.underworldFog, 232 * (global.portalTower - 1), 0);
            gml_Script_draw_set_blend_mode(bm_normal);
            surface_set_target(global.underworldFog);
            draw_set_color(c_white);
            draw_rectangle(0, 0, 1420, 800, 0);
            gml_Script_draw_set_blend_mode(bm_subtract);
            draw_rectangle_colour(0, 0, 582, 1200, c_white, c_black, c_black, c_white, 0);
            gml_Script_draw_set_blend_mode(bm_normal);
            surface_reset_target();
        }
    }
}
