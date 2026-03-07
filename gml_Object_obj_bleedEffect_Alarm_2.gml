if (instance_exists(target))
{
    with (target)
    {
        if (bleedTimer <= 0)
        {
            alarm[1] = 1;
            exit;
        }
        
        var _player = other.player;
        var _target = id;
        
        if (object_get_name(object_get_parent(object_index)) == "obj_enemy")
        {
            if (type != "final")
                gml_Script_scr_enemy_takeDamage((myStatInfo[8][3] * 0.033) / 5, 4, other.player, undefined, undefined, undefined, 1);
        }
        
        if (object_get_name(object_index) == "obj_warrior")
        {
            if (instance_exists(other.player))
                gml_Script_scr_player_takeDamage((myStatInfo[8][3] * 0.033) / 5, 4, other.player, 0);
            else
                gml_Script_scr_player_takeDamage((myStatInfo[8][3] * 0.033) / 5, 4, -1, 0);
        }
        
        hemorrhageTrigger += (0.2 / tierReduction);
        
        if (hemorrhageTrigger >= 5 && hemorrhageTimer == 0)
        {
            bleedTimer = 0;
            hemorrhageTrigger = 0;
            
            global.___struct___211 = function() constructor
            {
                self.player = argument[0];
                self.bleedHealReduction = 0.9;
                self.duration = 5;
                self.target = argument[1];
            };
            
            instance_create_depth(x, y, depth, obj_hemorrhageEffect, new function() constructor
            {
                self.player = argument[0];
                self.bleedHealReduction = 0.9;
                self.duration = 5;
                self.target = argument[1];
            }(_player, _target));
        }
    }
    
    alarm[2] = room_speed / 5;
}
else
{
    alarm[1] = 1;
}
