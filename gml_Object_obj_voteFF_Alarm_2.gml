with (obj_player)
{
    if (name == other.voteName)
    {
        other.yesVotes += 1;
        other.votes += 1;
        ds_list_add(other.voteList, name);
    }
}

if (votes >= minVotes)
    alarm[1] = 1;
