if (instance_exists(target))
{
    x = target.x;
    y = target.y;
}
else
{
    if (instance_exists(player))
        player.alarm[2] = 1;
    
    instance_destroy();
}
