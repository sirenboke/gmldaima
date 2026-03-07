with (gml_Script_instance_create(irandom_range(x + 300, 1800), room_height - 280, obj_meteor))
{
    dmg = other.dmg;
    player = -1;
    duration = other.duration;
    fireStacks = 1;
    expand = other.expand;
    slow = other.slow;
    challenge = true;
}

alarm[0] = spd;
