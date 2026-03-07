draw_self();

if (on == true)
{
    sprite_index = spr_torch;
    
    if (surface_exists(global.townFog))
    {
        surface_set_target(global.townFog);
        gml_Script_draw_set_blend_mode(bm_subtract);
        draw_ellipse_colour(x - (lightsize / 2), y - (lightsize / 2), x + (lightsize / 2), y + (lightsize / 2), c_orange, c_black, 0);
        gml_Script_draw_set_blend_mode(bm_normal);
        surface_reset_target();
    }
}
else
{
    sprite_index = spr_torch_off;
    draw_self();
}
