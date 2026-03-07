draw_sprite_ext(sprite_index, image_index + 1, x, y, xscale + 1, 2.5, 0, c_white, alpha2);
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, 0, c_white, alpha);
size += expand;

if (surface_exists(global.raidFog))
{
    surface_set_target(global.raidFog);
    gml_Script_draw_set_blend_mode(bm_subtract);
    
    if (alpha2 >= 0.5 || alarm[0] > (room_speed / 2))
    {
        part_emitter_region(global.over_partsys, global.burn_partemitter, x - size - global.partBgPos, (x + size) - global.partBgPos, y + 10, y + 18, 0, 0);
        part_emitter_burst(global.over_partsys, global.burn_partemitter, global.burn_part, size / 40);
        draw_ellipse_colour(x - (size + 10), y + 6, x + (size + 10), y + 22, c_orange, c_black, 0);
    }
    
    gml_Script_draw_set_blend_mode(bm_normal);
    surface_reset_target();
}
