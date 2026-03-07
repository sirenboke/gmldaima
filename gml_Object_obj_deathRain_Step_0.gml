if (instance_exists(obj_warrior) && !instance_exists(obj_cinematic))
{
    global.rainDmg += (((global.rainDmg * 1.1) - global.rainDmg) / room_speed);
    global.rainArmor += (((global.rainArmor * 1.01) - global.rainArmor) / room_speed);
}

if (global.rainDmg < 10000000)
    rainParticles = 10 + (global.rainDmg / 100000);
else
    rainParticles = 110;

part_emitter_region(global.over_partsys, global.deathrainpart_emitter, 0 - global.partBgPos, room_width - global.partBgPos, room_height - 250, room_height - 250, 1, 0);
part_emitter_stream(global.over_partsys, global.deathrainpart_emitter, global.rainpart, rainParticles);

with (obj_warrior)
{
    if (myRaidNumber == 0)
    {
        if (alarm[5] == -1)
            alarm[5] = room_speed;
    }
}
