if (global.raiding == false)
{
    draw_set_font(f_special);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_sprite_ext(spr_black, 0, 0, room_height - 35, string_width(text) + 30, 35, 0, c_white, 0.8);
    gml_Script_scr_textoutline(10, room_height - 30, string(text), 16777215, 0, 20, 1920);
}
