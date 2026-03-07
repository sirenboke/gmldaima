self.twitch_parse_data = function(arg0, arg1)
{
    var data = arg0;
    var iden = arg1;
    var q = "\"";
    var len = string_length(arg0);
    var pos = string_pos(string(q) + string(arg1) + string(q), arg0);
    
    while (string_char_at(data, pos) != ":")
    {
        pos++;
        
        if (pos > (len - 1))
            return "";
    }
    
    pos++;
    var str = "";
    
    while (string_char_at(data, pos) != ",")
    {
        str = string(str) + string(string_char_at(data, pos));
        pos++;
        
        if (pos > (len - 1))
            return "";
    }
    
    str = string_replace_all(str, " ", "");
    str = string_replace_all(str, "\"", "");
    
    for (var i = 0; i <= 2; i++)
    {
        len = string_length(str);
        
        if (string_char_at(str, len - i) == "}")
            str = string_copy(str, 0, len - (i + 1));
    }
    
    return str;
};
