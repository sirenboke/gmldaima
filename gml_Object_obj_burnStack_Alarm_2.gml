var _dmg = dmg;
var _duration = duration;
var _player = player;

if (instance_exists(target))
{
    with (target)
    {
        if (object_get_name(object_get_parent(object_index)) == "obj_enemy")
            gml_Script_scr_enemy_takeDamage(_dmg / (_duration / room_speed) / 5, 3, _player, undefined, undefined, undefined, 1);
        
        if (object_get_name(object_index) == "obj_warrior")
        {
            if (instance_exists(other.player))
                gml_Script_scr_player_takeDamage((_dmg * burnStacks) / 25, 3, _player, 0, undefined, undefined, undefined, undefined, 1);
            else
                gml_Script_scr_player_takeDamage((_dmg * burnStacks) / 25, 3, -1, 0, undefined, undefined, undefined, undefined, 1);
        }
    }
    
    alarm[2] = room_speed / 5;
}
else
{
    alarm[1] = 1;
}
