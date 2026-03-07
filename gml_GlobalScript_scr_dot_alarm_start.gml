self.scr_dot_alarm_start = function(arg0, arg1)
{
    dot_alarms[arg0][0] = arg1;
    var _found = false;
    
    for (var i = 0; i < array_length(activeDotAlarms); i++)
    {
        if (activeDotAlarms[i] == arg0)
        {
            _found = true;
            break;
        }
    }
    
    if (!_found)
        array_push(activeDotAlarms, arg0);
};
