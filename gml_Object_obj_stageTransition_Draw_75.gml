draw_sprite_ext(spr_black, 0, 0, room_height - 260, room_width, 260, 0, c_white, alpha);
draw_set_halign(fa_center);

if (in == false)
{
    draw_set_font(f_mid);
    draw_sprite_ext(spr_building, 0, room_width / 2, (room_height - 150) + 30, (20 + string_width(string_hash_to_newline(text2))) / 32, 3, 0, c_white, 1);
    gml_Script_scr_textoutline(room_width / 2, (room_height - 150) + 50, string(text2), 16777215, 0, 20, 2000);
    draw_set_font(f_big);
    gml_Script_scr_textoutline(room_width / 2, room_height - 150, string(text1), c1, 0, 20, 2000);
}
