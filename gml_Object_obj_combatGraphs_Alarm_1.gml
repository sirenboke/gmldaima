if (result == 0)
{
    rewardedTalent = 1 + floor(global.townLevel / 4);
    show_debug_message("Raid TP rewards: " + string(rewardedTalent) + " Raid Gems rewards: " + string(rewardedGems));
}
else
{
    rewardedTalent = 0;
}

if (room == r_1)
{
    global.raidTalents += rewardedTalent;
    
    with (obj_raidResults)
    {
        rewardedTalent += other.rewardedTalent;
        rewardedGems += other.rewardedGems;
    }
}
