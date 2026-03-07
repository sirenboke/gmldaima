if (alarm[0] > 1)
{
    draw_set_alpha((alarm[0] / room_speed) + 0.2);
    draw_line_width_colour(xx, y, xx, room_height - 300, 6, c_white, c_yellow);
    draw_line_width_colour(tx - (xx - x), room_height - 300, tx - (xx - x), ty, 6, c_yellow, c_orange);
    draw_set_alpha(1);
}
