self.scr_bigNumber = function(arg0)
{
    if (arg0 >= global.maxNumber)
        arg0 = global.maxNumber;
    
    if (global.avoidLeak == true)
    {
        return string(arg0);
    }
    else
    {
        var check;
        
        if (!is_string(arg0))
            check = round(real(arg0));
        else
            return 0;
        
        var _sign = sign(check);
        check *= _sign;
        
        if (check < 10)
            return string(arg0);
        
        var number_prefix = string(check);
        var number_sufix = "";
        var times = 0;
        var number_string = "";
        
        if (check > 999999)
        {
            for (var i = 0; i < 7; i++)
            {
                if (check > 999999)
                {
                    check /= 1000000;
                    times += 2;
                }
                else
                {
                    break;
                }
            }
        }
        else
        {
            return gml_Script_scr_number(check, ",", 3);
        }
        
        number_prefix = string(check);
        
        if (check >= 10)
            number_prefix = string_format(check, 1, 1);
        
        if (check >= 100)
            number_prefix = string_format(check, 1, 0);
        
        if (check >= 1000)
            number_prefix = gml_Script_scr_bigNumber(round(check));
        
        number_sufix = global.bigNumberLetter[times];
        number_string = number_prefix + number_sufix;
        return string(number_string);
    }
};

self.scr_addValue = function(arg0, arg1)
{
    return min(arg0 + arg1, global.maxNumber);
};
