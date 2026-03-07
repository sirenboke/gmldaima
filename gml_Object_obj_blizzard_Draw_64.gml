if (alarm[2] == -1)
{
    if (part_particles_count(global.snow_partsys) < 300)
    {
        part_emitter_region(global.snow_partsys, global.blizzard_partemitter, x, x + 800, room_height - 280, room_height - 220, 1, 0);
        part_emitter_burst(global.snow_partsys, global.blizzard_partemitter, global.blizzard_part, 10);
    }
    
    if (part_particles_count(global.blizzard_partsys) < 4)
    {
        part_emitter_region(global.blizzard_partsys, global.blizzardSmoke_partemitter, x + 100, x + 900, room_height - 60, room_height - 20, 1, 0);
        part_emitter_burst(global.blizzard_partsys, global.blizzardSmoke_partemitter, global.blizzardSmoke_part, 1);
    }
}
