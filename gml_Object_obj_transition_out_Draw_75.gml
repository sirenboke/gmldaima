if (transparent == false)
    draw_sprite_ext(spr_black, 0, 0, 0, room_width, room_height, 0, c_white, alpha);

if (blank == false)
{
    draw_set_font(f_big);
    draw_set_halign(fa_center);
    draw_sprite_ext(spr_building, 0, room_width / 2, (room_height / 2) + 10, 16, 2, 0, c_white, 0.9);
    
    if (obj_seasonControl.totalSeconds <= obj_seasonControl.seasonMaxTime)
        gml_Script_scr_textoutline(room_width / 2, room_height / 2, "Campaign #" + string(global.season) + " ended.", 16777215, 0, 20, 2000);
}

if (alarm[0] == -1)
{
    if (alpha < 1)
    {
        if (blank == false)
            alpha += 0.003;
        else
            alpha += 0.025;
    }
    else
    {
        alpha = 1;
        
        if (blank == false)
        {
            if (instance_exists(obj_deathRain))
            {
                with (obj_deathRain)
                {
                    part_emitter_clear(global.light_partsys, global.rainpart_emitter);
                    part_emitter_destroy(global.light_partsys, global.rainpart_emitter);
                }
            }
        }
        else
        {
            instance_destroy();
            
            if (room != r_1 && room != r_seasonEnd)
                room_goto(r_1);
            else
                game_end();
        }
    }
}
