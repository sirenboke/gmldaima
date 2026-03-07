draw_sprite_ext(spr_building, 0, x, y - 65, 9, 8, 0, c_white, 1);
draw_set_font(f_mid);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
gml_Script_scr_textoutline(x, y - 145, string(global.cmdPrefix) + "talent #*#", 16777215, 0, 20, 600);

if (costText != "Maximum Level")
    gml_Script_scr_textoutline(x, y - 185, string_lower(msg[global.buildingMsgDisplay]), 16777215, 0, 20, 500);
else
    gml_Script_scr_textoutline(x, y - 185, string_lower(msg[2]), 16777215, 0, 20, 500);

var _x = 0;

if (cost2 > 0)
    _x = 30 + (string_width(costText + gml_Script_scr_bigNumber(cost2)) / 2);

if (costText != "Maximum Level")
{
    gml_Script_scr_textoutline(x - (_x / 2), y - 165, costText, c_cost, 0, 20, 500);
    draw_sprite_ext(spr_resourceBonus, 2, (x - (_x / 2)) + ((string_width(costText) / 2) + 10), y - 165, 1, 1, 0, -1, 1);
    
    if (cost < oCost)
        draw_sprite_ext(spr_statArrow, 1, (x - (_x / 2)) + ((string_width(costText) / 2) + 10) + 10, y - 165, 1.5, 1.5, 0, -1, 1);
    
    if (cost2 > 0)
    {
        gml_Script_scr_textoutline(x + (_x / 2), y - 165, gml_Script_scr_bigNumber(cost2), c_cost2, 0, 20, 500);
        draw_sprite_ext(spr_underworldIcons, 2, x + (_x / 2) + ((string_width(gml_Script_scr_bigNumber(cost2)) / 2) + 10), y - 165, 0.5, 0.5, 0, -1, 1);
        
        if (cost2 < oCost2)
            draw_sprite_ext(spr_statArrow, 1, x + (_x / 2) + ((string_width(gml_Script_scr_bigNumber(cost2)) / 2) + 10) + 10, y - 165, 1.5, 1.5, 0, -1, 1);
    }
}
else
{
    gml_Script_scr_textoutline(x, y - 165, costText, c_cost, 0, 20, 500);
}

draw_sprite_ext(spr_magicBook, 1, x, y - 40, 1, 1, 0, c_white, 0.5);
gml_Script_scr_textoutline(x, y - 95, "+" + string(round((global.academyXpBonus - 1) * 100)) + "%[+] XP", 16777215, 0, 20, 1680);
gml_Script_scr_textoutline(x, y - 75, string(global.cmdPrefix) + "respec #*#", 16777215, 0, 20, 600);
gml_Script_scr_textoutline(x, y - 55, string(global.cmdPrefix) + "fullrespec", 16777215, 0, 20, 600);

if (level >= 30)
{
    gml_Script_scr_textoutline(x, y - 15, string(global.cmdPrefix) + "specialize", 16776960, 0, 20, 600);
    gml_Script_scr_textoutline(x, y + 5, string(global.cmdPrefix) + "spec #*#", 16776960, 0, 20, 600);
    gml_Script_scr_textoutline(x, y + 25, string(global.cmdPrefix) + "unspec #*#", 16776960, 0, 20, 600);
    gml_Script_scr_textoutline(x, y + 45, string(global.cmdPrefix) + "fullunspec", 16776960, 0, 20, 600);
}

draw_set_valign(fa_middle);
draw_sprite_ext(spr_whiteFrame, 0, x - 70, y - 130, 2, 2, 0, c_white, 1);
draw_sprite_ext(spr_statIcons, 3, x - 70, y - 130, 2, 2, 0, c_black, 1);
gml_Script_scr_textoutline(x - 70 - 30, y - 130, "1", 16777215, 0, 20, 600);
draw_sprite_ext(spr_whiteFrame, 0, x - 90, y - 85, 2, 2, 0, c_white, 1);
draw_sprite_ext(spr_statIcons, 8, x - 90, y - 85, 2, 2, 0, c_black, 1);
gml_Script_scr_textoutline(x - 90 - 30, y - 85, "2", 16777215, 0, 20, 600);
draw_sprite_ext(spr_whiteFrame, 0, x - 100, y - 40, 2, 2, 0, c_white, 1);
draw_sprite_ext(spr_statIcons, 6, x - 100, y - 40, 2, 2, 0, c_black, 1);
gml_Script_scr_textoutline(x - 100 - 30, y - 40, "3", 16777215, 0, 20, 600);
draw_sprite_ext(spr_whiteFrame, 0, x - 90, y + 5, 2, 2, 0, c_white, 1);
draw_sprite_ext(spr_statIcons, 7, x - 90, y + 5, 2, 2, 0, c_black, 1);
gml_Script_scr_textoutline(x - 90 - 30, y + 5, "4", 16777215, 0, 20, 600);
draw_sprite_ext(spr_whiteFrame, 0, x - 70, y + 50, 2, 2, 0, c_white, 1);
draw_sprite_ext(spr_statIcons, 0, x - 70, y + 50, 2, 2, 0, c_black, 1);
gml_Script_scr_textoutline(x - 70 - 30, y + 50, "5", 16777215, 0, 20, 600);
draw_sprite_ext(spr_whiteFrame, 0, x + 70, y - 130, 2, 2, 0, c_white, 1);
draw_sprite_ext(spr_statIcons, 5, x + 70, y - 130, 2, 2, 0, c_black, 1);
gml_Script_scr_textoutline(x + 70 + 30, y - 130, "6", 16777215, 0, 20, 600);
draw_sprite_ext(spr_whiteFrame, 0, x + 90, y - 85, 2, 2, 0, c_white, 1);
draw_sprite_ext(spr_statIcons, 4, x + 90, y - 85, 2, 2, 0, c_black, 1);
gml_Script_scr_textoutline(x + 90 + 30, y - 85, "7", 16777215, 0, 20, 600);
draw_sprite_ext(spr_whiteFrame, 0, x + 100, y - 40, 2, 2, 0, c_white, 1);
draw_sprite_ext(spr_statIcons, 1, x + 100, y - 40, 2, 2, 0, c_black, 1);
gml_Script_scr_textoutline(x + 100 + 30, y - 40, "8", 16777215, 0, 20, 600);
draw_sprite_ext(spr_whiteFrame, 0, x + 90, y + 5, 2, 2, 0, c_white, 1);
draw_sprite_ext(spr_statIcons, 2, x + 90, y + 5, 2, 2, 0, c_black, 1);
gml_Script_scr_textoutline(x + 90 + 30, y + 5, "9", 16777215, 0, 20, 600);
draw_sprite_ext(spr_whiteFrame, 0, x + 70, y + 50, 2, 2, 0, c_white, 1);
draw_sprite_ext(spr_statIcons, 9, x + 70, y + 50, 2, 2, 0, c_black, 1);
gml_Script_scr_textoutline(x + 70 + 30, y + 50, "10", 16777215, 0, 20, 600);
