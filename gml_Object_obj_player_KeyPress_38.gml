if (global.dev == 1)
{
    auraBonus[myAura] += 10;
    
    for (var s = 0; s <= 9; s++)
    {
        if (myItemInfo[s][0] == 0)
            myItemInfo[s][0] += 1;
        
        myItemInfo[s][1] += 1;
        
        if (myItemInfo[s][1] >= 4)
        {
            myItemInfo[s][1] = 1;
            myItemInfo[s][0] += 1;
        }
        
        myItemInfo[s][2] = string_repeat("I", myItemInfo[s][1]);
    }
    
    gml_Script_scr_updateStats();
    myMiningLevel += 1;
}
