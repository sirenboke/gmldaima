self.scr_textoutlineBIG = function()
{
    draw_set_color(argument[4]);
    draw_text_ext(argument[0] - 2, argument[1] - 2, argument[2], argument[5], argument[6]);
    draw_text_ext(argument[0] + 2, argument[1] + 2, argument[2], argument[5], argument[6]);
    draw_text_ext(argument[0] + 2, argument[1] - 2, argument[2], argument[5], argument[6]);
    draw_text_ext(argument[0] - 2, argument[1] + 2, argument[2], argument[5], argument[6]);
    draw_set_color(argument[3]);
    draw_text_ext(argument[0], argument[1], argument[2], argument[5], argument[6]);
};
