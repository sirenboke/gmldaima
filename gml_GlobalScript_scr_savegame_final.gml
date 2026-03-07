self.scr_savegame_final = function()
{
    gml_Script_scr_playsound(s_gameSave, 1, 1, 1);
    
    with (obj_player)
        gml_Script_scr_savePlayer();
    
    ini_open(string(global.platformDir) + "Campaign Data/Season Results.ini");
    ini_write_real("Time", "Current Time", obj_seasonControl.totalSeconds);
    ini_close();
    ini_open(string(global.platformDir) + "Village Data/Data.ini");
    ini_write_real("Stats", "Food", global.food);
    ini_write_real("Stats", "Gold", global.gold);
    ini_write_real("Stats", "HP", global.townHP);
    ini_write_real("Stats", "Max HP", global.townMaxHP);
    ini_write_real("Stats", "Max Gold", global.maxGold);
    ini_write_real("Stats", "Max Food", global.maxFood);
    ini_write_real("Stats", "Stage", global.ostage);
    ini_write_real("Stats", "Portal", global.portalPoints);
    ini_write_real("Witch", "Recipe", global.recipeProgress);
    
    with (obj_build_forge)
    {
        ini_write_real("Forge", "Forge Item Progress", forgeItem[0][0]);
        ini_write_real("Forge", "Forge Relic Progress", forgeItem[1][0]);
    }
    
    ini_write_real("Underworld", "Souls", global.souls);
    ini_write_real("Underworld", "Max Souls", global.maxSouls);
    ini_write_real("Underworld", "Stage", global.maxPortalStage);
    
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
};
