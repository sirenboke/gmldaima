draw_sprite_ext(spr_building, 0, x, y, 3, 1, 0, c_white, 1);
draw_set_font(f_mid);
draw_set_valign(fa_middle);
draw_set_halign(fa_center);

if (costText != "Maximum Level")
    gml_Script_scr_textoutline(x, y - 80, string_lower(msg[global.buildingMsgDisplay]), 16777215, 0, 20, 500);
else
    gml_Script_scr_textoutline(x, y - 80, string_lower(msg[2]), 16777215, 0, 20, 500);

gml_Script_scr_textoutline(x, y, "+" + string(round(global.wellGoldBonus * 100)) + "%[+] gold", 16777215, 0, 20, 1680);
var _x = 0;

if (cost2 > 0)
    _x = 30 + (string_width(costText + gml_Script_scr_bigNumber(cost2)) / 2);

if (costText != "Maximum Level")
{
    gml_Script_scr_textoutline(x - (_x / 2), y - 60, costText, c_cost, 0, 20, 500);
    draw_sprite_ext(spr_resourceBonus, 2, (x - (_x / 2)) + ((string_width(costText) / 2) + 10), y - 60, 1, 1, 0, -1, 1);
    
    if (cost < oCost)
        draw_sprite_ext(spr_statArrow, 1, (x - (_x / 2)) + ((string_width(costText) / 2) + 10) + 10, y - 60, 1.5, 1.5, 0, -1, 1);
    
    if (cost2 > 0)
    {
        gml_Script_scr_textoutline(x + (_x / 2), y - 60, gml_Script_scr_bigNumber(cost2), c_cost2, 0, 20, 500);
        draw_sprite_ext(spr_underworldIcons, 2, x + (_x / 2) + ((string_width(gml_Script_scr_bigNumber(cost2)) / 2) + 10), y - 60, 0.5, 0.5, 0, -1, 1);
        
        if (cost2 < oCost2)
            draw_sprite_ext(spr_statArrow, 1, x + (_x / 2) + ((string_width(gml_Script_scr_bigNumber(cost2)) / 2) + 10) + 10, y - 60, 1.5, 1.5, 0, -1, 1);
    }
}
else
{
    gml_Script_scr_textoutline(x, y - 60, costText, c_cost, 0, 20, 500);
}
