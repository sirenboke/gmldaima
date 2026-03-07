self.scr_updateStats = function(arg0 = -1, arg1 = -1, arg2 = 1)
{
    for (var _v = 0; _v < 4; _v++)
    {
        if (ascended == true)
            canAutoAction[_v] = 0;
        
        if (myVocationInfo[_v][0] >= maxVocationLevel)
        {
            canAutoAction[_v] = 1;
            
            if (ascended == true)
                autoAction[_v] = 1;
        }
        else if (ascended == true)
        {
            canAutoAction[_v] = 0;
            autoAction[_v] = 0;
        }
    }
    
    skillTimer = 0;
    skillBuff = 0;
    buffed = 0;
    maxEnergy = 65 + (level / 1.7) + extraEnergy;
    
    if (extraSpeed > 1.33)
        extraSpeed = 1.33;
    
    skillBonus = 1;
    
    if (global.milestone[8][4] == 1)
    {
        skillBonus += 0.2;
        
        if (myAbilityInfo[4] < 18)
            skillBonus += 0.2;
    }
    
    if (global.milestone[9][4] == 1)
    {
        skillBonus += 0.2;
        
        if (myAbilityInfo[4] < 36)
            skillBonus += 0.2;
    }
    
    auraPowerBonus = 1;
    
    if (global.milestone[4][4] == 1)
    {
        auraPowerBonus += 0.2;
        
        if (auraBonus[myAura] < 50)
            auraPowerBonus += 0.2;
    }
    
    if (global.milestone[5][4] == 1)
    {
        auraPowerBonus += 0.2;
        
        if (auraBonus[myAura] < 200)
            auraPowerBonus += 0.2;
    }
    
    if (global.milestone[6][4] == 1)
    {
        auraPowerBonus += 0.2;
        
        if (auraBonus[myAura] < 500)
            auraPowerBonus += 0.2;
    }
    
    if (global.milestone[7][4] == 1)
    {
        auraPowerBonus += 0.2;
        
        if (auraBonus[myAura] < 1000)
            auraPowerBonus += 0.2;
    }
    
    vpBonus = 1;
    
    if (global.milestone[10][4] == 1)
    {
        var _check = 0;
        
        for (var _v = 0; _v < 4; _v++)
        {
            if (myVocationInfo[_v][0] > 6)
                _check += 1;
        }
        
        if (_check == 0)
            vpBonus += 0.4;
        else
            vpBonus += 0.2;
    }
    
    if (global.milestone[11][4] == 1)
    {
        var _check = 0;
        
        for (var _v = 0; _v < 4; _v++)
        {
            if (myVocationInfo[_v][0] >= maxVocationLevel)
                _check += 1;
        }
        
        if (_check == 0)
            vpBonus += 0.4;
        else
            vpBonus += 0.2;
    }
    
    vpBonus *= (1 + global.corruptionShardEffect[13]);
    var _oldHP = hp;
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
    
    myStatInfo[0][4] += (ceil((((myItemInfo[0][0] * 25) + (myItemInfo[0][1] * 8)) * (myItemInfo[0][0] / 2)) + power(myItemInfo[0][0] + (myItemInfo[0][1] / 3), 1 + (myItemInfo[0][0] / 4.5))) * vocationStatsBonus);
    myStatInfo[1][4] += (((myItemInfo[1][0] / 2) + (myItemInfo[1][1] / 8) + power((myItemInfo[1][0] / 5) + (myItemInfo[1][1] / 20), 1 + (myItemInfo[1][0] / 15))) * vocationStatsBonus);
    myStatInfo[2][4] += ((myItemInfo[2][0] + (myItemInfo[2][1] / 3) + power((myItemInfo[2][0] / 2) + (myItemInfo[2][1] / 10), 1 + (myItemInfo[2][0] / 10))) * vocationStatsBonus);
    myStatInfo[3][4] += (((myItemInfo[3][0] * 2) + (myItemInfo[3][1] / 2) + power((myItemInfo[3][0] / 2) + (myItemInfo[3][1] / 8), 1 + (myItemInfo[3][0] / 10))) * vocationStatsBonus);
    myStatInfo[4][4] += (((myItemInfo[4][0] / 10) + (myItemInfo[4][1] / 4) + power((myItemInfo[4][0] / 2) + (myItemInfo[4][1] / 10), 1 + (myItemInfo[4][0] / 10))) * vocationStatsBonus);
    myStatInfo[5][4] += (((myItemInfo[5][0] * 5) + (myItemInfo[5][1] * 2)) * vocationStatsBonus);
    myStatInfo[6][4] += (ceil((myItemInfo[6][0] * 100) + (myItemInfo[6][1] * 30) + power((myItemInfo[6][0] * 10) + (myItemInfo[6][1] * 3), 1 + (myItemInfo[6][0] / 10))) * vocationStatsBonus);
    myStatInfo[7][4] += (((myItemInfo[7][0] * 4) + myItemInfo[7][1]) * vocationStatsBonus);
    myStatInfo[8][4] += (ceil((((myItemInfo[8][0] * 200) + (myItemInfo[8][1] * 60)) * myItemInfo[8][0]) + power((myItemInfo[8][0] * 2) + (myItemInfo[8][1] / 2), 1 + (myItemInfo[8][0] / 5))) * vocationStatsBonus);
    myStatInfo[9][4] += (ceil((((myItemInfo[9][0] * 30) + (myItemInfo[9][1] * 9)) * (myItemInfo[9][0] / 2)) + power(myItemInfo[9][0] + (myItemInfo[9][1] / 3), 1 + (myItemInfo[9][0] / 4))) * vocationStatsBonus);
    myResistance[0][0] = omyResistance[0][0] - ((myVocationInfo[2][0] - 1) / 100) - global.globalResistanceBonus;
    myDamage[0] = (omyDamage[0] + ((myVocationInfo[3][0] - 1) / 50) + global.globalDamageBonus) * (1 + global.corruptionShardEffect[6]);
    
    for (var r = 1; r <= 3; r++)
        myResistance[0][r] = omyResistance[0][r] - (myTier * 0.1);
    
    for (var r = 0; r <= 1; r++)
    {
        myResistance[1][r] = omyResistance[0][r] - (myTier * 0.05);
        myResistance[2][r] = omyResistance[0][r] - (myTier * 0.05);
    }
    
    for (var z = 1; z <= global.totalAuras; z += 1)
        myMultiplier[z] = 1;
    
    var _gemstoneBonus = [];
    var gemTypes = 6;
    var gemStats = [8, 0, 9];
    
    for (var t = 0; t < gemTypes; t++)
        _gemstoneBonus[t] = 0;
    
    for (var g = 0; g <= 9; g++)
    {
        if (myItemInfo[g][6] != 0)
        {
            var _type = myItemInfo[g][6] - 1;
            var _size = myItemInfo[g][7];
            var _slotBonus = (g == 0 || g == 9) ? 2 : 1;
            _gemstoneBonus[_type] += 0.02 * (1 + _size) * _slotBonus;
        }
    }
    
    for (var gs = 0; gs < 3; gs++)
    {
        var statIndex = gemStats[gs];
        var _oldStat = myStatInfo[statIndex][3];
        myStatInfo[statIndex][3] *= (1 + _gemstoneBonus[gs]);
        myStatInfo[statIndex][4] *= (1 + _gemstoneBonus[gs]);
        show_debug_message("stat " + string(statIndex) + " increased by " + string(_gemstoneBonus[gs] * 100) + "% from inserted gems!");
    }
    
    myResistance[0][1] -= _gemstoneBonus[3];
    myResistance[0][2] -= _gemstoneBonus[4];
    myResistance[0][3] -= _gemstoneBonus[5];
    
    for (var r = 1; r <= 3; r++)
    {
        if (myResistance[0][r] <= 0)
            myResistance[0][r] = 0.01;
    }
    
    show_debug_message("Resistances increased from inserted gems!");
    
    if (class == "archer")
    {
        if (specialized == 2)
        {
            myStatInfo[1][4] = 2.5;
            myStatInfo[0][3] *= 5;
            myStatInfo[0][4] *= 5;
        }
    }
    
    for (var s = 0; s <= 9; s++)
    {
        myStatInfo[s][4] *= (1 + ((ascensionLevel / 10) + (global.totalAscensionLevel / 50)));
        
        if (myStatInfo[s][5] != -1)
            myStatInfo[s][5] = myOrganicCap[s] * (1 + ((ascensionLevel / 10) + (global.totalAscensionLevel / 50)));
    }
    
    myMultiplier[myAura] *= 1 + (auraBonus[myAura] / 100);
    
    if (sub == 1)
    {
        myMultiplier[4] *= 1.1;
        myMultiplier[2] *= 1.1;
    }
    
    if (alarm[8] != -1 || gml_Script_scr_alarm_get(0) > 0)
        myMultiplier[4] *= 1.2;
    
    if (alarm[9] != -1 || gml_Script_scr_alarm_get(1) > 0)
        myMultiplier[2] *= 1.2;
    
    if (gml_Script_scr_alarm_get(2) > 0)
        vpBonus *= 1.2;
    
    if (gml_Script_scr_alarm_get(3) > 0)
        myDamage[0] *= 1.2;
    
    if (gml_Script_scr_alarm_get(4) > 0)
        myResistance[0][0] *= 0.8;
    
    if (gml_Script_scr_alarm_get(5) > 0)
    {
        for (var s = 0; s <= 9; s++)
        {
            myStatInfo[s][4] *= 1.1;
            myStatInfo[s][3] *= 1.1;
        }
    }
    
    if (global.milestone[0][4] == 1)
    {
        myMultiplier[2] *= 1.2;
        
        if (level < 250)
            myMultiplier[2] *= 1.2;
    }
    
    if (global.milestone[1][4] == 1)
    {
        myMultiplier[2] *= 1.2;
        
        if (level < 500)
            myMultiplier[2] *= 1.2;
    }
    
    if (global.milestone[2][4] == 1)
    {
        myMultiplier[2] *= 1.2;
        
        if (level < 1000)
            myMultiplier[2] *= 1.2;
    }
    
    if (global.milestone[3][4] == 1)
    {
        myMultiplier[2] *= 1.2;
        
        if (level < 2500)
            myMultiplier[2] *= 1.2;
    }
    
    show_debug_message(string(name) + " HP and DMG before guild bonuses: " + gml_Script_scr_bigNumber(myStatInfo[8][3]) + " | " + string(myDamage[0]));
    myStatInfo[8][3] *= (1 + (global.farmerGuildLevel / 50));
    myStatInfo[8][4] *= (1 + (global.farmerGuildLevel / 50));
    myDamage[0] += global.hunterGuildLevel / 50;
    show_debug_message(string(name) + " HP and DMG after guild bonuses: " + gml_Script_scr_bigNumber(myStatInfo[8][3]) + " | " + string(myDamage[0]));
    myStatInfo[0][3] *= myMultiplier[3];
    myStatInfo[7][3] *= myMultiplier[3];
    myStatInfo[8][3] *= myMultiplier[1];
    myStatInfo[6][3] *= myMultiplier[1];
    myStatInfo[9][3] *= myMultiplier[5];
    myStatInfo[4][3] *= myMultiplier[5];
    myStatInfo[0][4] *= myMultiplier[3];
    myStatInfo[7][4] *= myMultiplier[3];
    myStatInfo[8][4] *= myMultiplier[1];
    myStatInfo[6][4] *= myMultiplier[1];
    myStatInfo[9][4] *= myMultiplier[5];
    myStatInfo[4][4] *= myMultiplier[5];
    
    if (variable_instance_exists(id, "diaryQuest"))
    {
        var _totalStatMultiplier = 1;
        var _constStatMultiplier = 1;
        
        for (var i = 0; i < global.totalDiaryQuests; i += 1)
        {
            if (global.diaryQuestInfo[i][0] > 0)
            {
                if (diaryQuest[i][2] == 1)
                {
                    if (diaryQuest[i][1] == 1)
                    {
                        if (global.diaryQuestInfo[i][8] > 0)
                            maxEnergy += global.diaryQuestInfo[i][8];
                        
                        if (global.diaryQuestInfo[i][9] > 0)
                            myDamage[0] += global.diaryQuestInfo[i][9];
                        
                        if (global.diaryQuestInfo[i][10] > 0)
                            _totalStatMultiplier += global.diaryQuestInfo[i][10];
                        
                        if (global.diaryQuestInfo[i][11] > 0)
                            _constStatMultiplier += global.diaryQuestInfo[i][11];
                    }
                }
            }
        }
        
        if (_totalStatMultiplier > 1)
        {
            for (var s = 0; s <= 9; s++)
            {
                myStatInfo[s][3] *= _totalStatMultiplier;
                myStatInfo[s][4] *= _totalStatMultiplier;
            }
            
            show_debug_message("Kenji's Diary all stats multiplier: " + string(_totalStatMultiplier));
        }
        
        if (_constStatMultiplier > 1)
        {
            myStatInfo[8][3] *= _constStatMultiplier;
            myStatInfo[8][4] *= _constStatMultiplier;
            show_debug_message("Kenji's Diary constitution multiplier: " + string(_constStatMultiplier));
        }
    }
    
    if (global.djinnInfo[1][0] == 1)
    {
        myStatInfo[0][3] *= (1 + (global.djinnInfo[1][2] / 100));
        myStatInfo[9][3] *= (1 + (global.djinnInfo[1][2] / 100));
        myStatInfo[0][4] *= (1 + (global.djinnInfo[1][2] / 100));
        myStatInfo[9][4] *= (1 + (global.djinnInfo[1][2] / 100));
        show_debug_message("STR and INT multiplied by Djinn");
    }
    
    if (global.djinnInfo[2][0] == 1)
    {
        myStatInfo[3][3] *= (1 + (global.djinnInfo[2][2] / 100));
        myStatInfo[8][3] *= (1 + (global.djinnInfo[2][2] / 100));
        myStatInfo[3][4] *= (1 + (global.djinnInfo[2][2] / 100));
        myStatInfo[8][4] *= (1 + (global.djinnInfo[2][2] / 100));
        show_debug_message("ARM and CON multiplied by Djinn");
    }
    
    myStatInfo[8][3] *= (1 + global.corruptionShardEffect[14]);
    myStatInfo[8][4] *= (1 + global.corruptionShardEffect[14]);
    var _djinnSpeed = 1;
    
    if (global.djinnInfo[3][0] == 1)
    {
        maxEnergy *= (1 + (global.djinnInfo[3][2] / 100));
        _djinnSpeed = 1 + (global.djinnInfo[3][2] / 100);
        show_debug_message("Energy and speed multiplied by Djinn");
    }
    
    maxEnergy *= (1 + global.corruptionShardEffect[15]);
    moveSpeed = (0.5 + (level / 2000)) * (1 + extraSpeed) * _djinnSpeed;
    
    if (myStatInfo[1][5] > 30)
        myStatInfo[1][5] = 30;
    
    if (myStatInfo[2][5] > 100)
        myStatInfo[2][5] = 100;
    
    if (myStatInfo[7][5] > 100)
        myStatInfo[7][5] = 100;
    
    var _hpPercent = hp / myStatInfo[8][3];
    hp = myStatInfo[8][3] * _hpPercent;
    hpRegenHeal = myStatInfo[6][3];
    var _newHP = hp;
    show_debug_message(string(name) + " HP %: " + string(_hpPercent * 100) + "% of " + gml_Script_scr_bigNumber(myStatInfo[8][3]) + " (before: " + gml_Script_scr_bigNumber(_oldHP) + ", after: " + gml_Script_scr_bigNumber(_newHP));
    
    if (specialized != 0)
    {
        for (var i = 0; i < global.globalSpecialBranches; i += 1)
        {
            mySpecialBuff[i] = 0;
            var _extraPoints = floor(mySpecialInfo[classType][specialized - 1][myAbilityInfo[0]][i] / 3);
            mySpecialBuff[i] = (mySpecialInfo[classType][specialized - 1][myAbilityInfo[0]][i] + _extraPoints) * global.globalSpecialInfo[classType][specialized - 1][myAbilityInfo[0]][i][2];
            show_debug_message("Special Points total effect on Branch " + string(i) + ": " + string(mySpecialBuff[i]));
        }
    }
    
    var _return = arg0;
    
    if (arg2 == 1)
        _return = gml_Script_scr_limitStats(arg0, arg1);
    
    if (arg2 == 0)
    {
        for (var _cs = 0; _cs <= 9; _cs++)
        {
            if (myStatInfo[_cs][5] != -1)
            {
                if (myStatInfo[_cs][4] >= myStatInfo[_cs][5])
                {
                    show_debug_message("stat " + string(_cs) + " cap is " + string(myStatInfo[_cs][4] - myStatInfo[_cs][5]) + " too high!");
                    myStatInfo[_cs][4] = myStatInfo[_cs][5];
                }
            }
        }
        
        for (var _s = 0; _s <= 9; _s++)
        {
            if (myStatInfo[_s][3] >= myStatInfo[_s][4])
            {
                show_debug_message("stat " + string(_s) + " is " + string(myStatInfo[_s][3] - myStatInfo[_s][4]) + " too high!");
                myStatInfo[_s][3] = myStatInfo[_s][4];
            }
        }
    }
    
    return _return;
};
