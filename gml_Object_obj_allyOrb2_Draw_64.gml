if (alarm[1] == -1)
{
    if (instance_exists(target) && instance_exists(parent))
    {
        if (alarm[0] > 1)
        {
            draw_set_alpha((alarm[0] / room_speed) + 0.2);
            draw_line_width_colour(parent.x, parent.y - (parent.sprite_height / 1.5), target.x, yy, 3, c_dkgray, c_ltgray);
            draw_set_alpha(1);
        }
    }
    else
    {
        instance_destroy();
    }
}
