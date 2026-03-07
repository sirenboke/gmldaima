self.scr_savegame = function()
{
    if (room == r_1)
    {
        gml_Script_scr_playsound(s_gameSave, 1, 1, 1);
        obj_subControl.alarm[1] = 1;
        
        with (obj_player)
            gml_Script_scr_savePlayer();
        
        ini_open(string(global.platformDir) + "Campaign Data/Season Results.ini");
        ini_write_real("Time", "Current Time", obj_seasonControl.totalSeconds);
        ini_write_real("Corrupted Dimension", "Corruption Timer", obj_seasonControl.alarm[4]);
        ini_write_real("Time", "Final War Timer", obj_seasonControl.alarm[3]);
        ini_close();
        ini_open(string(global.platformDir) + "Village Data/Data.ini");
        ini_write_real("Stats", "Food", global.food);
        ini_write_real("Stats", "Gold", global.gold);
        ini_write_real("Stats", "Gems", global.gems);
        ini_write_real("Stats", "HP", global.townHP);
        ini_write_real("Stats", "Max HP", global.townMaxHP);
        ini_write_real("Stats", "Max Gold", global.maxGold);
        ini_write_real("Stats", "Max Food", global.maxFood);
        ini_write_real("Stats", "Town Level", global.townLevel);
        ini_write_real("Stats", "Town XP", global.townXP);
        ini_write_real("Stats", "Town Max XP", global.townMaxXP);
        ini_write_real("Underworld", "Underworld XP", global.underworldXP);
        ini_write_real("Underworld", "Underworld Level", global.underworldLevel);
        ini_write_real("Underworld", "Underworld Max XP", global.underworldMaxXP);
        ini_write_real("Stats", "Stage", global.ostage);
        ini_write_real("Stats", "Portal Points", global.portalPoints);
        ini_write_real("Witch", "Recipe", global.recipeProgress);
        ini_write_real("Witch", "Recipe", global.recipeProgress);
        
        if (instance_exists(obj_build_witchhut))
            ini_write_real("Witch", "Recipe Duration", obj_build_witchhut.alarm[0]);
        
        if (instance_exists(obj_build_creaturekeeper))
        {
            with (obj_build_creaturekeeper)
            {
                ini_write_real("Buildings", "Creature Keeper Egg Stage", eggstage);
                ini_write_real("Buildings", "Creature Keeper Egg Timer", alarm[0]);
            }
        }
        
        with (obj_raid)
        {
            for (var i = 0; i < array_length(specialRaid); i++)
            {
                ini_write_real("Minibosses", "Miniboss " + string(i) + " Respawn Time", gml_Script_scr_alarm_get(50 + i));
                ini_write_real("Minibosses", "Miniboss " + string(i) + " Relic 1", specialRaid[i][1]);
                ini_write_real("Minibosses", "Miniboss " + string(i) + " Relic 2", specialRaid[i][2]);
                ini_write_real("Minibosses", "Miniboss " + string(i) + " Relic 3", specialRaid[i][3]);
                ini_write_real("Minibosses", "Miniboss " + string(i) + " Type", specialRaid[i][4]);
            }
        }
        
        var _finalWarListName = ds_list_write(global.finalWarListName);
        var _finalWarListClass = ds_list_write(global.finalWarListClass);
        ini_write_string("Final War", "List Names", _finalWarListName);
        ini_write_string("Final War", "List Classes", _finalWarListClass);
        
        if (instance_exists(obj_build_forge))
        {
            with (obj_build_forge)
            {
                ini_write_real("Forge", "Forge Item Progress", forgeItem[0][0]);
                ini_write_real("Forge", "Forge Item Duration", alarm[0]);
                ini_write_real("Forge", "Forge Relic Progress", forgeItem[1][0]);
                ini_write_real("Forge", "Forge Relic Duration", alarm[1]);
            }
        }
        
        ini_write_real("Underworld", "Souls", global.souls);
        ini_write_real("Underworld", "Max Souls", global.maxSouls);
        ini_write_real("Underworld", "Blood Gems", global.bloodgems);
        ini_write_real("Underworld", "Stage", global.maxPortalStage);
        var portalListName = ds_list_write(global.raidListPortalName);
        var portalListClass = ds_list_write(global.raidListPortalClass);
        ini_write_string("Underworld", "Portal List Names", portalListName);
        ini_write_string("Underworld", "Portal List Classes", portalListClass);
        ini_write_real("Underworld", "Portal Timer", obj_bossKey.alarm[0]);
        var redportalListName = ds_list_write(global.raidListRedPortalName);
        var redportalListClass = ds_list_write(global.raidListRedPortalClass);
        ini_write_string("Corrupted Dimension", "Red Portal List Names", redportalListName);
        ini_write_string("Corrupted Dimension", "Red Portal List Classes", redportalListClass);
        ini_write_real("Corrupted Dimension", "Red Portal Timer", obj_corruptedControl.alarm[0]);
        
        if (instance_exists(obj_portal))
        {
            with (obj_portal)
            {
                if (global.portalTower > 5)
                    global.portalTower = 5;
                
                show_debug_message("Portal Tower: " + string(global.portalTower));
                
                for (var i = 1; i < global.portalTower; i++)
                {
                    show_debug_message("Portal Tower: " + string(i));
                    ini_write_real("Underworld", "Tower " + string(i) + " Building Production", global.towerBuilding[i][1]);
                    ini_write_real("Underworld", "Tower " + string(i) + " Building Timer", ceil(alarm[i] / room_speed));
                    ini_write_real("Underworld", "Tower " + string(i) + " Level", global.towerBuilding[i][4]);
                }
                
                ini_write_real("Underworld", "Outpost Level", global.towerBuilding[0][1]);
                ini_write_real("Underworld", "Outpost XP Production", global.towerBuilding[0][4]);
                ini_write_real("Underworld", "Outpost XP Timer", ceil(alarm[5] / room_speed));
                ini_write_real("Underworld", "Outpost Gold Production", global.towerBuilding[0][7]);
                ini_write_real("Underworld", "Outpost Gold Timer", ceil(alarm[6] / room_speed));
                ini_write_real("Underworld", "Outpost TP Production", global.towerBuilding[0][10]);
                ini_write_real("Underworld", "Outpost TP Timer", ceil(alarm[7] / room_speed));
                ini_write_real("Underworld", "Outpost Gem Production", global.towerBuilding[0][13]);
                ini_write_real("Underworld", "Outpost Gem Timer", ceil(alarm[8] / room_speed));
            }
        }
        
        if (instance_exists(obj_build_guildhall))
        {
            ini_write_real("Guilds", "Miner Level", global.minerGuildLevel);
            ini_write_real("Guilds", "Miner XP", obj_build_guildhall.minerGuildXP);
            ini_write_real("Guilds", "Miner Max XP", obj_build_guildhall.minerGuildMaxXP);
            ini_write_real("Guilds", "Hunter Level", global.hunterGuildLevel);
            ini_write_real("Guilds", "Hunter XP", obj_build_guildhall.hunterGuildXP);
            ini_write_real("Guilds", "Hunter Max XP", obj_build_guildhall.hunterGuildMaxXP);
            ini_write_real("Guilds", "Farmer Level", global.farmerGuildLevel);
            ini_write_real("Guilds", "Farmer XP", obj_build_guildhall.farmerGuildXP);
            ini_write_real("Guilds", "Farmer Max XP", obj_build_guildhall.farmerGuildMaxXP);
            ini_write_real("Guilds", "Chest Reward ID", global.globalRewardID);
            ini_write_real("Guilds", "Chest 1 ID", global.chestID[1]);
            ini_write_real("Guilds", "Chest 2 ID", global.chestID[2]);
            ini_write_real("Guilds", "Chest 3 ID", global.chestID[3]);
            ini_write_real("Guilds", "Chest Progress", global.rewardChestProgress);
            ini_write_real("Guilds", "Chest Timer", obj_gameControl.alarm[4]);
            ini_write_real("Guilds", "Chest Duration", obj_gameControl.alarm[3]);
        }
        
        if (instance_exists(obj_build_shop))
            ini_write_real("Buildings", "Shop ID", global.globalShopID);
        
        if (instance_exists(obj_build_forge))
        {
            ini_write_real("Buildings", "Forge ID", global.globalForgeID);
            ini_write_real("Buildings", "Reforge ID", global.globalReforgeID);
        }
        
        ini_write_real("Buildings", "Max Train", 1 + obj_build_train.level);
        ini_write_real("Buildings", "Max Farm", 1 + obj_build_farm.level);
        ini_write_real("Buildings", "Max Mine", 1 + obj_build_mine.level);
        ini_close();
        ini_open(string(global.platformDir) + "Campaign Data/Credits.ini");
        
        if (is_nan(global.creditsGold))
            global.creditsGold = global.maxNumber;
        
        if (global.creditsFood > global.maxNumber)
            global.creditsFood = global.maxNumber;
        
        if (global.creditsXP > global.maxNumber)
            global.creditsXP = global.maxNumber;
        
        ini_write_real("Global", "Gold", global.creditsGold);
        ini_write_real("Global", "Food", global.creditsFood);
        ini_write_real("Global", "XP", global.creditsXP);
        ini_write_real("Global", "Kills", global.creditsKills);
        ini_write_real("Global", "Deaths", global.creditsDeaths);
        ini_write_real("Global", "Honor", global.creditsHonor);
        ini_write_real("Global", "Total Bunnies", global.totalBunnies);
        ini_write_real("Global", "Bunnies", global.creditsBunnies);
        ini_close();
        ini_open(string(global.platformDir) + "Core Data/Permanent.ini");
        ini_write_string("Honor Ranking", "String", ds_grid_write(global.honorRanking));
        ini_write_string("Town", "Prefix", global.cmdPrefix);
        ini_write_real("God", "Favor Max", global.godsHonorMax + (global.godLevel / 10));
        ini_write_real("God", "Favor Stacks", global.godsFavorStacks);
        ini_write_real("God", "Favor Progress", global.godsHonor);
        ini_close();
        show_debug_message("Game Saved!");
        gml_Script_twitch_chat_say("/color YellowGreen");
        gml_Script_twitch_chat_say_direct("/me Game saved!");
        gml_Script_twitch_chat_say("/color FireBrick");
    }
};
