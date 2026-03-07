sprite_index = obj_bossKey.spr_key;
depth = obj_bossKey.depth - 1;
image_speed = 0;
image_index = global.keyFrags;
event_inherited();
alarm[0] = room_speed;
grav = 1 * global.roomSpeed;
dir = random_range(-0.2, 0.2) * global.roomSpeed;
locked = false;
