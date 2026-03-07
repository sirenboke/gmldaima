draw_set_font(f_mid);
draw_set_halign(fa_center);

if (transparent == false)
    draw_sprite_ext(spr_black, 0, 0, 0, room_width, room_height, 0, c_white, alpha);

if (blank == false)
{
    draw_sprite_ext(spr_building, 0, room_width / 2, (room_height / 2) + 20, (20 + string_width(string_hash_to_newline(randQuote))) / 32, 3, 0, c_white, 1);
    gml_Script_scr_textoutline(room_width / 2, (room_height / 2) + 40, string(randQuote), 65535, 0, 20, 2000);
    draw_set_font(f_big);
    gml_Script_scr_textoutline(room_width / 2, room_height / 2, "Campaign #" + string(global.season), 16777215, 0, 20, 2000);
}

if (alarm[0] == -1)
{
    if (alpha > 0)
        alpha -= 0.006;
    else
        alpha = 0;
}

if (alarm[1] == -1)
    instance_destroy();
