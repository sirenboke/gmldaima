if (instance_exists(target))
{
    x = target.x;
    y = target.y - (target.height / 2);
    image_xscale = (value / maxValue) * 2;
    image_yscale = (value / maxValue) * 2;
    
    if (value >= maxValue)
    {
        alarm[0] = 1;
        target.alarm[2] = 1;
    }
}
else
{
    alarm[0] = 1;
}
