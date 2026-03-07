var _scale = scale;
var _dmg = dmg;
var _player = player;
var _warrior = _player.myWarrior;
var _duration = duration;
var _stacks = stacks;
var _range = range;

if (instance_exists(obj_enemy))
{
    with (obj_enemy)
    {
        if (distance_to_object(other) <= _range)
        {
            global.___struct___217 = function() constructor
            {
                self.warrior = argument[0];
                self.stack = argument[1];
                self.duration = argument[2];
                self.target = other;
            };
            
            instance_create_depth(x, y, depth, obj_freezeStack, new function() constructor
            {
                self.warrior = argument[0];
                self.stack = argument[1];
                self.duration = argument[2];
                self.target = other;
            }(_warrior, _stacks, _duration));
            
            if ((freezeStacks + _stacks) >= 10 && frozen == false)
            {
                with (_warrior)
                    gml_Script_scr_shield(myStatInfo[8][3] * 0.01, undefined, 1);
            }
            
            gml_Script_scr_enemy_takeDamage(_dmg, 3, _player, undefined, undefined, undefined, undefined);
        }
    }
}

with (instance_create_depth(x, y, depth - 1, obj_raidAnimation))
{
    sprite_index = spr_frostNova2;
    image_angle = irandom(359);
    spd = room_speed / 3;
    follow = other;
}

with (instance_create_depth(x, room_height - 25, depth - 1, obj_raidAnimation))
{
    sprite_index = spr_ground_explosion;
    image_xscale = (_range * 2) / sprite_width;
    image_yscale = 1.5;
    spd = room_speed / 3;
    color = 16777215;
    alpha = 0.6;
    fade = true;
}

instance_destroy();
