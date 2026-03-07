if (alarm[0] == -1)
{
    draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, 0, color, alpha);
    alpha -= 0.01;
    
    if (alpha <= 0)
        instance_destroy();
}
