if (!global.console && room == r_1)
{
    if (!global.borderless)
    {
        var _w = display_get_width();
        var _h = display_get_height();
        window_set_fullscreen(false);
        window_set_showborder(false);
        window_set_size(_w, _h);
        window_set_position(0, 0);
        global.borderless = true;
    }
    else
    {
        window_set_showborder(true);
        window_set_size(1920, 1080);
        window_center();
        global.borderless = false;
    }
}
