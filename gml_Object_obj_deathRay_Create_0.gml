alarm[0] = room_speed / 5;
alpha = 0.9;
move = choose(-1, 1);
lastTarget = -4;
target = -4;
drawtarget = -4;
multiplier = 1;
distance = 0;
image_speed = 0;
image_index = irandom(image_number - 1);
image_xscale = choose(-1, 1);

if (instance_exists(obj_enemy))
{
    with (instance_nearest(x, y, obj_enemy))
        other.target = id;
}

lastTarget = target;
targetx = x;
targety = y;
targetheight = 0;
