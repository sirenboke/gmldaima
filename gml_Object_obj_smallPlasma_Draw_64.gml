if (alarm[0] == -1)
{
    _image_index += _image_speed;
    
    if (_image_index > sprite_get_number(spr_smallPlasma_long))
        _image_index = 0;
    
    draw_sprite_ext(spr_smallPlasma_long, _image_index, x, y, (1 / sprite_get_width(spr_smallPlasma_long)) * distance, image_yscale / 2, angle, c_purple, alpha);
    alpha -= 0.05;
}

if (alpha <= 0)
    instance_destroy();
