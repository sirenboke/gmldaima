if (!variable_instance_exists(id, "duration"))
    duration = room_speed * 5;
else
    duration *= room_speed;

if (variable_instance_exists(id, "warrior"))
{
    if (instance_exists(warrior))
    {
        if (variable_instance_exists(warrior, "statusDurationBonus"))
            duration *= warrior.statusDurationBonus;
        
        show_debug_message("Duration extended by Relic 20");
    }
}

if (instance_exists(target))
    duration *= target.myResistance[1][1];

if (duration <= 0)
{
    instance_destroy();
    exit;
}

if (duration < 1)
    duration = 1;

maxStacks = 10;
alarm[0] = 1;
alarm[2] = room_speed / 5;
image_xscale = 2;
image_yscale = 2;
image_index = 0;
image_speed = 0.2;
