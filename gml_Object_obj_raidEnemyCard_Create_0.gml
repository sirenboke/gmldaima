player = -1;
textColor = 16777215;
myTurn = false;
var cw = gml_Script___view_get(e__VW.WView, 0);
var ch = gml_Script___view_get(e__VW.HView, 0);
display_scalex = display_get_gui_width() / cw;
display_scaley = display_get_gui_height() / ch;
show = 0;
showMax = 1;
alarm[0] = room_speed * 5;
spr_itemType[0] = spr_newItems;
spr_index[0] = 0;
show_debug_message("enemy card layer depth: " + string(layer_get_depth(layer)) + " depth:" + string(depth));

enum e__VW
{
    XView,
    YView,
    WView,
    HView,
    Angle,
    HBorder,
    VBorder,
    HSpeed,
    VSpeed,
    Object,
    Visible,
    XPort,
    YPort,
    WPort,
    HPort,
    Camera,
    SurfaceID
}
