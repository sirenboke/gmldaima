self.textbox_set_sound = function()
{
    with (textbox)
    {
        textsound = argument[0];
        text_sound = true;
        
        if (argument_count >= 2)
            text_sound_volume = argument[1];
        
        if (argument_count >= 3)
            text_sound_interval = argument[2];
    }
};
