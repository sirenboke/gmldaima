global.gold += global.towerBuilding[0][4];
show_debug_message("Gold Mine: +" + string(global.towerBuilding[0][4]) + " gold.");
gml_Script_twitch_chat_say_direct("/me Underworld's ?Outpost (lv." + string(global.towerBuilding[0][1]) + ") Gold Mine yielded " + gml_Script_scr_bigNumber(global.towerBuilding[0][4]) + " gold!");
alarm[5] = global.towerBuilding[0][5] * room_speed;
