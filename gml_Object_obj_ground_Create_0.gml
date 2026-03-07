bgSpd = 0.5 * global.roomSpeed;
spawned = false;
first = false;
y = room_height - 15;
xx = room_width / 2;
ox = x;
oy = y;
image_speed = 0;
alarm[0] = room_speed * 60;

if (global.stageType == "Forest")
    image_index = 0;

if (global.stageType == "Grassland")
    image_index = 2;

if (global.stageType == "Underworld")
    image_index = 1;

if (global.stageType == "Dungeon")
    image_index = 1;

if (global.stageType == "Snow Trail")
    image_index = 3;

if (global.stageType == "Corrupted Dimension")
    image_index = 4;
