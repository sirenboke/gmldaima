self.scr_rogue_skill1_spec3 = function()
{
    var _player = player;
    var _maxValue = myStatInfo[9][3] * (1 + mySpecialBuff[0]);
    skillTimer = 4;
    skillTimer *= abilityDurationBonus;
    var _skillTimer = skillTimer;
    var _extraTargets = mySpecialBuff[1];
    var _armor = myStatInfo[3][3] * mySpecialBuff[2];
    
    if (_armor > 0)
        gml_Script_scr_statChange(_armor, undefined, 3, undefined, undefined, 1);
    
    var _freeze = mySpecialBuff[3];
    var _dmg = (myStatInfo[9][3] / 500) * (1 + mySpecialBuff[4]);
    var _target = -1;
    
    if (instance_exists(obj_enemy))
    {
        if (instance_exists(target))
            _target = target;
        else
            _target = instance_nearest(x, y, obj_enemy);
    }
    
    canAttack = true;
    
    if (_target != -1)
    {
        with (gml_Script_instance_create(_target.x, _target.y - height, obj_rog1_3))
        {
            player = _player;
            target = _target;
            value = 0;
            dmg = _dmg;
            maxValue = _maxValue;
            extraTargets = 1 + _extraTargets;
            armor = _armor;
            freeze = _freeze;
            alarm[0] = _skillTimer * room_speed;
            depth = other.depth - 1;
        }
        
        if (alarm[2] == -1)
            alarm[2] = room_speed * skillTimer;
    }
    
    show_debug_message("deadly seal casted");
};
