if (instance_exists(target))
{
    if (alarm[2] <= 3)
    {
        part_emitter_region(global.over_partsys, global.poison_partemitter, x - (target.length / 3) - global.partBgPos, (x + (target.length / 3)) - global.partBgPos, y - (target.height / 3), y + (target.height / 3), 1, 0);
        part_emitter_burst(global.over_partsys, global.poison_partemitter, global.poison_part, 1 + (totalStacks / 30));
    }
    
    if (surface_exists(global.raidFog))
    {
        surface_set_target(global.raidFog);
        gml_Script_draw_set_blend_mode(bm_subtract);
        draw_ellipse_colour((x + 14) - 15, y - 15, x + 14 + 15, y + 15, c_lime, c_black, 0);
        gml_Script_draw_set_blend_mode(bm_normal);
        surface_reset_target();
    }
}
else
{
    instance_destroy();
}
