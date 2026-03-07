self.scr_enemy_ult8 = function()
{
    if (argument[1] <= 0)
        argument[1] = 1;
    
    if (gml_Script_scr_relicEffect(player, 0, 28) > 0 && argument[1] > 0)
        show_debug_message("Wise Hat effect (on " + string(name) + "'s " + string(myAbilityInfo[1]) + "): " + string(argument[1]) + "x.");
    
    canAttack = true;
    var _player = id;
    var _abilityDmg = other.myStatInfo[0][3] * 5 * argument[1];
    var _amount = 1 + floor(level / 10000);
    
    with (obj_warrior)
    {
        if (myRaidNumber == 0)
        {
            var _target = id;
            
            global.___struct___148 = function() constructor
            {
                self.target = argument[0];
                self.dmg = argument[1];
                self.player = argument[2];
                self.warrior = argument[3];
                self.stacks = argument[4];
            };
            
            instance_create_depth(x, y - (height / 2), depth, obj_poisonStack_new, new function() constructor
            {
                self.target = argument[0];
                self.dmg = argument[1];
                self.player = argument[2];
                self.warrior = argument[3];
                self.stacks = argument[4];
            }(_target, _abilityDmg, _player, _player, _amount));
            
            if (other.tier >= 2)
            {
                global.___struct___149 = function() constructor
                {
                    self.player = argument[0];
                    self.bleedHealReduction = 0.2;
                    self.duration = 3;
                    self.target = argument[1];
                };
                
                instance_create_depth(x, y, depth, obj_bleedEffect, new function() constructor
                {
                    self.player = argument[0];
                    self.bleedHealReduction = 0.2;
                    self.duration = 3;
                    self.target = argument[1];
                }(_player, _target));
            }
        }
    }
};
