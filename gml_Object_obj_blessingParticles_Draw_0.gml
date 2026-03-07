if (room == r_corrupted)
{
    if (alarm[1] == -1)
    {
        if (half == false)
        {
            if (_alpha < alpha)
                _alpha += spd;
            else
                half = true;
        }
        
        if (half == true)
        {
            _alpha -= spd;
            
            if (alpha <= 0)
                alarm[0] = 1;
        }
        
        x += spd;
        draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, 0, color, _alpha);
    }
    
    if (surface_exists(global.raidFog))
    {
        surface_set_target(global.raidFog);
        gml_Script_draw_set_blend_mode(bm_subtract);
        draw_ellipse_colour(x - ((sprite_width * image_xscale) / 2), y - (sprite_height * image_yscale), x + (sprite_width * image_xscale), y + 5, c_white, c_black, 0);
        gml_Script_draw_set_blend_mode(bm_normal);
        surface_reset_target();
    }
}
