draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, 0, c_white, alpha);

if (alpha > 0.1)
{
    image_yscale += 0.025;
    image_xscale += 0.025;
    x += _spd;
}
else
{
    if (_end == false)
        spd = 1;
    
    _end = true;
    
    if (spd <= (sprite_get_number(spr_groundSprintStop) - 1))
    {
        x += _spd;
        _spd *= 0.85;
    }
    else
    {
        alarm[0] = 1;
    }
}

alpha -= i;
spd += 0.5;
i *= distance;
