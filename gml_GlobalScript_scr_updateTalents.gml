self.scr_updateTalents = function()
{
    myItemInfo[0][3] = ((myItemInfo[0][0] * 2) + (myItemInfo[0][1] / 2)) * (myItemInfo[0][0] / 2);
    myItemInfo[1][3] = ((myItemInfo[1][0] / 6) + (myItemInfo[1][1] / 10)) * (myItemInfo[1][0] / 6);
    myItemInfo[2][3] = (myItemInfo[2][0] / 2) + (myItemInfo[2][1] / 7);
    myItemInfo[3][3] = myItemInfo[3][0] + (myItemInfo[3][1] / 4);
    myItemInfo[4][3] = (myItemInfo[4][0] / 3) + (myItemInfo[4][1] / 10);
    myItemInfo[5][3] = (myItemInfo[5][0] / 2) + (myItemInfo[5][1] / 8);
    myItemInfo[6][3] = (myItemInfo[6][0] + (myItemInfo[6][1] / 4)) * (myItemInfo[6][0] / 2);
    myItemInfo[7][3] = myItemInfo[7][0] + (myItemInfo[7][1] / 4);
    myItemInfo[8][3] = ((myItemInfo[8][0] * 5) + myItemInfo[8][1]) * (myItemInfo[8][0] / 2);
    myItemInfo[9][3] = ((myItemInfo[9][0] * 3.5) + (myItemInfo[9][1] / 2)) * (myItemInfo[9][0] / 2);
    var _vocBonus = 0;
    
    for (var _v = 0; _v < 4; _v++)
        _vocBonus += myVocationInfo[_v][0];
    
    vocationStatsBonus = 1 + ((_vocBonus - 4) / 100);
    
    for (var s = 0; s <= 9; s++)
    {
        baseStat[s][1] = (level * 2) + ceil(power(myItemInfo[s][0] + (myItemInfo[s][1] / 3), 3.5));
        myStatInfo[s][4] = myStatInfo[s][2];
        
        if (myStatInfo[s][2] == -1)
            myStatInfo[s][4] = -1;
        
        myStatInfo[s][3] = ((myStatInfo[s][0] * ((myStatInfo[s][1] * level) - (level - 1))) + (baseStat[s][0] / global.talentValue[s]) + myItemInfo[s][3]) * (1 + (myItemInfo[s][3] / 100)) * vocationStatsBonus;
    }
    
    myStatInfo[0][4] += ceil((((myItemInfo[0][0] * 25) + (myItemInfo[0][1] * 8)) * (myItemInfo[0][0] / 2)) + power(myItemInfo[0][0] + (myItemInfo[0][1] / 3), 1 + (myItemInfo[0][0] / 4.5)));
    myStatInfo[1][4] += ((myItemInfo[1][0] / 2) + (myItemInfo[1][1] / 8) + power((myItemInfo[1][0] / 5) + (myItemInfo[1][1] / 20), 1 + (myItemInfo[1][0] / 15)));
    myStatInfo[2][4] += (myItemInfo[2][0] + (myItemInfo[2][1] / 3) + power((myItemInfo[2][0] / 2) + (myItemInfo[2][1] / 10), 1 + (myItemInfo[2][0] / 10)));
    myStatInfo[3][4] += ((myItemInfo[3][0] * 2) + (myItemInfo[3][1] / 2) + power((myItemInfo[3][0] / 2) + (myItemInfo[3][1] / 8), 1 + (myItemInfo[3][0] / 10)));
    myStatInfo[4][4] += ((myItemInfo[4][0] / 10) + (myItemInfo[4][1] / 4) + power((myItemInfo[4][0] / 2) + (myItemInfo[4][1] / 10), 1 + (myItemInfo[4][0] / 10)));
    myStatInfo[5][4] += ((myItemInfo[5][0] * 5) + (myItemInfo[5][1] * 2));
    myStatInfo[6][4] += ceil((myItemInfo[6][0] * 100) + (myItemInfo[6][1] * 30) + power((myItemInfo[6][0] * 10) + (myItemInfo[6][1] * 3), 1 + (myItemInfo[6][0] / 10)));
    myStatInfo[7][4] += ((myItemInfo[7][0] * 4) + myItemInfo[7][1]);
    myStatInfo[8][4] += ceil((((myItemInfo[8][0] * 200) + (myItemInfo[8][1] * 60)) * myItemInfo[8][0]) + power((myItemInfo[8][0] * 2) + (myItemInfo[8][1] / 2), 1 + (myItemInfo[8][0] / 5)));
    myStatInfo[9][4] += ceil((((myItemInfo[9][0] * 30) + (myItemInfo[9][1] * 9)) * (myItemInfo[9][0] / 2)) + power(myItemInfo[9][0] + (myItemInfo[9][1] / 3), 1 + (myItemInfo[9][0] / 4)));
    myResistance[0][0] = omyResistance[0][0] - ((myVocationInfo[2][0] - 1) / 100) - global.globalResistanceBonus;
    myDamage[0] = omyDamage[0] + ((myVocationInfo[3][0] - 1) / 50) + global.globalDamageBonus;
    
    for (var z = 1; z <= maxAuras; z += 1)
        myMultiplier[z] = 1;
    
    myMultiplier[myAura] *= 1 + (auraBonus[myAura] / 100);
    myStatInfo[0][3] *= myMultiplier[3];
    myStatInfo[7][3] *= myMultiplier[3];
    myStatInfo[8][3] *= myMultiplier[1];
    myStatInfo[9][3] *= myMultiplier[5];
    myStatInfo[4][3] *= myMultiplier[5];
    myStatInfo[0][4] *= myMultiplier[3];
    myStatInfo[7][4] *= myMultiplier[3];
    myStatInfo[8][4] *= myMultiplier[1];
    myStatInfo[6][4] *= myMultiplier[1];
    myStatInfo[9][4] *= myMultiplier[5];
    myStatInfo[4][4] *= myMultiplier[5];
};
