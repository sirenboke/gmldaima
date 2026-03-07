if (instance_exists(target))
{
    if (target.canFreeze == true)
    {
        alarm[1] = duration;
        target.freezeStacks += stack;
        target.freezeTimer = duration;
        target.freezeTimerMax = duration;
        var _aspdslow = 0.2;
        var _moveslow = 0.2;
        var _duration = duration;
        
        with (target)
        {
            gml_Script_scr_statChange(_moveslow, -1, 10, _duration / room_speed, undefined);
            gml_Script_scr_statChange(_aspdslow, -1, 1, _duration / room_speed, undefined);
        }
        
        gml_Script_scr_playsound(s_iceStack, 1.4, 1.7, 0.5);
        
        if (target.freezeStacks >= maxStacks)
        {
            target.freezeStacks = maxStacks;
            
            with (obj_freezeStack)
            {
                if (target == other.target && id != other.id)
                    instance_destroy();
            }
            
            with (target)
                gml_Script_scr_freeze(other.duration / myResistance[1][1] / room_speed, floor(hp * 0.1));
        }
    }
    
    depth = target.depth - 1;
}
else if (alarm[1] > 1)
{
    alarm[1] = 1;
}
