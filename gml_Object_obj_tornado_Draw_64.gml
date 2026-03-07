if (x >= (room_width - 200) || x <= 490)
    spd *= -1;

x += spd;

if (alarm[0] == -1)
{
    alpha -= 0.05;
    
    if (alpha <= 0)
        instance_destroy();
}
else
{
    if (alpha < 0.9)
        alpha += 0.05;
    else
        alpha = 0.9;
    
    if (scale < 4)
        scale += 0.04;
    else
        scale = 4;
}

draw_sprite_ext(sprite_index, image_index, x, y, scale, scale, 0, c_white, alpha);
var _pull = pulling;

with (obj_enemy)
{
    if (distance_to_object(other) <= 30)
    {
        if (_pull > 0)
        {
            if (x > other.x)
                x -= _pull;
            else
                x += _pull;
        }
    }
}
