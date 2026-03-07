if (instance_exists(target))
{
    if (surface_exists(global.raidFog))
    {
        surface_set_target(global.raidFog);
        gml_Script_draw_set_blend_mode(bm_subtract);
        draw_ellipse_colour(x - 15, y - 15, x + 15, y + 15, c_aqua, c_black, 0);
        gml_Script_draw_set_blend_mode(bm_normal);
        surface_reset_target();
    }
}
else
{
    instance_destroy();
}
