self.copy_words = function(arg0, arg1, arg2)
{
    var char = string_char_at(arg0, arg2);
    
    while (char != " " && char != "")
    {
        arg2++;
        char = string_char_at(arg0, arg2);
    }
    
    var final_text = string_copy(arg0, arg1, arg2);
    return final_text;
};
