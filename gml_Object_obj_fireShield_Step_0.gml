if (instance_exists(player))
{
    x = player.x;
    y = player.y - (player.height / 2);
}
else
{
    alarm[0] = 1;
}
