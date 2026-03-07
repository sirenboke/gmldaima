with (obj_raid)
{
    if (territoryRewardsCycle < 2.5)
    {
        territoryRewardsCycle += 0.5;
    }
    else
    {
        territoryRewardsCycle = 0;
        
        if (territoryBossesDisplayPage < floor((global.ostage - 50) / 250))
            territoryBossesDisplayPage += 1;
        else
            territoryBossesDisplayPage = 0;
        
        if (territoryBossesDisplayMain < floor(global.ostage / 50))
            territoryBossesDisplayMain += 1;
        else
            territoryBossesDisplayMain = 1;
    }
}

if (instance_exists(obj_build_witchhut))
{
    with (obj_build_witchhut)
    {
        gemDisplay += 0.25;
        
        if (gemDisplay >= 7)
            gemDisplay = 1;
        
        if (displayTab == 0)
        {
            if (gemDisplay == 1)
                displayTab = 1;
        }
        else if (gemDisplay == 1)
        {
            displayTab = 0;
        }
    }
}

if (instance_exists(obj_seasonControl))
{
    with (obj_seasonControl)
    {
        tabDisplay += 0.1;
        
        if (tabDisplay == 2)
            tabDisplay = 0;
    }
}

alarm[6] = room_speed;
