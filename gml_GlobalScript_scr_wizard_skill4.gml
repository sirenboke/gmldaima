self.scr_wizard_skill4 = function()
{
    if (argument[1] <= 0)
        argument[1] = 1;
    
    if (gml_Script_scr_relicEffect(player, 0, 28) > 0 && argument[1] > 0)
        show_debug_message("Wise Hat effect (on " + string(name) + "'s " + string(myAbilityInfo[1]) + "): " + string(argument[1]) + "x.");
    
    skillTimer = 1.5 + (argument[0] / 10);
    skillTimer *= abilityDurationBonus;
    
    if (instance_exists(obj_enemy))
    {
        if (instance_exists(target) && distance_to_object(target) <= rng)
        {
            global.___struct___201 = function() constructor
            {
                self.duration = argument[0];
            };
            
            with (instance_create_depth(target.x, target.y, target.depth - 1, obj_polymorph, new function() constructor
            {
                self.duration = argument[0];
            }(other.skillTimer / other.target.myResistance[1][1])))
            {
                if (duration < 1)
                    duration = 1;
                
                alarm[0] = duration * room_speed;
                player = other.id;
            }
        }
    }
    
    if (alarm[2] == -1)
        alarm[2] = room_speed * skillTimer;
};
