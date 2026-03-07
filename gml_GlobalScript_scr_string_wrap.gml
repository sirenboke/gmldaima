self.scr_string_wrap = function(arg0 = "", arg1 = 100)
{
    var str_len = string_length(arg0);
    var last_space = 1;
    var count = 1;
    
    repeat (str_len)
    {
        var substr = string_copy(arg0, 1, count);
        
        if (string_char_at(arg0, count) == " ")
            last_space = count;
        
        if (string_width(substr) > arg1)
        {
            arg0 = string_insert("\n", arg0, last_space);
            count += 1;
        }
        
        count++;
    }
    
    return arg0;
};
