draw_sprite(spr_header, 0, room_width / 2, 200);
draw_set_font(f_mid);

if (!instance_exists(obj_continue))
    gml_Script_scr_textshadow(room_width / 2, 1000, "Press 'F2' to play offline (single player)", 12632256, 0, 20, 600);

draw_sprite_ext(sprite_index, 0, x, y, 1, 1, 0, c_white, 1);
draw_set_font(f_big);
draw_set_valign(fa_middle);
draw_set_halign(fa_center);
gml_Script_scr_textshadow(x, y, text, 16777215, 0, 20, 200);
var _version = string_insert(".", global.gameVersion, 2);
_version = string_insert(".", _version, 4);
gml_Script_scr_textshadow(room_width / 2, (room_height / 2) - 220, "alpha build v" + string(_version), undefined, undefined, undefined, undefined, 0.5);
