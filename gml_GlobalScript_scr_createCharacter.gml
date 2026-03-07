self.scr_createCharacter = function()
{
    chooseClass = argument[0];
    uname = argument[1];
    
    with (obj_player)
    {
        if (name == other.uname && class == other.chooseClass)
            exit;
        
        if (name == other.uname && class != other.chooseClass)
        {
            if (global.inFinalWar == false)
                alarm[10] = 1;
        }
    }
    
    if (chooseClass == "warrior")
    {
        player = gml_Script_instance_create(300, 300, obj_player);
        global.warriorNumber += 1;
        
        with (player)
        {
            class = "warrior";
            classType = 0;
            raidType = 0;
            myStatInfo[0][0] = 0.6;
            myStatInfo[0][1] = 1.05;
            myStatInfo[0][2] = 10;
            myStatInfo[0][5] = -1;
            myStatInfo[0][6] = -1;
            myStatInfo[1][0] = 0.8;
            myStatInfo[1][1] = 1;
            myStatInfo[1][2] = 1;
            myStatInfo[1][5] = 8;
            myStatInfo[1][6] = 30;
            myStatInfo[2][0] = 0;
            myStatInfo[2][1] = 1;
            myStatInfo[2][2] = 5;
            myStatInfo[2][5] = 20;
            myStatInfo[2][6] = 100;
            myStatInfo[3][0] = 1.3;
            myStatInfo[3][1] = 1.01;
            myStatInfo[3][2] = 5;
            myStatInfo[3][5] = -1;
            myStatInfo[3][6] = -1;
            myStatInfo[4][0] = 1;
            myStatInfo[4][1] = 1;
            myStatInfo[4][2] = 1.5;
            myStatInfo[4][5] = -1;
            myStatInfo[4][6] = -1;
            myStatInfo[5][0] = 0;
            myStatInfo[5][1] = 1;
            myStatInfo[5][2] = 5;
            myStatInfo[5][5] = 200;
            myStatInfo[5][6] = 200;
            myStatInfo[6][0] = 0.5;
            myStatInfo[6][1] = 1.01;
            myStatInfo[6][2] = 100;
            myStatInfo[6][5] = -1;
            myStatInfo[6][6] = -1;
            myStatInfo[7][0] = 0;
            myStatInfo[7][1] = 1;
            myStatInfo[7][2] = 5;
            myStatInfo[7][5] = 50;
            myStatInfo[7][6] = 100;
            myStatInfo[8][0] = 15;
            myStatInfo[8][1] = 1.8;
            myStatInfo[8][2] = 100;
            myStatInfo[8][5] = -1;
            myStatInfo[8][6] = -1;
            myStatInfo[9][0] = 0;
            myStatInfo[9][1] = 1;
            myStatInfo[9][2] = 10;
            myStatInfo[9][5] = -1;
            myStatInfo[9][6] = -1;
        }
    }
    
    if (chooseClass == "rogue")
    {
        player = gml_Script_instance_create(300, 300, obj_player);
        global.rogueNumber += 1;
        
        with (player)
        {
            class = "rogue";
            classType = 1;
            raidType = 0;
            myStatInfo[0][0] = 1;
            myStatInfo[0][1] = 1.2;
            myStatInfo[0][2] = 15;
            myStatInfo[0][5] = -1;
            myStatInfo[0][6] = -1;
            myStatInfo[1][0] = 1;
            myStatInfo[1][1] = 1;
            myStatInfo[1][2] = 1.5;
            myStatInfo[1][5] = 15;
            myStatInfo[1][6] = 30;
            myStatInfo[2][0] = 5;
            myStatInfo[2][1] = 1;
            myStatInfo[2][2] = 10;
            myStatInfo[2][5] = 75;
            myStatInfo[2][6] = 100;
            myStatInfo[3][0] = 1;
            myStatInfo[3][1] = 1;
            myStatInfo[3][2] = 2;
            myStatInfo[3][5] = -1;
            myStatInfo[3][6] = -1;
            myStatInfo[4][0] = 1;
            myStatInfo[4][1] = 1;
            myStatInfo[4][2] = 1.5;
            myStatInfo[4][5] = -1;
            myStatInfo[4][6] = -1;
            myStatInfo[5][0] = 0;
            myStatInfo[5][1] = 1;
            myStatInfo[5][2] = 5;
            myStatInfo[5][5] = 200;
            myStatInfo[5][6] = 200;
            myStatInfo[6][0] = 0;
            myStatInfo[6][1] = 1;
            myStatInfo[6][2] = 20;
            myStatInfo[6][5] = -1;
            myStatInfo[6][6] = -1;
            myStatInfo[7][0] = 5;
            myStatInfo[7][1] = 1;
            myStatInfo[7][2] = 8;
            myStatInfo[7][5] = 75;
            myStatInfo[7][6] = 100;
            myStatInfo[8][0] = 11;
            myStatInfo[8][1] = 1.2;
            myStatInfo[8][2] = 50;
            myStatInfo[8][5] = -1;
            myStatInfo[8][6] = -1;
            myStatInfo[9][0] = 5;
            myStatInfo[9][1] = 1;
            myStatInfo[9][2] = 10;
            myStatInfo[9][5] = -1;
            myStatInfo[9][6] = -1;
        }
    }
    
    if (chooseClass == "farmer")
    {
        player = gml_Script_instance_create(300, 300, obj_player);
        global.farmerNumber += 1;
        
        with (player)
        {
            class = "farmer";
            classType = 2;
            raidType = 0;
            myStatInfo[0][0] = 0.5;
            myStatInfo[0][1] = 1.04;
            myStatInfo[0][2] = 8;
            myStatInfo[0][5] = -1;
            myStatInfo[0][6] = -1;
            myStatInfo[1][0] = 0.6;
            myStatInfo[1][1] = 1;
            myStatInfo[1][2] = 1;
            myStatInfo[1][5] = 7;
            myStatInfo[1][6] = 30;
            myStatInfo[2][0] = 2;
            myStatInfo[2][1] = 1;
            myStatInfo[2][2] = 10;
            myStatInfo[2][5] = 50;
            myStatInfo[2][6] = 100;
            myStatInfo[3][0] = 1;
            myStatInfo[3][1] = 1;
            myStatInfo[3][2] = 2;
            myStatInfo[3][5] = -1;
            myStatInfo[3][6] = -1;
            myStatInfo[4][0] = 0.8;
            myStatInfo[4][1] = 1;
            myStatInfo[4][2] = 1.5;
            myStatInfo[4][5] = -1;
            myStatInfo[4][6] = -1;
            myStatInfo[5][0] = 0;
            myStatInfo[5][1] = 1;
            myStatInfo[5][2] = 5;
            myStatInfo[5][5] = 100;
            myStatInfo[5][6] = 200;
            myStatInfo[6][0] = 0;
            myStatInfo[6][1] = 1;
            myStatInfo[6][2] = 20;
            myStatInfo[6][5] = -1;
            myStatInfo[6][6] = -1;
            myStatInfo[7][0] = 0;
            myStatInfo[7][1] = 1;
            myStatInfo[7][2] = 3;
            myStatInfo[7][5] = 50;
            myStatInfo[7][6] = 100;
            myStatInfo[8][0] = 8;
            myStatInfo[8][1] = 1.7;
            myStatInfo[8][2] = 75;
            myStatInfo[8][5] = -1;
            myStatInfo[8][6] = -1;
            myStatInfo[9][0] = 10;
            myStatInfo[9][1] = 1;
            myStatInfo[9][2] = 15;
            myStatInfo[9][5] = -1;
            myStatInfo[9][6] = -1;
        }
    }
    
    if (chooseClass == "archer")
    {
        player = gml_Script_instance_create(300, 300, obj_player);
        global.rangerNumber += 1;
        
        with (player)
        {
            class = "archer";
            classType = 3;
            raidType = 1;
            myStatInfo[0][0] = 0.8;
            myStatInfo[0][1] = 1.1;
            myStatInfo[0][2] = 12;
            myStatInfo[0][5] = -1;
            myStatInfo[0][6] = -1;
            myStatInfo[1][0] = 0.8;
            myStatInfo[1][1] = 1;
            myStatInfo[1][2] = 1.5;
            myStatInfo[1][5] = 10;
            myStatInfo[1][6] = 30;
            myStatInfo[2][0] = 5;
            myStatInfo[2][1] = 1;
            myStatInfo[2][2] = 10;
            myStatInfo[2][5] = 50;
            myStatInfo[2][6] = 100;
            myStatInfo[3][0] = 1;
            myStatInfo[3][1] = 1;
            myStatInfo[3][2] = 2;
            myStatInfo[3][5] = -1;
            myStatInfo[3][6] = -1;
            myStatInfo[4][0] = 0.8;
            myStatInfo[4][1] = 1;
            myStatInfo[4][2] = 1.5;
            myStatInfo[4][5] = -1;
            myStatInfo[4][6] = -1;
            myStatInfo[5][0] = 0;
            myStatInfo[5][1] = 1;
            myStatInfo[5][2] = 5;
            myStatInfo[5][5] = 100;
            myStatInfo[5][6] = 200;
            myStatInfo[6][0] = 0;
            myStatInfo[6][1] = 1;
            myStatInfo[6][2] = 10;
            myStatInfo[6][5] = -1;
            myStatInfo[6][6] = -1;
            myStatInfo[7][0] = 0;
            myStatInfo[7][1] = 1;
            myStatInfo[7][2] = 10;
            myStatInfo[7][5] = 75;
            myStatInfo[7][6] = 100;
            myStatInfo[8][0] = 5;
            myStatInfo[8][1] = 1.55;
            myStatInfo[8][2] = 50;
            myStatInfo[8][5] = -1;
            myStatInfo[8][6] = -1;
            myStatInfo[9][0] = 5;
            myStatInfo[9][1] = 1;
            myStatInfo[9][2] = 8;
            myStatInfo[9][5] = -1;
            myStatInfo[9][6] = -1;
        }
    }
    
    if (chooseClass == "mage")
    {
        player = gml_Script_instance_create(300, 300, obj_player);
        global.wizardNumber += 1;
        
        with (player)
        {
            class = "mage";
            classType = 4;
            raidType = 1;
            myStatInfo[0][0] = 0.2;
            myStatInfo[0][1] = 1.01;
            myStatInfo[0][2] = 10;
            myStatInfo[0][5] = -1;
            myStatInfo[0][6] = -1;
            myStatInfo[1][0] = 0.5;
            myStatInfo[1][1] = 1;
            myStatInfo[1][2] = 0.8;
            myStatInfo[1][5] = 5;
            myStatInfo[1][6] = 30;
            myStatInfo[2][0] = 0;
            myStatInfo[2][1] = 1;
            myStatInfo[2][2] = 10;
            myStatInfo[2][5] = 30;
            myStatInfo[2][6] = 100;
            myStatInfo[3][0] = 1;
            myStatInfo[3][1] = 1;
            myStatInfo[3][2] = 3;
            myStatInfo[3][5] = -1;
            myStatInfo[3][6] = -1;
            myStatInfo[4][0] = 1;
            myStatInfo[4][1] = 1;
            myStatInfo[4][2] = 3;
            myStatInfo[4][5] = -1;
            myStatInfo[4][6] = -1;
            myStatInfo[5][0] = 0;
            myStatInfo[5][1] = 1;
            myStatInfo[5][2] = 2;
            myStatInfo[5][5] = 50;
            myStatInfo[5][6] = 200;
            myStatInfo[6][0] = 0;
            myStatInfo[6][1] = 1;
            myStatInfo[6][2] = 20;
            myStatInfo[6][5] = -1;
            myStatInfo[6][6] = -1;
            myStatInfo[7][0] = 0;
            myStatInfo[7][1] = 1;
            myStatInfo[7][2] = 5;
            myStatInfo[7][5] = 30;
            myStatInfo[7][6] = 100;
            myStatInfo[8][0] = 8;
            myStatInfo[8][1] = 1.6;
            myStatInfo[8][2] = 40;
            myStatInfo[8][5] = -1;
            myStatInfo[8][6] = -1;
            myStatInfo[9][0] = 2;
            myStatInfo[9][1] = 1.15;
            myStatInfo[9][2] = 60;
            myStatInfo[9][5] = -1;
            myStatInfo[9][6] = -1;
        }
    }
    
    if (chooseClass == "rogue" || chooseClass == "warrior" || chooseClass == "farmer" || chooseClass == "archer" || chooseClass == "mage")
    {
        with (player)
        {
            show_debug_message("myStatInfo length: " + string(array_length(myStatInfo)));
            myOrganicCap = [];
            
            for (var s = 0; s <= 9; s++)
                myOrganicCap[s] = myStatInfo[s][5];
            
            name = other.uname;
            saveName = string(name) + string(class);
            displayName = name;
            subClassName = "";
            
            if (string_length(displayName) > 8)
            {
                if (string_pos("ascended ", name) == 1)
                {
                    var _oldName = string_delete(displayName, 1, 9);
                    displayName = "# " + string_delete(_oldName, 7, 100) + "...";
                }
                else
                {
                    displayName = string_delete(displayName, 7, 100) + "...";
                }
            }
            
            ds_list_add(global.playerList, name);
            ds_list_sort(global.playerList, true);
            ds_list_add(global.list_notafk, name);
            ds_list_sort(global.list_notafk, true);
            global.totalPlayers += 1;
            gml_Script_scr_playsound(s_playerSpawn, 1.2, 1.7, 0.3);
            
            with (obj_player)
                myNumber = ds_list_find_index(global.playerList, name);
            
            tempNumber = global.totalPlayers - 1;
            
            if (!directory_exists(string(global.platformDir) + "Player Data/" + string(name)))
                directory_create(string(global.platformDir) + "Player Data/" + string(name));
            
            if (!directory_exists(string(global.platformDir) + "Player Data/" + string(name) + "/Account"))
                directory_create(string(global.platformDir) + "Player Data/" + string(name) + "/Account");
            
            if (!directory_exists(string(global.platformDir) + "Player Data/" + string(name) + "/Classes/" + string(class)))
                directory_create(string(global.platformDir) + "Player Data/" + string(name) + "/Classes/" + string(class));
            
            myCharDir = "Player Data/" + string(name) + "/Classes/" + string(class) + "/";
            myAccDir = "Player Data/" + string(name) + "/Account/";
            show_debug_message("Dir 1: " + string(myCharDir));
            show_debug_message("Dir 2: " + string(myAccDir));
            ini_open(string(global.platformDir) + "Core Data/Active Players.ini");
            
            with (obj_player)
            {
                saveNumber = ds_list_find_index(global.playerList, name);
                ini_write_string(saveNumber, "Name", name);
                savedMaxPlayers = global.totalPlayers - 1;
                ini_write_string(saveNumber, "Class", class);
                ini_write_real("Saved Players", "Last Save", savedMaxPlayers);
            }
            
            ini_close();
            myTier = 0;
            ini_open(string(global.platformDir) + string(myAccDir) + "Account Data.ini");
            lastCamp = ini_read_real("Misc", "Last Campaign", global.season);
            lastPatch = ini_read_real("Misc", "Last Patch", 0);
            honor = ini_read_real("Honor", "Account Honor", 0);
            honorLevel = ini_read_real("Honor", "Account Level", 1);
            honorPoints = ini_read_real("Honor", "Honor Points", 0);
            showHitDMG = ini_read_real("Misc", "Show Hit DMG", 0);
            sub = 0;
            tutorial = ini_read_real("Misc", "Tutorial", 1);
            
            if (lastCamp < global.season)
            {
                directory_destroy(string(global.platformDir) + string("Player Data/" + string(name) + "/Classes"));
                file_delete(string(global.platformDir) + string("Player Data/" + string(name) + "/Account/Character Data.ini"));
                ini_key_delete("Misc", "Sub");
                honorPoints += ceil(honorLevel / 10);
            }
            
            ini_close();
            ini_open(string(global.platformDir) + string(myAccDir) + "Character Data.ini");
            myGems = ini_read_real("Resources", "Gems", 0);
            vpBonus = ini_read_real("Bonuses", "VP Bonus", 1);
            canSwap = false;
            var inRanking = 0;
            
            for (var h = 0; h < ds_grid_height(global.honorRanking); h++)
            {
                if (ds_grid_get(global.honorRanking, 0, h) == name)
                    inRanking = 1;
            }
            
            if (inRanking == 0)
            {
                ds_grid_resize(global.honorRanking, 2, ds_grid_height(global.honorRanking) + 1);
                ds_grid_set(global.honorRanking, 0, ds_grid_height(global.honorRanking) - 1, string(name));
                ds_grid_set(global.honorRanking, 1, ds_grid_height(global.honorRanking) - 1, honor);
                ds_grid_sort(global.honorRanking, 1, 0);
            }
            
            for (var gt = 0; gt <= 5; gt++)
            {
                for (var gs = 0; gs <= 2; gs++)
                    myGemstoneInfo[gt][gs] = ini_read_real("Gemstones", "Stat " + string(gt + 1) + " Size " + string(gs), 0);
            }
            
            for (var i = 0; i < 4; i += 1)
                canAutoAction[i] = ini_read_real("Misc", "Can Auto " + string(i), 0);
            
            for (var s = 0; s <= 9; s++)
                myStatInfo[s][3] = myStatInfo[s][0] * myStatInfo[s][1];
            
            for (var sui = 1; sui <= 4; sui += 1)
                boughtItem[sui] = ini_read_real("Shop", "Bought Item " + string(sui), 1);
            
            myShopID = ini_read_real("Shop", "My Shop ID", -1);
            
            if (instance_exists(obj_build_shop))
            {
                if (myShopID < global.globalShopID)
                {
                    myShopID = -1;
                    
                    for (var sui = 1; sui <= 4; sui += 1)
                        boughtItem[sui] = obj_build_shop.itemAmount[sui];
                }
            }
            
            forgedRelic = ini_read_real("Forge", "Forged Relic", 1);
            forgedItem = ini_read_real("Forge", "Forged Item", 1);
            myForgeID = ini_read_real("Forge", "My Forge ID", -1);
            myReforgeID = ini_read_real("Forge", "My Reforge ID", -1);
            
            if (instance_exists(obj_build_forge))
            {
                if (myForgeID < global.globalForgeID)
                    forgedItem = clamp(round(obj_build_forge.level / 3), 1, 6);
                
                if (obj_build_forge.level >= 13)
                {
                    if (myReforgeID < global.globalReforgeID)
                    {
                        myReforgeID = -1;
                        forgedRelic = (obj_build_forge.level - 13) * 2;
                    }
                }
            }
            
            ini_close();
            ini_open(string(global.platformDir) + string(myCharDir) + "Data.ini");
            ascended = ini_read_real("Ascension", "Ascended", 0);
            
            for (var p = 0; p <= global.maxPets; p++)
            {
                gotPet[p] = ini_read_real("Pets", "Got Pet " + string(p), 0);
                myPetInfo[p][1] = global.globalPetInfo[p][1];
                myPetInfo[p][2] = global.globalPetInfo[p][2];
                myPetInfo[p][3] = global.globalPetInfo[p][4];
                myPetInfo[p][4] = ini_read_real("Pets", "My Pet " + string(p) + " Level", 1);
                myPetInfo[p][5] = ini_read_real("Pets", "My Pet " + string(p) + " XP", 0);
                myPetInfo[p][6] = myPetInfo[p][4] * 1000 * myPetInfo[p][4];
                myPetInfo[p][7] = global.globalPetInfo[p][3];
                
                for (var pr = 0; pr <= global.maxUniqueItems; pr++)
                    myPetEquippedRelic[p][pr] = ini_read_real("Pets", "My Pet " + string(p) + " Equipped Relic " + string(pr), 0);
                
                for (var ps = 1; ps <= 5; ps++)
                {
                    petRelicSlot[p][ps] = ini_read_real("Pets", "My Pet " + string(p) + " Relic Slot " + string(ps), 0);
                    myPetRelicSlotEffect[p][ps] = (0.1 + (0.05 * myPetInfo[p][4])) - (ps * 0.5);
                }
            }
            
            myPetID = ini_read_real("Pets", "My Pet ID", 0);
            favoriteRelicsTotal = 0;
            
            for (var f = 0; f <= global.maxUniqueItems; f++)
            {
                favoriteRelics[f] = ini_read_real("Favorite Relic List", "Relic " + string(f), 0);
                
                if (favoriteRelics[f] == 1)
                    favoriteRelicsTotal += 1;
            }
            
            ini_close();
            ini_open(string(global.platformDir) + string(myAccDir) + "Character Data.ini");
            tryAscension = false;
            ascension = [];
            ascensionLevel = ini_read_real("Ascensions", "Level", 0);
            
            for (var _c = 0; _c < 5; _c++)
            {
                for (var _s = 0; _s <= 3; _s++)
                {
                    ascension[_c][_s] = ini_read_real("Ascensions", "Class " + string(_c) + " Specialization " + string(_s), 0);
                    show_debug_message("Ascended Check: Class " + string(_c + 1) + " Specialization " + string(_s) + ": " + string(ascension[_c][_s]));
                }
            }
            
            if (lastPatch >= 4825)
            {
                ini_close();
                ini_open(string(global.platformDir) + string(myCharDir) + "Data.ini");
            }
            
            for (var ui = 1; ui <= global.maxUniqueItems; ui += 1)
            {
                gotUniqueItem[ui] = ini_read_real("Relics", "Got Unique Item " + string(ui), 0);
                equippedUniqueItem[ui] = ini_read_real("Relics", "Equipped Unique Item " + string(ui), 0);
                
                if (myPetID > 0)
                {
                    if (equippedUniqueItem[ui] == 1 && myPetEquippedRelic[myPetID][ui] == 1)
                        equippedUniqueItem[ui] = 0;
                }
                
                uniqueItemLevel[ui] = ini_read_real("Relics", "Unique Item " + string(ui) + " Level", 1);
                uniqueItemCorruption[ui] = ini_read_real("Relics", "Unique Item " + string(ui) + " Corruption", 1);
            }
            
            gotUniqueItem[0] = 1;
            equippedUniqueItem[0] = 1;
            uniqueItemLevel[0] = 1;
            myRelicSlots = 0;
            uniqueSlot[0] = 0;
            mySpecialSlots = 1;
            mySpecialInventorySize = 5;
            mySpecialInventory[0][0] = 0;
            specialSlot[0][0] = 0;
            
            for (var sr = 1; sr <= 5; sr += 1)
            {
                uniqueSlot[sr] = ini_read_real("Relics", "Unique Slot " + string(sr), 0);
                
                if (myPetID > 0)
                {
                    for (var cr = 1; cr <= 5; cr += 1)
                    {
                        if (uniqueSlot[sr] == petRelicSlot[myPetID][cr])
                            uniqueSlot[sr] = 0;
                    }
                }
                
                if (uniqueSlot[sr] == 0)
                    equippedUniqueItem[uniqueSlot[sr]] = 0;
            }
            
            for (var _i = 1; _i < mySpecialInventorySize; _i++)
            {
                specialSlot[_i] = ini_read_real("Special Items Inventory", "Equipped Special Slot " + string(_i), 0);
                
                if (specialSlot[_i] != 0)
                    show_debug_message("Special Item Equipped: nº" + string(specialSlot[_i]) + " in inventory (" + string(global.specialItem[specialSlot[_i]][0]) + " level " + string(ini_read_real("Special Items Inventory", "Special Item " + string(_i) + " Stat " + "1", 0)) + ").");
                
                equippedSpecial[_i][0] = 0;
                
                for (var _ii = 0; _ii < 8; _ii++)
                {
                    mySpecialInventory[_i][_ii] = ini_read_real("Special Items Inventory", "Special Item " + string(_i) + " Stat " + string(_ii), 0);
                    
                    if (mySpecialInventory[_i][0] != 0 && specialSlot[_i] == mySpecialInventory[_i][0])
                    {
                        equippedSpecial[_i][_ii] = mySpecialInventory[specialSlot[_i]][_ii];
                        show_debug_message("Special Item Equipped: nº" + string(specialSlot[_i]) + " in inventory stat " + string(_ii) + " " + string(equippedSpecial[_i][_ii]));
                    }
                }
            }
            
            uniqueSlot[4] = 0;
            ini_close();
            ini_open(string(global.platformDir) + string(myAccDir) + "Character Data.ini");
            usePortal = ini_read_real("Portal", "Portal ID", -1);
            useRedPortal = ini_read_real("Portal", "Red Portal ID", -1);
            useChest = ini_read_real("Chests", "Chest Uses", 0);
            myRewardID = ini_read_real("Chests", "My Reward ID", -1);
            
            if (myRewardID < global.globalRewardID)
                myRewardID = -1;
            
            for (var ach = 0; ach <= 26; ach += 1)
                achievement[ach] = ini_read_real("Achievements", "Achievement " + string(ach), 0);
            
            ini_close();
            maxHonor = round(power(honorLevel + 5, 2));
            ini_open(string(global.platformDir) + string(myCharDir) + "Data.ini");
            x = ini_read_real("Misc", "Last X", 1420);
            y = ini_read_real("Misc", "Last Y", 480);
            readyRaid = 0;
            state = ini_read_real("Misc", "Last State", 0);
            actionPath = -1;
            
            if (myTier > 0 && state == UnknownEnum.Value_0)
            {
                if (hp < myStatInfo[8][3] || energy < maxEnergy)
                {
                    path_end();
                    state = UnknownEnum.Value_5;
                    target = obj_build_inn;
                    actionPath = path_add();
                    var w = 20;
                    var h = 15;
                    gotoX = irandom_range(target.x - w, target.x + w);
                    gotoY = target.y;
                    
                    if (mp_grid_path(global.gameGrid, actionPath, x, y, gotoX, gotoY, 1))
                        path_start(actionPath, moveSpeed * global.roomSpeed, path_action_stop, 0);
                }
            }
            else
            {
                alarm[1] = room_speed;
            }
            
            if (state == UnknownEnum.Value_8)
            {
                if (path_exists(actionPath))
                    path_end();
                
                readyRaid = 0;
                x = 1420;
                y = 480;
                state = UnknownEnum.Value_0;
            }
            
            level = ini_read_real("Stats", "Level", 1);
            extraSpeed = ini_read_real("Stats", "Extra Speed", 0);
            
            if (extraSpeed > 0.4)
                extraSpeed = 0.4;
            
            moveSpeed = (0.5 + (level / 2000)) * (1 + extraSpeed);
            
            for (var i = 0; i <= global.damageTypes; i++)
            {
                omyResistance[0][i] = 1;
                omyDamage[i] = 1;
            }
            
            for (var i = 0; i <= 1; i++)
            {
                omyResistance[1][i] = 1;
                omyResistance[2][i] = 1;
            }
            
            if (class == "warrior")
            {
                omyResistance[0][0] = 0.9;
                omyResistance[1][0] = 0.75;
                omyResistance[1][1] = 0.75;
            }
            
            for (var i = 0; i <= global.damageTypes; i++)
            {
                myResistance[0][i] = omyResistance[0][i];
                myDamage[i] = omyDamage[i];
            }
            
            for (var i = 0; i <= 1; i++)
            {
                myResistance[1][i] = omyResistance[1][i];
                myResistance[2][i] = omyResistance[2][i];
            }
            
            if (state == UnknownEnum.Value_8)
                state = UnknownEnum.Value_0;
            
            if (place_meeting(x, y, obj_townCollision) && state != UnknownEnum.Value_15)
            {
                x = 1420;
                y = 480;
                state = UnknownEnum.Value_0;
            }
            
            raidType = ini_read_real("Build", "Raid Type", raidType);
            
            if (raidType == 0)
                raidList = global.raidList0;
            
            if (raidType == 1)
                raidList = global.raidList1;
            
            omyDamage[0] += ini_read_real("Stats", "Damage Bonus", 0);
            
            for (var i = 0; i < 4; i += 1)
                autoAction[i] = ini_read_real("Misc", "Auto " + string(i), 0);
            
            myDamage[0] = omyDamage[0];
            
            for (var n = 0; n <= 9; n += 1)
                baseStat[n][0] = ini_read_real("Stats", "Base Stat " + string(n), 0);
            
            costReduction = 1;
            
            if (class == "farmer")
                costReduction = 0.8;
            
            specialized = ini_read_real("Build", "Specialized", 0);
            
            for (var i = 0; i < 3; i += 1)
                classSpecialization[i] = ini_read_real("Build", "Ability " + string(i) + " Specialization", 0);
            
            myAbilityInfo[0] = ini_read_real("Build", "My Ability", 0);
            myAbilityInfo[1] = global.playerAbilityInfo[classType][myAbilityInfo[0]][1];
            myAbilityInfo[2] = global.playerAbilityInfo[classType][myAbilityInfo[0]][2];
            myAbilityInfo[3] = global.playerAbilityInfo[classType][myAbilityInfo[0]][3];
            myAbilityInfo[4] = floor(ini_read_real("Build", "Ability " + string(myAbilityInfo[0]) + " Level", 1));
            myAbilityInfo[5] = floor(ini_read_real("Build", "Ability " + string(myAbilityInfo[0]) + " Tier", 1));
            myAbilityInfo[6] = string_repeat("I", myAbilityInfo[5]);
            myAbilityInfo[7] = ini_read_real("Build", "Ability " + string(myAbilityInfo[0]) + " XP", 0);
            myAbilityInfo[8] = myAbilityInfo[4] * 300;
            myAbilityInfo[9] = global.playerAbilityInfo[classType][myAbilityInfo[0]][4] * room_speed;
            
            if (myAbilityInfo[4] >= global.maxAbilityLevel)
            {
                myAbilityInfo[4] = global.maxAbilityLevel;
                myAbilityInfo[7] = -1;
            }
            
            mySpecAbilityInfo[0] = ini_read_real("Build", "My Specialized Ability", 0);
            mySpecAbilityInfo[1] = global.playerSpecAbilityInfo[classType][myAbilityInfo[0]][mySpecAbilityInfo[0]][1];
            mySpecAbilityInfo[2] = global.playerSpecAbilityInfo[classType][myAbilityInfo[0]][mySpecAbilityInfo[0]][2];
            mySpecAbilityInfo[3] = global.playerSpecAbilityInfo[classType][myAbilityInfo[0]][mySpecAbilityInfo[0]][3];
            mySpecAbilityInfo[4] = floor(ini_read_real("Build", "Spec " + string(specialized - 1) + " Ability " + string(mySpecAbilityInfo[0]) + " Level", 1));
            mySpecAbilityInfo[5] = floor(ini_read_real("Build", "Spec " + string(specialized - 1) + " Ability " + string(mySpecAbilityInfo[0]) + " Tier", 1));
            mySpecAbilityInfo[6] = string_repeat("I", mySpecAbilityInfo[5]);
            mySpecAbilityInfo[7] = ini_read_real("Build", "Spec " + string(specialized - 1) + " Ability " + string(mySpecAbilityInfo[0]) + " XP", 0);
            mySpecAbilityInfo[8] = floor(power(global.maxAbilityLevel + mySpecAbilityInfo[4], 1.2) * 500);
            mySpecAbilityInfo[9] = global.playerSpecAbilityInfo[classType][myAbilityInfo[0]][mySpecAbilityInfo[0]][4] * room_speed;
            
            if (mySpecAbilityInfo[4] >= global.maxSpecAbilityLevel)
            {
                mySpecAbilityInfo[4] = global.maxSpecAbilityLevel;
                mySpecAbilityInfo[7] = -1;
            }
            
            if (specialized != 0)
            {
                mySpecialSlots = 1;
                
                for (var i = 0; i < array_length(mySpecAbilityInfo); i += 1)
                    myAbilityInfo[i] = mySpecAbilityInfo[i];
                
                ini_close();
                gml_Script_scr_player_setAbility(myAbilityInfo[0] + 1);
                ini_open(string(global.platformDir) + string(myCharDir) + "Data.ini");
            }
            
            show_debug_message("Using ability: " + string(myAbilityInfo[1]));
            
            for (var iii = 0; iii < 3; iii += 1)
            {
                for (var ii = 0; ii < 3; ii += 1)
                {
                    for (var i = 0; i < global.globalSpecialBranches; i += 1)
                        mySpecialInfo[classType][iii][ii][i] = ini_read_real("Build", "Spec " + string(iii) + " Ability " + string(ii) + " Points " + string(i), 0);
                }
            }
            
            autoAbility = ini_read_real("Misc", "Auto Ability", 0);
            autoSwitch = ini_read_real("Misc", "Auto Switch", 0);
            autoPot = ini_read_real("Misc", "Auto Potion", 0);
            autoPotHP = ini_read_real("Misc", "Auto Potion HP", 0.3);
            autoLoot = ini_read_real("Misc", "Auto Loot", 0);
            autoBuy = ini_read_real("Misc", "Auto Buy", 0);
            raidPos = ini_read_string("Misc", "Raid Position", "");
            petTraining = ini_read_real("Pets", "My Pet Training", 0);
            
            if (myPetID != 0)
            {
                myPlayerPet = instance_create_depth(x, y, depth - 1, obj_petPlayer);
                
                with (myPlayerPet)
                {
                    player = other.id;
                    type = other.myPetID;
                }
            }
            else
            {
                myPlayerPet = 0;
            }
            
            maxAuras = global.totalAuras;
            
            for (var z = 1; z <= maxAuras; z += 1)
            {
                gotAura[z] = ini_read_real("Build", "Got Aura " + string(z), 0);
                auraBonus[z] = ini_read_real("Build", "Aura " + string(z) + " Bonus", 0);
                myMultiplier[z] = 0;
            }
            
            gotAura[0] = 1;
            oauraIcon[0] = spr_none;
            oauraIcon[1] = spr_aura1;
            oauraIcon[2] = spr_aura2;
            oauraIcon[3] = spr_aura3;
            oauraIcon[4] = spr_aura4;
            oauraIcon[5] = spr_aura5;
            myAura = ini_read_real("Build", "My Aura", 0);
            auraIcon = oauraIcon[myAura];
            spr_aura = auraIcon;
            auraBonus[myAura] = ini_read_real("Build", "Aura " + string(myAura) + " Bonus", 1);
            auraPowerBonus = 1;
            build = ini_read_real("Build", "Build", 1);
            buildName = ini_read_string("Build", "Build " + string(build) + " Name", "!renamebuild" + string(build));
            toPortal = false;
            toRedPortal = false;
            inPortal = false;
            mineAura = ini_read_real("Build", "Mine Aura", 0);
            farmAura = ini_read_real("Build", "Farm Aura", 0);
            raidAura = ini_read_real("Build", "Raid Aura", 0);
            trainAura = ini_read_real("Build", "Train Aura", 0);
            portalAura = ini_read_real("Build", "Portal Aura", 0);
            myMiningLevel = ini_read_real("Vocations", "Mining Level", 1);
            myVocationInfo[0][0] = myMiningLevel;
            myFarmingLevel = ini_read_real("Vocations", "Farming Level", 1);
            myVocationInfo[1][0] = myFarmingLevel;
            myGuardLevel = ini_read_real("Vocations", "Guard Level", 1);
            myVocationInfo[2][0] = myGuardLevel;
            myRaidingLevel = ini_read_real("Vocations", "Raiding Level", 1);
            myVocationInfo[3][0] = myRaidingLevel;
            
            for (var i = 0; i < 4; i += 1)
            {
                if (myVocationInfo[i][0] >= maxVocationLevel)
                    canAutoAction[i] = 1;
            }
            
            if (level >= 250)
                myTier = 1;
            
            if (level >= 500)
                myTier = 2;
            
            if (level >= 1000)
                myTier = 3;
            
            if (level >= 2500)
                myTier = 4;
            
            myRelicSlots = 0;
            myBuildSlots = 2;
            
            if (level >= 100)
                myRelicSlots = 1;
            
            if (myTier == 2)
            {
                myRelicSlots = 2;
                myBuildSlots = 3;
            }
            
            if (myTier == 3)
            {
                myRelicSlots = 3;
                myBuildSlots = 4;
            }
            
            if (myTier == 4)
            {
                myRelicSlots = 3;
                myBuildSlots = 4;
            }
            
            if (class == "farmer")
            {
                global.farmerBonus += (1 * (1 + myTier));
                gml_Script_scr_updateBuildings();
            }
            
            skillPoints = ini_read_real("Stats", "Skill Points", level - 1);
            totalSkillPoints = ini_read_real("Stats", "Total Skill Points", level - 1);
            
            for (var i = 0; i < 3; i++)
            {
                specialPoints[i] = clamp(ini_read_real("Specialization", "Special Points Spec " + string(specialized - 1) + " Ability " + string(i), 0), 0, global.maxSpecAbilityLevel);
                totalSpecialPoints[i] = clamp(ini_read_real("Specialization", "Total Special Points Spec " + string(specialized - 1) + " Ability " + string(i), 1), 1, global.maxSpecAbilityLevel);
            }
            
            extraEnergy = ini_read_real("Stats", "Extra Energy", 0);
            maxEnergy = 65 + (level / 1.7) + extraEnergy;
            energy = ini_read_real("Stats", "Energy", maxEnergy);
            maxxp = round(((10 + power(level + 5, 2.3)) * (level + 20)) / 8);
            xp = ini_read_real("Stats", "XP", 0);
            hp = ini_read_real("Stats", "HP", myStatInfo[8][3]);
            myfood = ini_read_real("Stats", "Food", 0);
            
            if (global.dev == 0)
                mygold = ini_read_real("Stats", "Gold", 100);
            else
                mygold = 100000;
            
            if (is_nan(mygold) || is_infinity(mygold))
                mygold = 1000;
            
            raids = ini_read_real("Misc", "Raids", 0);
            kills = ini_read_real("Misc", "Kills", 0);
            donated = ini_read_real("Misc", "Donated Gold", 0);
            donated_food = ini_read_real("Misc", "Donated Food", 0);
            donated_gems = ini_read_real("Misc", "Donated Gems", 0);
            myMiningPoints = ini_read_real("Vocations", "Mining Points", 0);
            myVocationInfo[0][1] = myMiningPoints;
            myFarmingPoints = ini_read_real("Vocations", "Farming Points", 0);
            myVocationInfo[1][1] = myFarmingPoints;
            myGuardPoints = ini_read_real("Vocations", "Guard Points", 0);
            myVocationInfo[2][1] = myGuardPoints;
            myRaidingPoints = ini_read_real("Vocations", "Raiding Points", 0);
            myVocationInfo[3][1] = myRaidingPoints;
            skillBonus = 1;
            vpBonus = 1;
            miningMax = 500 * myMiningLevel * myMiningLevel * (myMiningLevel + 1);
            farmingMax = 500 * myFarmingLevel * myFarmingLevel * (myFarmingLevel + 1);
            guardMax = 500 * myGuardLevel * myGuardLevel * (myGuardLevel + 1);
            raidingMax = 500 * myRaidingLevel * myRaidingLevel * (myRaidingLevel + 1);
            
            for (var _v = 0; _v < 4; _v++)
            {
                myVocationInfo[_v][2] = 500 * myVocationInfo[_v][0] * myVocationInfo[_v][0] * (myVocationInfo[_v][0] + 1);
                myVocationInfo[_v][2] /= clamp(myVocationInfo[_v][0] / 10, 1, 2);
            }
            
            alarm[8] = ini_read_real("Misc", "Temp Res Bonus", -1);
            alarm[9] = ini_read_real("Misc", "Temp XP Bonus", -1);
            gml_Script_scr_alarm_start(0, ini_read_real("Temporary Bonuses", "Resource Bonus", -1), gml_Script_scr_updateStats);
            gml_Script_scr_alarm_start(1, ini_read_real("Temporary Bonuses", "XP Bonus", -1), gml_Script_scr_updateStats);
            gml_Script_scr_alarm_start(2, ini_read_real("Temporary Bonuses", "VP Bonus", -1), gml_Script_scr_updateStats);
            gml_Script_scr_alarm_start(3, ini_read_real("Temporary Bonuses", "DMG Bonus", -1), gml_Script_scr_updateStats);
            gml_Script_scr_alarm_start(4, ini_read_real("Temporary Bonuses", "RES Bonus", -1), gml_Script_scr_updateStats);
            gml_Script_scr_alarm_start(5, ini_read_real("Temporary Bonuses", "Stats Bonus", -1), gml_Script_scr_updateStats);
            
            for (var i = 0; i <= 9; i++)
            {
                myItemInfo[i][0] = ini_read_real("Items", "Item " + string(i) + " Level", 0);
                myItemInfo[i][1] = ini_read_real("Items", "Item " + string(i) + " Tier", 0);
                myItemInfo[i][2] = string_repeat("I", myItemInfo[i][1]);
                myItemInfo[i][6] = ini_read_real("Items", "Item " + string(i) + " Gemstone Type", 0);
                myItemInfo[i][7] = ini_read_real("Items", "Item " + string(i) + " Gemstone Size", 0);
            }
            
            myItemInfo[0][4] = "Weapon";
            myItemInfo[0][5] = "Strength";
            myItemInfo[1][4] = "Gloves";
            myItemInfo[1][5] = "Dexterity";
            myItemInfo[2][4] = "Boots";
            myItemInfo[2][5] = "Agility";
            myItemInfo[3][4] = "Helmet";
            myItemInfo[3][5] = "Armor";
            myItemInfo[4][4] = "Ring";
            myItemInfo[4][5] = "Fury";
            myItemInfo[5][4] = "Amulet";
            myItemInfo[5][5] = "Life steal";
            myItemInfo[6][4] = "Belt";
            myItemInfo[6][5] = "HP Regen";
            myItemInfo[7][4] = "Pants";
            myItemInfo[7][5] = "Luck";
            myItemInfo[8][4] = "Vest";
            myItemInfo[8][5] = "Constitution";
            myItemInfo[9][4] = "Spellbook";
            myItemInfo[9][5] = "Intelligence";
            ini_close();
            var _gemTypes = 6;
            var _gemSizes = 3;
            var _checkInv = array_create(_gemTypes);
            
            for (var gt = 0; gt < _gemTypes; gt++)
            {
                _checkInv[gt] = array_create(_gemSizes);
                
                for (var gs = 0; gs < _gemSizes; gs++)
                    _checkInv[gt][gs] = myGemstoneInfo[gt][gs];
            }
            
            for (var i = 0; i <= 9; i++)
            {
                var _gem = myItemInfo[i][6];
                
                if (_gem > 0 && _gem <= _gemTypes)
                {
                    var _size = myItemInfo[i][7];
                    
                    if (_size >= 0 && _size < _gemSizes)
                        _checkInv[_gem - 1][_size] += 1;
                }
            }
            
            for (var i = 0; i <= 9; i++)
            {
                var _gem = myItemInfo[i][6];
                
                if (_gem > 0 && _gem <= _gemTypes)
                {
                    var _size = myItemInfo[i][7];
                    
                    if (_size >= 0 && _size < _gemSizes)
                    {
                        _checkInv[_gem - 1][_size] -= 1;
                        
                        if (_checkInv[_gem - 1][_size] < 0)
                        {
                            myItemInfo[i][6] = 0;
                            myItemInfo[i][7] = 0;
                        }
                    }
                    else
                    {
                        myItemInfo[i][6] = 0;
                        myItemInfo[i][7] = 0;
                    }
                }
            }
            
            if (skillPoints < 0)
            {
                ini_open(string(global.platformDir) + string(myCharDir) + "Builds.ini");
                
                for (var i = 0; i <= myBuildSlots; i++)
                {
                    if (ini_section_exists("Build " + string(i)))
                    {
                        for (var t = 0; t <= 9; t++)
                            ini_write_real("Build " + string(i), "Base Stat " + string(t), 0);
                    }
                }
                
                ini_close();
                ini_open(string(global.platformDir) + string(myCharDir) + "Data.ini");
                
                for (var n = 0; n <= 9; n += 1)
                {
                    baseStat[n][0] = 0;
                    ini_write_real("Stats", "Base Stat " + string(n), 0);
                }
                
                ini_write_real("Stats", "Skill Points", totalSkillPoints);
                ini_close();
                skillPoints = totalSkillPoints;
            }
            
            gml_Script_scr_updateStats();
            gml_Script_scr_updateSkin();
            
            if (!instance_exists(obj_transition_in) && !instance_exists(obj_transition_out) && ds_list_find_index(global.raidListPortalName, name) == -1)
            {
                if (global.chatSpam <= 2)
                    gml_Script_twitch_chat_say("/me " + string(name) + " (lv. " + gml_Script_scr_bigNumber(level) + " - " + string(class) + ") has joined the village!");
            }
            
            action = 0;
            
            if (ds_list_size(global.playerList) == 1)
                obj_gameControl.alarm[5] = 1;
            
            myCard = gml_Script_instance_create(room_width - 250, 230, obj_playerCard);
            
            with (myCard)
            {
                textColor = 16777215;
                player = other.id;
                class = other.class;
                avatar = other.avatar;
                myNumber = other.myNumber;
                yy = 60 + (200 * myNumber);
                xx = x;
            }
            
            ini_open(string(global.platformDir) + string(myAccDir) + "Character Data.ini");
            diaryCompleted = ini_read_real("Kenji's Diary", "Completed", 0);
            diaryAnnounced = ini_read_real("Kenji's Diary", "Announced", 0);
            fullDiary = ini_read_real("Kenji's Diary", "Missing Pages", 0);
            
            for (var i = 0; i < global.totalDiaryQuests; i += 1)
            {
                diaryQuest[i][0] = ini_read_real("Kenji's Diary", "Quest " + string(i) + " Progress", 0);
                
                if (diaryQuest[i][0] < 0)
                    diaryQuest[i][0] *= -1;
                
                diaryQuest[i][1] = ini_read_real("Kenji's Diary", "Quest " + string(i) + " Rewarded", 0);
                diaryQuest[i][2] = 0;
                
                if ((i % 5) == 0)
                    diaryQuest[i][2] = 1;
                
                if (fullDiary == 1)
                    diaryQuest[i][2] = 1;
            }
            
            for (var i = 0; i < 3; i += 1)
            {
                diarySecretQuest[i][0] = ini_read_real("Kenji's Diary", "Secret Quest " + string(i) + " Progress", 0);
                diarySecretQuest[i][1] = ini_read_real("Kenji's Diary", "Secret Quest " + string(i) + " Completions", 0);
                diarySecretQuest[i][2] = global.secretQuestReq[i][0] * (1 + (diarySecretQuest[i][1] / 10));
            }
            
            ini_close();
            gml_Script_scr_checkDiaryProgress();
            ini_open(string(global.platformDir) + string(myAccDir) + "Account Data.ini");
            sub = ini_read_real("Misc", "Sub", 0);
            gml_Script_scr_playerUnsubscribe(name);
            
            for (var i = 0; i < ds_list_size(global.subList); i++)
            {
                var _isSubbed;
                _isSubbed[i] = ds_list_find_value(global.subList, i);
                
                if (string_lower(_isSubbed[i]) == string_lower(name))
                    gml_Script_scr_playerSubscribe(name);
            }
            
            ini_close();
            show_debug_message("relic slot 2:" + string(uniqueSlot[2]) + ", my slots: " + string(myRelicSlots));
            
            if (level < 100)
            {
                equippedUniqueItem[uniqueSlot[1]] = 0;
                equippedUniqueItem[uniqueSlot[2]] = 0;
                equippedUniqueItem[uniqueSlot[3]] = 0;
                uniqueSlot[1] = 0;
                uniqueSlot[2] = 0;
                uniqueSlot[3] = 0;
            }
            
            if (level < 500)
            {
                if (myRelicSlots == 1)
                    equippedUniqueItem[uniqueSlot[2]] = 0;
                
                equippedUniqueItem[uniqueSlot[3]] = 0;
                
                if (myRelicSlots == 1)
                    uniqueSlot[2] = 0;
                
                uniqueSlot[3] = 0;
            }
            
            if (level < 1000)
            {
                equippedUniqueItem[uniqueSlot[3]] = 0;
                uniqueSlot[3] = 0;
            }
            
            show_debug_message("2 relic slot 2:" + string(uniqueSlot[2]) + ", my slots: " + string(myRelicSlots));
        }
    }
    else
    {
        gml_Script_twitch_chat_say("/me Valid classes: rogue, warrior, farmer, archer, mage. (e.g. !join warrior), visit https://dungeon-raiders.netlify.app/classes/ to check them out!");
    }
};

enum UnknownEnum
{
    Value_0,
    Value_5 = 5,
    Value_8 = 8,
    Value_15 = 15
}
