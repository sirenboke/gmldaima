if (instance_exists(votedPlayer))
{
    if (yesVotes > noVotes)
    {
        gml_Script_twitch_chat_say_direct("/me You have decided to switch " + string(votedPlayer.name) + " with " + string(votes) + " votes.");
        
        with (obj_warrior)
        {
            if (name == other.votedPlayer.name)
            {
                if (global.raiding == true)
                    gml_Script_scr_switch(name);
            }
        }
    }
    else
    {
        gml_Script_twitch_chat_say_direct("/me You have decided not to switch " + string(votedPlayer.name) + " with " + string(votes) + " votes.");
    }
}

gml_Script_scr_ds_list_destroy(voteList);
instance_destroy();
