draw_set_font(f_mid);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
gml_Script_scr_textoutline(x, y - 70, string(global.cmdPrefix) + "shop", 16777215, 0, 20, 100);

if (shopCost <= global.maxGold)
{
    if (shopCost <= global.gold)
        c_cost = 65535;
    else
        c_cost = 4235519;
}
else
{
    c_cost = 255;
}

if (global.townLevel >= levelCost)
    gml_Script_scr_textoutline(x, y - 50, "2,500g", c_cost, 0, 20, 100);
else
    gml_Script_scr_textoutline(x, y - 50, "Need Town Level " + string(levelCost), 255, 0, 20, 500);
