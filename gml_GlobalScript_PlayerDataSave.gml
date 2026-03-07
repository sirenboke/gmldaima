self.scr_savePlayer = function()
{
    ini_open(string(global.platformDir) + string(myCharDir) + "Data.ini");
    ini_write_real("Stats", "Level", level);
    ini_write_real("Stats", "Energy", energy);
    ini_write_real("Stats", "XP", xp);
    ini_write_real("Stats", "Gold", mygold);
    ini_write_real("Stats", "Food", myfood);
    ini_write_real("Misc", "Kills", kills);
    ini_write_real("Misc", "Raids", raids);
    ini_write_real("Misc", "Auto Potion", autoPot);
    ini_write_real("Misc", "Auto Ability", autoAbility);
    ini_write_real("Misc", "Auto Switch", autoSwitch);
    ini_write_real("Misc", "Auto Loot", autoLoot);
    ini_write_real("Misc", "Auto Buy", autoBuy);
    
    for (var i = 0; i < 4; i += 1)
        ini_write_real("Misc", "Auto " + string(i), autoAction[i]);
    
    ini_write_real("Stats", "Honor", honor);
    
    if (ascended == true)
    {
        global.gold += mygold;
        global.food += myfood;
        global.gems += myGems;
        donated += mygold;
        donated_food += myfood;
        donated_gems += myGems;
        mygold = 0;
        myfood = 0;
        myGems = 0;
    }
    
    ini_write_real("Misc", "Donated Gold", donated);
    ini_write_real("Misc", "Donated Food", donated_food);
    ini_write_real("Misc", "Donated Gems", donated_gems);
    ini_write_real("Temporary Bonuses", "XP Bonus", gml_Script_scr_alarm_get(1));
    ini_write_real("Temporary Bonuses", "Resource Bonus", gml_Script_scr_alarm_get(0));
    ini_write_real("Temporary Bonuses", "VP Bonus", gml_Script_scr_alarm_get(2));
    ini_write_real("Temporary Bonuses", "DMG Bonus", gml_Script_scr_alarm_get(3));
    ini_write_real("Temporary Bonuses", "RES Bonus", gml_Script_scr_alarm_get(4));
    ini_write_real("Temporary Bonuses", "Stats Bonus", gml_Script_scr_alarm_get(5));
    ini_write_real("Build", "Specialized", specialized);
    
    if (specialized == 0)
    {
        ini_write_real("Build", "My Ability", myAbilityInfo[0]);
        ini_write_real("Build", "Ability " + string(myAbilityInfo[0]) + " Level", myAbilityInfo[4]);
        ini_write_real("Build", "Ability " + string(myAbilityInfo[0]) + " Tier", myAbilityInfo[5]);
        ini_write_real("Build", "Ability " + string(myAbilityInfo[0]) + " XP", myAbilityInfo[7]);
    }
    else
    {
        ini_write_real("Build", "My Specialized Ability", myAbilityInfo[0]);
        ini_write_real("Build", "Spec " + string(specialized - 1) + " Ability " + string(myAbilityInfo[0]) + " Level", myAbilityInfo[4]);
        ini_write_real("Build", "Spec " + string(specialized - 1) + " Ability " + string(myAbilityInfo[0]) + " Tier", myAbilityInfo[5]);
        ini_write_real("Build", "Spec " + string(specialized - 1) + " Ability " + string(myAbilityInfo[0]) + " XP", myAbilityInfo[7]);
    }
    
    for (var p = 0; p <= global.maxPets; p++)
    {
        ini_write_real("Pets", "My Pet ID", myPetID);
        ini_write_real("Pets", "My Pet " + string(p) + " Level", myPetInfo[p][4]);
        ini_write_real("Pets", "My Pet " + string(p) + " XP", myPetInfo[p][5]);
    }
    
    for (var re = 1; re <= floor(myPetInfo[myPetID][4] / 10); re++)
        ini_write_real("Pets", "My Pet " + string(myPetID) + " Relic Slot " + string(re), petRelicSlot[myPetID][re]);
    
    for (var i = 0; i <= 9; i++)
    {
        ini_write_real("Items", "Item " + string(i) + " Gemstone Type", myItemInfo[i][6]);
        ini_write_real("Items", "Item " + string(i) + " Gemstone Size", myItemInfo[i][7]);
    }
    
    ini_write_real("Build", "My Aura", myAura);
    
    for (var _a = 0; _a <= maxAuras; _a += 1)
    {
        ini_write_real("Build", "Got Aura " + string(_a), gotAura[_a]);
        ini_write_real("Build", "Aura " + string(_a) + " Bonus", auraBonus[_a]);
    }
    
    ini_write_real("Build", "Mine Aura", mineAura);
    ini_write_real("Build", "Farm Aura", farmAura);
    ini_write_real("Build", "Raid Aura", raidAura);
    ini_write_real("Build", "Train Aura", trainAura);
    ini_write_real("Build", "Portal Aura", portalAura);
    ini_write_real("Stats", "Skill Points", skillPoints);
    ini_write_real("Stats", "Total Skill Points", totalSkillPoints);
    
    if (specialized != 0)
    {
        ini_write_real("Specialization", "Special Points Spec " + string(specialized - 1) + " Ability " + string(myAbilityInfo[0]), specialPoints[myAbilityInfo[0]]);
        ini_write_real("Specialization", "Total Special Points Spec " + string(specialized - 1) + " Ability " + string(myAbilityInfo[0]), totalSpecialPoints[myAbilityInfo[0]]);
    }
    
    ini_write_real("Stats", "Extra Speed", extraSpeed);
    ini_write_real("Stats", "Extra Energy", extraEnergy);
    
    for (var _n = 0; _n <= 9; _n += 1)
        ini_write_real("Stats", "Base Stat " + string(_n), baseStat[_n][0]);
    
    ini_write_real("Misc", "Last State", state);
    ini_write_real("Misc", "Last Y", y);
    ini_write_real("Misc", "Last X", x);
    ini_write_real("Misc", "Path", actionPath);
    ini_write_real("Vocations", "Mining Points", myVocationInfo[0][1]);
    ini_write_real("Vocations", "Mining Level", myVocationInfo[0][0]);
    ini_write_real("Vocations", "Farming Points", myVocationInfo[1][1]);
    ini_write_real("Vocations", "Farming Level", myVocationInfo[1][0]);
    ini_write_real("Vocations", "Guard Points", myVocationInfo[2][1]);
    ini_write_real("Vocations", "Guard Level", myVocationInfo[2][0]);
    ini_write_real("Vocations", "Raiding Points", myVocationInfo[3][1]);
    ini_write_real("Vocations", "Raiding Level", myVocationInfo[3][0]);
    ini_write_real("Misc", "Temp Res Bonus", alarm[8]);
    ini_write_real("Misc", "Temp XP Bonus", alarm[9]);
    gml_Script_scr_updatePlayerItems();
    ini_close();
    gml_Script_scr_player_updateRelics();
    ini_open(string(global.platformDir) + string(myAccDir) + "Account Data.ini");
    ini_write_real("Misc", "Tier", myTier);
    ini_write_real("Misc", "Last Campaign", global.season);
    ini_write_real("Misc", "Last Patch", real(string_digits(global.patch)));
    ini_close();
    show_debug_message("Dir 1 save: " + string(string(global.platformDir) + string(myAccDir) + "Account Data.ini"));
    show_debug_message("Dir 2 save: " + string(string(global.platformDir) + string(myCharDir) + "Data.ini"));
    ini_open(string(global.platformDir) + string(myAccDir) + "Character Data.ini");
    ini_write_real("Resources", "Gems", myGems);
    ini_write_real("Bonuses", "VP Bonus", vpBonus);
    ini_write_real("Portal", "Portal ID", usePortal);
    
    for (var i = 0; i < 4; i += 1)
        ini_write_real("Misc", "Can Auto " + string(i), canAutoAction[i]);
    
    ini_write_real("Shop", "My Shop ID", myShopID);
    ini_write_real("Forge", "My Forge ID", myForgeID);
    ini_write_real("Forge", "My Reforge ID", myReforgeID);
    ini_write_real("Forge", "Forged Relic", forgedRelic);
    ini_write_real("Forge", "Forged Item", forgedItem);
    
    for (var ach = 0; ach <= 24; ach += 1)
        ini_write_real("Achievements", "Achievement " + string(ach), round(achievement[ach]));
    
    ini_close();
    
    global.___struct___129 = function() constructor
    {
        global.___struct___130 = function() constructor
        {
            self.sub = argument[0];
            self.myTier = argument[1];
            self.showHitDMG = argument[2];
        };
        
        self.Misc = new function() constructor
        {
            self.sub = argument[0];
            self.myTier = argument[1];
            self.showHitDMG = argument[2];
        }(argument[0], argument[1], argument[2]);
        
        global.___struct___131 = function() constructor
        {
            self.myGems = argument[0];
        };
        
        self.Resources = new function() constructor
        {
            self.myGems = argument[0];
        }(argument[3]);
        
        global.___struct___132 = function() constructor
        {
            self.vpBonus = argument[0];
        };
        
        self.Bonuses = new function() constructor
        {
            self.vpBonus = argument[0];
        }(argument[4]);
        
        global.___struct___133 = function() constructor
        {
            self.gotUniqueItem = argument[0];
            self.equippedUniqueItem = argument[1];
            self.uniqueItemLevel = argument[2];
            self.uniqueSlot = argument[3];
        };
        
        self.Relics = new function() constructor
        {
            self.gotUniqueItem = argument[0];
            self.equippedUniqueItem = argument[1];
            self.uniqueItemLevel = argument[2];
            self.uniqueSlot = argument[3];
        }(argument[5], argument[6], argument[7], argument[8]);
        
        global.___struct___134 = function() constructor
        {
            self.myShopID = argument[0];
            self.myForgeID = argument[1];
            self.myReforgeID = argument[2];
            self.usePortal = argument[3];
            self.useChest = argument[4];
            self.myRewardID = argument[5];
        };
        
        self.Tokens = new function() constructor
        {
            self.myShopID = argument[0];
            self.myForgeID = argument[1];
            self.myReforgeID = argument[2];
            self.usePortal = argument[3];
            self.useChest = argument[4];
            self.myRewardID = argument[5];
        }(argument[9], argument[10], argument[11], argument[12], argument[13], argument[14]);
        
        global.___struct___135 = function() constructor
        {
            self.achievement = argument[0];
        };
        
        self.Achievements = new function() constructor
        {
            self.achievement = argument[0];
        }(argument[15]);
    };
    
    var _charData = new function() constructor
    {
        global.___struct___130 = function() constructor
        {
            self.sub = argument[0];
            self.myTier = argument[1];
            self.showHitDMG = argument[2];
        };
        
        self.Misc = new function() constructor
        {
            self.sub = argument[0];
            self.myTier = argument[1];
            self.showHitDMG = argument[2];
        }(argument[0], argument[1], argument[2]);
        
        global.___struct___131 = function() constructor
        {
            self.myGems = argument[0];
        };
        
        self.Resources = new function() constructor
        {
            self.myGems = argument[0];
        }(argument[3]);
        
        global.___struct___132 = function() constructor
        {
            self.vpBonus = argument[0];
        };
        
        self.Bonuses = new function() constructor
        {
            self.vpBonus = argument[0];
        }(argument[4]);
        
        global.___struct___133 = function() constructor
        {
            self.gotUniqueItem = argument[0];
            self.equippedUniqueItem = argument[1];
            self.uniqueItemLevel = argument[2];
            self.uniqueSlot = argument[3];
        };
        
        self.Relics = new function() constructor
        {
            self.gotUniqueItem = argument[0];
            self.equippedUniqueItem = argument[1];
            self.uniqueItemLevel = argument[2];
            self.uniqueSlot = argument[3];
        }(argument[5], argument[6], argument[7], argument[8]);
        
        global.___struct___134 = function() constructor
        {
            self.myShopID = argument[0];
            self.myForgeID = argument[1];
            self.myReforgeID = argument[2];
            self.usePortal = argument[3];
            self.useChest = argument[4];
            self.myRewardID = argument[5];
        };
        
        self.Tokens = new function() constructor
        {
            self.myShopID = argument[0];
            self.myForgeID = argument[1];
            self.myReforgeID = argument[2];
            self.usePortal = argument[3];
            self.useChest = argument[4];
            self.myRewardID = argument[5];
        }(argument[9], argument[10], argument[11], argument[12], argument[13], argument[14]);
        
        global.___struct___135 = function() constructor
        {
            self.achievement = argument[0];
        };
        
        self.Achievements = new function() constructor
        {
            self.achievement = argument[0];
        }(argument[15]);
    }(sub, myTier, showHitDMG, myGems, vpBonus, [], [], [], [], myShopID, myForgeID, myReforgeID, usePortal, useChest, myRewardID, []);
    
    for (var _ui = 1; _ui <= global.maxUniqueItems; _ui += 1)
    {
        _charData.Relics.gotUniqueItem[_ui] = gotUniqueItem[_ui];
        _charData.Relics.equippedUniqueItem[_ui] = equippedUniqueItem[_ui];
        _charData.Relics.uniqueItemLevel[_ui] = uniqueItemLevel[_ui];
    }
    
    for (var _us = 1; _us <= 4; _us += 1)
        _charData.Relics.uniqueSlot[_us] = uniqueSlot[_us];
    
    for (var _ach = 0; _ach <= 24; _ach += 1)
        _charData.Achievements.achievement[_ach] = round(achievement[_ach]);
    
    var _json = json_stringify(_charData, true);
    gml_Script_scr_saveString(_json, string(global.platformDir) + string(myAccDir) + "Character Data");
    
    global.___struct___136 = function() constructor
    {
        global.___struct___137 = function() constructor
        {
            self.honor = argument[0];
            self.honorLevel = argument[1];
            self.honorPoints = argument[2];
        };
        
        self.Honor = new function() constructor
        {
            self.honor = argument[0];
            self.honorLevel = argument[1];
            self.honorPoints = argument[2];
        }(argument[0], argument[1], argument[2]);
        
        global.___struct___138 = function() constructor
        {
            self.lastCamp = argument[0];
            self.lastPatch = argument[1];
        };
        
        self.Misc = new function() constructor
        {
            self.lastCamp = argument[0];
            self.lastPatch = argument[1];
        }(argument[3], argument[4]);
    };
    
    var _accData = new function() constructor
    {
        global.___struct___137 = function() constructor
        {
            self.honor = argument[0];
            self.honorLevel = argument[1];
            self.honorPoints = argument[2];
        };
        
        self.Honor = new function() constructor
        {
            self.honor = argument[0];
            self.honorLevel = argument[1];
            self.honorPoints = argument[2];
        }(argument[0], argument[1], argument[2]);
        
        global.___struct___138 = function() constructor
        {
            self.lastCamp = argument[0];
            self.lastPatch = argument[1];
        };
        
        self.Misc = new function() constructor
        {
            self.lastCamp = argument[0];
            self.lastPatch = argument[1];
        }(argument[3], argument[4]);
    }(honor, honorLevel, honorPoints, global.season, lastPatch);
    _json = json_stringify(_accData, true);
    gml_Script_scr_saveString(_json, string(global.platformDir) + string(myAccDir) + "Account Data");
};
