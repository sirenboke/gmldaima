if (gml_Script_live_call())
    return global.live_result;

draw_sprite_ext(spr_building, 0, x, y - 65 - 100, 6, 3.5, 0, c_white, 1);
draw_set_font(f_mid);
draw_set_valign(fa_middle);
draw_set_halign(fa_center);

if (costText != "Maximum Level")
    gml_Script_scr_textoutline(x, y - 200, string_lower(msg[global.buildingMsgDisplay]), 16777215, 0, 20, 500);
else
    gml_Script_scr_textoutline(x, y - 200, string_lower(msg[2]), 16777215, 0, 20, 500);

var _x = 0;

if (cost2 > 0)
    _x = 30 + (string_width(costText + gml_Script_scr_bigNumber(cost2)) / 2);

if (costText != "Maximum Level")
{
    gml_Script_scr_textoutline(x - (_x / 2), y - 180, costText, c_cost, 0, 20, 500);
    draw_sprite_ext(spr_resourceBonus, 2, (x - (_x / 2)) + ((string_width(costText) / 2) + 10), y - 180, 1, 1, 0, -1, 1);
    
    if (cost < oCost)
        draw_sprite_ext(spr_statArrow, 1, (x - (_x / 2)) + ((string_width(costText) / 2) + 10) + 10, y - 180, 1.5, 1.5, 0, -1, 1);
    
    if (cost2 > 0)
    {
        gml_Script_scr_textoutline(x + (_x / 2), y - 180, gml_Script_scr_bigNumber(cost2), c_cost2, 0, 20, 500);
        draw_sprite_ext(spr_underworldIcons, 2, x + (_x / 2) + ((string_width(gml_Script_scr_bigNumber(cost2)) / 2) + 10), y - 180, 0.5, 0.5, 0, -1, 1);
        
        if (cost2 < oCost2)
            draw_sprite_ext(spr_statArrow, 1, x + (_x / 2) + ((string_width(gml_Script_scr_bigNumber(cost2)) / 2) + 10) + 10, y - 180, 1.5, 1.5, 0, -1, 1);
    }
}
else
{
    gml_Script_scr_textoutline(x, y - 180, costText, c_cost, 0, 20, 500);
}

draw_set_font(f_special);
gml_Script_scr_textoutline(x, y - 145, "items # are the same as the stats on the Academy", 16777215, 0, 20, 190);

if (level < 14)
{
    draw_set_font(f_special);
    
    if (forgeItem[0][0] >= forgeItem[0][1])
        draw_sprite(spr_forge_level_outline, 0, x - 5, y - 75);
    else
        draw_sprite(spr_forge_level, 0, x - 5, y - 75);
    
    if (alarm[0] != -1)
    {
        draw_sprite_part(spr_forge_level, forgingLevel, 0, 40 - ((alarm[0] / (room_speed * 1800)) * 40), 40, 40, x - 25, y - 55 - ((alarm[0] / (room_speed * 1800)) * 40));
        draw_set_halign(fa_right);
        draw_set_font(f_mid_pixel);
        gml_Script_scr_textoutline(x + 15, y - 85, "x" + string(forgeItemAmount), 16777215, 0, 20, 400);
        draw_set_font(f_special);
        draw_set_halign(fa_center);
    }
    else
    {
        draw_sprite_part(spr_forge_level, forgingLevel, 0, 40 - ((forgeItem[0][0] / forgeItem[0][1]) * 40), 40, 40, x - 25, y - 55 - ((forgeItem[0][0] / forgeItem[0][1]) * 40));
    }
    
    if (forgeItem[0][0] >= forgeItem[0][1])
        gml_Script_scr_textoutline(x - 5, y - 50, string(forgeItemText[0][2]), 65535, 0, 20, 200);
    else
        gml_Script_scr_textoutline(x - 5, y - 50, string(forgeItemText[0][2]), 12632256, 0, 20, 200);
}

