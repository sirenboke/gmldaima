if (gml_Script_live_call())
    return global.live_result;

draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_font(f_mid);
draw_sprite_ext(spr_building, 0, x + 150, y, 5.5, 3, 0, c_white, 1);
var c_souls = 16776960;
var c_cost = 16776960;

if (global.souls < (global.recipeMax - global.recipeProgress))
    c_souls = 4235519;

if (global.souls < cost)
    c_cost = 4235519;

gml_Script_scr_textoutline(x + 150, y - 20, string(global.cmdPrefix) + "upg witch (lv." + string(level) + ")", 16777215, 0, 20, 500);
gml_Script_scr_textoutline(x + 150, y, string(costText), c_cost, 0, 20, 500);
gml_Script_scr_textoutline(x + 150, y + 20, "Souls obtained:", 16777215, 0, 20, 500);
gml_Script_scr_textoutline(x + 150, y + 40, "+" + string(round((global.soulBonus - 1) * 100)) + "%", 16777215, 0, 20, 500);

if (level >= 2)
{
    draw_sprite_ext(spr_black, 0, x - 220, y - 40, 240, 105, 0, c_white, 0.6);
    var _gemStat = "";
    
    if (floor(gemDisplay) == 1)
        _gemStat = "constitution";
    
    if (floor(gemDisplay) == 2)
        _gemStat = "strength";
    
    if (floor(gemDisplay) == 3)
        _gemStat = "intelligence";
    
    if (floor(gemDisplay) == 4)
        _gemStat = "physical resistance";
    
    if (floor(gemDisplay) == 5)
        _gemStat = "special resistance";
    
    if (floor(gemDisplay) == 6)
        _gemStat = "status resistance";
    
    var _spr_gemDisplay = asset_get_index("spr_itemGem_" + string(floor(gemDisplay)));
    
    if (displayTab == 0)
    {
        gml_Script_scr_textoutline(x - 100, y - 20, string(global.cmdPrefix) + "craftgemstone (type):(size)", 16777215, 0, 20, 500);
        draw_set_font(f_special);
        gml_Script_scr_textoutline(x - 100, y, "Type: " + string(floor(gemDisplay)) + " (" + string(_gemStat) + ")", 16777215, 0, 20, 500);
        gml_Script_scr_textoutline(x - 160, y + 50, "Size:", 16777215, 0, 20, 500);
        
        for (var i = 1; i <= 3; i++)
        {
            draw_sprite_ext(_spr_gemDisplay, i, (x - 100 - 30) + (30 * (i - 1)), y + 30, 2, 2, 0, c_white, 1);
            gml_Script_scr_textoutline((x - 100 - 30) + (30 * (i - 1)), y + 50, string(i), 16777215, 0, 20, 500);
        }
    }
    else
    {
        gml_Script_scr_textoutline(x - 100, y - 20, string(global.cmdPrefix) + "setgemstone (type):(item)", 16777215, 0, 20, 500);
        draw_set_font(f_special);
        gml_Script_scr_textoutline(x - 100, y, "Type: " + string(floor(gemDisplay)) + " (" + string(_gemStat) + ")", 16777215, 0, 20, 500);
        draw_sprite_ext(_spr_gemDisplay, 3, x - 100, y + 30, 2, 2, 0, c_white, 1);
        gml_Script_scr_textoutline(x - 100, y + 50, "Item: Academy's #", 16777215, 0, 20, 200);
    }
}
else
{
    draw_sprite_ext(spr_black, 0, x - 200, y - 20, 200, 65, 0, c_white, 0.6);
    gml_Script_scr_textoutline(x - 100, y, "Gemstone Cutting", 16777215, 0, 20, 500);
    gml_Script_scr_textoutline(x - 100, y + 20, "(unlocked at lv.2)", 255, 0, 20, 500);
}

if (alarm[0] == -1)
{
    gml_Script_scr_textoutline(x + 50, y + 40, string(global.cmdPrefix) + "sacrifice#", 16777215, 0, 20, 500);
    gml_Script_scr_textoutline(x + 50, y + 20, string(round((global.recipeProgress / global.recipeMax) * 100)) + "%", 255, 0, 20, 500);
    draw_set_font(f_special);
    gml_Script_scr_textoutline(x + 50, y + 55, "(" + gml_Script_scr_bigNumber(global.recipeMax - global.recipeProgress) + " left)", c_souls, 0, 20, 500);
    draw_set_font(f_mid);
}
else
{
    gml_Script_scr_textoutline(x + 50, y + 55, "(Active for " + gml_Script_scr_formatTimer(alarm[0]) + ")", 16777215, 0, 20, 500);
    gml_Script_scr_textoutline(x + 50, y + 40, string(global.cmdPrefix) + "enchant #*#", 65280, 0, 20, 500);
}
