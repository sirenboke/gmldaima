draw_set_font(f_mid);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
gml_Script_scr_textoutline(x, y - 40, "Building...", 16777215, 0, 20, 100);
draw_sprite_ext(spr_blackbar, 0, x - 30, y - 20, 60, 1.2, 0, c_white, 1);
draw_sprite_ext(spr_hpbar, 0, x - 29, y - 20, 58 - ((alarm[0] / room_speed / timer) * 58), 1, 0, c_white, 1);
