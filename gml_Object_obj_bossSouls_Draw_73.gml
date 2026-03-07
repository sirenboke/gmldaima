draw_self();
draw_set_font(f_mid);
draw_set_halign(fa_center);
gml_Script_scr_textoutline(x, y, string(global.bossSouls[value]), 16777215, 0, 20, 10000);

if (global.portalStage > value)
    gml_Script_scr_textoutline(x, y + 25, "Floor " + string(0 - value), 16777215, 0, 20, 10000);
else
    gml_Script_scr_textoutline(x, y + 25, "Floor " + string(0 - value), 8421504, 0, 20, 10000);

if (alarm[0] == -1 && global.bossSouls[value] > 0)
{
    gml_Script_scr_textoutline(x, y - 25, string(name), 255, 0, 20, 10000);
    image_index = value + 1;
}
else
{
    gml_Script_scr_textoutline(x, y - 25, "?????", 128, 0, 20, 10000);
    image_index = 0;
}
