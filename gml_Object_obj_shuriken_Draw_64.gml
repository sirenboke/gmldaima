draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, angle, c_white, 1);

if (image_index == 1)
{
    if (obj_fog.light > 100)
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
}

if (image_index == 2)
{
    if (obj_fog.light > 100)
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
}
