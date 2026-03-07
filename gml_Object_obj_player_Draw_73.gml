if (gml_Script_live_call())
    return global.live_result;

if (afkdraw == true)
    exit;

if (afk == true)
{
    draw_sprite(spr_afk, afkicon, x + 10 + (length / 2), (y + 10) - height - 23);
    afkicon += 0.05;
    
    if (afkicon < 1 || afkicon > 3)
        afkicon -= 0.025;
    
    if (afkicon >= 4)
        afkicon = 0;
}

if (instance_exists(obj_quest))
{
    if (reputationCompleted == false)
    {
        draw_sprite_ext(spr_blackbar, 0, x - (length / 2), y - height - 6, length, 1, 0, c_white, 1);
    }
    else
    {
        draw_sprite_ext(spr_whitebar, 0, x - (length / 2), y - height - 6, length, 1, 0, c_white, 1);
        draw_sprite_ext(spr_blackbar, 0, x - (length / 2), y - height - 6, length, 0.7, 0, c_white, 1);
    }
    
    if (reputation < questReputation)
        draw_sprite_ext(spr_bluebarsmall, 0, (x - (length / 2)) + 1, y - height - 6, (reputation / questReputation) * (length - 2), 1, 0, c_white, 1);
    else
        draw_sprite_ext(spr_bluebarsmall, 0, (x - (length / 2)) + 1, y - height - 6, length - 2, 1, 0, c_white, 1);
}

for (var _v = 0; _v < 4; _v++)
{
    if (action == (_v + 1))
    {
        if (myVocationInfo[_v][0] > 8)
        {
            draw_sprite_ext(spr_vocation_color_small, myVocationInfo[_v][0] - 1 - 7, x + 10 + (length / 2), (y + 10) - height - 23, 1, 1, 0, c_white, 1);
            draw_sprite_ext(spr_vocationIcons_small_t2, _v, x + 10 + (length / 2), (y + 10) - height - 23, 1, 1, 0, c_white, 1);
        }
        else
        {
            draw_sprite_ext(spr_vocation_color_small, myVocationInfo[_v][0] - 1, x + 10 + (length / 2), (y + 10) - height - 23, 1, 1, 0, c_white, 1);
            draw_sprite_ext(spr_vocationIcons_small, _v, x + 10 + (length / 2), (y + 10) - height - 23, 1, 1, 0, c_white, 1);
        }
        
        draw_sprite_ext(spr_blackbar, 0, x + (length / 2), y - height - 22 - 4, 20, 1, 0, c_white, 1);
        
        if (myVocationInfo[_v][0] < maxVocationLevel)
            draw_sprite_ext(spr_xpbarsmall, 0, x + (length / 2) + 1, y - height - 22 - 4, (myVocationInfo[_v][1] / myVocationInfo[_v][2]) * 18, 1, 0, c_white, 1);
        else
            draw_sprite_ext(spr_energybarsmall, 0, x + (length / 2) + 1, y - height - 22 - 4, 18, 1, 0, c_white, 1);
    }
}

draw_sprite_ext(spr_blackbar, 0, x - (length / 2), y - height - 16, length, 2.4, 0, c_white, 1);

if (hp < myStatInfo[8][3])
    draw_sprite_ext(spr_hpbarsmall, 0, (x - (length / 2)) + 1, y - height - 20, (hp / myStatInfo[8][3]) * (length - 2), 1, 0, c_white, 1);
else
    draw_sprite_ext(spr_hpbarsmall, 0, (x - (length / 2)) + 1, y - height - 20, length - 2, 1, 0, c_white, 1);

if (xp < maxxp)
    draw_sprite_ext(spr_xpbarsmall, 0, (x - (length / 2)) + 1, y - height - 16, (xp / maxxp) * (length - 2), 1, 0, c_white, 1);
else
    draw_sprite_ext(spr_xpbarsmall, 0, (x - (length / 2)) + 1, y - height - 16, length - 2, 1, 0, c_white, 1);

draw_sprite_ext(spr_energybarsmall, 0, (x - (length / 2)) + 1, y - height - 12, (energy / maxEnergy) * (length - 2), 1, 0, c_white, 1);
draw_set_font(f_special);

if (global.channelName == "situ")
    draw_set_font(global.f_asian);

draw_set_halign(fa_center);
draw_set_valign(fa_top);

if (sub == 1)
{
    gml_Script_scr_textoutline(x - 8, y, string(displayName), 16777215, 0, 0, 600);
    draw_sprite_ext(spr_subStar, 1, x + (string_width(displayName) / 2) + 5, y + 10, 1, 1, 0, c_white, 1);
}
else
{
    gml_Script_scr_textoutline(x, y, string(displayName), 16777215, 0, 0, 600);
}

if (ascensionLevel > 0 && ascended == false)
{
    draw_sprite_ext(spr_specialPoint, 1, x - 24, y - 52, 0.75, 0.75, 0, c_white, 1);
    gml_Script_scr_textgradient(x - 24, y - 63, string(ascensionLevel), 16777215, 4235519, 0, 600);
}

draw_set_halign(fa_right);
draw_sprite_ext(spr_black, 0, x - (length / 2), y - height - 23, -string_width(gml_Script_scr_bigNumber(level)) - 2, 20, 0, c_white, 0.6);
gml_Script_scr_textoutline(x - (length / 2) - 1, y - height - 24, gml_Script_scr_bigNumber(level), 16777215, 0, 0, 600);
draw_set_font(f_special);
var totalBuffs = 0;

for (var i = 0; i < 6; i++)
{
    if (gml_Script_scr_alarm_get(i) > 0)
        totalBuffs += 1;
}

var _alpha = 1;

if (afksemi == 1)
    _alpha = 0.5;

var buffW = 28;
var buffX = totalBuffs * buffW;
var buffH = sprite_get_height(spr_tempBonuses) / 2;
draw_set_halign(fa_center);
var ii = 0;
var _y = 30;

for (var i = 0; i < 6; i++)
{
    if (gml_Script_scr_alarm_get(i) > 0)
    {
        draw_sprite_ext(spr_tempBonuses, i, (x - (buffX / 2)) + (ii * buffW) + 16, y + _y, 1, 1, 0, c_white, _alpha);
        draw_sprite_ext(spr_statArrow, 0, (x - (buffX / 2)) + (ii * buffW) + 16 + 10, y + _y, 1, 1, 0, c_white, _alpha);
        var _color = 16777215;
        
        if (gml_Script_scr_alarm_get(i) > (3600 * room_speed * 48))
            _color = 65280;
        
        if (gml_Script_scr_alarm_get(i) < (3600 * room_speed))
            _color = 4235519;
        
        gml_Script_scr_textgradient((x - (buffX / 2)) + (ii * buffW) + 16, y + _y + 5, string(clamp(ceil(gml_Script_scr_alarm_get(i) / room_speed / 60 / 60), 1, 48)) + "h", _color, undefined, undefined, 20, 1000, undefined, undefined, _alpha);
        ii += 1;
    }
}
