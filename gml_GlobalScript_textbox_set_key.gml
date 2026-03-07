self.textbox_set_key = function()
{
    with (textbox)
    {
        speak_key = argument[0];
        
        if (argument_count == 2)
            skip_key = argument[1];
    }
};
