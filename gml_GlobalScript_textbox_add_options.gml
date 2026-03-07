self.textbox_add_options = function()
{
    with (textbox)
    {
        s_text_colour = argument[0];
        show_options_when = argument[1];
        option1 = argument[2];
        optioncount = 1;
        
        if (argument_count >= 4)
        {
            option2 = argument[3];
            optioncount = 2;
        }
        
        if (argument_count >= 5)
        {
            option3 = argument[4];
            optioncount = 3;
        }
        
        options_set = true;
    }
};
