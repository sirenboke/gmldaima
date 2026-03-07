if (instance_exists(obj_enemy))
{
    with (instance_nearest(x, y, obj_enemy))
    {
        if (distance_to_object(other) <= other.rng)
            other.drawtarget = id;
        else
            other.drawtarget = -4;
    }
    
    if (drawtarget != -4)
    {
        if (instance_exists(drawtarget))
        {
            targetx = drawtarget.x;
            targety = drawtarget.y;
            targetheight = drawtarget.height / 2;
            distance = distance_to_point(targetx, targety - (drawtarget.height / 2));
        }
        
        draw_sprite_ext(spr_circlebar, 0, xx, yy, image_yscale, image_yscale, point_direction(xx, yy, targetx, targety - targetheight), c_red, alpha);
        draw_sprite_ext(spr_circlebar, 0, targetx, targety - targetheight, image_yscale, image_yscale, point_direction(xx, yy, targetx, targety - targetheight), c_red, alpha);
        draw_sprite_ext(spr_xpbar, 0, xx, yy, distance, image_yscale, point_direction(xx, yy, targetx, targety - targetheight), c_red, alpha);
    }
    
    if (distance_to_object(target) <= rng)
    {
        if (alarm[1] > 1)
        {
            if (instance_exists(target))
            {
                targetx = target.x;
                targety = target.y;
                targetheight = target.height / 2;
                distance = distance_to_point(targetx, targety - (target.height / 2));
            }
            else
            {
            }
        }
    }
}

if (alarm[1] == -1)
{
    alpha -= 0.05;
    image_yscale *= 0.9;
}

if (alpha <= 0)
    instance_destroy();

if (instance_exists(player))
{
    if (instance_exists(player.myWarrior))
    {
        xx = player.myWarrior.x + 49;
        yy = player.myWarrior.y - player.myWarrior.height - 14;
    }
    else
    {
        instance_destroy();
    }
}
