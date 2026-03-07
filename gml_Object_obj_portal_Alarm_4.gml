global.bloodgems += global.towerBuilding[4][1];
show_debug_message("Blood Gem Mine: +" + string(global.towerBuilding[4][1]) + " blood gems.");
gml_Script_twitch_chat_say_direct("/me Underworld's ?Tower 4 " + string(global.towerBuilding[4][0]) + " (lv." + string(global.towerBuilding[4][4]) + ") yielded " + string(global.towerBuilding[4][1]) + " blood gems!");
alarm[4] = global.towerBuilding[4][2] * room_speed;
