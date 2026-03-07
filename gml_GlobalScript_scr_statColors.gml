self.scr_statColors = function()
{
    for (var i = 0; i < 10; i++)
    {
        if (myStatInfo[i][3] == myStatInfo[i][1])
        {
            c_stat[i] = 16777215;
        }
        else if (myStatInfo[i][3] > myStatInfo[i][1])
        {
            c_stat[i] = 65280;
            
            if (myStatInfo[i][3] >= myStatInfo[i][4])
                c_stat[i] = 65535;
            
            if (myStatInfo[i][3] >= myStatInfo[i][5])
                c_stat[i] = 16776960;
        }
        else if (myStatInfo[i][3] < myStatInfo[i][1])
        {
            c_stat[i] = 4235519;
        }
        
        if (myStatInfo[i][3] < myStatInfo[i][2] && myStatInfo[i][3] <= (myStatInfo[i][2] * 0.1))
            c_stat[i] = 255;
    }
    
    if ((hpRegenHeal * healReduction) > myStatInfo[6][1])
        c_stat[6] = 65280;
    
    for (var ii = 0; ii < 4; ii++)
    {
        if (myResistance[0][ii] == omyResistance[0][ii])
            c_dmgReduction[ii] = 16777215;
        else if (myResistance[0][ii] < omyResistance[0][ii])
            c_dmgReduction[ii] = 65280;
        else if (myResistance[0][ii] > omyResistance[0][ii])
            c_dmgReduction[ii] = 4235519;
    }
    
    for (var ii = 0; ii < 2; ii++)
    {
        if (myResistance[1][ii] == omyResistance[1][ii])
            c_ccReduction[ii] = 16777215;
        else if (myResistance[1][ii] < omyResistance[1][ii])
            c_ccReduction[ii] = 65280;
        else if (myResistance[1][ii] > omyResistance[1][ii])
            c_ccReduction[ii] = 4235519;
        
        if (myResistance[2][ii] == omyResistance[2][ii])
            c_debuffReduction[ii] = 16777215;
        else if (myResistance[2][ii] < omyResistance[2][ii])
            c_debuffReduction[ii] = 65280;
        else if (myResistance[2][ii] > omyResistance[2][ii])
            c_debuffReduction[ii] = 4235519;
    }
    
    for (var ii = 0; ii <= global.damageTypes; ii++)
    {
        if (myDamage[ii] == omyDamage[ii])
            c_dmgBuff[ii] = 16777215;
        else if (myDamage[ii] > omyDamage[ii])
            c_dmgBuff[ii] = 65280;
        else if (myDamage[ii] < omyDamage[ii])
            c_dmgBuff[ii] = 4235519;
    }
    
    if (healReduction < 1)
    {
        c_stat[6] = 4235519;
        c_stat[5] = 4235519;
    }
};
