if (instance_exists(target))
{
    target.absorb = false;
    var _player = player;
    var _warrior = _player.myWarrior;
    var _dmg = value;
    var _freeze = freeze;
    var _scaling = dmg;
    show_debug_message("focus damage: " + string(value));
    var _spread = 0;
    
    if (instance_exists(_warrior))
    {
        with (_warrior)
            gml_Script_scr_w3s1_effect();
    }
    
    if (instance_exists(obj_enemy))
    {
        var _enemiesToHit;
        _enemiesToHit[0] = 0;
        var _availableEnemies;
        _availableEnemies[0] = 0;
        
        for (var t = 0; t < instance_number(obj_enemy); t++)
            _availableEnemies[t] = instance_find(obj_enemy, t);
        
        var _check = 0;
        
        for (var s = 0; s < array_length(_availableEnemies); s++)
        {
            if (_availableEnemies[s].x <= (other.x + 600))
            {
                _enemiesToHit[_check] = _availableEnemies[s];
                _check += 1;
            }
        }
        
        for (var i = 0; i < array_length(_enemiesToHit); i++)
        {
            if (extraTargets > _spread)
            {
                var _target;
                _target[i] = _enemiesToHit[i];
                _spread += 1;
                
                with (_target[i])
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
                    
                    gml_Script_scr_enemy_takeDamage((_dmg * _scaling) / _spread, 2, other.player);
                    
                    if (_freeze > irandom(99))
                    {
                        global.___struct___226 = function() constructor
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
                        }(_warrior, _target[i]));
                    }
                }
            }
        }
    }
    
    if (armor > 0)
    {
        with (target)
            gml_Script_scr_statChange(other.armor, -1, 3, undefined, undefined, 1);
    }
    
    show_debug_message("Focus hitting " + string(_spread) + " enemies.");
}

instance_destroy();
