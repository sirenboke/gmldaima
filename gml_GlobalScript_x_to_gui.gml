self.x_to_gui = function(arg0, arg1)
{
    var cl = camera_get_view_x(view_camera[0]);
    var ct = camera_get_view_y(view_camera[0]);
    var off_x = arg0 - cl;
    var off_y = arg1 - ct;
    var off_x_percent = off_x / camera_get_view_width(view_camera[0]);
    var off_y_percent = off_y / camera_get_view_height(view_camera[0]);
    var gui_x = off_x_percent * display_get_gui_width();
    var gui_y = off_y_percent * display_get_gui_height();
    return [gui_x, gui_y];
};
