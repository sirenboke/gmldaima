self.scr_relicEffect = function(arg0, arg1, arg2)
{
    var _source = "";
    
    if (arg2 >= array_length(global.uniqueItem))
        return arg1;
    
    if (instance_exists(arg0))
    {
        if (object_get_name(arg0.object_index) == "obj_warrior" || object_get_name(arg0.object_index) == "obj_player")
            _source = "Raider (" + string(arg0.name) + ") | ";
        
        if (object_get_name(object_get_parent(arg0.object_index)) == "obj_enemy")
            _source = "Enemy (" + string(arg0.name) + ") | ";
        
        if (arg0.equippedUniqueItem[arg2] == 1 || arg0.myPetEquippedRelic[arg0.myPetID][arg2] == 1)
        {
            var _value = (global.uniqueItem[arg2][2] + (global.uniqueItem[arg2][4] * (arg0.uniqueItemLevel[arg2] - 1))) * arg0.uniqueItemCorruption[arg2];
            
            if (global.challenge_relicEffect != 1)
                _value *= global.challenge_relicEffect;
            
            return gml_Script_scr_petRelic(arg0, _value, arg2);
        }
        else
        {
            return arg1;
        }
    }
    else
    {
        return arg1;
    }
};

self.scr_petRelic = function(arg0, arg1, arg2)
{
    if (arg0.myPetID > 0 && arg0.myPetEquippedRelic[arg0.myPetID][arg2] == 1)
    {
        var _oldvalue = arg1;
        
        for (var re = 1; re <= floor(arg0.myPetInfo[arg0.myPetID][4] / 10); re++)
        {
            if (arg0.petRelicSlot[arg0.myPetID][re] == arg2)
                arg1 *= arg0.myPetRelicSlotEffect[arg0.myPetID][re];
        }
        
        if (global.challenge_petRelicEffect != 1)
            arg1 *= global.challenge_petRelicEffect;
        
        return arg1;
    }
    else
    {
        return arg1;
    }
};

self.scr_relicCheck = function(arg0, arg1, arg2)
{
    var _relicLv;
    
    if (arg0.gotUniqueItem[arg2] == 0)
        _relicLv = 1;
    else
        _relicLv = arg0.uniqueItemLevel[arg2];
    
    var _value = (global.uniqueItem[arg2][2] + (global.uniqueItem[arg2][4] * (_relicLv - 1))) * arg0.uniqueItemCorruption[arg2];
    
    if (global.uniqueItem[arg2][6] == "%")
        _value *= 100;
    
    _value = string(gml_Script_scr_bigNumber(_value)) + global.uniqueItem[arg2][6];
    return _value;
};

self.scr_relicSetCheck = function(arg0, arg1, arg2)
{
    var _relicLv;
    
    if (arg0.gotUniqueItem[arg2] == 0)
        _relicLv = 1;
    else
        _relicLv = arg0.uniqueItemLevel[arg2];
    
    var _value = (global.uniqueItem[arg2][2] + (global.uniqueItem[arg2][4] * (_relicLv - 1))) * arg0.uniqueItemCorruption[arg2];
    var _relicPetEffect = 1;
    
    for (var _r = 1; _r <= 5; _r++)
    {
        if (arg0.petRelicSlot[arg0.myPetID][_r] == arg2)
        {
            _relicPetEffect = arg0.myPetRelicSlotEffect[arg0.myPetID][_r];
            _value = _value * _relicPetEffect;
        }
    }
    
    if (global.uniqueItem[arg2][6] == "%")
        _value *= 100;
    
    _value = string(gml_Script_scr_bigNumber(_value)) + global.uniqueItem[arg2][6];
    return _value;
};

self.scr_sim_end = function()
{
    if ((equippedUniqueItem[10] == 1 || player.myPetEquippedRelic[myPetID][10] == 1) && (equippedUniqueItem[11] == 1 || player.myPetEquippedRelic[myPetID][11] == 1) && (equippedUniqueItem[12] == 1 || player.myPetEquippedRelic[myPetID][12] == 1))
    {
        var _simDmg = simDmg;
        var _simHP = simHP;
        var _simInt = simInt;
        var _player = player;
        
        if (instance_exists(obj_enemy))
        {
            with (instance_nearest(x, y, obj_enemy))
            {
                gml_Script_scr_playsound(s_executeDemon, 1, 1, 1);
                gml_Script_scr_playsound(s_execute, 1, 1, 1);
                gml_Script_scr_enemy_takeDamage(_simDmg, 1, _player);
                gml_Script_scr_enemy_takeDamage(_simHP, 4, _player);
                gml_Script_scr_enemy_takeDamage(_simInt, 2, _player);
            }
        }
    }
    
    simStacks = 0;
    gml_Script_scr_statChange(simDmg, -1, 0, undefined, undefined, undefined, undefined, 1, id);
    gml_Script_scr_statChange(simHP, -1, 8, undefined, undefined, undefined, undefined, 1, id);
    gml_Script_scr_statChange(simInt, -1, 9, undefined, undefined, undefined, undefined, 1, id);
    simDmg = 0;
    simHP = 0;
    simInt = 0;
};
