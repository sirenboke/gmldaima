if (part_particles_count(global.smokebomb_partsys) < 5)
{
    part_emitter_region(global.smokebomb_partsys, global.smokebomb_partemitter, x - 5, x + 5, y - 20, y, 0, 1);
    part_emitter_burst(global.smokebomb_partsys, global.smokebomb_partemitter, global.smokebomb_part, 1);
}

if (poison == true)
{
    part_emitter_region(global.smokebomb_partsys, global.poisonbomb_partemitter, x, x + 300, room_height - 100, room_height, 0, 1);
    part_emitter_burst(global.smokebomb_partsys, global.poisonbomb_partemitter, global.poisonbomb_part, 1);
}
