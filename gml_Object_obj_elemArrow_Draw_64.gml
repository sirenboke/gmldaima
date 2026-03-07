if (instance_exists(player))
{
    if (player.class == "archer")
        draw_self();
}

if (image_index == 1)
{
    if (surface_exists(global.raidFog))
    {
        surface_set_target(global.raidFog);
        gml_Script_draw_set_blend_mode(bm_subtract);
        draw_ellipse_colour((x + 14) - 15, y - 15, x + 14 + 15, y + 15, c_lime, c_black, 0);
        gml_Script_draw_set_blend_mode(bm_normal);
        surface_reset_target();
    }
}

if (image_index == 2)
{
    if (surface_exists(global.raidFog))
    {
        surface_set_target(global.raidFog);
        gml_Script_draw_set_blend_mode(bm_subtract);
        draw_ellipse_colour((x + 14) - 15, y - 15, x + 14 + 15, y + 15, c_orange, c_black, 0);
        gml_Script_draw_set_blend_mode(bm_normal);
        surface_reset_target();
    }
}
