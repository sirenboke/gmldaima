draw_sprite_ext(spr_building, 0, x, y - 150, 7, 3, 0, c_white, 1);
draw_set_font(f_mid);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

if (costText != "Maximum Level")
    gml_Script_scr_textoutline(x, y - 160, string_lower(msg[global.buildingMsgDisplay]), 16777215, 0, 20, 500);
else
    gml_Script_scr_textoutline(x, y - 160, string_lower(msg[2]), 16777215, 0, 20, 500);

var _x = 0;

if (cost2 > 0)
    _x = 30 + (string_width(costText + gml_Script_scr_bigNumber(cost2)) / 2);

if (costText != "Maximum Level")
{
    gml_Script_scr_textoutline(x - (_x / 2), y - 140, costText, c_cost, 0, 20, 500);
    draw_sprite_ext(spr_resourceBonus, 2, (x - (_x / 2)) + ((string_width(costText) / 2) + 10), y - 140, 1, 1, 0, -1, 1);
    
    if (cost < oCost)
        draw_sprite_ext(spr_statArrow, 1, (x - (_x / 2)) + ((string_width(costText) / 2) + 10) + 10, y - 140, 1.5, 1.5, 0, -1, 1);
    
    if (cost2 > 0)
    {
        gml_Script_scr_textoutline(x + (_x / 2), y - 140, gml_Script_scr_bigNumber(cost2), c_cost2, 0, 20, 500);
        draw_sprite_ext(spr_underworldIcons, 2, x + (_x / 2) + ((string_width(gml_Script_scr_bigNumber(cost2)) / 2) + 10), y - 140, 0.5, 0.5, 0, -1, 1);
        
        if (cost2 < oCost2)
            draw_sprite_ext(spr_statArrow, 1, x + (_x / 2) + ((string_width(gml_Script_scr_bigNumber(cost2)) / 2) + 10) + 10, y - 140, 1.5, 1.5, 0, -1, 1);
    }
}
else
{
    gml_Script_scr_textoutline(x, y - 140, costText, c_cost, 0, 20, 500);
}

gml_Script_scr_textoutline(x, y - 120, text, 16777215, 0, 20, 100);
gml_Script_scr_textoutline(1370, 470, string(global.cmdPrefix) + "raid #", 16777215, 0, 40, 1680);
gml_Script_scr_textoutline(1370, 490, string(global.cmdPrefix) + "maxraid", 16777215, 0, 40, 1680);

if (afks > 0)
{
    gml_Script_scr_textoutline(x, y - 200, gml_Script_scr_bigNumber(afks), 16777215, 0, 40, 1680);
    draw_sprite_ext(spr_afk, afkicon, x + 18 + string_width(gml_Script_scr_bigNumber(afks)), y - 216, 2, 2, 0, c_white, 1);
    afkicon += 0.05;
    
    if (afkicon < 1 || afkicon > 3)
        afkicon -= 0.025;
    
    if (afkicon >= 4)
        afkicon = 0;
}

draw_set_font(f_special);
gml_Script_scr_textoutline(x, y - 180, "[+" + string_format(level / 10, 1, 1) + " guarding VP]", 16711935, 0, 20, 500);
