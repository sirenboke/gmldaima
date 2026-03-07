if (alarm[1] == -1)
{
    if (y <= (room_height - 300) && y > 100)
    {
        draw_set_font(f_small);
        draw_set_halign(fa_center);
        gml_Script_scr_textgradient(x, y, text, c1, c2);
    }
}
