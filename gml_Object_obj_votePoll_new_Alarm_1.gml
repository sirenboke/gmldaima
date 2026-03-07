if (yesVotes > noVotes && cost1 <= cost1type && cost2 <= cost2type)
    gml_Script_scr_upgBuilding(buildObj, undefined, string_digits(buildName), cost1, cost2, cost1typeString, cost2typeString);
else
    gml_Script_twitch_chat_say("/me You have decided not to upgrade " + string(buildName) + " for " + string(costText) + " with " + string(votes) + " votes.");

with (obj_player)
    voted = false;

gml_Script_scr_ds_list_destroy(voteList);
instance_destroy();
