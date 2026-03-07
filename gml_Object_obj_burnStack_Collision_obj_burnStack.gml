if (target == other.target && other.id > id)
{
    if (instance_exists(target))
    {
        dmg += other.dmg;
        player = other.player;
        
        if (target.burnStacks < 20)
        {
            if (other.duration > duration)
                duration = other.duration;
            
            alarm[1] = duration;
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
                if (other.duration > burnTimerMax)
                    burnTimerMax = other.duration;
                
                gml_Script_scr_statChange(_resistance, undefined, 11, undefined, undefined);
            }
            
            depth = target.depth - 1;
        }
        
        instance_destroy(other);
    }
    else
    {
        alarm[1] = 1;
    }
}
