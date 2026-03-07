if (instance_exists(orbit))
{
    xpos = orbit.x + xx;
    ypos = (orbit.y - orbit.height) + yy;
}

if (alarm[1] == -1)
{
    if (x > (room_width - 400))
    {
        visible = false;
        alarm[0] = 1;
        exit;
    }
    
    bgSpd = 0.5 * global.roomSpeed;
    target = instance_nearest(x, y, obj_enemy);
    
    if (instance_exists(target))
    {
        image_angle = point_direction(x, y, target.x, target.y - (target.height / 2));
        
        if (speed < 1)
            speed = 1;
        
        motion_set(point_direction(x, y, target.x, target.y - (target.height / 2)), spd);
        spd *= 1.1;
        image_xscale = 2 + (speed / 15);
    }
    else
    {
        x = xpos;
        y = ypos;
    }
}
else if (alarm[2] == -1)
{
    x = xpos;
    y = ypos;
}
else if (x != xpos || y != ypos)
{
    move_towards_point(xpos, ypos, 2);
}
else
{
    x = xpos;
    y = ypos;
}

draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, c_white, alpha);

if (surface_exists(global.raidFog))
{
    surface_set_target(global.raidFog);
    gml_Script_draw_set_blend_mode(bm_subtract);
    draw_ellipse_colour(x - 15, y - 15, x + 15, y + 15, c_fuchsia, c_black, 0);
    gml_Script_draw_set_blend_mode(bm_normal);
    surface_reset_target();
}
