self.scr_parseTime = function()
{
    var s = string(argument0);
    var p = argument1;
    return string_repeat(p, ceil((argument2 - string_length(s)) / string_length(p))) + s;
};

self.scr_dateFormat = function()
{
    var start = 1;
    var t = argument0;
    var fmt = argument1;
    var pos = 1;
    var len = string_length(fmt);
    var out = "";
    
    while (pos <= len)
    {
        if (string_ord_at(fmt, pos) == 37)
        {
            if (pos > start)
                out += string_copy(fmt, start, pos - start);
            
            switch (string_ord_at(fmt, pos + 1))
            {
                case 73:
                    var i = date_get_hour(t) % 12;
                    
                    if (i == 0)
                        i = 12;
                    
                    out += gml_Script_scr_parseTime(i, "0", 2);
                    break;
                
                case 112:
                    var i = date_get_hour(t);
                    
                    if (i >= 12)
                        out += "PM";
                    else
                        out += "AM";
                    
                    break;
                
                case 72:
                    out += gml_Script_scr_parseTime(date_get_hour(t), "0", 2);
                    break;
                
                case 77:
                    out += gml_Script_scr_parseTime(date_get_minute(t), "0", 2);
                    break;
                
                case 83:
                    out += gml_Script_scr_parseTime(date_get_second(t), "0", 2);
                    break;
                
                case 121:
                    out += gml_Script_scr_parseTime(date_get_year(t) % 100, "0", 2);
                    break;
                
                case 89:
                    out += string(date_get_year(t));
                    break;
                
                case 67:
                    out += gml_Script_scr_parseTime(date_get_year(t) div 100, "0", 2);
                    break;
                
                case 109:
                    out += gml_Script_scr_parseTime(date_get_month(t), "0", 2);
                    break;
                
                case 100:
                    out += gml_Script_scr_parseTime(date_get_day(t), "0", 2);
                    break;
                
                case 101:
                    out += gml_Script_scr_parseTime(date_get_day(t), " ", 2);
                    break;
                
                case 119:
                    out += string(date_get_weekday(t));
                    break;
                
                case 117:
                    var i = date_get_weekday(t);
                    
                    if (i == 0)
                        i = 7;
                    
                    out += string(i);
                    break;
                
                case 106:
                    out += gml_Script_scr_parseTime(date_get_day_of_year(t), "0", 3);
                    break;
                
                case 68:
                    out += (gml_Script_scr_parseTime(date_get_month(t), "0", 2) + "/" + gml_Script_scr_parseTime(date_get_day(t), "0", 2) + "/" + gml_Script_scr_parseTime(date_get_year(t) % 100, "0", 2));
                    break;
                
                case 70:
                    out += (string(date_get_year(t)) + "-" + gml_Script_scr_parseTime(date_get_month(t), "0", 2) + "-" + gml_Script_scr_parseTime(date_get_day(t), "0", 2));
                    break;
                
                case 114:
                    var i = date_get_hour(t);
                    var s;
                    
                    if (i >= 12)
                        s = "PM";
                    else
                        s = "AM";
                    
                    i = i % 12;
                    
                    if (i == 0)
                        i = 12;
                    
                    out += (gml_Script_scr_parseTime(i, "0", 2) + ":" + gml_Script_scr_parseTime(date_get_minute(t), "0", 2) + ":" + gml_Script_scr_parseTime(date_get_second(t), "0", 2) + " " + s);
                    break;
                
                case 82:
                    out += (gml_Script_scr_parseTime(date_get_hour(t), "0", 2) + ":" + gml_Script_scr_parseTime(date_get_minute(t), "0", 2));
                    break;
                
                case 84:
                    out += (gml_Script_scr_parseTime(date_get_hour(t), "0", 2) + ":" + gml_Script_scr_parseTime(date_get_minute(t), "0", 2) + ":" + gml_Script_scr_parseTime(date_get_second(t), "0", 2));
                    break;
                
                case 97:
                    var s;
                    
                    switch (date_get_weekday(t))
                    {
                        case 1:
                            s = "Mon";
                            break;
                        
                        case 2:
                            s = "Tue";
                            break;
                        
                        case 3:
                            s = "Wen";
                            break;
                        
                        case 4:
                            s = "Thu";
                            break;
                        
                        case 5:
                            s = "Fri";
                            break;
                        
                        case 6:
                            s = "Sat";
                            break;
                        
                        default:
                            s = "Sun";
                            break;
                    }
                    
                    out += s;
                    break;
                
                case 65:
                    var s;
                    
                    switch (date_get_weekday(t))
                    {
                        case 1:
                            s = "Monday";
                            break;
                        
                        case 2:
                            s = "Tuesday";
                            break;
                        
                        case 3:
                            s = "Wednesday";
                            break;
                        
                        case 4:
                            s = "Thursday";
                            break;
                        
                        case 5:
                            s = "Friday";
                            break;
                        
                        case 6:
                            s = "Saturday";
                            break;
                        
                        default:
                            s = "Sunday";
                            break;
                    }
                    
                    out += s;
                    break;
                
                case 98:
                case 104:
                    var s;
                    
                    switch (date_get_month(t))
                    {
                        case 1:
                            s = "Jan";
                            break;
                        
                        case 2:
                            s = "Feb";
                            break;
                        
                        case 3:
                            s = "Mar";
                            break;
                        
                        case 4:
                            s = "Apr";
                            break;
                        
                        case 5:
                            s = "May";
                            break;
                        
                        case 6:
                            s = "Jun";
                            break;
                        
                        case 7:
                            s = "Jul";
                            break;
                        
                        case 8:
                            s = "Aug";
                            break;
                        
                        case 9:
                            s = "Sep";
                            break;
                        
                        case 10:
                            s = "Oct";
                            break;
                        
                        case 11:
                            s = "Nov";
                            break;
                        
                        case 12:
                            s = "Dec";
                            break;
                        
                        default:
                            s = "???";
                            break;
                    }
                    
                    out += s;
                    break;
                
                case 66:
                    var s;
                    
                    switch (date_get_month(t))
                    {
                        case 1:
                            s = "January";
                            break;
                        
                        case 2:
                            s = "February";
                            break;
                        
                        case 3:
                            s = "March";
                            break;
                        
                        case 4:
                            s = "April";
                            break;
                        
                        case 5:
                            s = "May";
                            break;
                        
                        case 6:
                            s = "June";
                            break;
                        
                        case 7:
                            s = "July";
                            break;
                        
                        case 8:
                            s = "August";
                            break;
                        
                        case 9:
                            s = "September";
                            break;
                        
                        case 10:
                            s = "October";
                            break;
                        
                        case 11:
                            s = "November";
                            break;
                        
                        case 12:
                            s = "December";
                            break;
                        
                        default:
                            s = "Unknown";
                            break;
                    }
                    
                    out += s;
                    break;
                
                case 120:
                    out += date_date_string(t);
                    break;
                
                case 88:
                    out += date_time_string(t);
                    break;
                
                case 99:
                    out += date_datetime_string(t);
                    break;
                
                case 37:
                    out += "%";
                    break;
                
                case 110:
                    out += "\n";
                    break;
                
                case 116:
                    out += "\t";
                    break;
                
                default:
                    out += string_copy(fmt, pos, 2);
            }
            
            pos += 2;
            start = pos;
        }
        else
        {
            pos++;
        }
    }
    
    if (pos > start)
        out += string_copy(fmt, start, pos - start);
    
    return out;
};
