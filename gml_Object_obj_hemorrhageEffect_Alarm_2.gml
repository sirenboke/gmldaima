if (instance_exists(target))
{
    with (target)
    {
        if (hemorrhageTimer <= 0)
        {
            alarm[1] = 1;
            exit;
        }
        
        if (object_get_name(object_get_parent(object_index)) == "obj_enemy")
        {
            if (type != "final")
                gml_Script_scr_enemy_takeDamage((myStatInfo[8][3] * 0.16) / 5, 4, other.player, undefined, undefined, undefined, 1);
        }
        
        if (object_get_name(object_index) == "obj_warrior")
        {
            if (instance_exists(other.player))
                gml_Script_scr_player_takeDamage((myStatInfo[8][3] * 0.16) / 5, 4, other.player, 0);
            else
                gml_Script_scr_player_takeDamage((myStatInfo[8][3] * 0.16) / 5, 4, -1, 0);
        }
    }
    
    alarm[2] = room_speed / 5;
}
else
{
    alarm[1] = 1;
}
