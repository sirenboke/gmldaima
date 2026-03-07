if (!instance_exists(obj_uniqueItem))
{
    if (alarm[1] == -1)
    {
        if (tierImage == 1)
            draw_sprite(spr_item_color, tier, x, y);
        else
            draw_sprite(spr_item_color, tier - 7, x, y);
        
        draw_sprite(sprite_index, _itemType, x, y);
        draw_set_font(f_special);
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        gml_Script_scr_textoutline(x, y + (sprite_height / 2), "lv." + string(level), c1, 0, 20, 400);
        draw_set_font(f_big);
        gml_Script_scr_textoutline(x, (y - (sprite_height / 2)) + 2, string(string_replace_all(tierText, "I", ".")), c1, 0, 20, 400);
    }
    
    if (equipped == true)
        draw_sprite(spr_none, 2, x, y);
}
