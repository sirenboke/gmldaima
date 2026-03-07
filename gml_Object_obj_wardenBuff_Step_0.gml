if (instance_exists(player))
{
    x = player.x;
    y -= 1;
}

alpha -= 0.01;

if (alpha <= 0)
    instance_destroy();
