image_xscale = 2;
image_yscale = 2;
check = room_speed * 10;
alarm[0] = room_speed * 60;
sprite_index = choose(spr_barrels, spr_dungeonDoor, spr_dungeonLight);
image_index = irandom(image_number - 1);
image_speed = 0;
y = room_height - 40;
bgSpd = 0.5 * global.roomSpeed;

if (sprite_index == spr_dungeonDoor || sprite_index == spr_dungeonLight)
{
    depth = 9;
    bgSpd = 0.4 * global.roomSpeed;
    image_speed = random_range(0.0001, 0.01);
}

if (sprite_index == spr_box || sprite_index == spr_barrels)
{
    depth = choose(3, -3);
    
    if (depth == 3)
        bgSpd = 0.5 * global.roomSpeed;
    
    if (depth == -3)
    {
        bgSpd = 0.7 * global.roomSpeed;
        y += 50;
    }
}

image_xscale = choose(-2, 2);
