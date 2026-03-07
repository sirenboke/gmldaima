self.scr_updateTime = function()
{
    if (global.seasonTime > 8640000)
        global.seasonTime = 8640000;
    
    if (global.seasonTime < 60)
        global.seasonTime = 60;
    
    with (obj_seasonControl)
    {
        maxDays = global.seasonTime / 60 / 60 / 24;
        
        if (maxDays != floor(maxDays))
        {
            maxHours = (maxDays - floor(maxDays)) * 24;
            maxDays = floor(maxDays);
        }
        else
        {
            maxHours = 0;
        }
        
        if (maxHours != floor(maxHours))
        {
            maxMinutes = (maxHours - floor(maxHours)) * 60;
            maxHours = floor(maxHours);
        }
        else
        {
            maxMinutes = 0;
        }
        
        if (maxMinutes != floor(maxMinutes))
        {
            maxSeconds = floor((maxMinutes - floor(maxMinutes)) * 60);
            maxMinutes = floor(maxMinutes);
        }
        else
        {
            maxSeconds = 0;
        }
    }
};
