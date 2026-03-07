if (show == true)
{
    if (y < (room_height - 250))
        y = room_height - 150;
    
    draw_set_valign(fa_middle);
    draw_set_halign(fa_center);
    draw_set_font(f_comic);
    draw_sprite_ext(spr_statChange, type, x - (string_width(string(text)) / 2), y + 6, 2, 2, 0, c_black, alpha);
    draw_sprite_ext(spr_statChange, type, x - (string_width(string(text)) / 2), y, 2, 2, 0, c_white, alpha);
    draw_sprite_ext(spr_statArrow, arrow, x + (string_width(string(text)) / 2) + 10, y + 4, 2, 2, 0, c_white, alpha);
    gml_Script_scr_textshadow(x, y, text, c1, 0, 20, 100, alpha);
    y -= (spd * global.roomSpeed);
    alpha -= (0.015 * global.roomSpeed);
    
    if (alpha <= 0)
        instance_destroy();
}
