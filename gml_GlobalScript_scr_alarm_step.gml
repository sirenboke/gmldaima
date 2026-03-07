self.scr_alarm_step = function()
{
    var sz = array_length(custom_alarm) - 1;
    
    if (object_get_name(object_get_parent(object_index)) == "obj_enemy" || object_get_name(object_index) == "obj_warrior")
    {
        if (isStunned)
        {
            if (custom_alarm[0][0] > 0)
                custom_alarm[0][0]++;
        }
    }
    
    for (var i = 0; i < sz; i++)
    {
        for (var ini = 0; ini < 3; ini++)
        {
            var _extraArg;
            _extraArg[ini] = -1;
        }
        
        if (custom_alarm[i][0] > -1)
        {
            custom_alarm[i][0] -= 1;
            
            if (custom_alarm[i][0] <= 0)
            {
                custom_alarm[i][0] = -1;
                
                if (script_exists(custom_alarm[i][1]))
                {
                    var _extraArg;
                    
                    if (array_length(custom_alarm[i]) > 2)
                    {
                        if (i >= 50)
                            show_debug_message("Alarm " + string(i) + " extra arguments: " + string(array_length(custom_alarm[i]) - 2));
                        
                        for (var ii = 0; ii < (array_length(custom_alarm[i]) - 2); ii++)
                        {
                            _extraArg[i] = custom_alarm[i][ii + 2];
                            show_debug_message("Alarm " + string(i) + " extra argument " + string(ii) + ": " + string(_extraArg[i]));
                        }
                        
                        if (_extraArg[i] != -1)
                            show_debug_message("Execute script with arg0 = " + string(_extraArg[i]));
                    }
                    else
                    {
                        _extraArg[i] = -1;
                    }
                    
                    script_execute(custom_alarm[i][1], _extraArg[i]);
                }
            }
        }
    }
};
