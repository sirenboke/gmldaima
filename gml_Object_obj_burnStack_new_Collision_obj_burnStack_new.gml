if (expired == true)
    exit;

if (target == other.target && other.id > id)
{
    if (instance_exists(target))
    {
        var _myStackCount = array_length(stackOwners);
        var _otherStackCount = array_length(other.stackOwners);
        
        if (global.dev)
        {
            show_debug_message("═══════════════════════════════════════");
            show_debug_message("🔥 BURN FUSION START");
            show_debug_message("Target: " + object_get_name(target.object_index));
            show_debug_message("Total instances ANTES: " + string(totalBurnInstances));
            show_debug_message("Incoming stacks: " + string(_otherStackCount));
            show_debug_message("Incoming raw total: " + string(other.dmg));
        }
        
        var _incomingDamageReduced = 0;
        
        for (var i = 0; i < _otherStackCount; i++)
        {
            var _incomingDmg = other.stackDamage[i];
            var _age = current_time - other.stackTimestamp[i];
            var _durationMs = (other.duration / room_speed) * 1000;
            var _frameDuration = 1000 / room_speed;
            
            if (_age >= (_durationMs - _frameDuration))
                continue;
            
            var _effectiveness = gml_Script_scr_burn_effectiveness(totalBurnInstances);
            var _finalDmg = _incomingDmg * _effectiveness;
            
            if ((_myStackCount + i) < 20)
            {
                array_push(stackOwners, other.stackOwners[i]);
                array_push(stackDamage, _finalDmg);
                array_push(stackTimestamp, other.stackTimestamp[i]);
            }
            
            _incomingDamageReduced += _finalDmg;
            totalBurnInstances++;
        }
        
        dmg += _incomingDamageReduced;
        
        if (global.dev)
        {
            show_debug_message("Incoming AFTER diminishing: " + string(_incomingDamageReduced));
            show_debug_message("Reduction: " + string((1 - (_incomingDamageReduced / other.dmg)) * 100) + "%");
            show_debug_message("Total instances DESPUÉS: " + string(totalBurnInstances));
            show_debug_message("New total damage: " + string(dmg));
            show_debug_message("Physical stacks: " + string(min(array_length(stackOwners), 20)));
            show_debug_message("═══════════════════════════════════════");
        }
        
        fireStacks = min(array_length(stackOwners), 20);
        player = other.player;
        
        if (target.burnStacks < 20)
        {
            if (other.duration > duration)
                duration = other.duration;
            
            alarm[1] = duration;
            var _oldStacks = target.burnStacks;
            target.burnStacks = fireStacks;
            
            if (target.burnStacks > 20)
                target.burnStacks = 20;
            
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
