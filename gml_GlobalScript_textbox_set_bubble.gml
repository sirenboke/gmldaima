self.textbox_set_bubble = function()
{
    with (textbox)
    {
        name = argument[0];
        general_colour = argument[1];
        text_colour = argument[2];
        alpha = argument[3];
        font = argument[4];
        separation = argument[5];
        bubble_width = argument[6];
        object_talking = argument[7];
        
        if (argument_count >= 9)
            mouse_enabled = argument[8];
        
        if (argument_count >= 10)
            continue_icon = argument[9];
        
        if (argument_count >= 11)
            sprite_spd = argument[10];
        
        mode = "bubble";
    }
};