if (level >= 14)
{
    draw_set_font(f_special);
    
    if (forgeItem[0][0] >= forgeItem[0][1])
        draw_sprite(spr_forge_level_outline, 0, x - 40, y - 75);
    else
        draw_sprite(spr_forge_level, 0, x - 40, y - 75);
    
    if (alarm[0] != -1)
    {
        draw_sprite_part(spr_forge_level, forgingLevel, 0, 40 - ((alarm[0] / (room_speed * 1800)) * 40), 40, 40, x - 60, y - 55 - ((alarm[0] / (room_speed * 1800)) * 40));
        draw_set_halign(fa_right);
        draw_set_font(f_mid_pixel);
        gml_Script_scr_textoutline(x - 20, y - 85, "x" + string(forgeItemAmount), 16777215, 0, 20, 400);
        draw_set_font(f_special);
        draw_set_halign(fa_center);
    }
    else
    {
        draw_sprite_part(spr_forge_level, forgingLevel, 0, 40 - ((forgeItem[0][0] / forgeItem[0][1]) * 40), 40, 40, x - 60, y - 55 - ((forgeItem[0][0] / forgeItem[0][1]) * 40));
    }
    
    if (forgeItem[0][0] >= forgeItem[0][1])
        gml_Script_scr_textoutline(x - 40, y - 50, string(forgeItemText[0][2]), 65535, 0, 20, 200);
    else
        gml_Script_scr_textoutline(x - 40, y - 50, string(forgeItemText[0][2]), 12632256, 0, 20, 200);
    
    draw_set_font(f_special);
    
    if (forgeItem[1][0] >= forgeItem[1][1])
        draw_sprite(spr_forge_level_outline, 0, x + 40, y - 75);
    else
        draw_sprite(spr_forge_level, 0, x + 40, y - 75);
    
    if (alarm[1] != -1)
        draw_sprite_part(spr_forge_level, 14, 0, 40 - ((alarm[1] / (room_speed * 21600)) * 40), 40, 40, x + 20, y - 55 - ((alarm[1] / (room_speed * 21600)) * 40));
    else
        draw_sprite_part(spr_forge_level, 14, 0, 40 - ((forgeItem[1][0] / forgeItem[1][1]) * 40), 40, 40, x + 20, y - 55 - ((forgeItem[1][0] / forgeItem[1][1]) * 40));
    
    if (forgeItem[1][0] >= forgeItem[1][1])
    {
        gml_Script_scr_textgradient(x + 35, y - 50, string(forgeItem[1][2]), 65535, 65535, undefined, undefined, undefined, 16776960, 16776960);
        draw_sprite_ext(spr_underworldIcons, 2, x + 50, y - 48, 0.5, 0.5, 0, c_white, 1);
    }
    else
    {
        gml_Script_scr_textgradient(x + 30, y - 50, "+1", 65535, 65535, undefined, undefined, undefined, 16776960, 16776960);
        draw_sprite_ext(spr_underworldIcons, 2, x + 50, y - 48, 0.5, 0.5, 0, c_white, 1);
    }
    
    if (global.unlockCorrupted == true)
    {
        if (level >= 20)
        {
            if (global.buildingMsgDisplay == 0)
            {
                var corr_cost = 16777215;
                
                if (global.bloodgems < 1)
                    corr_cost = 4235519;
                
                draw_sprite_ext(spr_forge_level, 15, x + 40, y, 1, 1, 0, c_white, 1);
                gml_Script_scr_textoutline(x + 40, y - 30, "!corrupt #", corr_cost);
                draw_set_font(f_mid);
                gml_Script_scr_textoutline(x + 40, y, "x[0.5-" + string(global.maxRelicCorruption) + "]", corr_cost);
                draw_set_font(f_special);
                gml_Script_scr_textgradient(x + 35, y + 25, "1", corr_cost, corr_cost);
                draw_sprite_ext(spr_underworldIcons, 1, x + 50, y + 26, 0.5, 0.5, 0, c_white, 1);
            }
            else
            {
                draw_sprite_ext(spr_forge_level, 16, x + 40, y, 1, 1, 0, c_white, 1);
                gml_Script_scr_textoutline(x + 40, y - 30, "!purify #", 16777215);
                gml_Script_scr_textgradient(x + 30, y + 25, ">300", 65535, 65535, undefined, undefined, undefined, 16776960, 16776960);
                draw_sprite_ext(spr_underworldIcons, 2, x + 60, y + 26, 0.5, 0.5, 0, c_white, 1);
            }
        }
    }
}

if (level < 14)
{
    gml_Script_scr_textoutline(x - 5, y - 105, string(global.cmdPrefix) + "forge #*#", 16777215, 0, 20, 1680);
}
else
{
    gml_Script_scr_textoutline(x - 40, y - 105, string(global.cmdPrefix) + "forge #*#", 16777215, 0, 20, 1680);
    
    if (alarm[1] == -1)
    {
        gml_Script_scr_textoutline(x + 40, y - 105, string(global.cmdPrefix) + "recycle #*#", 16777215, 0, 20, 1680);
    }
    else
    {
        gml_Script_scr_textoutline(x + 40, y - 105, string(global.cmdPrefix) + "reforge #*#", 65280, 0, 20, 1680);
        draw_set_halign(fa_right);
        draw_set_font(f_mid_pixel);
        gml_Script_scr_textoutline(x + 60, y - 85, "x" + string(forgeRelicAmount), 16777215, 0, 20, 400);
        draw_set_font(f_special);
        draw_set_halign(fa_center);
    }
}
