gml_Script_scr_playsound(s_playerSpawn, 0.9, 1.1, 0.5);

if (buildName != "Witch Hut")
    gml_Script_twitch_chat_say_direct("/me " + string(name) + " proposes to upgrade " + string(buildName) + " for " + string(buildObj.costText) + " gold, type " + string(global.cmdPrefix) + "y to accept or " + string(global.cmdPrefix) + "n to oppose (Need " + string(minVotes) + " votes to accept/cancel this action). [" + string(round(alarm[1] / room_speed)) + "s left]");
else
    gml_Script_twitch_chat_say_direct("/me " + string(name) + " proposes to upgrade " + string(buildName) + " for " + string(buildObj.costText) + " souls, type " + string(global.cmdPrefix) + "y to accept or " + string(global.cmdPrefix) + "n to oppose (Need " + string(minVotes) + " votes to accept/cancel this action). [" + string(round(alarm[1] / room_speed)) + "s left]");
