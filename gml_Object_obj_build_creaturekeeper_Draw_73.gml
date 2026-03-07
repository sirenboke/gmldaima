draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_font(f_mid);
draw_sprite_ext(spr_building, 0, x, y - 50, 9, 5, 0, c_white, 1);

if (costText != "Maximum Level")
    gml_Script_scr_textoutline(x, y - 110, string_lower(msg[global.buildingMsgDisplay]), 16777215, 0, 20, 500);
else
    gml_Script_scr_textoutline(x, y - 110, string_lower(msg[2]), 16777215, 0, 20, 500);

var _x = 0;

if (cost2 > 0)
    _x = 30 + (string_width(costText + gml_Script_scr_bigNumber(cost2)) / 2);

if (costText != "Maximum Level")
{
    gml_Script_scr_textoutline(x - (_x / 2), y - 90, costText, c_cost, 0, 20, 500);
    draw_sprite_ext(spr_resourceBonus, 2, (x - (_x / 2)) + ((string_width(costText) / 2) + 10), y - 90, 1, 1, 0, -1, 1);
    
    if (cost < oCost)
        draw_sprite_ext(spr_statArrow, 1, (x - (_x / 2)) + ((string_width(costText) / 2) + 10) + 10, y - 90, 1.5, 1.5, 0, -1, 1);
    
    if (cost2 > 0)
    {
        gml_Script_scr_textoutline(x + (_x / 2), y - 90, gml_Script_scr_bigNumber(cost2), c_cost2, 0, 20, 500);
        draw_sprite_ext(spr_underworldIcons, 2, x + (_x / 2) + ((string_width(gml_Script_scr_bigNumber(cost2)) / 2) + 10), y - 90, 0.5, 0.5, 0, -1, 1);
        
        if (cost2 < oCost2)
            draw_sprite_ext(spr_statArrow, 1, x + (_x / 2) + ((string_width(gml_Script_scr_bigNumber(cost2)) / 2) + 10) + 10, y - 90, 1.5, 1.5, 0, -1, 1);
    }
}
else
{
    gml_Script_scr_textoutline(x, y - 90, costText, c_cost, 0, 20, 500);
}

gml_Script_scr_textoutline(x, y - 50, string(global.cmdPrefix) + "trainpet# (max lv." + string(level + 4) + ")", 16777215, 0, 20, 500);
gml_Script_scr_textoutline(x, y + 10, string(global.cmdPrefix) + "stoptrainpet", 16777215, 0, 20, 500);
draw_set_halign(fa_left);
gml_Script_scr_textoutline(x - (string_width(gml_Script_scr_bigNumber(goldCost) + " gold and " + gml_Script_scr_bigNumber(foodCost) + " food") / 2), y - 30, gml_Script_scr_bigNumber(goldCost) + " gold", 65535, 0, 20, 500);
gml_Script_scr_textoutline((x - (string_width(gml_Script_scr_bigNumber(goldCost) + " gold and " + gml_Script_scr_bigNumber(foodCost) + " food") / 2)) + string_width(gml_Script_scr_bigNumber(goldCost) + " gold"), y - 30, " and ", 16777215, 0, 20, 500);
gml_Script_scr_textoutline((x - (string_width(gml_Script_scr_bigNumber(goldCost) + " gold and " + gml_Script_scr_bigNumber(foodCost) + " food") / 2)) + string_width(gml_Script_scr_bigNumber(goldCost) + " gold and "), y - 30, gml_Script_scr_bigNumber(foodCost) + " food", 32768, 0, 20, 500);
draw_set_font(f_special);
gml_Script_scr_textoutline(x - (string_width("(pets gain " + gml_Script_scr_bigNumber(ceil((foodCost + goldCost) / 100)) + " XP/s") / 2), y - 10, "(pets gain ", 16777215, 0, 20, 500);
gml_Script_scr_textoutline((x - (string_width("(pets gain " + gml_Script_scr_bigNumber(ceil((foodCost + goldCost) / 100)) + " XP/s") / 2)) + string_width("(pets gain "), y - 10, gml_Script_scr_bigNumber(ceil((foodCost + goldCost) / 100)) + " XP/s", 16711935, 0, 20, 500);
gml_Script_scr_textoutline((x - (string_width("(pets gain " + gml_Script_scr_bigNumber(ceil((foodCost + goldCost) / 100)) + " XP/s") / 2)) + string_width("(pets gain " + gml_Script_scr_bigNumber(ceil((foodCost + goldCost) / 100)) + " XP/s"), y - 10, ")", 16777215, 0, 20, 500);
