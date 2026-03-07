if (instance_exists(target))
{
    x = target.x;
    y = target.y - (target.height / 2);
    target.burnTimer = alarm[1];
    
    if (alarm[0] == -1 && target.burnStacks <= 0)
        instance_destroy();
}
