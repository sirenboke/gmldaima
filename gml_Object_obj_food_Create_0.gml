goto = instance_nearest(x, y, obj_player);
alarm[0] = room_speed;
grav = 0.9 * global.roomSpeed;
dir = random_range(-0.2, 0.2) * global.roomSpeed;
image_speed = 0;
image_index = irandom_range(0, image_number);
