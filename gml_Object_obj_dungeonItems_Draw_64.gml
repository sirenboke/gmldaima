draw_self();

if (sprite_index == spr_dungeonLight)
{
    if (surface_exists(global.raidFog))
    {
        surface_set_target(global.raidFog);
        gml_Script_draw_set_blend_mode(bm_subtract);
        draw_ellipse_colour(x - 200, y - sprite_height - 240, x + 150, (y - sprite_height) + 100, c_orange, c_black, 0);
        draw_ellipse_colour(x - 150, y - sprite_height - 240, x + 200, (y - sprite_height) + 100, c_orange, c_black, 0);
        gml_Script_draw_set_blend_mode(bm_normal);
        surface_reset_target();
    }
}
