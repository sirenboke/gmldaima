if (instance_number(obj_mist) < 50)
    gml_Script_instance_create(random_range(room_width + 200, room_width * 2), random_range(room_height - 200, room_height - 30), obj_mist);

alarm[0] = 10 * room_speed;
