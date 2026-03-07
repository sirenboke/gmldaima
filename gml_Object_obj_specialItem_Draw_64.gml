draw_self();

if (alarm[1] == -1 && image_xscale == 1.5)
{
    draw_set_font(f_special);
    draw_set_halign(fa_center);
    draw_set_valign(fa_top);
    gml_Script_scr_textoutline(x, y + (sprite_height / 2), string(description), 4235519, 0, 20, 500);
    gml_Script_scr_textoutline(x, y - (sprite_height / 2) - 20, string(name) + " (lv." + string(level) + ") (" + string(class) + ")", 4235519, 0, 20, 400);
}
