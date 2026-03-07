for (var i = 0; i < instance_number(obj_player); i += 1)
{
    player[i] = instance_find(obj_player, i);
    
    if (player[i].state == UnknownEnum.Value_6)
    {
        if (ds_list_find_index(trainList, player[i]) == -1)
            ds_list_add(trainList, player[i]);
    }
    else if (ds_list_find_index(trainList, player[i]) != -1)
    {
        var trainPos = ds_list_find_index(trainList, player[i]);
        ds_list_delete(trainList, trainPos);
    }
}

currentSlots = ds_list_size(trainList);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_font(f_big);
gml_Script_scr_textoutline(x + 60, y - 100, string(currentSlots) + "/" + string(global.maxTrain), 16777215, 0, 20, 100);
draw_set_font(f_mid);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_sprite_ext(spr_building, 0, x + 80, y - 15, 5.5, 3.8, 0, c_white, 1);

if (costText != "Maximum Level")
    gml_Script_scr_textoutline(x + 80, y - 40, string_lower(msg[global.buildingMsgDisplay]), 16777215, 0, 20, 500);
else
    gml_Script_scr_textoutline(x + 80, y - 40, string_lower(msg[2]), 16777215, 0, 20, 500);

var _x = 0;

if (cost2 > 0)
    _x = 30 + (string_width(costText + gml_Script_scr_bigNumber(cost2)) / 2);

if (costText != "Maximum Level")
{
    gml_Script_scr_textoutline((x + 80) - (_x / 2), y - 20, costText, c_cost, 0, 20, 500);
    draw_sprite_ext(spr_resourceBonus, 2, ((x + 80) - (_x / 2)) + ((string_width(costText) / 2) + 10), y - 20, 1, 1, 0, -1, 1);
    
    if (cost < oCost)
        draw_sprite_ext(spr_statArrow, 1, ((x + 80) - (_x / 2)) + ((string_width(costText) / 2) + 10) + 10, y - 20, 1.5, 1.5, 0, -1, 1);
    
    if (cost2 > 0)
    {
        gml_Script_scr_textoutline(x + 80 + (_x / 2), y - 20, gml_Script_scr_bigNumber(cost2), c_cost2, 0, 20, 500);
        draw_sprite_ext(spr_underworldIcons, 2, x + 80 + (_x / 2) + ((string_width(gml_Script_scr_bigNumber(cost2)) / 2) + 10), y - 20, 0.5, 0.5, 0, -1, 1);
        
        if (cost2 < oCost2)
            draw_sprite_ext(spr_statArrow, 1, x + 80 + (_x / 2) + ((string_width(gml_Script_scr_bigNumber(cost2)) / 2) + 10) + 10, y - 20, 1.5, 1.5, 0, -1, 1);
    }
}
else
{
    gml_Script_scr_textoutline(x + 80, y - 20, costText, c_cost, 0, 20, 500);
}

gml_Script_scr_textoutline(x + 80, y, text, 16777215, 0, 20, 100);
draw_set_font(f_special);
gml_Script_scr_textgradient(x + 70, y + 30, "+" + gml_Script_scr_bigNumber(round(amount * global.academyXpBonus)), 16711935, 8388736);
draw_sprite(spr_xpBonus, 1, x + 80 + (string_width(string("+" + gml_Script_scr_bigNumber(round(amount * global.academyXpBonus)))) / 2), y + 30);
global.raidingVP = (level / 10) + (global.hunterGuildLevel / 3);
gml_Script_scr_textoutline(x + 80, y - 60, "[+" + string_format(global.raidingVP, 1, 1) + " raiding VP]", 16711935, 0, 20, 500);

enum UnknownEnum
{
    Value_6 = 6
}
