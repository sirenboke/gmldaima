if (global.dev == 1)
{
    for (var s = 0; s <= 9; s++)
    {
        myItemInfo[s][1] -= 1;
        
        if (myItemInfo[s][1] <= 0)
        {
            myItemInfo[s][1] = 3;
            myItemInfo[s][0] -= 1;
        }
        
        if (myItemInfo[s][0] <= 0)
        {
            myItemInfo[s][0] = 0;
            myItemInfo[s][1] = 0;
        }
        
        myItemInfo[s][2] = string_repeat("I", myItemInfo[s][1]);
    }
    
    gml_Script_scr_updateStats();
    
    if (myMiningLevel > 1)
        myMiningLevel -= 1;
}
