draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, 0, c_white, alpha);

if (x < maxPos)
{
    x += _spd;
    image_yscale += 0.025;
    image_xscale += 0.025;
    draw_sprite_ext(spr_groundSprint, spd, x + 44, y, 2.5 - (image_xscale * 0.8), 2.5 - (image_yscale * 0.8), 0, c_white, 0.9);
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
        draw_sprite_ext(spr_groundSprintStop, spd, x + 44, y, 2.5 - (image_xscale * 0.8), 2.5 - (image_yscale * 0.8), 0, c_white, 0.9);
    }
    else
    {
        alarm[0] = 1;
    }
}

alpha -= i;
spd += 0.5;
i *= distance;
