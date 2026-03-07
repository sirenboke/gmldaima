if (y < (room_height - 30))
{
    motion_set(direction, spd);
    yy *= 1.1;
    direction -= yy;
}
else
{
    speed = 0;
    spd = 0;
}

image_angle = direction;
