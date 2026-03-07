draw_set_font(f_mid);
draw_set_valign(fa_middle);
draw_set_halign(fa_left);
draw_sprite_ext(spr_black, 0, 0, 80, string_width("(F2) Console: " + string(msg)) + 30, 30, 0, c_white, 0.5);
gml_Script_scr_textshadow(10, 90, "(F2) Console: " + string(msg + cursor), 16777215, 0, 20, 1000);
