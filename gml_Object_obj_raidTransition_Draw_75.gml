draw_set_font(f_mid);
draw_sprite_ext(spr_black, 0, 0, 0, room_width, room_height, 0, c_white, alpha);
draw_sprite_ext(spr_black, 0, 0, room_height - 260, room_width, 260, 0, c_white, alpha);
draw_set_halign(fa_center);
var _width1 = string_width(randQuote);
draw_set_font(f_big);
var _width2 = string_width("Traveling to '" + string(text1) + "'...");
var _width = max(_width1, _width2) + 40;
draw_set_font(f_mid);
draw_sprite_ext(spr_black, 0, 0, (room_height / 2) - 50, room_width, 130, 0, c_white, 0.8);
gml_Script_scr_textoutline(room_width / 2, (room_height / 2) + 40, string(randQuote), 65535, 0, 20, 2000);
draw_set_font(f_big);
gml_Script_scr_textoutline(room_width / 2, room_height / 2, "Traveling to '" + string(text1) + "'...", 16777215, 0, 20, 2000);

if (in == false)
{
    draw_set_font(f_big);
    gml_Script_scr_textoutline(room_width / 2, room_height - 150, string(text1), c1, 0, 20, 2000);
    draw_set_font(f_mid);
    gml_Script_scr_textoutline(room_width / 2, (room_height - 150) + 50, string(text2), 16777215, 0, 20, 2000);
}
