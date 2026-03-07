self.textbox_set_sprite = function()
{
    with (textbox)
    {
        textbox_sprite = argument[0];
        textbox_sprite_set = true;
        
        if (argument_count == 2)
            textbox_sprite2 = argument[1];
        else
            textbox_sprite2 = argument[0];
    }
};
