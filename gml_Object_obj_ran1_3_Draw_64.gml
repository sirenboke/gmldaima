if (alarm[1] == -1 || alarm[1] > (room_speed / 4))
{
    part_emitter_region(global.raidObject_partsys, global.arrows_partemitter, x - 150 - (sprite_width / 2) - global.partBgPos, ((x - 150) + (sprite_width / 2)) - global.partBgPos, room_height - 300, room_height - 260, 1, 0);
    part_emitter_burst(global.raidObject_partsys, global.arrows_partemitter, global.arrows_part, 14 / frequency);
}
