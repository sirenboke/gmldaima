self.scr_updateSkin = function()
{
    var _class = class;
    
    if (class == "mage")
        _class = "wizard";
    
    avatar = asset_get_index("spr_" + string(class) + "_avatar");
    
    if (specialized == 0)
    {
        spr_idle = asset_get_index("spr_" + string(_class) + "_idle");
        spr_move = asset_get_index("spr_" + string(_class) + "_move");
        spr_attack = asset_get_index("spr_" + string(_class) + "_attack");
        spr_cast = asset_get_index("spr_" + string(_class) + "_cast");
        spr_dead = asset_get_index("spr_" + string(_class) + "_dead");
        avatar = asset_get_index("spr_" + string(_class) + "_avatar");
    }
    else
    {
        var _spec = specialized;
        spr_idle = asset_get_index("spr_" + string(_class) + string(_spec) + "_idle");
        spr_move = asset_get_index("spr_" + string(_class) + string(_spec) + "_move");
        spr_attack = asset_get_index("spr_" + string(_class) + string(_spec) + "_attack");
        spr_cast = asset_get_index("spr_" + string(_class) + string(_spec) + "_cast");
        spr_dead = asset_get_index("spr_" + string(_class) + string(_spec) + "_dead");
        avatar = asset_get_index("spr_" + string(_class) + string(_spec) + "_avatar");
    }
    
    spr_mining = spr_attack;
    spr_farming = spr_attack;
    spr_training = spr_attack;
    
    if ((specialized == 2 && class == "warrior") || class == "mage" || class == "archer")
        canSwap = true;
    else
        canSwap = false;
    
    if (canSwap == false)
    {
        raidType = 0;
        raidList = global.raidList0;
    }
    
    gml_Script_scr_updateCoreStats();
    
    if (variable_instance_exists(id, "maxEnergy"))
        gml_Script_scr_updateStats();
};

self.scr_updateCoreStats = function()
{
    if (class == "warrior")
    {
        if (specialized == 1)
        {
            myStatInfo[1][5] = 15;
            myStatInfo[7][5] = 90;
        }
        
        if (specialized == 2)
        {
        }
        
        if (specialized == 3)
        {
            myStatInfo[1][5] = 12;
            myStatInfo[7][5] = 75;
        }
    }
    
    if (class == "mage")
    {
        if (specialized == 1)
        {
        }
        
        if (specialized == 2)
        {
            myStatInfo[1][5] = 10;
            myStatInfo[7][5] = 75;
            myStatInfo[5][5] = 75;
        }
        
        if (specialized == 3)
            myStatInfo[2][5] = 75;
    }
};

