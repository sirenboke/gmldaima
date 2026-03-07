var _duration = duration;
var _stacks = stacks;
var _damage = dmg;
var _player = player;

if (target == other.target && id > other.id)
{
    with (other)
    {
        if (totalStacks < maxPoisonStacks)
        {
            var _slotFound = -1;
            
            for (var i = 0; i < maxPoisonStacks; i++)
            {
                if (dot_alarms[i][0] == -1)
                {
                    _slotFound = i;
                    break;
                }
            }
            
            if (_slotFound != -1)
            {
                gml_Script_scr_dot_alarm_start(_slotFound, _duration);
                stackInfo[_slotFound][0] = _damage;
                stackInfo[_slotFound][1] = _stacks;
                stackInfo[_slotFound][2] = _duration;
                stackInfo[_slotFound][3] = _player;
                array_push(activeSlots, _slotFound);
                
                if (totalDuration < _duration)
                    totalDuration = _duration;
                
                totalStacks += _stacks;
                
                if (totalStacks > maxPoisonStacks)
                    totalStacks = maxPoisonStacks;
                
                totalDamage += _damage;
                
                if (instance_exists(target))
                    target.poisonTimerMax = totalDuration;
            }
        }
    }
    
    instance_destroy();
}
