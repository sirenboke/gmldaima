spawned = false;
y = room_height - 20;
xx = room_width / 2;
bgSpd = 0.01 * global.roomSpeed;
first = false;
image_speed = 0;
alarm[0] = room_speed * 60;

if (global.stageType == "Forest")
    image_index = 4;

if (global.stageType == "Underworld")
    image_index = 1;

if (global.stageType == "Dungeon")
    image_index = 2;

if (global.stageType == "Grassland")
    image_index = 3;

if (global.stageType == "Snow Trail")
    image_index = 5;

if (global.stageType == "Corrupted Dimension")
    image_index = 6;

if (image_index == 3)
    bgSpd = 0.01 * global.roomSpeed;

if (image_index == 1)
    bgSpd = 0.01 * global.roomSpeed;

if (image_index == 2)
    bgSpd = 0.4 * global.roomSpeed;

if (image_index == 4)
    bgSpd = 0.15 * global.roomSpeed;

if (image_index == 5)
    bgSpd = 0.01 * global.roomSpeed;

if (image_index == 6)
    bgSpd = 0.001 * global.roomSpeed;

global.___struct___221 = function() constructor
{
    self.from = argument[0];
};

instance_create_depth(x, y, depth - 1, obj_mountainsNight, new function() constructor
{
    self.from = argument[0];
}(other.id));
