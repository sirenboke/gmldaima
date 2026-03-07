if (gml_Script_live_call())
    return global.live_result;

if (name != "Your World")
{
    if (y < (room_height - 300))
    {
        if (!variable_instance_exists(self, "sector") || !variable_instance_exists(self, "level"))
            exit;
        
        var currentRow = ((sector - 1) * 5) + (level - 1);
        var corruptedRow = ((global.corruptedSector - 1) * 5) + (floor(global.corruptedLevel) - 1);
        draw_sprite_ext(sprite_index, image_index, x, y + yy, image_xscale, image_yscale, image_angle, c_white, 1);
    }
}
else
{
    sprite_index = spr_corruptedWorld;
    image_angle += 0.1;
    
    if (image_angle >= 360)
        image_angle = 0;
    
    draw_sprite_ext(sprite_index, image_index, x, y + 40 + (yy / 5), image_xscale, image_yscale, image_angle, c_white, 1);
}
