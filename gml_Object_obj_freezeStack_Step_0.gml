if (instance_exists(target))
{
    x = target.x;
    y = target.y - (target.height / 2);
    
    if (alarm[0] == -1 && target.freezeStacks <= 0)
        instance_destroy();
}
