draw_sprite_ext(spr_kenjiExplosion, 0, x, y, 3.5, 2, 0, c_yellow, alpha);
image += 0.5;

if (alarm[0] < room_speed)
    alpha -= 0.02;

if (surface_exists(global.raidFog))
{
    surface_set_target(global.raidFog);
    gml_Script_draw_set_blend_mode(bm_subtract);
    
    if (alpha >= 0.4)
    {
        part_emitter_region(global.over_partsys, global.blessing_partemitter, x - 170 - global.partBgPos, (x + 170) - global.partBgPos, y, y - 50, 1, 2);
        part_emitter_stream(global.over_partsys, global.blessing_partemitter, global.blessing_part, 1.5);
    }
    
    draw_ellipse_colour(x - 185, y - 15, x + 185, y + 15, c_white, c_black, 0);
    gml_Script_draw_set_blend_mode(bm_normal);
    surface_reset_target();
}
