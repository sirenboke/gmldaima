if (sprite != spr_arrow)
    draw_sprite_ext(sprite, i_index, x, y, image_xscale, image_yscale, image_angle, sprite_color, 1);
else
    draw_self();

i_index += 0.5;

if (i_index > 4)
    i_index = 2;

if (sprite == spr_arrow)
{
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
}
else if (surface_exists(global.raidFog))
{
    surface_set_target(global.raidFog);
    gml_Script_draw_set_blend_mode(bm_subtract);
    draw_ellipse_colour(x - 25, y - 15, x + 25, y + 15, sprite_color, c_black, 0);
    gml_Script_draw_set_blend_mode(bm_normal);
    surface_reset_target();
}
