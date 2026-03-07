if (sprite_index == spr_water_circle)
{
    image_xscale = 0.6;
    image_yscale = 0.6;
    color = 16777215;
    
    if (audio_sound_get_gain(ember) == 0)
        audio_sound_gain(ember, 0.5, room_speed);
    
    image_angle += 5;
    draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle + 90, color, image_alpha);
    draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, color, image_alpha);
}

draw_sprite_ext(spr_fireAura, image_index, x, y, 2, 2, 0, c_white, 1);
