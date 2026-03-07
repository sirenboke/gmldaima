with (obj_player)
    gml_Script_scr_player_reward(global.towerBuilding[0][7] / global.globalXPBonus, 0);

show_debug_message("XP Camp: +" + string(global.towerBuilding[0][7]) + " xp.");
gml_Script_twitch_chat_say_direct("/me Underworld's ?Outpost (lv." + string(global.towerBuilding[0][1]) + ") Training Camp yielded " + gml_Script_scr_bigNumber(global.towerBuilding[0][7]) + " XP!");
alarm[6] = global.towerBuilding[0][8] * room_speed;
