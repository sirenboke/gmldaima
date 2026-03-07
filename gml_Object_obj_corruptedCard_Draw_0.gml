if (gml_Script_live_call())
    return global.live_result;

if (instance_number(obj_corruptedCard) == 1 || x > ((room_width / 2) - 250))
{
    if (instance_exists(obj_raidCorruptedResults))
    {
        if (obj_raidCorruptedResults.alarm[3] > 0)
            _alpha = clamp(0.9 - (obj_raidCorruptedResults.alarm[3] / 100), 0, 1);
    }
    
    draw_sprite_ext(spr_black, 0, 0, 0, 1420, room_height - 300, 0, c_white, 0.85 - _alpha);
}

if (alarm[0] != -1)
{
    image_xscale += 0.04;
    image_yscale += 0.04;
}

if (instance_number(obj_corruptedCard) == 1)
{
    if (distance_to_point((room_width / 2) - 250, y) > 5)
        move_towards_point((room_width / 2) - 250, y, 20);
    else
        x = (room_width / 2) - 250;
}

if ((alarm[2] == -1 && votes == 0) || (instance_exists(obj_raidCorruptedResults) && (obj_raidCorruptedResults.alarm[3] != -1 && obj_raidCorruptedResults.alarm[3] < (room_speed * 2))))
{
    if (image_xscale > 0)
    {
        if (c_votes != 65280)
        {
            image_xscale -= 0.02;
            image_yscale -= 0.02;
            image_angle += random_range(2, 5);
            _alpha2 -= 0.02;
        }
        else
        {
            image_xscale += 0.02;
            image_yscale += 0.02;
            _alpha2 -= 0.01;
        }
    }
    else
    {
        image_xscale = 0;
        image_yscale = 0;
        instance_destroy();
    }
}

draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, c_white, _alpha2);
