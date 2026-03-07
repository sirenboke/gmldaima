scale += 0.02;

if (alarm[0] < 3)
{
    scale += 0.7;
    alpha -= 0.3;
    
    if (trigger == false)
    {
        trigger = true;
        
        with (instance_create_depth(x, y, depth - 1, obj_raidAnimation))
        {
            sprite_index = spr_frostNova3;
            image_angle = other.angle;
            image_xscale = 2;
            image_yscale = 2;
            spd = room_speed / 2;
            follow = other;
        }
    }
}

if (spd > 0)
{
    if (instance_exists(goto))
    {
        if (distance_to_object(goto) <= 5)
            speed = 0;
    }
}

draw_sprite_ext(spr_frostNova3, 1, x, y, scale, scale, angle, c_white, alpha);
