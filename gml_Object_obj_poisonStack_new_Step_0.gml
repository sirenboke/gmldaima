gml_Script_scr_dot_alarm_step();

if (totalDuration > 0)
    totalDuration -= 1;

var i = array_length(activeSlots) - 1;

while (i >= 0)
{
    var _slotIndex = activeSlots[i];
    
    if (dot_alarms[_slotIndex][0] == -1)
    {
        if (stackInfo[_slotIndex][1] > 0)
        {
            totalStacks -= stackInfo[_slotIndex][1];
            stackInfo[_slotIndex][1] = -1;
        }
        
        if (stackInfo[_slotIndex][0] > 0)
        {
            totalDamage -= stackInfo[_slotIndex][0];
            stackInfo[_slotIndex][0] = -1;
        }
        
        stackInfo[_slotIndex][3] = -4;
        array_delete(activeSlots, i, 1);
    }
    
    i--;
}

if (instance_exists(target))
{
    target.poisonStacks = totalStacks;
    target.poisonTimer = totalDuration;
    x = target.x;
    y = target.y - (target.height / 2);
}
else
{
    alarm[1] = 1;
    exit;
}

if (totalStacks <= 0)
    alarm[1] = 1;
