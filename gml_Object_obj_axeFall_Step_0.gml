if (y < (room_height - 30))
{
    motion_set(point_direction(x, y, x + 1, y + yy), spd);
    image_angle -= 30;
    yy *= 1.2;
}
else
{
    speed = 0;
    image_angle = -35;
}
