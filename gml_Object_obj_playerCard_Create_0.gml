alarm[11] = 1;
depth = obj_gameControl.depth - 1;
textColor = 16777215;
displayGold = 0;
displayHonor = 0;
myTurn = false;
c_pet = 16777215;
var cw = gml_Script___view_get(e__VW.WView, 0);
var ch = gml_Script___view_get(e__VW.HView, 0);
display_scalex = display_get_gui_width() / cw;
display_scaley = display_get_gui_height() / ch;
spr_itemType[0] = spr_newItems;
spr_index[0] = 0;
gemSize = [];
gemType = [];

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
