noVotes = 0;
yesVotes = 0;
minVotes = 0;
voteList = gml_Script_scr_ds_list_create();

for (var i = 0; i < global.totalPlayers; i++)
{
    with (instance_find(obj_player, i))
    {
        if (afksemi == false)
            other.minVotes += 1;
    }
}

minVotes = ceil(minVotes / 2);
alarm[2] = 1;
cost1 = 0;
cost2 = 0;
cost1type = "gold";
cost2type = "gems";
cost1typeString = cost1type;
cost2typeString = cost2type;
costText = "";
