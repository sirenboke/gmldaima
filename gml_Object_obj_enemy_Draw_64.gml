if (room != r_corrupted)
{
    if (!isStunned)
    {
        draw_self();
    }
    else
    {
        gpu_set_fog(true, c_white, 0, 0);
        draw_self();
        gpu_set_fog(false, c_white, 0, 0);
        moveSpeed = 0;
    }
    
    if (frozen)
        draw_sprite_ext(spr_iceShard, 0, x, room_height - 20, image_xscale, image_yscale, 0, c_white, 0.5);
    else if (freezeStacks > 0)
        draw_sprite_ext(spr_freezeStack, ceil(freezeStacks / 2) - 1, x, room_height - 20, image_xscale, image_yscale, 0, c_white, 0.4);
    
    if (immune == true)
        draw_sprite(spr_immune, 0, x, y - (height / 2));
    
    if (class == "alpha" || class == "boss")
    {
        if (surface_exists(global.raidFog))
        {
            surface_set_target(global.raidFog);
            gml_Script_draw_set_blend_mode(bm_subtract);
            draw_ellipse_colour(x - 200, y - (height / 2) - 200, x + 200, (y - (height / 2)) + 200, #00FA96, c_black, 0);
            gml_Script_draw_set_blend_mode(bm_normal);
            surface_reset_target();
        }
    }
    
    if (global.dev == 1)
    {
        draw_set_alpha(0.5);
        draw_rectangle_colour(bbox_left, bbox_top, bbox_right, bbox_bottom, c_red, c_red, c_red, c_red, false);
        draw_set_alpha(1);
    }
}
