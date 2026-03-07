self.scr_number = function(arg0, arg1, arg2)
{
    var check;
    
    if (!is_string(arg0))
        check = real(arg0);
    else
        return 0;
    
    if (check >= 100)
    {
        var _sign = sign(check);
        check *= _sign;
        var value = string(round(check));
        var sep = arg1;
        var digits = arg2 - 1;
        var res = "";
        var cnt = 0;
        var i = string_length(value);
        
        while (i > 0)
        {
            res = string_char_at(value, i) + res;
            
            if (cnt++ == digits && i > 1)
            {
                cnt = 0;
                res = sep + res;
            }
            
            i--;
        }
        
        return res;
    }
    else
    {
        return string(check);
    }
};
