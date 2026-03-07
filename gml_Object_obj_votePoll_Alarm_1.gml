if (yesVotes > noVotes && global.gold >= buildObj.cost)
    gml_Script_scr_upgBuilding(buildObj);
else
    gml_Script_twitch_chat_say("/me You have decided not to upgrade " + string(buildName) + " with " + string(votes) + " votes.");

with (obj_player)
    voted = false;

gml_Script_scr_ds_list_destroy(voteList);
instance_destroy();
