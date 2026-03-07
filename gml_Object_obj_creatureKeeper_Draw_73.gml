draw_set_font(f_mid);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
gml_Script_scr_textoutline(x, y - 70, string(global.cmdPrefix) + "creature keeper", 16777215, 0, 20, 500);

if (cost <= global.maxGold)
{
    if (cost <= global.gold)
        c_cost = 65535;
    else
        c_cost = 4235519;
}
else
{
    c_cost = 255;
}

if (global.townLevel >= levelCost)
    gml_Script_scr_textoutline(x, y - 50, gml_Script_scr_bigNumber(cost), c_cost, 0, 20, 500);
else
    gml_Script_scr_textoutline(x, y - 50, "Need Town Level " + string(levelCost), 255, 0, 20, 500);
