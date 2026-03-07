if (!variable_instance_exists(id, "duration"))
    duration = room_speed * 5;

if (!variable_instance_exists(id, "stacks"))
    stacks = 1;

if (!variable_instance_exists(id, "dmg"))
    dmg = 1;

if (variable_instance_exists(id, "warrior"))
{
    if (instance_exists(warrior))
    {
        if (variable_instance_exists(warrior, "statusDurationBonus"))
            duration *= warrior.statusDurationBonus;
    }
}

if (duration < 1)
    duration = 1;

stackInfo[0][0] = dmg;
stackInfo[0][1] = stacks;
stackInfo[0][2] = duration;
stackInfo[0][0] *= stackInfo[0][1];
totalStacks = stackInfo[0][1];
totalDuration = stackInfo[0][2];
totalDamage = stackInfo[0][0];
maxPoisonStacks = 500;

for (var i = 1; i < maxPoisonStacks; i++)
{
    stackInfo[i][0] = -1;
    stackInfo[i][1] = -1;
    stackInfo[i][2] = -1;
}

gml_Script_scr_alarm_initialize(maxPoisonStacks);
gml_Script_scr_alarm_start(0, duration);
alarm[2] = room_speed / 5;

if (instance_exists(target) && (target != -4 && target > 0))
{
    with (target)
    {
        var _duration = 5;
        poisonTimerMax = _duration;
        gml_Script_scr_statChange(0.01 * other.stacks, undefined, 12, _duration, undefined);
    }
    
    depth = target.depth - 1;
}

image_xscale = 2;
image_yscale = 2;
image_index = 0;
image_speed = 0.2;
