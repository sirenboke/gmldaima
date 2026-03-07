self.chooses_option = function()
{
    with (textbox)
    {
        if (keyboard_check_pressed(speak_key))
        {
            if (message_current == show_options_when)
            {
                if (characters == message_length)
                {
                    if (selected == 1)
                        return 1;
                    else if (selected == 2)
                        return 2;
                    else if (selected == 3)
                        return 3;
                }
            }
        }
    }
};
