if (alarm[0] > -1)
{
    y -= grav;
    grav -= (0.01 * global.roomSpeed * global.roomSpeed);
    x += dir;
}
else
{
    if (distance_to_point(gotoX, gotoY) <= 4)
    {
        x = gotoX;
        y = gotoY;
    }
    else
    {
        move_towards_point(gotoX, gotoY, 4);
    }
    
    if (image_xscale < 1.5)
    {
        image_xscale += 0.05;
        image_yscale += 0.05;
    }
    else
    {
        image_xscale = 1.5;
    }
}