self.scr_player_setAbility = function(arg0, arg1 = 0)
{
    if (specialized == 0)
    {
        subClassName = "";
        ini_open(string(global.platformDir) + string(myCharDir) + "Data.ini");
        ini_write_real("Build", "Ability " + string(myAbilityInfo[0]) + " Level", myAbilityInfo[4]);
        ini_write_real("Build", "Ability " + string(myAbilityInfo[0]) + " Tier", myAbilityInfo[5]);
        ini_write_real("Build", "Ability " + string(myAbilityInfo[0]) + " XP", myAbilityInfo[7]);
        myAbilityInfo[0] = global.playerAbilityInfo[classType][arg0 - 1][0];
        myAbilityInfo[1] = global.playerAbilityInfo[classType][myAbilityInfo[0]][1];
        myAbilityInfo[2] = global.playerAbilityInfo[classType][myAbilityInfo[0]][2];
        myAbilityInfo[3] = global.playerAbilityInfo[classType][myAbilityInfo[0]][3];
        myAbilityInfo[4] = floor(ini_read_real("Build", "Ability " + string(myAbilityInfo[0]) + " Level", 1));
        myAbilityInfo[5] = floor(ini_read_real("Build", "Ability " + string(myAbilityInfo[0]) + " Tier", 1));
        myAbilityInfo[6] = string_repeat("I", myAbilityInfo[5]);
        myAbilityInfo[7] = ini_read_real("Build", "Ability " + string(myAbilityInfo[0]) + " XP", 0);
        myAbilityInfo[8] = myAbilityInfo[4] * 300;
        myAbilityInfo[9] = global.playerAbilityInfo[classType][myAbilityInfo[0]][4] * room_speed;
        classSpecialization[myAbilityInfo[0]] = ini_read_real("Build", "Ability " + string(myAbilityInfo[0]) + " Specialization", 0);
        ini_write_real("Build", "My Ability", myAbilityInfo[0]);
        ini_close();
        
        if (arg1 == 1)
        {
            myAbilityInfo[4] = global.maxAbilityLevel;
            myAbilityInfo[5] = 2;
            myAbilityInfo[6] = string_repeat("I", myAbilityInfo[5]);
            myAbilityInfo[8] = myAbilityInfo[4] * 300;
            myAbilityInfo[7] = myAbilityInfo[8];
        }
    }
    else
    {
        show_debug_message("Ability should be set to " + string(global.playerSpecAbilityInfo[classType][specialized - 1][arg0 - 1][1]));
        ini_open(string(global.platformDir) + string(myCharDir) + "Data.ini");
        
        if (arg1 != 1)
        {
            ini_write_real("Build", "Spec " + string(specialized - 1) + " Ability " + string(mySpecAbilityInfo[0]) + " Level", myAbilityInfo[4]);
            ini_write_real("Build", "Spec " + string(specialized - 1) + " Ability " + string(mySpecAbilityInfo[0]) + " Tier", myAbilityInfo[5]);
            ini_write_real("Build", "Spec " + string(specialized - 1) + " Ability " + string(mySpecAbilityInfo[0]) + " XP", myAbilityInfo[7]);
        }
        
        mySpecAbilityInfo[0] = global.playerSpecAbilityInfo[classType][specialized - 1][arg0 - 1][0];
        mySpecAbilityInfo[1] = global.playerSpecAbilityInfo[classType][specialized - 1][mySpecAbilityInfo[0]][1];
        mySpecAbilityInfo[2] = global.playerSpecAbilityInfo[classType][specialized - 1][mySpecAbilityInfo[0]][2];
        mySpecAbilityInfo[3] = global.playerSpecAbilityInfo[classType][specialized - 1][mySpecAbilityInfo[0]][3];
        mySpecAbilityInfo[4] = floor(ini_read_real("Build", "Spec " + string(specialized - 1) + " Ability " + string(mySpecAbilityInfo[0]) + " Level", 1));
        mySpecAbilityInfo[5] = floor(ini_read_real("Build", "Spec " + string(specialized - 1) + " Ability " + string(mySpecAbilityInfo[0]) + " Tier", 1));
        mySpecAbilityInfo[6] = string_repeat("I", mySpecAbilityInfo[5]);
        mySpecAbilityInfo[7] = ini_read_real("Build", "Spec " + string(specialized - 1) + " Ability " + string(mySpecAbilityInfo[0]) + " XP", 0);
        mySpecAbilityInfo[8] = floor(power(global.maxAbilityLevel + mySpecAbilityInfo[4], 1.2) * 500);
        mySpecAbilityInfo[9] = global.playerSpecAbilityInfo[classType][specialized - 1][mySpecAbilityInfo[0]][4] * room_speed;
        classSpecialization[myAbilityInfo[0]] = ini_read_real("Build", "Ability " + string(specialized - 1) + " Specialization", 0);
        subClassName = string(global.skillSpecialization[classType][specialized - 1]);
        show_debug_message(string(subClassName) + " Ability actually set to " + string(mySpecAbilityInfo[1]));
        ini_write_real("Build", "My Specialized Ability", mySpecAbilityInfo[0]);
        
        for (var i = 0; i < array_length(mySpecAbilityInfo); i += 1)
            myAbilityInfo[i] = mySpecAbilityInfo[i];
        
        for (var i = 0; i < 3; i++)
        {
            specialPoints[i] = clamp(ini_read_real("Specialization", "Special Points Spec " + string(specialized - 1) + " Ability " + string(i), 0), 0, global.maxSpecAbilityLevel);
            totalSpecialPoints[i] = clamp(ini_read_real("Specialization", "Total Special Points Spec " + string(specialized - 1) + " Ability " + string(i), 1), 1, global.maxSpecAbilityLevel);
        }
        
        show_debug_message("Special Points " + string(myAbilityInfo[0] + 1) + ": " + string(specialPoints[myAbilityInfo[0]]) + ".");
        
        for (var iii = 0; iii < 3; iii += 1)
        {
            for (var ii = 0; ii < 3; ii += 1)
            {
                for (var i = 0; i < global.globalSpecialBranches; i += 1)
                    mySpecialInfo[classType][iii][ii][i] = ini_read_real("Build", "Spec " + string(iii) + " Ability " + string(ii) + " Points " + string(i), 0);
            }
        }
        
        ini_close();
    }
    
    gml_Script_scr_updateSkin();
    
    if (global.chatSpam <= 1)
        gml_Script_twitch_chat_say("/me " + string(name) + " Ability " + string(myAbilityInfo[0] + 1) + " (" + string(myAbilityInfo[1]) + " " + string(myAbilityInfo[6]) + ") set successfully.");
};

