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
