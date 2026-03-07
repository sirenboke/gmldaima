if (instance_exists(player))
{
    depth = player.depth - 1;
    motion_add(point_direction(x, y, player.x - 15, player.y - 50), 0.1 * global.roomSpeed);
    
    if (speed > 5)
        speed = 5;
}
else
{
    instance_destroy();
}