self.scr_player_abilityXP = function(arg0, arg1 = 1)
{
    if (specialized == 0)
    {
        if (arg0.myAbilityInfo[4] < global.maxAbilityLevel)
        {
            xpvaluespecial = arg1 * arg0.myMultiplier[2] * global.academyXpBonus * arg0.skillBonus;
            
            if (arg0.state != UnknownEnum.Value_6)
                xpvaluespecial *= 0.4;
            
            arg0.myAbilityInfo[7] += xpvaluespecial;
            
            if (arg0.myAbilityInfo[7] >= arg0.myAbilityInfo[8])
            {
                arg0.myAbilityInfo[4] += 1;
                arg0.myAbilityInfo[7] -= arg0.myAbilityInfo[8];
                arg0.myAbilityInfo[8] = arg0.myAbilityInfo[4] * 300;
                
                if (arg0.myAbilityInfo[4] <= (global.maxAbilityLevel / 2))
                {
                    gml_Script_twitch_chat_say("/me " + string(name) + " leveled up ability " + string(arg0.myAbilityInfo[0] + 1) + " (" + string(arg0.myAbilityInfo[1]) + " " + string(arg0.myAbilityInfo[6]) + ") to level " + string(arg0.myAbilityInfo[4]) + "!");
                }
                else if (arg0.myAbilityInfo[4] == ((global.maxAbilityLevel / 2) + 1))
                {
                    gml_Script_twitch_chat_say("/me " + string(name) + " maxed ability " + string(arg0.myAbilityInfo[0] + 1) + " (" + string(arg0.myAbilityInfo[1]) + " " + string(arg0.myAbilityInfo[6]) + ") and unlocked extra effects for it!");
                    arg0.myAbilityInfo[5] += 1;
                    arg0.myAbilityInfo[6] = string_repeat("I", arg0.myAbilityInfo[5]);
                    
                    if (global.milestone[8][4] == 0)
                    {
                        with (gml_Script_instance_create(room_width / 2, room_height / 2, obj_showMilestone))
                        {
                            type = 8;
                            icon = 0;
                            name = other.name;
                        }
                    }
                }
                else if (arg0.myAbilityInfo[4] == global.maxAbilityLevel)
                {
                    gml_Script_twitch_chat_say("/me " + string(name) + " maxed ability " + string(arg0.myAbilityInfo[0] + 1) + " (" + string(arg0.myAbilityInfo[1]) + " " + string(arg0.myAbilityInfo[6]) + ")! You can now !specialize as a " + string(global.skillSpecialization[arg0.classType][arg0.myAbilityInfo[0]]) + ".");
                    
                    if (global.milestone[9][4] == 0)
                    {
                        with (gml_Script_instance_create(room_width / 2, room_height / 2, obj_showMilestone))
                        {
                            type = 9;
                            icon = 1;
                            name = other.name;
                        }
                    }
                }
                else
                {
                    gml_Script_twitch_chat_say("/me " + string(name) + " leveled up ability " + string(arg0.myAbilityInfo[0] + 1) + " (" + string(arg0.myAbilityInfo[1]) + " " + string(arg0.myAbilityInfo[6]) + ") to level " + string(arg0.myAbilityInfo[4] - (global.maxAbilityLevel / 2)) + "!");
                }
            }
        }
        else
        {
            arg0.myAbilityInfo[7] = -1;
        }
    }
    else if (arg0.myAbilityInfo[4] < global.maxSpecAbilityLevel)
    {
        xpvaluespecial = 1 * arg0.myMultiplier[2] * global.academyXpBonus * arg0.skillBonus;
        
        if (arg0.state != UnknownEnum.Value_6)
            xpvaluespecial *= 0.4;
        
        arg0.myAbilityInfo[7] += xpvaluespecial;
        
        if (arg0.myAbilityInfo[7] >= arg0.myAbilityInfo[8])
        {
            arg0.myAbilityInfo[4] += 1;
            arg0.myAbilityInfo[7] -= arg0.myAbilityInfo[8];
            arg0.myAbilityInfo[8] = floor(power(global.maxAbilityLevel + arg0.myAbilityInfo[4], 1.2) * 500);
            arg0.totalSpecialPoints[myAbilityInfo[0]] += 1;
            arg0.specialPoints[myAbilityInfo[0]] += 1;
            ini_open(string(global.platformDir) + string(arg0.myCharDir) + "Data.ini");
            ini_write_real("Specialization", "Special Points Spec " + string(arg0.specialized - 1) + " Ability " + string(myAbilityInfo[0]), arg0.specialPoints[myAbilityInfo[0]]);
            ini_write_real("Specialization", "Total Special Points Spec " + string(arg0.specialized - 1) + " Ability " + string(myAbilityInfo[0]), arg0.totalSpecialPoints[myAbilityInfo[0]]);
            ini_close();
            
            if (arg0.myAbilityInfo[4] <= (global.maxAbilityLevel / 2))
                gml_Script_twitch_chat_say("/me " + string(name) + " leveled up ability " + string(arg0.myAbilityInfo[0] + 1) + " (" + string(arg0.myAbilityInfo[1]) + " " + string(arg0.myAbilityInfo[6]) + ") to level " + string(arg0.myAbilityInfo[4]) + " and gained 1 Special Point!");
        }
    }
    else
    {
        arg0.myAbilityInfo[7] = -1;
    }
};

