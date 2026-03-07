draw_set_valign(fa_middle);

if (!variable_instance_exists(id, "text"))
    exit;

if (alarm[1] == -1)
{
    draw_set_halign(fa_center);
    
    if (y <= 60)
    {
        depth = obj_gameControl.depth - 1;
        draw_set_font(f_midbig);
        draw_set_halign(fa_left);
        gml_Script_scr_textgradient(x, y, text, c1, c2, undefined, undefined, undefined, undefined, undefined, alpha);
    }
    
    if (y >= (room_height - 300))
    {
        draw_set_font(f_comic);
        
        if (instance_exists(obj_warrior) && x < 500)
        {
            visible = false;
        }
        else
        {
            visible = true;
            
            if (type == 20 || type == 11 || (type == 21 && is_string(value)) || type == 25 || type == 24 || type == 26)
                draw_set_font(f_mid);
            
            if (type == 9 || (type == 21 && is_real(value)))
                draw_sprite_ext(spr_statusIcons, 8, x - (string_width(string_hash_to_newline(text)) / 2), y, 1.5, 1.5, 0, c_white, alpha);
            
            if (type == 10)
                draw_sprite_ext(spr_statusIcons, 7, x - (string_width(string_hash_to_newline(text)) / 2), y, 1.5, 1.5, 0, c_white, alpha);
            
            if (type == 12 || type == 22)
                draw_sprite_ext(spr_statusIcons, 2, x - (string_width(string_hash_to_newline(text)) / 2), y, 1.5, 1.5, 0, c_white, alpha);
            
            if (type == 13 || type == 23)
                draw_sprite_ext(spr_statusIcons, 1, x - (string_width(string_hash_to_newline(text)) / 2), y, 1.5, 1.5, 0, c_white, alpha);
            
            draw_text_colour(x + 1, y, string_hash_to_newline(text), c_black, c_black, c_black, c_black, alpha);
            draw_text_colour(x - 1, y, string_hash_to_newline(text), c_black, c_black, c_black, c_black, alpha);
            draw_text_colour(x, y + 2, string_hash_to_newline(text), c_black, c_black, c_black, c_black, alpha);
            draw_text_colour(x, y - 1, string_hash_to_newline(text), c2, c2, c2, c2, alpha);
            draw_text_colour(x, y, string_hash_to_newline(text), c1, c1, c2, c2, alpha);
        }
    }
    
    y -= (0.07 * global.roomSpeed);
    
    if (alarm[2] == -1)
        alpha -= 0.05;
    
    if (alpha <= 0)
        instance_destroy();
}
