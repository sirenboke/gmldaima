if (instance_exists(player))
{
    var _value = 0;
    
    if (shield < maxshield)
    {
        _value = ceil(maxshield / 500);
        
        if ((shield + _value) > maxshield)
            _value = ceil(maxshield - shield);
        
        shield += _value;
        
        with (player)
            gml_Script_scr_shield(_value);
    }
}

alarm[4] = room_speed / 5;
