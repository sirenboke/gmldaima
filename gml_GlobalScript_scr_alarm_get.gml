self.scr_alarm_get = function(arg0)
{
    var sz = array_length(custom_alarm) - 1;
    
    if (arg0 < sz)
        return custom_alarm[arg0][0];
    else
        show_debug_message("Out of range (alarm " + string(arg0) + "). Max alarm id: " + string(sz - 1));
};
