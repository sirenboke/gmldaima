with (gml_Script_instance_create(irandom_range(x, 1500), room_height - 300, obj_thunderSummon))
{
    dmg = other.dmg;
    player = other.player;
    tier = other.tier;
    level = other.level;
}

alarm[0] = spd;
