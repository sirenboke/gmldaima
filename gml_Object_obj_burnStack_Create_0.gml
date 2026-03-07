alarm[0] = 1;

if (!variable_instance_exists(id, "duration"))
    duration = room_speed;
else
    duration *= room_speed;

if (variable_instance_exists(id, "warrior"))
{
    if (instance_exists(warrior))
    {
        if (variable_instance_exists(warrior, "statusDurationBonus"))
            duration *= warrior.statusDurationBonus;
    }
}

if (instance_exists(target))
    duration *= target.myResistance[2][1];

if (duration <= 0 || !variable_instance_exists(id, "player") || !variable_instance_exists(id, "target"))
{
    instance_destroy();
    exit;
}

if (duration < 1)
    duration = 1;

alarm[1] = duration;
alarm[2] = room_speed / 5;
image_xscale = 2;
image_yscale = 2;
image_index = 0;
image_speed = 0.2;
totalstacks = 0;
dmg *= fireStacks;
