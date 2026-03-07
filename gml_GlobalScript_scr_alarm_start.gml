self.scr_alarm_start = function(arg0, arg1, arg2)
{
    if (arg1 < 0)
        exit;
    
    var _args = argument_count - 3;
    
    if (arg0 >= 50)
        show_debug_message("TERRITORY BOSS ALARM");
    
    var _extraArg;
    
    if (_args > 0)
    {
        if (arg0 >= 50)
            show_debug_message("Custom alarm " + string(arg0) + " initialized with extra arguments.");
        
        for (var i = 0; i < _args; i++)
        {
            _extraArg[i] = argument[i + 3];
            show_debug_message("Extra argument " + string(i) + ": " + string(_extraArg[i]) + ".");
        }
    }
    
    var sz = array_length(custom_alarm) - 1;
    
    if (arg0 < sz)
    {
        custom_alarm[arg0][0] = max(-1, arg1);
        custom_alarm[arg0][1] = arg2;
        
        if (_args > 0)
        {
            for (var i = 0; i < array_length(_extraArg); i++)
            {
                custom_alarm[arg0][2 + i] = _extraArg[i];
                
                if (arg0 >= 50)
                    show_debug_message("Extra argument " + string(i) + ": " + string(_extraArg[i]) + " added to custom_alarm[" + string(arg0) + "].");
            }
        }
    }
    else
    {
        show_debug_message("Out of range (alarm " + string(arg0) + "). Max alarm id: " + string(sz - 1));
    }
};
