var _bounces = bounces;
var _dmg = dmg;
var _player = player;
chooseBounce = array_create(0);
var targetX = x;
var _check = 0;
bounceFrom = target;

if (instance_exists(bounceFrom))
{
    bounceFromX = bounceFrom.x;
    bounceFromY = room_height - 20;
    bounceFromH = bounceFrom.y - (bounceFrom.height / 2);
}

bounceTo = instance_furthest(bounceFromX + _check, bounceFromY, obj_enemy);

for (var i = 0; i < instance_number(obj_enemy); i++)
{
    if (instance_find(obj_enemy, i).x > bounceFromX && (instance_find(obj_enemy, i) != bounceTo && instance_find(obj_enemy, i) != target))
    {
        if (real(instance_find(obj_enemy, i).x - bounceFromX) < real(bounceTo.x - bounceFromX))
            bounceTo = instance_find(obj_enemy, i);
    }
}

bounceFrom = bounceTo;

if (bounceTo != target)
{
    if (!instance_exists(bounceTo))
        exit;
    
    bounceToX = bounceTo.x;
    bounceToY = room_height - 20;
    bounceToH = bounceTo.y - (bounceTo.height / 2);
    xx = bounceToX;
    yy = bounceToH;
    
    if (real(bounceToX - bounceFromX) > rng)
    {
        alarm[1] = 1;
        bounceToX = bounceFromX;
        bounceToY = bounceFromY;
        bounceToH = bounceFromH;
        exit;
    }
    
    angle = point_direction(bounceFromX, bounceFromH, xx, yy);
    distance = real(bounceFromX - bounceToX);
    
    if (real(distance) > rng)
        distance = 0;
    
    dmg = _dmg;
    player = _player;
    depth = other.depth - 1;
    
    if (instance_exists(player) && instance_exists(player.myWarrior))
    {
        if (instance_exists(bounceTo))
        {
            target = bounceTo;
            bounceFromX = bounceTo.x;
            bounceFromY = room_height - 20;
            bounceFromH = bounceFrom.y - (bounceFrom.height / 2);
            
            with (instance_create_depth(bounceFromX, bounceFromH, depth - 1, obj_raidAnimation))
            {
                sprite_index = other.sprite;
                image_xscale = (1 / sprite_get_width(sprite_index)) * other.distance;
                image_yscale = 2;
                image_angle = other.angle;
                spd = room_speed / 2;
                color = 16777215;
                alpha = 1;
                fade = false;
                fadeSpeed = 0;
            }
            
            with (bounceTo)
            {
                gml_Script_scr_zap(0.2);
                gml_Script_scr_enemy_takeDamage(_dmg, 2, _player);
            }
        }
    }
}

bounces -= 1;

if (bounces > 0)
    alarm[0] = frequency;
else
    alarm[1] = 1;
