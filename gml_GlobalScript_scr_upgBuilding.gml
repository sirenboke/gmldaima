self.scr_upgBuilding = function(arg0, arg1 = 1, arg2 = 0, arg3 = 0, arg4 = 0, arg5 = "", arg6 = "")
{
    building = arg0;
    
    if (arg3 == 0)
        arg3 = building.cost;
    
    if (arg5 == "")
        arg5 = "gold";
    
    var _xpText = "";
    
    if (arg1 == 1)
        _xpText = " The Town obtained " + gml_Script_scr_bigNumber(arg3) + " XP!";
    
    if (room == r_underworld_new)
        _xpText = string_replace(_xpText, "Town", "Underworld");
    
    if (arg2 != "")
        arg2 = real(arg2);
    else
        arg2 = 0;
    
    if (building == obj_build_shop)
    {
        say[0] = "/me Shop upgraded to level " + string(obj_build_shop.level + 1) + "! The shopkeeper will sell 1 more item at a time.";
        say[1] = "/me Shop upgraded to level " + string(obj_build_shop.level + 1) + "! The shopkeeper is now selling higher quality items.";
        costIncrease1 = 2;
        costIncrease2 = 2000;
    }
    
    if (building == obj_build_forge)
    {
        with (building)
        {
            forgeItemAmount = clamp(round((level + 1) / 3), 1, 6);
            
            if ((level + 1) < 14)
            {
                other.say[0] = "/me Forge upgraded to level " + string(obj_build_forge.level + 1) + "! The blacksmith has unlocked a new forging tier, can now !!forge " + string(forgeItemAmount) + " items and will get more materials when recycling items.";
                forgingLevel += 1;
                forgeItem[0][1] = 50 + power((level + 1) * 20, 2);
                forgeItem[0][2] = 100 + round((power(level + 1, 6) + ((level + 1) * 30)) * power(1 + level + 1, 2));
                alarm[0] = 1;
                forgeItemText[0][2] = string(gml_Script_scr_bigNumber(floor(forgeItem[0][2])) + "g");
                
                if (forgeItem[0][2] >= 1000 && forgeItem[0][2] < 1000000)
                {
                    forgeItem[0][2] = floor(forgeItem[0][2] / 1000) * 1000;
                    forgeItemText[0][2] = string(gml_Script_scr_bigNumber(floor(forgeItem[0][2] / 1000)) + "k");
                }
                
                if (forgeItem[0][2] >= 1000000)
                {
                    forgeItem[0][2] = floor(forgeItem[0][2] / 1000000) * 1000000;
                    forgeItemText[0][2] = string(gml_Script_scr_bigNumber(floor(forgeItem[0][2] / 1000000)) + "M");
                }
            }
            else
            {
                var _corruptionText = "";
                
                if ((level + 1) >= 20)
                {
                    global.maxRelicCorruption = 1.5 + clamp(((level + 1) - 20) / 10, 0, 10);
                    
                    if ((level + 1) == 20)
                    {
                        if (global.unlockCorrupted == true)
                            _corruptionText = " You can now !!corrupt your Relics! But be careful, this is a dangerous and expensive process!";
                    }
                    else if (global.unlockCorrupted == true)
                    {
                        _corruptionText = " Maximum Relic corrupting power increased to x" + string(global.maxRelicCorruption) + "!";
                    }
                }
                
                forgeRelicAmount = ((level + 1) - 13) * 2;
                other.say[0] = "/me Forge upgraded to level " + string(obj_build_forge.level + 1) + "! The blacksmith can now !!forge " + string(forgeItemAmount) + " items and !!reforge " + string(forgeRelicAmount) + " Relics! !!Recycle unused Relics to obtain Relic materials." + string(_corruptionText);
                global.globalForgeID += 1;
                global.globalReforgeID += 1;
                
                with (obj_player)
                {
                    forgedRelic = ((obj_build_forge.level + 1) - 13) * 2;
                    forgedItem = clamp(round(obj_build_forge.level / 3), 1, 6);
                }
            }
        }
        
        costIncrease1 = 3.5;
        costIncrease2 = 0;
    }
    
    if (building == obj_build_guildhall)
    {
        var _extra = "";
        
        if (((building.level + 1) % 10) == 0)
            _extra = " You also got an extra key to open Guild Chests (" + string(global.maxChestUses + 1) + " keys)!";
        
        show_debug_message("guilds mod = " + string((building.level + 1) % 10));
        say[0] = "/me Guild Hall upgraded to level " + string(obj_build_guildhall.level + 1) + "! Guilds will now earn more XP per contribution." + string(_extra);
        global.maxChestUses = 0 + floor((building.level + 1) / 10);
        costIncrease1 = 1.8;
        costIncrease2 = 1800;
    }
    
    if (building == obj_build_well)
    {
        global.wellGoldBonus += 0.05;
        say[0] = "/me Well upgraded to level " + string(obj_build_well.level + 1) + "! Gold from all sources increased by " + string(round(global.wellGoldBonus * 100)) + "%[+]!";
        costIncrease1 = 1.5;
        costIncrease2 = 250;
    }
    
    if (building == obj_build_mine)
    {
        if ((building.level + 1) >= 10)
        {
            if (global.tutorialStep == 2)
            {
                if (instance_exists(obj_tutorial))
                {
                    if (obj_tutorial.alarm[1] > room_speed)
                        obj_tutorial.alarm[1] = room_speed;
                }
            }
        }
        
        global.maxMine = clamp(3 + building.level, 3, global.maxPlayers);
        say[0] = "/me Mine upgraded to level " + string(obj_build_mine.level + 1) + "! You now have " + string(3 + obj_build_mine.level) + " slots to mine and gold yield has increased!";
        costIncrease1 = 1.4;
        costIncrease2 = 500 + (building.level * 100);
    }
    
    if (building == obj_build_farm)
    {
        global.maxFarm = clamp(3 + building.level, 3, global.maxPlayers);
        say[0] = "/me Farm upgraded to level " + string(obj_build_farm.level + 1) + "! You now have " + string(3 + obj_build_farm.level) + " slots to farm and food yield has increased!";
        costIncrease1 = 1.4;
        costIncrease2 = 500 + (building.level * 100);
    }
    
    if (building == obj_build_train)
    {
        global.maxTrain = clamp(3 + building.level, 3, global.maxPlayers);
        building.amount = (5 + (building.level + 1)) * (1 + ((building.level + 1) / 5) + (1 + ((building.level + 1) / 2))) * (building.level + 1);
        building.amount *= 1 + global.corruptionShardEffect[4];
        say[0] = "/me Training camp upgraded to level " + string(obj_build_train.level + 1) + "! You now have " + string(3 + obj_build_train.level) + " slots to train and the efficiency has increased!";
        costIncrease1 = 1.4;
        costIncrease2 = 500 + (building.level * 100);
    }
    
    if (building == obj_build_academy)
    {
        global.academyXpBonus += 0.05;
        ini_close();
        ini_open(string(global.platformDir) + "Village Data/Data.ini");
        say[0] = "/me Academy upgraded to level " + string(obj_build_academy.level + 1) + "! XP from all sources increased by " + string(round((global.academyXpBonus - 1) * 100)) + "%[+]!";
        costIncrease1 = 1.6;
        costIncrease2 = 750;
    }
    
    if (building == obj_build_creaturekeeper)
    {
        var _maxPetLevel = obj_build_creaturekeeper.level + 5;
        say[0] = "/me Creature Keeper upgraded to level " + string(obj_build_creaturekeeper.level + 1) + "! Pets can now evolve to level " + string(_maxPetLevel) + "!";
        costIncrease1 = 1.6;
        costIncrease2 = 750;
        building.goldCost *= 1.05;
        building.foodCost *= 1.05;
    }
    
    if (building == obj_build_inn)
    {
        if (global.tutorialStep == 1)
        {
            if (instance_exists(obj_tutorial))
            {
                if (obj_tutorial.alarm[1] > room_speed)
                    obj_tutorial.alarm[1] = room_speed;
            }
        }
        
        global.maxFood *= 1.65;
        global.maxFood += (500 + (building.level * 100));
        global.maxFood = round(global.maxFood);
        
        if (global.maxFood >= global.maxNumber || is_nan(global.maxFood) || global.maxFood == 0)
            global.maxFood = global.maxNumber;
        
        global.maxGold = global.maxFood;
        say[0] = "/me Inn upgraded to level " + string(obj_build_inn.level + 1) + "! Maximum resources capacity increased to " + gml_Script_scr_bigNumber(round(global.maxFood)) + "! You will now regenerate more energy while resting!";
        costIncrease1 = 1.5;
        costIncrease2 = 500 + (building.level * 100);
    }
    
    if (building == obj_build_well || building == obj_build_academy)
    {
        ini_close();
        ini_open(string(global.platformDir) + "Village Data/Data.ini");
    }
    
    with (building)
    {
        if (room == r_1)
            level += 1;
    }
    
    if (building == obj_build_shop)
        alarm[0] = 1;
    
    if (building == obj_build_witchhut)
    {
        global.recipeMax *= 2;
        global.underworldBonus += 0.05;
        global.soulBonus += 0.25;
        global.towerBuilding[2][1] = floor(100 * (1 + ((global.towerBuilding[2][4] - 1) / 5)) * global.soulBonus * (1 + global.corruptionShardEffect[5]));
        say[0] = "/me Witch Hut upgraded to level " + string(obj_build_witchhut.level) + "! The Witch will now increase the amount of souls you harvest by " + string(round((global.soulBonus - 1) * 100)) + "%.";
        
        if (building.level == 2)
            say[0] = "/me Witch Hut upgraded to level " + string(obj_build_witchhut.level) + "! The Witch will now increase the amount of souls you harvest by " + string(round((global.soulBonus - 1) * 100)) + "%. Additionally, she can now craft !!gemstones, which you can insert in your equipment to gain extra stat caps.";
        
        costIncrease1 = 2;
        costIncrease2 = 0;
        ini_close();
        ini_open(string(global.platformDir) + "Village Data/Data.ini");
        ini_read_real("Witch", "Souls Bonus", 1.05);
        ini_close();
    }
    
    if (building == obj_portal)
    {
        if (arg2 != 0)
            say[0] = "/me Underworld Tower " + string(arg2) + " upgraded to level " + string(global.towerBuilding[arg2][4] + 1) + "!";
        else
            say[0] = "/me Underworld Outpost upgraded to level " + string(global.towerBuilding[arg2][1] + 1) + "!";
    }
    
    gml_Script_scr_playsound(choose(s_buy1, s_buy2, s_buy3), 0.9, 1.1, 1);
    gml_Script_scr_playsound(s_built, 1, 1, 1);
    gml_Script_scr_playsound(s_build1, 0.9, 1.1, 1);
    gml_Script_scr_playsound(s_build2, 0.9, 1.1, 1);
    
    if (building == obj_build_shop)
    {
        if (building.level <= 4)
            gml_Script_twitch_chat_say(string(say[0]) + string(_xpText));
        else
            gml_Script_twitch_chat_say(string(say[1]) + string(_xpText));
    }
    else
    {
        gml_Script_twitch_chat_say(string(say[0]) + string(_xpText));
    }
    
    ini_open(string(global.platformDir) + "Village Data/Data.ini");
    
    if (room == r_1)
        ini_write_real("Buildings", string(building.name) + " Level", building.level);
    
    if (building == obj_build_witchhut)
        ini_write_real("Witch", "Souls Bonus", global.soulBonus);
    
    if (building == obj_build_well)
        ini_write_real("Buildings", "Gold Bonus", global.wellGoldBonus);
    
    if (building == obj_build_academy)
        ini_write_real("Buildings", "XP Bonus", global.academyXpBonus);
    
    if (building == obj_build_creaturekeeper)
    {
        ini_write_real("Buildings", "Creature Keeper Gold Cost", building.goldCost);
        ini_write_real("Buildings", "Creature Keeper Food Cost", building.foodCost);
    }
    
    ini_write_real("Buildings", "Underworld Bonus", global.underworldBonus);
    ini_write_real("Witch", "Recipe Max", global.recipeMax);
    
    if (arg1 == 1)
    {
        var _x1 = 0;
        var _y1 = 0;
        var _x2 = 0;
        var _y2 = 0;
        
        if (arg5 == "gold")
            global.gold -= arg3;
        
        if (arg5 == "souls")
        {
            global.souls -= arg3;
            _x1 = 100;
            _y1 = 30;
        }
        
        if (arg6 == "gems")
        {
            global.gems -= arg4;
            _x2 = 0;
            _y2 = 30;
        }
        
        if (arg6 == "blood gems")
        {
            global.bloodgems -= arg4;
            _x2 = 220;
            _y2 = 30;
        }
        
        if (arg3 > 0)
        {
            with (gml_Script_instance_create(370 + _x1, 25 + _y1, obj_float))
            {
                type = 8;
                value = arg3;
                text = "-" + gml_Script_scr_bigNumber(value);
                c1 = 255;
                c2 = 128;
                parent = type;
            }
        }
        
        if (arg4 > 0)
        {
            with (gml_Script_instance_create(370 + _x2, 25 + _y2, obj_float))
            {
                type = 6;
                value = arg4;
                text = "-" + gml_Script_scr_bigNumber(value);
                c1 = 255;
                c2 = 128;
                parent = type;
            }
        }
        
        ini_close();
        gml_Script_scr_townXP(arg3);
        ini_open(string(global.platformDir) + "Village Data/Data.ini");
    }
    
    if (room == r_1)
    {
        if (building.cost < global.maxNumber)
        {
            building.oCost = min(building.oCost * costIncrease1, global.maxNumber);
            building.oCost = gml_Script_scr_addValue(building.oCost, costIncrease2);
            building.oCost = ceil(building.oCost);
            building.cost = building.oCost;
        }
        
        if (building.cost >= 1000000)
            building.cost = (ceil(building.cost / 10000) / 100) * 1000000;
        
        if (building.cost < global.maxNumber)
        {
            building.costText = gml_Script_scr_bigNumber(building.cost);
        }
        else
        {
            building.cost = global.maxNumber;
            building.costText = gml_Script_scr_bigNumber(building.cost);
            
            if (building == obj_build_inn)
                building.costText = "Maximum Level";
        }
        
        building.oCost = building.cost;
        building.cost2 = clamp(floor((0.3 * power(building.oCost, 0.25)) / 2) - 40, 0, 100000);
        
        if (building.cost == global.maxNumber)
        {
            show_debug_message("cost is maxed, increase gem cost from " + string(building.cost2) + " to " + string(floor(building.cost2 * (1 + (building.level * 0.05)))));
            building.cost2 *= 1 + (building.level * 0.1);
            building.cost2 = floor(building.cost2);
        }
        
        show_debug_message(string(building.name) + " OG cost is now: " + string(building.oCost) + ", calculating if needs gem cost: " + string(0.3 * power(building.oCost, 0.25)) + ", (-40) actual gems cost: " + string(building.cost2));
        building.oCost2 = building.cost2;
        ini_write_real("Buildings", string(building.name) + " Original Cost", building.oCost);
        ini_write_real("Buildings", string(building.name) + " Cost", building.cost);
        ini_write_real("Buildings", string(building.name) + " Original Cost 2", building.oCost2);
        ini_write_real("Buildings", string(building.name) + " Cost 2", building.cost2);
        ini_write_real("Buildings", "Max Train", global.maxTrain);
        ini_write_real("Buildings", "Max Mine", global.maxMine);
        ini_write_real("Buildings", "Max Farm", global.maxFarm);
    }
    
    if (room == r_underworld_new)
    {
        ini_close();
        
        if (arg2 > 0)
            global.towerBuilding[arg2][4] += 1;
        else
            global.towerBuilding[arg2][1] += 1;
        
        gml_Script_scr_updateTowers();
        ini_open(string(global.platformDir) + "Village Data/Data.ini");
    }
    
    ini_write_real("Stats", "Max Gold", global.maxGold);
    ini_write_real("Stats", "Max Food", global.maxFood);
    ini_write_real("Stats", "Gold", global.gold);
    ini_write_real("Stats", "Food", global.food);
    ini_write_real("Stats", "Gems", global.gems);
    ini_write_real("Underworld", "Souls", global.souls);
    ini_write_real("Underworld", "Blood Gems", global.bloodgems);
    ini_write_real("Underworld", "Underworld XP", global.underworldXP);
    ini_write_real("Underworld", "Underworld Level", global.underworldLevel);
    ini_write_real("Underworld", "Underworld Max XP", global.underworldMaxXP);
    ini_write_real("Stats", "Town XP", global.townXP);
    ini_write_real("Stats", "Town Max XP", global.townMaxXP);
    ini_write_real("Stats", "Town Level", global.townLevel);
    ini_close();
    gml_Script_scr_updateBuildings();
};
