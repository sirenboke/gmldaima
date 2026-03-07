self.scr_textgradient = function(arg0, arg1, arg2, arg3 = 16777215, arg4 = 12632256, arg5 = 0, arg6 = 20, arg7 = 400, arg8 = "none", arg9 = "none", arg10 = 1)
{
    if (arg8 == "none")
        arg8 = arg3;
    
    if (arg9 == "none")
        arg9 = arg4;
    
    draw_text_ext_color(arg0 - 1, arg1, arg2, arg6, arg7, arg5, arg5, arg5, arg5, arg10);
    draw_text_ext_color(arg0 + 1, arg1, arg2, arg6, arg7, arg5, arg5, arg5, arg5, arg10);
    draw_text_ext_color(arg0, arg1 - 1, arg2, arg6, arg7, arg5, arg5, arg5, arg5, arg10);
    draw_text_ext_color(arg0, arg1 + 2, arg2, arg6, arg7, arg5, arg5, arg5, arg5, arg10);
    draw_text_ext_colour(arg0, arg1, arg2, arg6, arg7, arg3, arg8, arg4, arg9, arg10);
};
