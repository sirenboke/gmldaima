global.gems += global.towerBuilding[0][13];
show_debug_message("Gem Mine: +" + string(global.towerBuilding[0][13]) + " gems.");
gml_Script_twitch_chat_say_direct("/me Underworld's ?Outpost (lv." + string(global.towerBuilding[0][1]) + ") Gem Mine yielded " + string(global.towerBuilding[0][13]) + " room00Gem !");
alarm[8] = global.towerBuilding[0][14] * room_speed;
