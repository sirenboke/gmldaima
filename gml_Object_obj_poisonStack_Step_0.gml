gml_Script_scr_alarm_step();
totalDuration -= 1;

for (var i = 0; i < (array_length(custom_alarm) - 1); i++)
{
    if (custom_alarm[i][0] == -1)
    {
        if (stackInfo[i][1] > 0)
        {
            totalStacks -= stackInfo[i][1];
            stackInfo[i][1] = -1;
        }
        
        if (stackInfo[i][0] > 0)
        {
            totalDamage -= stackInfo[i][0];
            stackInfo[i][0] = -1;
        }
    }
}

if (instance_exists(target))
{
    with (target)
    {
        poisonStacks = other.totalStacks;
        poisonTimer = other.totalDuration;
    }
}

var _active = 0;

for (var i = 0; i < (array_length(custom_alarm) - 1); i++)
{
    if (custom_alarm[i][0] != -1)
    {
        _active = 1;
        break;
    }
}

if (_active == 0)
    alarm[1] = 1;

if (instance_exists(target))
{
    x = target.x;
    y = target.y - (target.height / 2);
}
else
{
    alarm[1] = 1;
}
