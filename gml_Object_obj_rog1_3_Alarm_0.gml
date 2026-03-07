if (instance_exists(target))
{
    var _player = player;
    var _warrior = _player.myWarrior;
    var _dmg = value;
    var _freeze = freeze;
    var _scaling = dmg;
    var _target = -1;
    show_debug_message("deadly seal damage: " + string(value));
    
    if (instance_exists(target))
        _target = target;
    
    if (instance_exists(obj_enemy) && instance_exists(_target))
    {
        with (_target)
        {
            with (instance_create_depth(x, y - (height / 2), depth - 1, obj_raidAnimation))
            {
                sprite_index = spr_frostNova2;
                image_angle = irandom(359);
                image_xscale = 1.5;
                image_yscale = 1.5;
                spd = room_speed / 2;
                color = 128;
                alpha = 0.9;
                fade = true;
                fadeSpeed = 1;
            }
            
            gml_Script_scr_enemy_takeDamage(_dmg * _scaling, 2, other.player);
            
            if (_freeze > irandom(99))
            {
                global.___struct___225 = function() constructor
                {
                    self.warrior = argument[0];
                    self.stack = 1;
                    self.duration = 3;
                    self.target = argument[1];
                };
                
                instance_create_depth(x, y, depth, obj_freezeStack, new function() constructor
                {
                    self.warrior = argument[0];
                    self.stack = 1;
                    self.duration = 3;
                    self.target = argument[1];
                }(_warrior, _target));
            }
        }
    }
    
    if (armor > 0)
    {
        with (target)
            gml_Script_scr_statChange(other.armor, -1, 3, undefined, undefined, 1);
    }
}

instance_destroy();
