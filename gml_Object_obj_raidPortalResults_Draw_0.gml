if (room == r_underworld)
{
    if (result == 0)
    {
        c1 = 65280;
        c2 = 32768;
        text1 = "Floor " + string(0 - (global.portalStage - 1)) + " cleared!";
    }
    else
    {
        c1 = 255;
        c2 = 128;
        text1 = "You died on floor " + string(0 - (global.portalStage - 1)) + "...";
    }
}

if (room == r_underworld_new)
{
    if (result == 0)
    {
        c1 = 65280;
        c2 = 32768;
        text1 = "Tower " + string(global.portalTower) + ", Floor " + string(global.portalFloor) + " cleared!";
    }
    else
    {
        c1 = 255;
        c2 = 128;
        text1 = "You died on Tower " + string(global.portalTower) + ", Floor " + string(global.portalFloor) + "...";
    }
}

draw_set_valign(fa_top);
draw_set_halign(fa_center);
draw_set_alpha(0.5);
draw_set_color(c_black);
draw_rectangle(x - 500, room_height - 300, x + 500, room_height, 0);
draw_set_alpha(1);

if (alarm[0] != -1)
{
    draw_set_font(f_big);
    gml_Script_scr_textoutlineBIG(room_width / 2, room_height - 230, string(text1), c1, 0, 20, 1620);
    draw_set_font(f_mid);
    gml_Script_scr_textoutlineBIG(room_width / 2, room_height - 20, "(" + string(round(alarm[0] / room_speed)) + "s)", 16777215, 0, 20, 1620);
}
