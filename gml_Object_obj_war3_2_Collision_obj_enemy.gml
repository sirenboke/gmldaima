if (x <= maxPos)
{
    if (lastHit != other.id)
    {
        var _player = player;
        var _push = push;
        
        with (other)
        {
            var _target = id;
            
            if (_push > 0)
                gml_Script_scr_knockup(_push / 5);
            
            global.___struct___227 = function() constructor
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
            
            if (gml_Script_scr_enemy_takeDamage(other.dmg, 2, other.player, 1) <= 0)
            {
                if (instance_exists(other.target))
                {
                    if (other.target.skillBuff > 0)
                    {
                        if (other.target.buffed < other.target.skillBuff)
                            other.target.buffed += 1;
                    }
                }
            }
        }
    }
    
    lastHit = other.id;
}