self.scr_player_updateSpecialPoints = function()
{
    for (var i = 0; i < global.globalSpecialBranches; i += 1)
        ini_write_real("Build", "Spec " + string(specialized - 1) + " Ability " + string(myAbilityInfo[0]) + " Points " + string(i), mySpecialInfo[classType][specialized - 1][myAbilityInfo[0]][i]);
    
    ini_write_real("Specialization", "Special Points Spec " + string(specialized - 1) + " Ability " + string(myAbilityInfo[0]), specialPoints[myAbilityInfo[0]]);
    ini_write_real("Specialization", "Total Special Points Spec " + string(specialized - 1) + " Ability " + string(myAbilityInfo[0]), totalSpecialPoints[myAbilityInfo[0]]);
};

self.scr_player_updateRelics = function()
{
    ini_open(string(global.platformDir) + string(myCharDir) + "Data.ini");
    
    for (var ui = 1; ui <= global.maxUniqueItems; ui += 1)
    {
        if (gotUniqueItem[ui] > 0)
            ini_write_real("Relics", "Got Unique Item " + string(ui), gotUniqueItem[ui]);
        else
            ini_key_delete("Relics", "Got Unique Item " + string(ui));
        
        if (equippedUniqueItem[ui] > 0)
            ini_write_real("Relics", "Equipped Unique Item " + string(ui), equippedUniqueItem[ui]);
        else
            ini_key_delete("Relics", "Equipped Unique Item " + string(ui));
        
        if (gotUniqueItem[ui] > 0 && uniqueItemLevel[ui] > 1)
            ini_write_real("Relics", "Unique Item " + string(ui) + " Level", uniqueItemLevel[ui]);
        else
            ini_key_delete("Relics", "Unique Item " + string(ui) + " Level");
    }
    
    for (var sr = 1; sr <= 3; sr += 1)
        ini_write_real("Relics", "Unique Slot " + string(sr), uniqueSlot[sr]);
    
    for (var p = 0; p <= global.maxPets; p++)
    {
        var pr;
        
        for (pr = 0; pr <= global.maxUniqueItems; pr++)
        {
            if (myPetEquippedRelic[p][pr] > 0)
                ini_write_real("Pets", "My Pet " + string(p) + " Equipped Relic " + string(pr), myPetEquippedRelic[p][pr]);
            else
                ini_key_delete("Pets", "My Pet " + string(p) + " Equipped Relic " + string(pr));
        }
        
        for (var ps = 1; ps <= 5; ps++)
        {
            if (petRelicSlot[p][ps] > 0)
                ini_write_real("Pets", "My Pet " + string(p) + " Relic Slot " + string(ps), petRelicSlot[p][ps]);
            else
                ini_key_delete("Pets", "My Pet " + string(p) + " Relic Slot " + string(pr));
        }
    }
    
    ini_close();
};

