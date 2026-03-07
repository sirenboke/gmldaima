if (instance_exists(target))
{
    if (surface_exists(global.raidFog))
    {
        surface_set_target(global.raidFog);
        gml_Script_draw_set_blend_mode(bm_subtract);
        part_emitter_region(global.over_partsys, global.burn_partemitter, x - (target.length / (3 - (totalstacks / 20))) - global.partBgPos, (x + (target.length / (3 - (totalstacks / 20)))) - global.partBgPos, y - (target.height / (3 - (totalstacks / 20))), y + (target.height / (3 - (totalstacks / 20))), 1, 1);
        part_emitter_burst(global.over_partsys, global.burn_partemitter, global.burn_part, 1 + (totalstacks / 2));
        draw_ellipse_colour((x + 14) - 15, y - 15, x + 14 + 15, y + 15, c_orange, c_black, 0);
        gml_Script_draw_set_blend_mode(bm_normal);
        surface_reset_target();
    }
}
