if (gml_Script_live_call())
    return global.live_result;

if (room == r_corrupted)
{
    if (!instance_exists(obj_corruptedCard))
    {
        draw_sprite_ext(spr_black, 0, 0, 0, 1420, 210, 0, c_white, 0.9);
        draw_sprite_ext(spr_black, 0, 0, 680, 1420, 70, 0, c_white, 0.5);
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        draw_set_font(f_big);
        gml_Script_scr_textgradient((room_width / 2) - 250, 100, "Sector " + string(global.corruptedSector) + ":" + string(floor(global.corruptedLevel)));
        gml_Script_scr_textgradient((room_width / 2) - 250, 700, string(global.totalCorruption) + "% Corruption", 255, 128);
        draw_set_font(f_midbig);
        gml_Script_scr_textgradient((room_width / 2) - 250, 140, "Choose your next destination with !island#", undefined, undefined, undefined, undefined, 1000);
        draw_set_font(f_mid);
        
        if (alarm[1] > 1)
            gml_Script_scr_textgradient((room_width / 2) - 250, 180, "(" + string(round(alarm[1] / room_speed)) + "s left to decide)", undefined, undefined, undefined, undefined, 1000);
        else if (alarm[2] == -1)
            gml_Script_scr_textgradient((room_width / 2) - 250, 180, "(traveling to the Shattered Island...)", undefined, undefined, undefined, undefined, 1000);
        else
            gml_Script_scr_textgradient((room_width / 2) - 250, 180, "(leaving the Corrupted Dimension...)", undefined, undefined, undefined, undefined, 1000);
    }
    
    if (alarm[1] != -1 || alarm[2] != -1)
    {
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        draw_set_font(f_midbig);
        
        if (!instance_exists(obj_raidTransition) && !instance_exists(obj_stageTransition))
        {
            if (accepted == true)
                gml_Script_scr_textgradient(room_width / 2, room_height - 150, "Traveling to your destination...", undefined, undefined, undefined, 35, 1400);
            else
                gml_Script_scr_textgradient(room_width / 2, room_height - 150, "Corruption is spreading endlessly over the universe...\nTo prevent your World from collapsing you must restore its reality by retreiving and consuming Corruption Shards throughout the Shattered Islands.", undefined, undefined, undefined, 35, 1200);
        }
    }
}

if (alarm[0] != -1 && alarm[0] <= (room_speed * 60))
{
    if (room == r_underworld || (global.raiding == true || global.raidCall == true || (obj_raid.alarm[9] != -1 && obj_raid.alarm[9] <= (room_speed * 120))) || global.inFinalWar == true)
    {
        if (alarm[0] <= (room_speed * 60))
            alarm[0] = room_speed * 60;
    }
}

if (instance_exists(obj_corruptedCard))
{
    if (instance_exists(obj_raidCorruptedResults) && (obj_raidCorruptedResults.alarm[3] == -1 || obj_raidCorruptedResults.alarm[3] > (room_speed * 2)))
    {
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        draw_set_font(f_big);
        gml_Script_scr_textgradient((room_width / 2) - 250, 200, "Pick a Corruption Shard", 65535, 4235519, undefined, undefined, 1000);
        draw_set_font(f_mid);
        gml_Script_scr_textgradient((room_width / 2) - 250, 650, "Corruption Shards are obtained after restoring a Shattered Island, granting permanent bonuses when consumed.", 16777215, 8421504, undefined, undefined, 1400);
        draw_set_font(f_midbig);
        
        if (instance_exists(obj_raidCorruptedResults))
        {
            if (obj_raidCorruptedResults.alarm[1] > 1)
                gml_Script_scr_textgradient((room_width / 2) - 250, 240, "(" + string(round(obj_raidCorruptedResults.alarm[1] / room_speed)) + "s)", undefined, undefined, undefined, undefined, 1000);
        }
    }
}
