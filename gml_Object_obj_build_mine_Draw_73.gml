if (hp >= maxhp)
{
    if (!audio_is_playing(s_itemAppear))
        gml_Script_scr_playsound(s_itemAppear, 2, 2.5, 0.1);
    
    if (!audio_is_playing(s_mineFull2))
        gml_Script_scr_playsound(s_mineFull2, 0.9, 1.1, 1);
    
    with (gml_Script_instance_create(x, y - (sprite_height / 2), obj_gold))
        value = other.amount;
    
    hp -= maxhp;
}

if (hp < 0)
    hp = 0;

for (var i = 0; i < instance_number(obj_player); i += 1)
{
    player[i] = instance_find(obj_player, i);
    
    if (player[i].state == UnknownEnum.Value_4)
    {
        if (ds_list_find_index(mineList, player[i]) == -1)
            ds_list_add(mineList, player[i]);
    }
    else if (ds_list_find_index(mineList, player[i]) != -1)
    {
        var minePos = ds_list_find_index(mineList, player[i]);
        ds_list_delete(mineList, minePos);
    }
}

currentSlots = ds_list_size(mineList);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_font(f_big);
gml_Script_scr_textoutline(x - 100, y - 60, string(currentSlots) + "/" + string(global.maxMine), 16777215, 0, 20, 100);
draw_set_font(f_mid);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_sprite_ext(spr_building, 0, x + 130, (y - 115) + 70, 5.5, 4.8, 0, c_white, 1);

if (costText != "Maximum Level")
    gml_Script_scr_textoutline(x + 130, (y - 140) + 50, string_lower(msg[global.buildingMsgDisplay]), 16777215, 0, 20, 500);
else
    gml_Script_scr_textoutline(x + 130, (y - 140) + 50, string_lower(msg[2]), 16777215, 0, 20, 500);

var _x = 0;

if (cost2 > 0)
    _x = 30 + (string_width(costText + gml_Script_scr_bigNumber(cost2)) / 2);

if (costText != "Maximum Level")
{
    gml_Script_scr_textoutline((x + 130) - (_x / 2), (y - 120) + 50, costText, c_cost, 0, 20, 500);
    draw_sprite_ext(spr_resourceBonus, 2, ((x + 130) - (_x / 2)) + ((string_width(costText) / 2) + 10), (y - 120) + 50, 1, 1, 0, -1, 1);
    
    if (cost < oCost)
        draw_sprite_ext(spr_statArrow, 1, ((x + 130) - (_x / 2)) + ((string_width(costText) / 2) + 10) + 10, (y - 120) + 50, 1.5, 1.5, 0, -1, 1);
    
    if (cost2 > 0)
    {
        gml_Script_scr_textoutline(x + 130 + (_x / 2), (y - 120) + 50, gml_Script_scr_bigNumber(cost2), c_cost2, 0, 20, 500);
        draw_sprite_ext(spr_underworldIcons, 2, x + 130 + (_x / 2) + ((string_width(gml_Script_scr_bigNumber(cost2)) / 2) + 10), (y - 120) + 50, 0.5, 0.5, 0, -1, 1);
        
        if (cost2 < oCost2)
            draw_sprite_ext(spr_statArrow, 1, x + 130 + (_x / 2) + ((string_width(gml_Script_scr_bigNumber(cost2)) / 2) + 10) + 10, (y - 120) + 50, 1.5, 1.5, 0, -1, 1);
    }
}
else
{
    gml_Script_scr_textoutline(x + 130, (y - 120) + 50, costText, c_cost, 0, 20, 500);
}

gml_Script_scr_textoutline(x + 130, (y - 100) + 50, text, 16777215, 0, 20, 100);
draw_sprite_ext(spr_blackbar, 0, (x + 130) - 30, (y - 85) + 50, 60, 1.2, 0, c_white, 1);

if (hp < maxhp)
    draw_sprite_ext(spr_hpbar, 0, (x + 130) - 29, (y - 85) + 50, (hp / maxhp) * 58, 1, 0, c_white, 1);
else
    draw_sprite_ext(spr_hpbar, 0, (x + 130) - 29, (y - 85) + 50, 58, 1, 0, c_white, 1);

draw_set_font(f_special);
gml_Script_scr_textgradient(x + 120, (y - 70) + 50, "+" + gml_Script_scr_bigNumber(round(amount)), 65535, 4235519);
draw_sprite(spr_resourceBonus, 2, x + 130 + (string_width(string("+" + gml_Script_scr_bigNumber(round(amount)))) / 2), (y - 70) + 50);
gml_Script_scr_textgradient(x + 120, (y - 70) + 70, "+" + string(floor(1 + (((global.townLevel / 2) + (obj_build_mine.level / 10)) / 2))) + " to " + string(floor(2 + ((global.townLevel / 2) + (obj_build_mine.level / 10)))), 65535, 16776960);
draw_sprite_ext(spr_underworldIcons, 2, x + 135 + (string_width("+" + string(floor(1 + (((global.townLevel / 2) + (obj_build_mine.level / 10)) / 2))) + " to " + string(floor(2 + ((global.townLevel / 2) + (obj_build_mine.level / 10))))) / 2), (y - 70) + 70, 0.5, 0.5, 0, c_white, 1);
draw_set_font(f_special);
gml_Script_scr_textgradient(x + 130, (y - 70) + 90, "(" + string_format(1 / gemChance, 0, 4) + "%)", 16777215, 16777215);
draw_set_font(f_special);
global.miningVP = (level / 10) + (global.minerGuildLevel / 3);
gml_Script_scr_textoutline(x + 130, (y - 160) + 50, "[+" + string_format(global.miningVP, 1, 1) + " mining VP]", 16711935, 0, 20, 500);

enum UnknownEnum
{
    Value_4 = 4
}
