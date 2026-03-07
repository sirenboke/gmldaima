if (room != r_corrupted)
{
    if (surface_exists(global.townFog))
    {
        gml_Script_draw_set_blend_mode(bm_subtract);
        draw_surface(global.townFog, 0, 0);
        gml_Script_draw_set_blend_mode(bm_normal);
        surface_set_target(global.townFog);
        draw_set_color(lightColor);
        draw_rectangle(0, 0, room_width, room_height, 0);
        
        if (global.finalWar == true)
        {
            draw_set_color(warColor);
            draw_rectangle(0, 0, room_width, room_height, 0);
        }
        
        surface_reset_target();
    }
}