self.scr_player_loadbuild = function(arg0 = 0, arg1 = "", arg2 = 1)
{
    ini_open(string(global.platformDir) + string(myCharDir) + "Builds.ini");
    
    for (var i = 1; i <= myBuildSlots; i++)
    {
        show_debug_message("Trying to match Build " + string(i) + " with name " + string(arg1));
        
        if (ini_read_string("Build " + string(i), "Name", "!renamebuild" + string(i)) == arg1)
        {
            arg0 = i;
            show_debug_message("Matched Build " + string(arg0) + " with name " + string(arg1));
            break;
        }
    }
    
    ini_close();
    
    if (arg0 > 0 && arg0 <= myBuildSlots)
    {
        gml_Script_scr_savePlayer();
        ini_open(string(global.platformDir) + string(myCharDir) + "Builds.ini");
        
        if (ini_section_exists("Build " + string(arg0)))
        {
            skillPoints = totalSkillPoints;
            
            for (var r = 0; r <= 9; r += 1)
            {
                baseStat[r][0] = ini_read_real("Build " + string(arg0), "Base Stat " + string(r), 0);
                skillPoints -= baseStat[r][0];
                show_debug_message("Talent Points on " + string(global.baseStatText[r]) + ": " + string(baseStat[r][0]));
            }
            
            var _ability = ini_read_real("Build " + string(arg0), "My Ability", 0);
            var _specialized = specialized;
            var _transition = 0;
            specialized = ini_read_real("Build " + string(arg0), "Specialized", 0);
            
            if (_specialized != specialized)
                _transition = 1;
            
            autoAbility = ini_read_real("Build " + string(arg0), "Auto Ability", 0);
            myAura = ini_read_real("Build " + string(arg0), "My Aura", 0);
            mineAura = ini_read_real("Build " + string(arg0), "Mine Aura", 0);
            farmAura = ini_read_real("Build " + string(arg0), "Farm Aura", 0);
            trainAura = ini_read_real("Build " + string(arg0), "Train Aura", 0);
            raidAura = ini_read_real("Build " + string(arg0), "Raid Aura", 0);
            portalAura = ini_read_real("Build " + string(arg0), "Portal Aura", 0);
            auraIcon = oauraIcon[myAura];
            spr_aura = auraIcon;
            
            for (var eu = 1; eu <= global.maxUniqueItems; eu += 1)
                equippedUniqueItem[eu] = 0;
            
            for (var sr = 1; sr <= 3; sr += 1)
            {
                uniqueSlot[sr] = 0;
                
                if (level >= 100)
                {
                    uniqueSlot[sr] = ini_read_real("Build " + string(arg0), "Relic Slot " + string(sr), 0);
                    
                    if (gotUniqueItem[uniqueSlot[sr]] > 0)
                    {
                        equippedUniqueItem[uniqueSlot[sr]] = 1;
                    }
                    else
                    {
                        equippedUniqueItem[uniqueSlot[sr]] = 0;
                        uniqueSlot[sr] = 0;
                    }
                }
            }
            
            myPetID = ini_read_real("Build " + string(arg0), "My Pet ID", 0);
            
            for (var eu = 1; eu <= global.maxUniqueItems; eu += 1)
                myPetEquippedRelic[myPetID][eu] = 0;
            
            if (petTraining != 0 && petTraining == myPetID)
                myPetID = 0;
            
            if (myPetID != 0)
            {
                for (var re = 1; re <= 5; re++)
                {
                    petRelicSlot[myPetID][re] = ini_read_real("Build " + string(arg0), "Pet " + string(myPetID) + " Relic Slot " + string(re), 0);
                    
                    if (gotUniqueItem[petRelicSlot[myPetID][re]] > 0)
                        myPetEquippedRelic[myPetID][petRelicSlot[myPetID][re]] = 1;
                    else
                        myPetEquippedRelic[myPetID][petRelicSlot[myPetID][re]] = 0;
                    
                    myPetRelicSlotEffect[myPetID][re] = (0.1 + (0.05 * myPetInfo[myPetID][4])) - (re * 0.5);
                    
                    if (myPetRelicSlotEffect[myPetID][re] < 0)
                        myPetRelicSlotEffect[myPetID][re] = 0;
                    
                    show_debug_message("Relic Slot " + string(re) + " = Relic " + string(petRelicSlot[myPetID][re]) + " (" + string(myPetRelicSlotEffect[myPetID][re]) + " effect)");
                }
            }
            
            var _gemsEquipped = "";
            var _gemsMissing = "";
            
            for (var g = 0; g <= 9; g++)
            {
                var _curGem = myItemInfo[g][6];
                var _curSize = myItemInfo[g][7];
                
                if (_curGem != 0)
                {
                    myGemstoneInfo[_curGem - 1][_curSize] += 1;
                    myItemInfo[g][6] = 0;
                    myItemInfo[g][7] = 0;
                }
            }
            
            for (var g = 0; g <= 9; g++)
            {
                var _buildGem = ini_read_real("Build " + string(arg0), "Item " + string(g) + " Gemstone Type", 0);
                
                if (_buildGem != 0)
                {
                    var _buildSize = ini_read_real("Build " + string(arg0), "Item " + string(g) + " Gemstone Size", 0);
                    
                    if (myGemstoneInfo[_buildGem - 1][_buildSize] > 0)
                    {
                        myGemstoneInfo[_buildGem - 1][_buildSize] -= 1;
                        myItemInfo[g][6] = _buildGem;
                        myItemInfo[g][7] = _buildSize;
                    }
                }
            }
            
            raidPos = ini_read_string("Build " + string(arg0), "Raid Position", "");
            raidType = ini_read_real("Build " + string(arg0), "Raid Type", raidType);
            ini_close();
            gml_Script_scr_player_setAbility(_ability + 1, _transition);
            ini_open(string(global.platformDir) + string(myCharDir) + "Data.ini");
            classSpecialization[myAbilityInfo[0]] = ini_read_real("Build", "Ability " + string(myAbilityInfo[0]) + " Specialization", 0);
            ini_write_real("Build", "My Ability", myAbilityInfo[0]);
            build = arg0;
            buildName = ini_read_string("Build", "Build " + string(arg0) + " Name", "!renamebuild" + string(arg0));
            ini_write_real("Build", "Build", build);
            
            if (myPetID != 0)
            {
                myPetInfo[myPetID][1] = global.globalPetInfo[myPetID][1];
                myPetInfo[myPetID][2] = global.globalPetInfo[myPetID][2];
                myPetInfo[myPetID][3] = global.globalPetInfo[myPetID][4];
                myPetInfo[myPetID][4] = ini_read_real("Pets", "My Pet " + string(myPetID) + " Level", 1);
                myPetInfo[myPetID][5] = ini_read_real("Pets", "My Pet " + string(myPetID) + " XP", 0);
                myPetInfo[myPetID][6] = myPetInfo[myPetID][4] * 1000 * myPetInfo[myPetID][4];
                myPetInfo[myPetID][7] = global.globalPetInfo[myPetID][3];
                
                if (myPlayerPet != 0)
                {
                    with (myPlayerPet)
                        instance_destroy();
                }
                
                myPlayerPet = instance_create_depth(x, y, depth - 1, obj_petPlayer);
                
                with (myPlayerPet)
                {
                    player = other.id;
                    type = other.myPetID;
                }
            }
            else if (myPlayerPet != 0)
            {
                with (myPlayerPet)
                    instance_destroy();
                
                myPlayerPet = 0;
            }
            
            ini_open(string(global.platformDir) + string(myAccDir) + "Character Data.ini");
            
            for (var gt = 0; gt <= 5; gt++)
            {
                for (var gs = 0; gs <= 2; gs++)
                    ini_write_real("Gemstones", "Stat " + string(gt + 1) + " Size " + string(gs), myGemstoneInfo[gt][gs]);
            }
            
            ini_close();
            ini_open(string(global.platformDir) + string(myCharDir) + "Data.ini");
            
            for (var i = 0; i <= 9; i++)
            {
                ini_write_real("Items", "Item " + string(i) + " Gemstone Type", myItemInfo[i][6]);
                ini_write_real("Items", "Item " + string(i) + " Gemstone Size", myItemInfo[i][7]);
            }
            
            ini_close();
            gml_Script_scr_updateStats();
            ini_close();
            
            if (arg2 == 0 && global.chatSpam <= 2)
                gml_Script_twitch_chat_say("/me " + string(name) + " Build " + string(arg0) + " (" + string(buildName) + ") set successfully.");
        }
        else if (arg2 == 0 && global.chatSpam <= 2)
        {
            gml_Script_twitch_chat_say("/me " + string(name) + " Build " + string(arg0) + " does not exist.");
        }
    }
    else if (arg2 == 0 && global.chatSpam <= 2)
    {
        gml_Script_twitch_chat_say("/me " + string(name) + " You can only save " + string(myBuildSlots) + " builds.");
    }
};

