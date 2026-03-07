event_inherited();
alarm[1] = 1;
image_speed = 0;
image_index = 0;

if (!variable_instance_exists(id, "spd"))
    spd = room_speed;

color = 16777215;

if (!variable_instance_exists(id, "alpha"))
    alpha = 1;

fade = false;

if (!variable_instance_exists(id, "fadeSpeed"))
    fadeSpeed = 0.9;

follow = -1;
dmg = 0;
player = -1;
