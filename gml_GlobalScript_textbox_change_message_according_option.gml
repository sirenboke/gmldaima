self.textbox_change_message_according_option = function()
{
    with (textbox)
    {
        message_to_change = argument[0];
        ifoption1 = argument[1];
        
        if (argument_count >= 3)
            ifoption2 = argument[2];
        
        if (argument_count >= 4)
            ifoption3 = argument[3];
    }
};
