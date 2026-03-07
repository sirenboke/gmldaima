with (obj_player)
{
    skillPoints += global.towerBuilding[0][10];
    totalSkillPoints += global.towerBuilding[0][10];
}

show_debug_message("TP Library: +" + string(global.towerBuilding[0][10]) + " TPs.");
gml_Script_twitch_chat_say_direct("/me Underworld's ?Outpost (lv." + string(global.towerBuilding[0][1]) + ") Academy yielded " + gml_Script_scr_bigNumber(global.towerBuilding[0][10]) + " room00Talent");
alarm[7] = global.towerBuilding[0][11] * room_speed;
