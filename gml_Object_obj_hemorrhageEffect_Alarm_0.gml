var _healRed = bleedHealReduction;
var _duration = duration;
var _durationMax = bleedTimerMax;

if (instance_exists(target))
{
    with (target)
    {
        if (healReduction > (1 - (_healRed * myResistance[1][0])))
            gml_Script_scr_statChange(_healRed, -1, 40, _duration / room_speed, undefined, undefined, undefined);
        
        if (hemorrhageTimer < (_duration / room_speed))
        {
            hemorrhageTimer = _duration / room_speed;
            
            if (hemorrhageTimerMax < (_durationMax / room_speed))
                hemorrhageTimerMax = _durationMax / room_speed;
        }
    }
    
    depth = target.depth - 1;
}
else
{
    alarm[1] = 1;
}
