text = string(global.cmdPrefix) + "reward";
name = "Guild Hall";
mp_grid_add_instances(global.gameGrid, self, 1);
event_inherited();
ini_open(string(global.platformDir) + "Village Data/Data.ini");
level = ini_read_real("Buildings", name + " Level", 1);
cost = ini_read_real("Buildings", name + " Cost", 150000);
oCost = ini_read_real("Buildings", name + " Original Cost", 150000);
cost2 = ini_read_real("Buildings", name + " Cost 2", 0);
oCost2 = ini_read_real("Buildings", name + " Original Cost 2", 0);
show_debug_message(string(name) + " gems cost: " + string(cost2));
gml_Script_instance_create(x, y, obj_quest);
global.maxChestUses += floor(level / 10);
minerGuildXP = ini_read_real("Guilds", "Miner XP", 0);
global.minerGuildLevel = ini_read_real("Guilds", "Miner Level", 1);
minerGuildMaxXP = ini_read_real("Guilds", "Miner Max XP", global.minerGuildLevel * 50);
hunterGuildXP = ini_read_real("Guilds", "Hunter XP", 0);
global.hunterGuildLevel = ini_read_real("Guilds", "Hunter Level", 1);
hunterGuildMaxXP = ini_read_real("Guilds", "Hunter Max XP", global.hunterGuildLevel * 50);
farmerGuildXP = ini_read_real("Guilds", "Farmer XP", 0);
global.farmerGuildLevel = ini_read_real("Guilds", "Farmer Level", 1);
farmerGuildMaxXP = ini_read_real("Guilds", "Farmer Max XP", global.farmerGuildLevel * 50);
global.mineBonusValue = 1.05 + ((global.minerGuildLevel / 50) * global.minerGuildLevel * (global.minerGuildLevel / 5));
global.farmBonusValue = 1.05 + ((global.farmerGuildLevel / 50) * global.farmerGuildLevel * (global.farmerGuildLevel / 5));

with (obj_build_mine)
    gemChance = 5000 - (global.minerGuildLevel * 50);

ini_close();
costText = gml_Script_scr_bigNumber(cost);

with (obj_guilds)
    instance_destroy();
