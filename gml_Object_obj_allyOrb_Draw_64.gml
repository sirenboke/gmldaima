if (alarm[0] > 1)
{
    draw_set_alpha((alarm[0] / room_speed) + 0.2);
    draw_line_width_colour(x, y, tx, ty, 3, c1, c2);
    draw_set_alpha(1);
}
