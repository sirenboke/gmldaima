event_inherited();
check = room_speed;
_shade = 16777215;
_sprite = 0;
alpha = 1;
alarm[0] = check;

if (global.stageType == "Forest")
    _sprite = choose(spr_tree2, spr_bushes2Mesh);

if (global.stageType == "Grassland")
{
    _sprite = spr_rocks;
    
    if (choose(0, 1, 2) > 0)
        visible = false;
}

if (global.stageType == "Snow Trail")
    _sprite = choose(spr_treeSnow, spr_bushesSnow);

if (global.stageType == "Corrupted Dimension")
    _sprite = spr_corruptedRocks;

sprite_index = _sprite;
image_index = irandom(image_number - 1);
image_speed = 0;
y += (6 + irandom_range(-6, 20));

if (global.stageType == "Snow Trail")
    y += 20;

bgSpd = 0.5 * global.roomSpeed;
var _behind = choose(5, 6, 7, 8, 9, 10);
depth = choose(5, 6, 7, 8, 9, 10, -3, -3);

if (global.stageType == "Corrupted Dimension")
{
    depth = irandom_range(5, 10);
    y = room_height - 20;
    y += irandom_range(-15, 0);
}

if (depth >= 7)
{
    bgSpd = 0.3 * global.roomSpeed;
    _shade = 8421504;
    
    if (_sprite == spr_rocks)
        _shade = 12632256;
    
    if (global.stageType == "Snow Trail")
        y += irandom(100);
}

if (depth >= 9)
{
    bgSpd = 0.2 * global.roomSpeed;
    _shade = 4210752;
    
    if (_sprite == spr_rocks)
        _shade = 8421504;
    
    if (global.stageType == "Snow Trail")
        y += irandom(100);
}

if (depth == -3)
{
    bgSpd = 0.7 * global.roomSpeed;
    y += irandom_range(20, 30);
}

oy = y;
image_xscale = choose(-1, 1);
