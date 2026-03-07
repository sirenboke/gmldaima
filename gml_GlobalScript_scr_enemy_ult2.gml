self.scr_enemy_ult2 = function()
{
    if (argument[1] <= 0)
        argument[1] = 1;
    
    if (gml_Script_scr_relicEffect(player, 0, 28) > 0 && argument[1] > 0)
        show_debug_message("Wise Hat effect (on " + string(name) + "'s " + string(myAbilityInfo[1]) + "): " + string(argument[1]) + "x.");
    
    gml_Script_scr_playsound(s_enemyBite, 0.9, 1.1, 0.2);
    canAttack = true;
    
    if (instance_exists(target))
    {
        if (target.immune == false)
        {
            var _abilityDmg = myStatInfo[0][3] * 1.2 * (1.5 + (level / 2000));
            var _player = id;
            var _target = target;
            gml_Script_instance_create(target.x, target.y - (target.height / 2), obj_bite);
            
            with (target)
            {
                gml_Script_scr_player_takeDamage(_abilityDmg, 2, other.id, 0, 0);
                
                if (other.tier >= 2)
                {
                    global.___struct___147 = function() constructor
                    {
                        self.player = argument[0];
                        self.bleedHealReduction = 0.2;
                        self.duration = 5;
                        self.target = argument[1];
                    };
                    
                    instance_create_depth(x, y, depth, obj_bleedEffect, new function() constructor
                    {
                        self.player = argument[0];
                        self.bleedHealReduction = 0.2;
                        self.duration = 5;
                        self.target = argument[1];
                    }(_player, _target));
                }
            }
        }
    }
};
