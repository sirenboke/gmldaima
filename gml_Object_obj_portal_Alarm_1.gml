with (obj_player)
{
    if (ascended == false)
    {
        for (var i = 1; i <= global.totalAuras; i++)
        {
            gotAura[i] = 1;
            auraBonus[i] += global.towerBuilding[1][1] * auraPowerBonus;
        }
        
        show_debug_message("Aura Generator: +" + string(global.towerBuilding[1][1]) + "% power to all Auras.");
    }
}

gml_Script_twitch_chat_say_direct("/me Underworld's ?Tower 1 " + string(global.towerBuilding[1][0]) + " (lv." + string(global.towerBuilding[1][4]) + ") yielded " + string(global.towerBuilding[1][1]) + " Aura power to all Auras!");
alarm[1] = global.towerBuilding[1][2] * room_speed;
