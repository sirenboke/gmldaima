if (room != r_seasonEnd && room != r_corrupted)
{
    if (surface_exists(global.raidFog))
    {
        gml_Script_draw_set_blend_mode(bm_subtract);
        draw_surface(global.raidFog, 0, 0);
        gml_Script_draw_set_blend_mode(bm_normal);
        surface_set_target(global.raidFog);
        draw_set_color(obj_fog.lightColor);
        draw_rectangle(0, room_height - 340, room_width, room_height, 0);
        
        if (global.finalWar == true)
        {
            draw_set_color(obj_fog.warColor);
            draw_rectangle(0, room_height - 340, room_width, room_height, 0);
        }
        
        if (global.stageType == "Dungeon" || room == global.room_underworld)
        {
            draw_set_color(c_ltgray);
            draw_rectangle(0, room_height - 340, room_width, room_height, 0);
        }
        
        surface_reset_target();
    }
}
