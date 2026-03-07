with (obj_warrior)
{
    if (ascended == true)
    {
        reposition = ds_list_find_index(raidList, string("Z" + string(raidPos) + string(player.levelRaid) + string(name)));
    }
    else
    {
        if (player.levelRaid < 10)
            reposition = ds_list_find_index(raidList, string(string(raidPos) + "A" + string(player.levelRaid) + string(name)));
        
        if (player.levelRaid >= 10 && player.levelRaid <= 99)
            reposition = ds_list_find_index(raidList, string(string(raidPos) + "B" + string(player.levelRaid) + string(name)));
        
        if (player.levelRaid >= 100 && player.levelRaid <= 999)
            reposition = ds_list_find_index(raidList, string(string(raidPos) + "C" + string(player.levelRaid) + string(name)));
        
        if (player.levelRaid >= 1000 && player.levelRaid <= 9999)
            reposition = ds_list_find_index(raidList, string(string(raidPos) + "D" + string(player.levelRaid) + string(name)));
        
        if (player.levelRaid >= 10000 && player.levelRaid <= 99999)
            reposition = ds_list_find_index(raidList, string(string(raidPos) + "E" + string(player.levelRaid) + string(name)));
        
        if (player.levelRaid >= 100000)
            reposition = ds_list_find_index(raidList, string(string(raidPos) + "F" + string(player.levelRaid) + string(name)));
    }
    
    myRaidNumber = reposition;
    showNumber = reposition;
    mainChar = false;
    
    if (raidList == global.raidList0)
    {
        xx = 400 - (myRaidNumber * 100);
        x = -50 - (myRaidNumber * 100);
        mainChar = true;
    }
    
    if (raidList == global.raidList1)
    {
        xx = 350 - (myRaidNumber * 100);
        x = -100 - (myRaidNumber * 100);
    }
    
    if (ds_list_size(global.raidList0) <= 0)
        mainChar = true;
    
    alarm[11] = room_speed * 90;
    alarm[2] = 1;
    
    if (class == "warrior")
    {
        if (classSpecialization[2] == 1)
        {
            with (obj_warrior)
            {
                if (id != other.id)
                {
                    myStatInfo[3][2] += (other.myStatInfo[3][2] * 0.1);
                    omaxhp += (other.omaxhp * 0.1);
                    myStatInfo[6][2] += (other.myStatInfo[6][2] * 0.1);
                }
            }
        }
    }
    
    if (class == "warrior" && myRaidNumber == 0)
    {
        with (obj_warrior)
        {
            if (raidList == global.raidList1)
            {
                if (myRaidNumber == 0)
                {
                    show_debug_message(string(name) + " i got dmg resistance buff.");
                    myResistance[0][0] -= 0.1;
                }
            }
        }
    }
}
