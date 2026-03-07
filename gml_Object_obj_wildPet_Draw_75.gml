draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, 0, c_pet, 1);
draw_set_font(f_special);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
gml_Script_scr_textshadow(x, y - sprite_height, string(word), 16777215, 0, 20, 300);
gml_Script_scr_textshadow(x, y - sprite_height - 20, string(_playerName), 16777215, 0, 20, 300);
