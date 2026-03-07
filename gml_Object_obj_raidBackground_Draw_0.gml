if (room == r_corrupted)
{
    if (global.dev)
    {
        if (first == false)
            color = 16777215;
        
        if (first == true)
            color = 255;
    }
    else
    {
        color = 16777215;
    }
    
    draw_sprite_ext(sprite_index, image_index, round(x), round(y), image_xscale, image_yscale, 0, color, image_alpha);
}