self.scr_addDiaryProgress = function(arg0, arg1 = 1)
{
    if (ascended == true)
        exit;
    
    ini_open(string(global.platformDir) + string(myAccDir) + "Character Data.ini");
    
    if (arg0 >= 0)
    {
        arg0 -= 1;
        var _questID = arg0 * 5;
        
        for (var _chapterQuests = 0; _chapterQuests < 5; _chapterQuests += 1)
        {
            if (diaryQuest[_questID + _chapterQuests][0] < global.diaryQuestInfo[_questID + _chapterQuests][0])
            {
                diaryQuest[_questID + _chapterQuests][0] += arg1;
                show_debug_message("Added " + string(arg1) + " to quest " + string(_questID + _chapterQuests) + " (Chapter " + string(arg0 + 1) + ") (" + string(diaryQuest[_questID + _chapterQuests][0]) + " total).");
                ini_write_real("Kenji's Diary", "Quest " + string(_questID + _chapterQuests) + " Progress", diaryQuest[_questID + _chapterQuests][0]);
            }
            else
            {
                diaryQuest[_questID + _chapterQuests][0] = global.diaryQuestInfo[_questID + _chapterQuests][0];
            }
        }
    }
    else if (diaryCompleted == 1)
    {
        arg0 += 1;
        arg0 *= -1;
        diarySecretQuest[arg0][0] += arg1;
        ini_write_real("Kenji's Diary", "Secret Quest " + string(arg0) + " Progress", diarySecretQuest[arg0][0]);
    }
    
    ini_close();
    gml_Script_scr_checkDiaryProgress();
};

