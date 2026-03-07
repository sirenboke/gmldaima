self.scr_dot_alarm_initialize = function(arg0)
{
    dot_alarms = array_create(arg0);
    
    for (var i = 0; i < arg0; i++)
    {
        dot_alarms[i] = array_create(2);
        dot_alarms[i][0] = -1;
        dot_alarms[i][1] = -1;
    }
    
    activeDotAlarms = [];
};
