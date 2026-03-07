if (alarm[1] == -1)
{
    draw_set_font(f_special);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    
    if (upgChance == 0)
        draw_sprite_ext(spr_part_glow, 0, x, y, 2.5, 2.5, 0, c_orange, 1);
    
    if (itemType == 0)
    {
        if (cost < 1000000)
            gml_Script_scr_textoutline(x, y + (sprite_height / 2) + 24, string(costText) + "g", 65535, 0, 20, 400);
        else
            gml_Script_scr_textoutline(x, y + (sprite_height / 2) + 24, string(costText) + "M", 65535, 0, 20, 400);
        
        if (tierImage == 1)
            draw_sprite(spr_item_color, tier, x, y);
        else
            draw_sprite(spr_item_color, tier - 7, x, y);
        
        draw_sprite(sprite_index, _itemType, x, y);
        gml_Script_scr_textoutline(x, y + (sprite_height / 2) + 8, "lv. " + gml_Script_scr_bigNumber(level), c1, 0, 20, 400);
        draw_set_font(f_mid);
        gml_Script_scr_textoutline(x, y - (sprite_height / 2) - 8, string(number), 16777215, 0, 20, 200);
        draw_set_halign(fa_center);
        draw_set_font(f_big);
        gml_Script_scr_textoutline(x, (y - (sprite_height / 2)) + 2, string(string_replace_all(tierText, "I", ".")), c1, 0, 20, 400);
    }
    
    if (upgChance == 0)
    {
        rot += 1;
        
        if (rot > 359)
            rot = 0;
        
        draw_sprite(spr_item_color, 8, x, y);
    }
    
    if (itemType == 1)
    {
        draw_self();
        gml_Script_scr_textgradient(x, y + (sprite_height / 2) + 24, string(cost) + " gems", 65535, 65535, undefined, undefined, undefined, 16776960, 16776960);
        gml_Script_scr_textoutline(x, y + (sprite_height / 2) + 8, string(name), c1, 0, 20, 200);
        draw_set_font(f_mid);
        gml_Script_scr_textoutline(x, y - (sprite_height / 2) - 8, string(number), 16777215, 0, 20, 200);
        draw_set_halign(fa_right);
        draw_set_font(f_mid_pixel);
        gml_Script_scr_textoutline(x + (sprite_width / 2), (y - (sprite_height / 2)) + 10, "x" + string(amount), 16777215, 0, 20, 400);
    }
}
