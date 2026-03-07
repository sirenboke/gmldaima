event_inherited();
bgSpd /= 2;
image_speed = 0;
image_xscale = 2;
image_yscale = 2;
move_towards_point(x + 1, y + random_range(-0.02, 0.02), 60);
image_angle = direction;
gml_Script_scr_playsound(s_arrow1, 1, 1.2, 0.5);
alarm[2] = room_speed * 2;
