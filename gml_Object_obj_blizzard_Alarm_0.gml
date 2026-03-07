if (alarm[1] != -1)
{
    var _shield = shield;
    var _stacks = 0;
    var _player = player;
    var _warrior = _player.myWarrior;
    
    if (instance_exists(obj_enemy))
    {
        for (var i = 0; i < instance_number(obj_enemy); i++)
        {
            var _target = instance_find(obj_enemy, i);
            
            if (distance_to_object(_target) <= 1000)
            {
                target = _target;
                var _hit = choose(0, 1);
                
                if (_hit == 0)
                {
                    with (target)
                        gml_Script_scr_enemy_takeDamage(other.dmg / 5, 3, _player, undefined, undefined, undefined, 1);
                }
                
                if (instance_exists(target) && _hit == 0)
                {
                    if (irandom(99) <= 10)
                    {
                        global.___struct___212 = function() constructor
                        {
                            self.warrior = argument[0];
                            self.stack = 1;
                            self.duration = 3;
                            self.target = argument[1];
                        };
                        
                        instance_create_depth(target.x, target.y, depth, obj_freezeStack, new function() constructor
                        {
                            self.warrior = argument[0];
                            self.stack = 1;
                            self.duration = 3;
                            self.target = argument[1];
                        }(_warrior, target));
                        _stacks = target.freezeStacks + 1;
                        
                        if (tier > 1)
                        {
                            if (instance_exists(_warrior))
                            {
                                with (_warrior)
                                {
                                    gml_Script_scr_shield(_shield / 5, undefined, 1);
                                    show_debug_message("Blizzard shielded for " + string(_shield));
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    alarm[0] = room_speed / 5;
}
