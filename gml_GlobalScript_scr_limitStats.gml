self.scr_limitStats = function(arg0 = 0, arg1 = -1)
{
    var _removedTPs;
    _removedTPs[0] = 0;
    var _diff;
    _diff[0] = 0;
    
    for (var _s = 0; _s <= 9; _s++)
    {
        if (myStatInfo[_s][5] != -1)
        {
            if (myStatInfo[_s][4] >= myStatInfo[_s][5])
                myStatInfo[_s][4] = myStatInfo[_s][5];
        }
        
        if (myStatInfo[_s][6] != -1 && myStatInfo[_s][4] > myStatInfo[_s][6])
            myStatInfo[_s][4] = myStatInfo[_s][6];
        
        _diff[_s] = 0;
        _removedTPs[_s] = 0;
        
        if (myStatInfo[_s][3] > myStatInfo[_s][4])
        {
            var _isolatestattps;
            _isolatestattps[_s] = ((myStatInfo[_s][0] * ((myStatInfo[_s][1] * level) - (level - 1))) + myItemInfo[_s][3]) * (1 + (myItemInfo[_s][3] / 100)) * vocationStatsBonus;
            
            if (_s == 8)
            {
                _isolatestattps[_s] *= 1 + (global.farmerGuildLevel / 50);
                _isolatestattps[_s] *= myMultiplier[1];
            }
            
            if (_s == 6)
                _isolatestattps[_s] *= myMultiplier[1];
            
            if (_s == 4 || _s == 9)
                _isolatestattps[_s] *= myMultiplier[5];
            
            if (_s == 0 || _s == 7)
                _isolatestattps[_s] *= myMultiplier[3];
            
            var _totalStatMultiplier = 1;
            var _constStatMultiplier = 1;
            
            if (variable_instance_exists(id, "diaryQuest"))
            {
                for (var i = 0; i < global.totalDiaryQuests; i += 1)
                {
                    if (global.diaryQuestInfo[i][0] > 0)
                    {
                        if (diaryQuest[i][2] == 1)
                        {
                            if (diaryQuest[i][1] == 1)
                            {
                                if (global.diaryQuestInfo[i][10] > 0)
                                    _totalStatMultiplier += global.diaryQuestInfo[i][10];
                                
                                if (global.diaryQuestInfo[i][11] > 0)
                                    _constStatMultiplier += global.diaryQuestInfo[i][11];
                            }
                        }
                    }
                }
                
                if (_totalStatMultiplier > 1)
                    _isolatestattps[_s] *= _totalStatMultiplier;
                
                if (_s == 8 && _constStatMultiplier > 1)
                    _isolatestattps[_s] *= _constStatMultiplier;
            }
            
            if (global.djinnInfo[1][0] == 1)
            {
                if (_s == 0)
                    _isolatestattps[_s] *= 1 + (global.djinnInfo[1][2] / 100);
                
                if (_s == 9)
                    _isolatestattps[_s] *= 1 + (global.djinnInfo[1][2] / 100);
            }
            
            if (global.djinnInfo[2][0] == 1)
            {
                if (_s == 3)
                    _isolatestattps[_s] *= 1 + (global.djinnInfo[2][2] / 100);
                
                if (_s == 8)
                    _isolatestattps[_s] *= 1 + (global.djinnInfo[2][2] / 100);
            }
            
            var _tpsvalue;
            _tpsvalue[_s] = (1 / global.talentValue[_s]) * (1 + (myItemInfo[_s][3] / 100)) * vocationStatsBonus;
            
            if (_s == 8)
            {
                _tpsvalue[_s] *= 1 + (global.farmerGuildLevel / 50);
                _tpsvalue[_s] *= myMultiplier[1];
            }
            
            if (_s == 6)
                _tpsvalue[_s] *= myMultiplier[1];
            
            if (_s == 4 || _s == 9)
                _tpsvalue[_s] *= myMultiplier[5];
            
            if (_s == 0 || _s == 7)
                _tpsvalue[_s] *= myMultiplier[3];
            
            if (_totalStatMultiplier > 1)
                _tpsvalue[_s] *= _totalStatMultiplier;
            
            if (_s == 8 && _constStatMultiplier > 1)
                _tpsvalue[_s] *= _constStatMultiplier;
            
            var _tpstomax;
            _tpstomax[_s] = ceil((myStatInfo[_s][4] - _isolatestattps[_s]) / _tpsvalue[_s]);
            var _currenttps;
            _currenttps[_s] = baseStat[_s][0];
            show_debug_message("before: TPs to max stat " + string(_s) + ": " + string(_tpstomax[_s]) + ", current TPs: " + string(_currenttps[_s]) + " total stat value: " + string(myStatInfo[_s][3]));
            
            if (_tpstomax[_s] <= 0)
            {
                _diff[_s] = baseStat[_s][0];
                baseStat[_s][0] -= _diff[_s];
                _removedTPs[_s] = _diff[_s];
                skillPoints += _diff[_s];
                show_debug_message("Stat is maxed even without TPs, it removed all possible (" + string(_removedTPs[_s]) + ")");
            }
            else if (_tpstomax[_s] < _currenttps[_s])
            {
                _diff[_s] = _currenttps[_s] - _tpstomax[_s];
                
                if (_diff[_s] > 0)
                {
                    show_debug_message("diff is higher than 0 (" + string(_diff[_s]) + ")");
                    
                    if (baseStat[_s][0] > 0)
                    {
                        show_debug_message("stat is higher than 0 (" + string(baseStat[_s][0]) + ")");
                        baseStat[_s][0] -= _diff[_s];
                        skillPoints += _diff[_s];
                        _removedTPs[_s] += _diff[_s];
                    }
                    else
                    {
                        baseStat[_s][0] = 0;
                        _diff[_s] = 0;
                        show_debug_message("diff is NOT higher than 0 (" + string(baseStat[_s][0]) + ")");
                    }
                }
                else
                {
                    baseStat[_s][0] = 0;
                    _diff[_s] = 0;
                    show_debug_message("diff is NOT higher than 0 (" + string(_diff[_s]) + ")");
                }
            }
            
            myStatInfo[_s][3] = myStatInfo[_s][4];
            _currenttps[_s] = baseStat[_s][0];
            show_debug_message("after: TPs to max stat " + string(_s) + ": " + string(_tpstomax[_s]) + ", current TPs: " + string(_currenttps[_s]) + ", removed " + string(_diff[_s]) + " TPs, total stat value: " + string(myStatInfo[_s][3]));
        }
    }
    
    gml_Script_scr_updateStats(undefined, undefined, 0);
    
    if (arg1 != -1)
        return arg0 - _removedTPs[arg1];
};
