if (alarm[0] == -1)
{
    draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, 0, c_white, alpha);
    
    if ((y + 50) < fallLimit)
    {
        y += 50;
    }
    else
    {
        y = fallLimit;
        
        if (alarm[2] == -1)
        {
            if (alpha == 1)
                alarm[2] = duration;
            
            alpha -= 0.025;
            
            if (alpha <= 0)
                instance_destroy();
        }
    }
}

if (surface_exists(global.raidFog))
{
    surface_set_target(global.raidFog);
    gml_Script_draw_set_blend_mode(bm_subtract);
    draw_ellipse_colour(x - 10, y - 50, x + 10, y + 5, c_white, c_black, 0);
    gml_Script_draw_set_blend_mode(bm_normal);
    surface_reset_target();
}
