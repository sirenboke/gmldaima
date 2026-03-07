var _dmg = dmg;
var _player = player;
var _bounceRange = bounceRange;
var _zapChance = zapChance;

if (instance_exists(player) && instance_exists(player.myWarrior))
{
    if (instance_exists(obj_enemy) && place_meeting(x, y, obj_enemy))
    {
        with (instance_nearest(x, y, obj_enemy))
        {
            if (irandom(99) < _zapChance)
            {
                gml_Script_scr_zap(1.5);
                
                with (gml_Script_instance_create(x, y - (height / 2), obj_smallPlasma))
                {
                    target = other.id;
                    rng = _bounceRange;
                    bounceTo = -4;
                    chooseBounce = array_create(0);
                    
                    for (var i = 0; i < instance_number(obj_enemy); i++)
                    {
                        var bounceCheck;
                        bounceCheck[i] = instance_find(obj_enemy, i);
                        
                        if (distance_to_object(bounceCheck[i]) <= rng)
                            array_push(chooseBounce, bounceCheck[i]);
                    }
                    
                    if (chooseBounce[0].id != target)
                        bounceTo = chooseBounce[0];
                    else if (array_length(chooseBounce) > 1)
                        bounceTo = chooseBounce[1];
                    
                    for (var i = 1; i < array_length(chooseBounce); i++)
                    {
                        if (distance_to_object(chooseBounce[i]) <= distance_to_object(chooseBounce[i - 1]))
                        {
                            if (chooseBounce[i].id != target)
                                bounceTo = chooseBounce[i];
                        }
                    }
                    
                    if (bounceTo == -4)
                    {
                        instance_destroy();
                        exit;
                    }
                    
                    xx = bounceTo.x;
                    yy = bounceTo.y - (bounceTo.height / 2);
                    angle = point_direction(x, y, xx, yy);
                    distance = distance_to_point(xx, yy);
                    dmg = _dmg;
                    player = _player;
                    depth = other.depth - 1;
                }
            }
            
            var _hp = gml_Script_scr_enemy_takeDamage(_dmg, 2, _player, undefined, undefined, undefined, 1);
        }
    }
}

alarm[0] = room_speed / 5;