self.scr_checkDiaryProgress = function()
{
    if (ascended == true)
        exit;
    
    var _isCompleted = 1;
    var _wasCompleted = diaryCompleted;
    
    for (var i = 0; i < global.totalDiaryQuests; i += 1)
    {
        if (global.diaryQuestInfo[i][0] > 0)
        {
            if (diaryQuest[i][2] == 1)
            {
                if (diaryQuest[i][1] != 1)
                {
                    if (diaryQuest[i][0] >= global.diaryQuestInfo[i][0])
                    {
                        diaryQuest[i][1] = 1;
                        diaryQuest[i][0] = global.diaryQuestInfo[i][0];
                        var _chapterNumber = string(floor(i / 5) + 1);
                        show_debug_message("Kenji's Diary Chapter #" + string(floor(i / 5) + 1) + " Quest #" + string(i + 1) + " completed! (" + string(global.diaryQuestInfo[i][1]) + " " + string(global.diaryQuestInfo[i][2]));
                        gml_Script_twitch_chat_say("/me " + string(name) + " Kenji's Diary Chapter #" + string(_chapterNumber) + " Q" + string((i + 1) - ((real(_chapterNumber) - 1) * 5)) + " completed! (" + string(global.diaryQuestInfo[i][1]) + " " + string(global.diaryQuestInfo[i][2]) + ").");
                        
                        if (global.diaryQuestInfo[i][3] > 0)
                        {
                            skillPoints += global.diaryQuestInfo[i][3];
                            totalSkillPoints += global.diaryQuestInfo[i][3];
                        }
                        
                        if (global.diaryQuestInfo[i][4] > 0)
                            myGems += global.diaryQuestInfo[i][4];
                        
                        if (global.diaryQuestInfo[i][5] > 0)
                            gml_Script_scr_player_reward(global.diaryQuestInfo[i][5], 1);
                        
                        if (global.diaryQuestInfo[i][6] > 0)
                            gml_Script_scr_player_reward(global.diaryQuestInfo[i][6], 2);
                        
                        if (global.diaryQuestInfo[i][7] > 0)
                            gml_Script_scr_gainHonor(global.diaryQuestInfo[i][7]);
                    }
                    else
                    {
                        _isCompleted = 0;
                    }
                }
            }
            else
            {
                _isCompleted = 0;
            }
        }
    }
    
    ini_open(string(global.platformDir) + string(myAccDir) + "Character Data.ini");
    
    for (var i = 0; i < global.totalDiaryQuests; i += 1)
    {
        if (global.diaryQuestInfo[i][0] > 0 && diaryQuest[i][0] > 0)
        {
            ini_write_real("Kenji's Diary", "Quest " + string(i) + " Progress", diaryQuest[i][0]);
            ini_write_real("Kenji's Diary", "Quest " + string(i) + " Rewarded", diaryQuest[i][1]);
        }
    }
    
    diaryCompleted = _isCompleted;
    
    if (diaryCompleted == 1)
    {
        if (diaryAnnounced != 1)
        {
            diaryAnnounced = 1;
            ini_write_real("Kenji's Diary", "Announced", 1);
            gml_Script_twitch_chat_say_direct("/me " + string(name) + " has completed all Kenji's Diary Chapters and unlocked the legendary 3 Secret Chapters!");
        }
        
        for (var i = 0; i < 3; i += 1)
        {
            if (diarySecretQuest[i][0] >= diarySecretQuest[i][2])
            {
                var _string = "/me " + string(name) + " Kenji's Diary Lost Chapter #" + string(i + 1) + " completed (" + string(diarySecretQuest[i][1] + 1) + "x)! (" + string(global.secretQuestReq[i][1]) + " " + string(global.secretQuestReq[i][2]) + ").";
                
                if (global.secretQuestReq[i][4] > 0)
                    myGems += global.secretQuestReq[i][4];
                
                diarySecretQuest[i][0] -= diarySecretQuest[i][2];
                diarySecretQuest[i][1] += 1;
                
                if ((diarySecretQuest[i][1] % 10) == 0)
                {
                    _string += " [+1 Honor for every 10th completion!]";
                    ini_close();
                    gml_Script_scr_gainHonor(1);
                    ini_open(string(global.platformDir) + string(myAccDir) + "Character Data.ini");
                }
                
                gml_Script_twitch_chat_say(_string);
                diarySecretQuest[i][2] = global.secretQuestReq[i][0] * (1 + (diarySecretQuest[i][1] / 10));
                ini_write_real("Kenji's Diary", "Secret Quest " + string(i) + " Progress", diarySecretQuest[i][0]);
                ini_write_real("Kenji's Diary", "Secret Quest " + string(i) + " Completions", diarySecretQuest[i][1]);
            }
        }
    }
    
    ini_close();
};

self.scr_skillDesc = function(arg0, arg1 = 1)
{
    var values = script_execute(arg0, arg1, undefined, 1);
    
    if (!is_struct(values))
        return "No description available.";
    
    var text = global.skillDescriptions[arg0];
    var keys = variable_struct_get_names(values);
    
    for (var i = 0; i < array_length(keys); i++)
    {
        var k = keys[i];
        text = string_replace(text, "{" + k + "}", gml_Script_scr_bigNumber(variable_struct_get(values, k)));
    }
    
    return text;
};

enum UnknownEnum
{
    Value_6 = 6
}
