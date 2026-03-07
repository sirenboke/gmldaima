global.towerBuilding[2][1] = floor(100 * (1 + ((global.towerBuilding[2][4] - 1) / 5)) * global.soulBonus * (1 + global.corruptionShardEffect[5]));
global.souls += global.towerBuilding[2][1];
show_debug_message("Soul Extractor: +" + string(global.towerBuilding[2][1]) + " souls.");
gml_Script_twitch_chat_say_direct("/me Underworld's ?Tower 2 " + string(global.towerBuilding[2][0]) + " (lv." + string(global.towerBuilding[2][4]) + ") yielded " + gml_Script_scr_bigNumber(global.towerBuilding[2][1]) + " souls!");
alarm[2] = global.towerBuilding[2][2] * room_speed;
