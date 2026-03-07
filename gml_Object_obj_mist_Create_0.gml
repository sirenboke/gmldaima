event_inherited();
image_index = irandom(image_number - 1);
image_speed = 0;
bgSpd = 0.5 * global.roomSpeed;
spd = random_range(0.005, 0.1) * global.roomSpeed;
depth = irandom_range(2, -6);

if (depth < -4)
    bgSpd = 0.6 * global.roomSpeed;

if (depth >= -4)
    bgSpd = 0.5 * global.roomSpeed;

if (depth >= 0)
    bgSpd = 0.4 * global.roomSpeed;

image_alpha = 0.5;
alarm[0] = 10 * room_speed;
