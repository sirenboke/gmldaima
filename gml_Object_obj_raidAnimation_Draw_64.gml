if (alarm[1] == -1)
{
    draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, color, alpha);
    
    if (fade == true)
        alpha *= fadeSpeed;
    
    if (follow != -1)
    {
        if (instance_exists(follow))
        {
            x = follow.x;
            y = follow.y;
        }
    }
}
