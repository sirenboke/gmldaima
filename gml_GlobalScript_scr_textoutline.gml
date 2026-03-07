self.scr_textoutline = function(arg0, arg1, arg2, arg3 = 16777215, arg4 = 0, arg5 = 20, arg6 = 1000)
{
    draw_set_color(arg4);
    draw_text_ext(arg0 - 1, arg1, arg2, arg5, arg6);
    draw_text_ext(arg0 + 1, arg1, arg2, arg5, arg6);
    draw_text_ext(arg0, arg1 - 1, arg2, arg5, arg6);
    draw_text_ext(arg0, arg1 + 2, arg2, arg5, arg6);
    draw_set_color(arg3);
    draw_text_ext(arg0, arg1, arg2, arg5, arg6);
};
