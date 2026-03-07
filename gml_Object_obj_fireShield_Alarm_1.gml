var _armorOverTime = armorOverTime;

if (_armorOverTime > 0)
{
    with (obj_warrior)
    {
        if (fireshieldDmg > 0)
            gml_Script_scr_statChange(_armorOverTime, undefined, 3, alarm[0] / room_speed, undefined, 1);
    }
    
    alarm[1] = room_speed / 5;
}
