if (instance_exists(target))
{
    var _dmg = totalDamage;
    
    with (target)
    {
        if (object_get_name(object_get_parent(object_index)) == "obj_enemy")
            gml_Script_scr_enemy_takeDamage(_dmg / 25, 3, other.player, undefined, undefined, undefined, 1);
        
        if (object_get_name(object_index) == "obj_warrior")
        {
            if (instance_exists(other.player))
                gml_Script_scr_player_takeDamage(_dmg / 25, 3, other.player, 0, undefined, undefined, undefined, undefined, 1);
            else
                gml_Script_scr_player_takeDamage(_dmg / 25, 3, -4, 0, undefined, undefined, undefined, undefined, 1);
        }
    }
    
    alarm[2] = room_speed / 5;
}
else
{
    alarm[1] = 1;
}
