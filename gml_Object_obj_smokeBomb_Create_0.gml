image_speed = image_number / (room_speed / 2);
poison = false;
part_emitter_region(global.smokebomb_partsys, global.smokebomb_partemitter, x, x, y, y, 0, 1);
part_emitter_burst(global.smokebomb_partsys, global.smokebomb_partemitter, global.smokebomb_part, 3);
