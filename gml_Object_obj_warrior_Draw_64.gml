if (room != r_corrupted)
{
    draw_sprite_ext(spr_player_shadow, 0, x, y, 1.5, 0.5, 0, c_black, 0.5);
    var _alpha = 1;
    var _color = 16777215;
    
    if (player.ascended == true)
    {
        _alpha = 0.7;
        _color = 65535;
    }
    
    if (!isStunned)
    {
        draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, _color, _alpha);
    }
    else
    {
        gpu_set_fog(true, c_white, 0, 0);
        image_speed = 0;
        draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, _color, _alpha);
        gpu_set_fog(false, c_white, 0, 0);
        moveSpeed = 0;
    }
    
    if (frozen)
        draw_sprite_ext(spr_iceShard, 0, x, room_height - 20, image_xscale, image_yscale, 0, c_white, 0.5);
    else if (freezeStacks > 0)
        draw_sprite_ext(spr_freezeStack, ceil(freezeStacks / 2) - 1, x, room_height - 20, image_xscale, image_yscale, 0, c_white, 0.4);
    
    if (global.dev)
    {
        if (alarm[0] == -1)
        {
            if (instance_exists(target))
            {
                draw_line(x, y, target.x, target.y);
                gml_Script_scr_textshadow(x, y - 50, "State:" + string(state), 16777215, 0, 20, 1000);
                gml_Script_scr_textshadow(x, y - 70, "Rng: " + string(rng) + " | Dist:" + string(distance_to_object(target)), 16777215, 0, 20, 1000);
                gml_Script_scr_textshadow(x, y - 90, "CanAA: " + string(canAttack), 16777215, 0, 20, 1000);
            }
        }
    }
    
    if (alarm[0] == -1)
    {
        if (obj_gameControl.debug)
        {
            draw_set_color(c_white);
            draw_text(x, y - 150, "Raid: " + string(myRaidNumber));
            draw_text(x, y - 170, "Show: " + string(showNumber + 1));
            draw_text(x, y - 50, "Buff: " + string(speedBuff));
            draw_text(x, y - 70, "Speed: " + string(moveSpeed));
        }
        
        if (immune == true)
            draw_sprite(spr_immune, 0, x, y - (height / 2));
        
        if (obj_fog.light > 100 || global.stageType == "Dungeon")
        {
            if (surface_exists(global.raidFog))
            {
                surface_set_target(global.raidFog);
                gml_Script_draw_set_blend_mode(bm_subtract);
                draw_ellipse_colour(x - 120, y - (height / 2) - 120, x + 120, (y - (height / 2)) + 120, c_orange, c_black, 0);
                gml_Script_draw_set_blend_mode(bm_normal);
                surface_reset_target();
            }
        }
    }
}
