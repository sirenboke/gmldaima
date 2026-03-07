with (obj_player)
{
    if (name == other.name)
    {
        other.yesVotes += (1 + sub);
        other.votes += 1;
        ds_list_add(other.voteList, name);
    }
}

if (votes >= minVotes)
    alarm[1] = 1;
