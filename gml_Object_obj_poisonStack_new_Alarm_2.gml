if (instance_exists(target))
{
    with (target)
    {
        if (object_get_name(object_get_parent(object_index)) == "obj_enemy")
        {
            if (other.totalDamage > 0)
            {
                var _playerContribs = [];
                var _playerDmgs = [];
                var _verifiedTotal = 0;
                
                for (var i = 0; i < array_length(other.activeSlots); i++)
                {
                    var _slotIndex = other.activeSlots[i];
                    
                    if (other.dot_alarms[_slotIndex][0] != -1 && other.stackInfo[_slotIndex][0] > 0)
                    {
                        var _slotDmg = other.stackInfo[_slotIndex][0];
                        var _slotPlayer = other.stackInfo[_slotIndex][3];
                        _verifiedTotal += _slotDmg;
                        var _found = false;
                        
                        for (var j = 0; j < array_length(_playerContribs); j++)
                        {
                            if (_playerContribs[j] == _slotPlayer)
                            {
                                _playerDmgs[j] += _slotDmg;
                                _found = true;
                                break;
                            }
                        }
                        
                        if (!_found)
                        {
                            array_push(_playerContribs, _slotPlayer);
                            array_push(_playerDmgs, _slotDmg);
                        }
                    }
                }
                
                var _baseDmg = other.totalDamage / 25;
                
                for (var i = 0; i < array_length(_playerContribs); i++)
                {
                    var _proportion = _playerDmgs[i] / _verifiedTotal;
                    var _finalDmg = _baseDmg * _proportion;
                    gml_Script_scr_enemy_takeDamage(_finalDmg, 3, _playerContribs[i], undefined, undefined, undefined, 1);
                }
            }
        }
        
        if (object_get_name(object_index) == "obj_warrior")
        {
            var _totalDmg = other.totalDamage;
            
            if (instance_exists(other.player))
                gml_Script_scr_player_takeDamage(_totalDmg / 25, 3, other.player, 0, undefined, undefined, undefined, undefined, 1);
            else
                gml_Script_scr_player_takeDamage(_totalDmg / 25, 3, -4, 0, undefined, undefined, undefined, undefined, 1);
        }
    }
    
    alarm[2] = room_speed / 5;
}
else
{
    alarm[1] = 1;
}
