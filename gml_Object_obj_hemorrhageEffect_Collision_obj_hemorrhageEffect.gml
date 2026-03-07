if (instance_exists(target))
{
    if (other.target == target && other.id < id)
    {
        if (alarm[0] == -1)
        {
            if (other.duration > alarm[1])
            {
                alarm[1] = other.duration;
                
                if (other.bleedTimerMax > bleedTimerMax)
                    bleedTimerMax = other.bleedTimerMax;
            }
            
            if (other.bleedHealReduction > bleedHealReduction)
                bleedHealReduction = other.bleedHealReduction;
            
            alarm[0] = 1;
        }
        
        show_debug_message("Bleed new properties: " + string(duration) + "/" + string(bleedTimerMax) + ", " + string(bleedHealReduction) + " healing reduction");
        
        with (other)
            instance_destroy();
    }
}
