draw_sprite_ext(sprite_index, 0, x, y, 1, 1, 0, c_white, 1);
draw_set_font(f_big);
draw_set_valign(fa_middle);
draw_set_halign(fa_center);
gml_Script_scr_textshadow(x, y, text, 16777215, 0, 20, 1000);
draw_set_font(f_mid);

if (alarm[0] > 0)
    gml_Script_scr_textshadow(room_width / 2, (room_height / 2) + 60, "(Automatically starting in " + string(round(alarm[0] / room_speed)) + "s)", 65280, 0, 20, 1000);
