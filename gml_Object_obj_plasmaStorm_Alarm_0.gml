with (gml_Script_instance_create(irandom_range(x, 1500), room_height - 260, obj_plasmaSummon))
{
    dmg = other.dmg;
    player = other.player;
    bounceRange = other.bounceRange;
    zapChance = other.zapChance;
    alarm[1] = other.duration;
    depth = other.depth;
}

alarm[0] = spd;
