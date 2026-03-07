event_inherited();
bgSpd = 0;
alarm[0] = room_speed * 1.5;
scale = 0;
alpha = 0.9;
goto = -4;
trigger = false;
angle = irandom(359);
x = irandom_range(600, room_width - 300);

with (instance_create_depth(x, y, depth - 1, obj_raidAnimation))
{
    sprite_index = spr_frostNova;
    image_angle = irandom(359);
    spd = room_speed;
    follow = other;
}
