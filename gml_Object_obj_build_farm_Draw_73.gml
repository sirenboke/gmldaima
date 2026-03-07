if (hp >= maxhp)
{
    if (!audio_is_playing(s_itemAppear))
        gml_Script_scr_playsound(s_itemAppear, 2, 2.5, 0.1);
    
    with (gml_Script_instance_create(random_range(x - (sprite_width / 3), x + (sprite_width / 3)), random_range(y + (sprite_height / 3), y - (sprite_height / 3)), obj_food))
        value = other.amount;
    
    hp -= maxhp;
}

if (hp < 0)
    hp = 0;

for (var i = 0; i < instance_number(obj_player); i += 1)
{
    player[i] = instance_find(obj_player, i);
    
    if (player[i].state == UnknownEnum.Value_3)
    {
        if (ds_list_find_index(farmList, player[i]) == -1)
            ds_list_add(farmList, player[i]);
    }
    else if (ds_list_find_index(farmList, player[i]) != -1)
    {
        var farmPos = ds_list_find_index(farmList, player[i]);
        ds_list_delete(farmList, farmPos);
    }
}

currentSlots = ds_list_size(farmList);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_font(f_big);
gml_Script_scr_textoutline(x + 120, y - 50, string(currentSlots) + "/" + string(global.maxFarm), 16777215, 0, 20, 100);
draw_set_font(f_mid);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_sprite_ext(spr_building, 0, x, y - 115, 5.5, 3.8, 0, c_white, 1);

if (costText != "Maximum Level")
    gml_Script_scr_textoutline(x, y - 140, string_lower(msg[global.buildingMsgDisplay]), 16777215, 0, 20, 500);
else
    gml_Script_scr_textoutline(x, y - 140, string_lower(msg[2]), 16777215, 0, 20, 500);

var _x = 0;

if (cost2 > 0)
    _x = 30 + (string_width(costText + gml_Script_scr_bigNumber(cost2)) / 2);

if (costText != "Maximum Level")
{
    gml_Script_scr_textoutline(x - (_x / 2), y - 120, costText, c_cost, 0, 20, 500);
    draw_sprite_ext(spr_resourceBonus, 2, (x - (_x / 2)) + ((string_width(costText) / 2) + 10), y - 120, 1, 1, 0, -1, 1);
    
    if (cost < oCost)
        draw_sprite_ext(spr_statArrow, 1, (x - (_x / 2)) + ((string_width(costText) / 2) + 10) + 10, y - 120, 1.5, 1.5, 0, -1, 1);
    
    if (cost2 > 0)
    {
        gml_Script_scr_textoutline(x + (_x / 2), y - 120, gml_Script_scr_bigNumber(cost2), c_cost2, 0, 20, 500);
        draw_sprite_ext(spr_underworldIcons, 2, x + (_x / 2) + ((string_width(gml_Script_scr_bigNumber(cost2)) / 2) + 10), y - 120, 0.5, 0.5, 0, -1, 1);
        
        if (cost2 < oCost2)
            draw_sprite_ext(spr_statArrow, 1, x + (_x / 2) + ((string_width(gml_Script_scr_bigNumber(cost2)) / 2) + 10) + 10, y - 120, 1.5, 1.5, 0, -1, 1);
    }
}
else
{
    gml_Script_scr_textoutline(x, y - 120, costText, c_cost, 0, 20, 500);
}

gml_Script_scr_textoutline(x, y - 100, text, 16777215, 0, 20, 100);
draw_sprite_ext(spr_blackbar, 0, x - 30, y - 85, 60, 1.2, 0, c_white, 1);

if (hp < maxhp)
    draw_sprite_ext(spr_hpbar, 0, x - 29, y - 85, (hp / maxhp) * 58, 1, 0, c_white, 1);
else
    draw_sprite_ext(spr_hpbar, 0, x - 29, y - 85, 58, 1, 0, c_white, 1);

draw_set_font(f_special);
gml_Script_scr_textgradient(x - 10, y - 70, "+" + gml_Script_scr_bigNumber(round(amount)), 65280, 32768);
draw_sprite(spr_resourceBonus, 1, x + (string_width(string("+" + gml_Script_scr_bigNumber(round(amount)))) / 2), y - 70);
global.farmingVP = (level / 10) + (global.farmerGuildLevel / 3);
gml_Script_scr_textoutline(x, y - 160, "[+" + string_format(global.farmingVP, 1, 1) + " farming VP]", 16711935, 0, 20, 500);

enum UnknownEnum
{
    Value_3 = 3
}
