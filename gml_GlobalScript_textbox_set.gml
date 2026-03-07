self.textbox_set = function(arg0, arg1 = 0, arg2 = 16777215, arg3 = 0, arg4 = 1, arg5 = f_small, arg6, arg7, arg8, arg9, arg10, arg11, arg12)
{
    with (textbox)
    {
        name = arg0;
        general_colour = arg1;
        text_colour = arg2;
        outline_colour = arg3;
        alpha = arg4;
        font = arg5;
        
        if (!is_undefined(arg6))
            sprite = arg6;
        
        if (!is_undefined(arg7))
            mouse_enabled = arg7;
        
        if (!is_undefined(arg8))
            continue_icon = arg8;
        
        if (!is_undefined(arg9))
            separation = arg9;
        
        if (!is_undefined(arg10))
            smart_linebreak = arg10;
        
        if (!is_undefined(arg11))
            sync_sprite = arg11;
        
        if (!is_undefined(arg12))
            sprite_spd = arg12;
        
        mode = "box";
    }
};
