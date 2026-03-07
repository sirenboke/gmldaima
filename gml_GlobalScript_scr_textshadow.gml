self.scr_textshadow = function(arg0, arg1, arg2, arg3 = 16777215, arg4 = 0, arg5 = string_height("W") + 4, arg6 = 1000, arg7 = 1)
{
    draw_text_ext_color(argument[0], argument[1] + 3, argument[2], arg5, arg6, arg4, arg4, arg4, arg4, arg7);
    draw_text_ext_color(argument[0], argument[1], argument[2], arg5, arg6, arg3, arg3, arg3, arg3, arg7);
};
