draw_set_font(f_big);
draw_set_halign(fa_center);
var _text1 = string_width(string(text1));
draw_set_font(f_mid);
var _text2 = string_width(string(text2));
var _text3 = string_width(string(text3));
width = max(_text1, _text2, _text3) + 40;
draw_set_font(f_big);
draw_sprite_ext(spr_black, 0, 0, 0, room_width - 500, room_height - 300, 0, c_white, alpha);
draw_sprite_ext(spr_black, 0, ((room_width - 500) / 2) - (width / 2), ((room_height - 600) / 2) + 20, width, 150, 0, c_white, 0.5);
gml_Script_scr_textoutline((room_width - 500) / 2, (room_height - 500) / 2, string(text1), c1, 0, 20, 2000);
draw_set_font(f_mid);
gml_Script_scr_textoutline((room_width - 500) / 2, ((room_height - 500) / 2) + 50, string(text2), 16777215, 0, 20, 2000);
gml_Script_scr_textoutline((room_width - 500) / 2, ((room_height - 500) / 2) + 80, string(text3), 16777215, 0, 20, 2000);

if (alarm[0] == -1)
{
    if (alpha > 0)
        alpha -= 0.003;
    else
        instance_destroy();
}
