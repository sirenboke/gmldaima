var _alpha = 1;
var _color = 16777215;

if (ascended == true)
{
    _alpha = 0.7;
    _color = 65535;
}

draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, _color, _alpha);
