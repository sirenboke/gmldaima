if (type != 1)
{
    if (instance_exists(player))
    {
        if (type != 2)
        {
            var _player = player.player;
            var _dmg = (player.myStatInfo[0][3] + (player.myStatInfo[9][3] / 2)) * (0.05 + (level / 50));
            var _target = player.target;
            
            if (instance_exists(_target))
            {
                if (distance_to_object(_target) <= rng)
                {
                    with (gml_Script_instance_create(x, y, obj_allyOrb))
                    {
                        c1 = 255;
                        c2 = 128;
                        
                        if (instance_exists(_target))
                        {
                            tx = _target.x;
                            ty = random_range(_target.y - (_target.height / 3), _target.y - (_target.height / 1.5));
                        }
                        else
                        {
                            tx = x;
                            ty = y;
                        }
                    }
                    
                    thirdAttack += 1;
                    
                    if (thirdAttack == 3)
                    {
                        with (_target)
                        {
                            gml_Script_scr_enemy_takeDamage(_dmg, 4, _player, 1, 1, undefined, undefined);
                            
                            global.___struct___222 = function() constructor
                            {
                                self.player = argument[0];
                                self.bleedHealReduction = 0.5;
                                self.duration = 3;
                                self.target = argument[1];
                            };
                            
                            instance_create_depth(x, y, depth, obj_bleedEffect, new function() constructor
                            {
                                self.player = argument[0];
                                self.bleedHealReduction = 0.5;
                                self.duration = 3;
                                self.target = argument[1];
                            }(_player, _target));
                        }
                        
                        thirdAttack = 0;
                    }
                    
                    with (_target)
                        gml_Script_scr_enemy_takeDamage(_dmg, 1, _player, 1, 1, undefined, undefined);
                }
            }
        }
        else
        {
            var _value = 10 * level;
            _value += (player.myStatInfo[8][3] * (level / 2000));
            
            with (player)
                gml_Script_scr_player_heal(_value);
            
            with (gml_Script_instance_create(x, y, obj_allyOrb))
            {
                tx = other.player.x;
                ty = random_range(other.player.y - (other.player.height / 3), other.player.y - (other.player.height / 1.5));
                c1 = 65280;
                c2 = 32768;
            }
        }
    }
}
