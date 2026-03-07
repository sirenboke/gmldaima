var lastPos = room_width * 5;
var _lastPlayer = player;

if (instance_exists(obj_enemy))
{
    for (var i = 0; i < instance_number(obj_enemy); i++)
    {
        if (instance_find(obj_enemy, i).x < lastPos)
        {
            lastPos = instance_find(obj_enemy, i).x;
            player = instance_find(obj_enemy, i);
        }
    }
}
else
{
    player = -1;
}

if (player != _lastPlayer)
{
    alarm[0] = room_speed * 5;
    show = 0;
}

with (obj_enemy)
{
    draw_set_valign(fa_middle);
    var totalStatus = 0;
    
    if (poisonStacks > 0)
    {
        totalStatus += 1;
        status[0][0] = poisonStacks;
        status[0][1] = string(status[0][0]) + "x";
        poisonTimer -= 1;
        status[0][2] = poisonTimer;
        status[0][3] = max(poisonTimerMax, poisonTimer);
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
        status[2][3] = max(burnTimerMax, burnTimer);
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
        status[3][3] = max(freezeTimerMax, freezeTimer);
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
}

if (player != -1)
{
    with (player)
    {
        if (alarm[0] == -1 && global.raiding == true && !instance_exists(obj_raidResults))
        {
            xx = room_width - 120;
            yy = room_height - 100;
            
            if (round(displayHP) != round(hp))
            {
                var diff = hp - displayHP;
                displayHP += (diff / 10);
            }
            
            gml_Script_scr_statColors();
            draw_sprite(spr_raidCard3, 0, xx, yy - 22);
            draw_sprite_ext(spr_blackbar, 0, xx - 81, yy - 122, 162, 0.5, 0, c_white, 0.5);
            draw_sprite_ext(spr_manabarsmall, 0, xx - 80, yy - 122, (other.alarm[0] / (room_speed * 5)) * 160, 0.5, 0, c_ltgray, 0.5);
            draw_sprite_ext(spr_enemy_icons, icon, xx, yy - 95, 2, 2, 0, c_white, 1);
            draw_set_halign(fa_center);
            draw_sprite_ext(spr_blackbar2, 0, xx - 67, yy - 95 - 20, 1, 40, 0, c_white, 1);
            
            if (alarm[2] > 1 || buffed > 0)
                draw_sprite_ext(spr_enemyUlt, skill, xx - 45, yy - 95, 1, 1, 0, c_white, 1);
            else
                draw_sprite_ext(spr_enemyUlt, skill, xx - 45, yy - 95, 1, 1, 0, c_gray, 1);
            
            draw_sprite_ext(spr_manabarsmall2, 0, xx - 67, (yy - 95) + 18, 1, -((mana / maxmana) * 36), 0, c_white, 1);
            draw_set_font(f_mid);
            
            if (alarm[2] > 1)
                draw_sprite_ext(spr_energybarsmall2, 0, xx - 67, (yy - 95) + 18, 1, -(alarm[2] / room_speed / skillTimer) * 36, 0, c_white, 1);
            
            if (buffed > 0)
                draw_sprite_ext(spr_energybarsmall2, 0, xx - 67, (yy - 95) + 18, 1, -((buffed / skillBuff) * 36), 0, c_white, 1);
            
            if (castingAbility == true)
                draw_sprite_ext(spr_energybarsmall2, 0, xx - 67, (yy - 95) + 18, 1, -36 + ((gml_Script_scr_alarm_get(0) / abilityCastTime) * 36), 0, c_lime, 1);
            
            if (player.myRelicSlots == 1)
            {
                draw_sprite_ext(spr_uniqueItem, player.uniqueSlot[1], xx + 45, yy - 95, 1, 1, 0, c_white, 1);
                
                if (player.uniqueSlot[1] > 0)
                    gml_Script_scr_textoutline(xx + 45, yy - 80, "lv." + string(uniqueItemLevel[player.uniqueSlot[1]]), 16777215, 0, 20, 100);
            }
            else if (player.myRelicSlots > 1)
            {
                if (global.showRelic <= player.myRelicSlots)
                {
                    draw_sprite_ext(spr_uniqueItem, player.uniqueSlot[global.showRelic], xx + 45, yy - 95, 1, 1, 0, c_white, 1);
                    
                    if (player.uniqueSlot[global.showRelic] > 0)
                        gml_Script_scr_textoutline(xx + 45, yy - 80, "lv." + string(uniqueItemLevel[player.uniqueSlot[global.showRelic]]), 16777215, 0, 20, 100);
                }
                else
                {
                    draw_sprite_ext(spr_uniqueItem, player.uniqueSlot[1], xx + 45, yy - 95, 1, 1, 0, c_white, 1);
                    
                    if (player.uniqueSlot[1] > 0)
                        gml_Script_scr_textoutline(xx + 45, yy - 80, "lv." + string(uniqueItemLevel[player.uniqueSlot[1]]), 16777215, 0, 20, 100);
                }
            }
            
            draw_set_font(f_mid);
            draw_set_halign(fa_center);
            
            if (type != "final")
                gml_Script_scr_textoutline(xx, yy - 145, string(name) + " (lv." + gml_Script_scr_bigNumber(level) + ")", 16777215, 0, 20, 500);
            
            if (type == "final")
                gml_Script_scr_textoutline(xx, yy - 145, string(name), 16777215, 0, 20, 500);
            
            if (tier > 1)
                draw_sprite(spr_enemyTier, tier - 2, xx, yy - 110);
            
            draw_sprite_ext(spr_blackbar, 0, xx - 81, yy + 82, 163, 5, 0, c_white, 1);
            
            if (round(displayHP) != round(hp))
            {
                var diff = hp - displayHP;
                displayHP += (diff / 10);
            }
            
            draw_sprite_ext(spr_hpbar, 0, (xx - 81) + 2, yy + 82, clamp((displayHP / myStatInfo[8][3]) * 159, 0, 159), 2, 0, c_white, 1);
            
            if (hp > displayHP)
                draw_sprite_ext(spr_hpbar, 0, (xx - 81) + 2 + ((displayHP / myStatInfo[8][3]) * 159), yy + 82, clamp(((hp - displayHP) / myStatInfo[8][3]) * 159, 0, 159), 2, 0, c_gray, 1);
            else
                draw_sprite_ext(spr_redbar, 0, (xx - 81) + 2 + ((displayHP / myStatInfo[8][3]) * 159), yy + 82, clamp(((hp - displayHP) / myStatInfo[8][3]) * 159, 0, 159), 2, 0, c_ltgray, 1);
            
            if (shield > 0)
            {
                if (((shield / myStatInfo[8][3]) * 163) > 159)
                    draw_sprite_ext(spr_shieldbar, 0, ((xx - 81) + 163) - 2, yy + 82, -159, 2, 0, c_white, 1);
                else if (shield < myStatInfo[8][3])
                    draw_sprite_ext(spr_shieldbar, 0, ((xx - 81) + 163) - 2, yy + 82, clamp(((-shield / myStatInfo[8][3]) * 163) + 4, -159, 0), 2, 0, c_white, 1);
            }
            
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
            
            if (other.show == 0)
            {
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
                    
                    if (other.alarm[0] < -1)
                    {
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
                    draw_sprite_ext(spr_manabarsmall2, 0, (xx - 40) + (i * 45), (yy + 15) - 87, 6, 50, 0, _color[i], 1);
                    gml_Script_scr_textoutline((xx - 40) + (i * 45), (yy + 15) - 70, string(_myResistance[0][i]), c_dmgReduction[i], 0, 20, 300);
                    gml_Script_scr_textoutline((xx - 40) + (i * 45), (yy + 15) - 50, string(_myDamage[i]), c_dmgBuff[i], 0, 20, 300);
                }
                
                for (var i = 0; i < 2; i++)
                    gml_Script_scr_textoutline(xx + 30 + (i * 60), yy + 15 + 5, string(_myResistance[1][i]), c_ccReduction[i], 0, 20, 300);
                
                for (var i = 0; i < 2; i++)
                    gml_Script_scr_textoutline(xx + 30 + (i * 60), yy + 15 + 35, string(_myResistance[2][i]), c_debuffReduction[i], 0, 20, 300);
            }
        }
    }
}
