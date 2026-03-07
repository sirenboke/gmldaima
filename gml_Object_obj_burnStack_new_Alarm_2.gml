if (instance_exists(target))
{
    var i = array_length(stackOwners) - 1;
    
    while (i >= 0)
    {
        var _age = current_time - stackTimestamp[i];
        var _durationMs = (duration / room_speed) * 1000;
        var _frameDuration = 1000 / room_speed;
        
        if (_age >= (_durationMs - _frameDuration))
        {
            array_delete(stackOwners, i, 1);
            array_delete(stackDamage, i, 1);
            array_delete(stackTimestamp, i, 1);
            totalBurnInstances--;
        }
        
        i--;
    }
    
    with (target)
    {
        if (object_get_name(object_get_parent(object_index)) == "obj_enemy")
        {
            var _stackCount = array_length(other.stackOwners);
            var _totalTicks = other.duration / (room_speed / 5);
            var _uniquePlayers = [];
            var _playerDamage = [];
            
            for (i = 0; i < _stackCount; i++)
            {
                var _stackPlayer = other.stackOwners[i];
                var _stackDmg = other.stackDamage[i];
                var _dmgPerTick = _stackDmg / _totalTicks;
                var _playerIndex = -1;
                
                for (var j = 0; j < array_length(_uniquePlayers); j++)
                {
                    if (_uniquePlayers[j] == _stackPlayer)
                    {
                        _playerIndex = j;
                        break;
                    }
                }
                
                if (_playerIndex == -1)
                {
                    array_push(_uniquePlayers, _stackPlayer);
                    array_push(_playerDamage, _dmgPerTick);
                }
                else
                {
                    _playerDamage[_playerIndex] += _dmgPerTick;
                }
            }
            
            for (i = 0; i < array_length(_uniquePlayers); i++)
                gml_Script_scr_enemy_takeDamage(_playerDamage[i], 3, _uniquePlayers[i], undefined, undefined, undefined, 1);
        }
        
        if (object_get_name(object_index) == "obj_warrior")
        {
            if (instance_exists(other.player))
                gml_Script_scr_player_takeDamage((other.dmg * burnStacks) / 25, 3, other.player, 0, undefined, undefined, undefined, undefined, 1);
            else
                gml_Script_scr_player_takeDamage((other.dmg * burnStacks) / 25, 3, -1, 0, undefined, undefined, undefined, undefined, 1);
        }
    }
    
    alarm[2] = room_speed / 5;
}
else
{
    alarm[1] = 1;
}
