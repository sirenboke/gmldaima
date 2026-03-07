var _duration = duration;
var _armor = armorReduction;
var _player = player;
var _globalRes = globalReduction;
var _physRes = physReduction;
var _specRes = specReduction;
var _dmg = dmg;

if (triggered == false && alarm[1] == -1)
{
    if (real(other.x - x) <= 10)
    {
        if (other.isTrapped == false)
        {
            triggered = true;
            image_index = 3;
            depth = other.depth - 1;
            
            with (other)
            {
                gml_Script_scr_trap(_duration);
                var _target = id;
                gml_Script_scr_stun(_duration);
                gml_Script_scr_statChange(myStatInfo[3][3] * (_armor / 100), -1, 3, _duration);
                gml_Script_scr_statChange(_globalRes, 1, 11, _duration);
                
                if (_physRes > 0)
                    gml_Script_scr_statChange(_physRes, 1, 12, _duration);
                
                if (_specRes > 0)
                    gml_Script_scr_statChange(_specRes, 1, 13, _duration);
                
                gml_Script_scr_enemy_takeDamage(_dmg, 2, _player);
                
                global.___struct___224 = function() constructor
                {
                    self.player = argument[0];
                    self.bleedHealReduction = 0.9;
                    self.duration = 5;
                    self.target = argument[1];
                };
                
                instance_create_depth(x, y, depth, obj_bleedEffect, new function() constructor
                {
                    self.player = argument[0];
                    self.bleedHealReduction = 0.9;
                    self.duration = 5;
                    self.target = argument[1];
                }(_player, _target));
            }
            
            if (statBoost > 0)
            {
                if (instance_exists(warrior))
                {
                    with (warrior)
                    {
                        for (var i = 0; i < 10; i++)
                            gml_Script_scr_statChange(myStatInfo[i][3] * other.statBoost, 1, i, _duration, undefined, 1);
                    }
                }
            }
            
            alarm[0] = room_speed * 2;
        }
    }
}
