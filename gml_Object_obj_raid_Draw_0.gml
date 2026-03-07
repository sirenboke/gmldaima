if (room != r_seasonEnd)
{
    if (global.stageType == "Forest" || global.stageType == "Snow Trail")
    {
        if (instance_number(obj_trees) < 60)
            gml_Script_instance_create(random_range(room_width + 100, (room_width * 2) + 100), room_height - 20, obj_trees);
    }
}

if (room == r_1)
{
    if (global.stageType == "Forest")
        draw_sprite(spr_bg2, 4, room_width / 2, room_height - 20);
    
    if (global.stageType == "Underworld")
        draw_sprite(spr_bg2, 1, room_width / 2, room_height - 20);
    
    if (global.stageType == "Dungeon")
        draw_sprite(spr_bg2, 2, room_width / 2, room_height - 20);
    
    if (global.stageType == "Grassland")
        draw_sprite(spr_bg2, 3, room_width / 2, room_height - 20);
    
    if (global.stageType == "Snow Trail")
        draw_sprite(spr_bg2, 5, room_width / 2, room_height - 20);
}

gml_Script_scr_alarm_step();
