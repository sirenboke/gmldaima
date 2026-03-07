event_inherited();
image_index = 2;
image_xscale = 0.5;
image_yscale = 0.5;
alarm[0] = random_range(room_speed * 1.5, room_speed * 4);
value = choose(1, 2);
status = 1;
grav = random_range(1, 1.4) * global.roomSpeed;
ograv = grav;
dir = random_range(-0.4, 0.4) * global.roomSpeed;
onlyVisual = true;
image_speed = 0;
image_index = 2;

with (obj_warrior)
{
    if (myRaidNumber == 0)
        other.goto = id;
}
