parent = instance_nearest(x, y, obj_enemy);

if (instance_exists(obj_warrior))
{
    target = instance_nearest(x, y, obj_warrior);
    yy = random_range(target.y - (target.height / 3), target.y - (target.height / 1.5));
}
else
{
    instance_destroy();
}

alarm[0] = room_speed / 4;
