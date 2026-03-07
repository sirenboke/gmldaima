event_inherited();
alarm[0] = random_range(room_speed * 1.5, room_speed * 4);
value = irandom_range(20, 50) + irandom_range(global.stage, global.stage * 3);
grav = random_range(1, 1.4) * global.roomSpeed;
ograv = grav;
dir = random_range(-0.4, 0.4) * global.roomSpeed;
onlyVisual = true;
status = 1;
image_speed = 0;
image_index = irandom_range(0, image_number);

with (obj_warrior)
{
    if (myRaidNumber == 0)
        other.goto = id;
}
