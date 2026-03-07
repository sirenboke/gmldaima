event_inherited();
alarm[0] = room_speed;
grav = 0.7 * global.roomSpeed;
ograv = grav;
dir = random_range(-0.2, 0.2) * global.roomSpeed;
image_speed = 0.2 * global.roomSpeed;
image_index = irandom_range(0, image_number);

if (instance_exists(obj_warrior))
{
    with (obj_warrior)
    {
        if (myRaidNumber == 0)
            other.goto = id;
    }
}
else
{
    goto = obj_gameControl;
    instance_destroy();
}

value = 1 + (global.stage / 10);
used = false;
