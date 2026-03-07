draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, 0, c_white, alpha);

if (surface_exists(global.raidFog))
{
    surface_set_target(global.raidFog);
    gml_Script_draw_set_blend_mode(bm_subtract);
    gml_Script_draw_set_blend_mode(bm_normal);
    surface_reset_target();
}
