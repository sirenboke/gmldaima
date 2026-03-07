move_snap(2, 2);
depth = -101;
size = 0;
count = 0;
x = 120;
y = 560;
image_speed = 0.1;

if (!layer_exists(layer_get_id("Corrupted")))
    layer_create(depth, "Corrupted");

var _layer = layer_get_id("Corrupted");
layer_add_instance(_layer, id);
var _fxdistort2 = fx_create("_filter_heathaze");
fx_set_single_layer(_fxdistort2, true);
layer_set_fx(_layer, _fxdistort2);
