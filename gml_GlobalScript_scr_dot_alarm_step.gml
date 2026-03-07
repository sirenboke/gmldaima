self.scr_dot_alarm_step = function()
{
    var i = array_length(activeDotAlarms) - 1;
    
    while (i >= 0)
    {
        var _alarmIndex = activeDotAlarms[i];
        
        if (dot_alarms[_alarmIndex][0] > -1)
        {
            dot_alarms[_alarmIndex][0] -= 1;
            
            if (dot_alarms[_alarmIndex][0] <= 0)
            {
                dot_alarms[_alarmIndex][0] = -1;
                array_delete(activeDotAlarms, i, 1);
            }
        }
        
        i--;
    }
};
