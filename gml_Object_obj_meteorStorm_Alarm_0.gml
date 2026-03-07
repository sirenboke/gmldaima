with (gml_Script_instance_create(irandom_range(x + 300, 1800), room_height - 280, obj_meteor))
{
    dmg = other.dmg;
    player = other.player;
    duration = other.duration;
    fireStacks = other.fireStacks;
    expand = other.expand;
    slow = other.slow;
}

alarm[0] = spd;
