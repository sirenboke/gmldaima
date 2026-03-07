if (!variable_instance_exists(id, "duration"))
    duration = 3;

if (!variable_instance_exists(id, "bleedHealReduction"))
    bleedHealReduction = 0.9;

if (instance_exists(target))
    duration *= target.myResistance[1][1];

duration *= room_speed;

if (duration < 1)
    duration = 1;

bleedTimerMax = duration;
alarm[0] = 1;
alarm[1] = duration;
alarm[2] = room_speed / 5;
image_xscale = 2;
image_yscale = 2;
image_index = 0;
image_speed = 1;
show_debug_message("Hemorrhage ID: " + string(id));
