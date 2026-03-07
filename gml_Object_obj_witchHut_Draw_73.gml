if (global.unlockWitch == true)
{
    draw_set_font(f_mid);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    gml_Script_scr_textoutline(x - 65, y - 20, string(global.cmdPrefix) + "magic", 16777215, 0, 20, 500);
}
