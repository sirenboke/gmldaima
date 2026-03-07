if (instance_exists(target))
{
    alarm[1] = duration;
    
    if (target.burnStacks < 20)
    {
        var _oldStacks = target.burnStacks;
        target.burnStacks += fireStacks;
        
        if (target.burnStacks > 20)
        {
            fireStacks = 20 - _oldStacks;
            target.burnStacks = 20;
        }
        
        totalstacks = target.burnStacks;
        var _resistance = fireStacks / 100;
        
        with (target)
        {
            burnTimerMax = other.duration;
            gml_Script_scr_statChange(_resistance, undefined, 11, undefined, undefined);
        }
        
        depth = target.depth - 1;
    }
}
else
{
    alarm[1] = 1;
}
