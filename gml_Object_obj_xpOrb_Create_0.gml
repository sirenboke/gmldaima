event_inherited();
alarm[0] = room_speed * 3;
alarm[1] = room_speed * 6;
grav = random_range(0.3, 1) * global.roomSpeed;
ograv = grav;
dir = random_range(-0.2, 0.2) * global.roomSpeed;
image_xscale = 2;
image_yscale = 2;
image_speed = 0.2 * global.roomSpeed;
image_index = irandom_range(0, image_number);
used = false;

if (instance_exists(obj_warrior))
{
    goto = choose(global.xpGoto[0], global.xpGoto[1]);
    
    if (goto == -2)
        goto = instance_nearest(x, y, obj_warrior);
}
else
{
    goto = obj_build_farm;
    instance_destroy();
}
