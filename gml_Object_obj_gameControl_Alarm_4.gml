global.chestReward[1][1] = irandom_range(10000, 50000);
global.chestReward[1][2] = irandom_range(1, 5);
global.chestReward[2][1] = irandom_range(10000, 50000);
global.chestReward[2][2] = irandom_range(5, 25);
global.chestReward[3][1] = irandom_range(1, global.maxUniqueItems);
global.chestReward[3][3] = irandom_range(1, 2);
global.chestReward[3][2] = irandom_range(1, global.maxUniqueItems);
global.chestReward[3][4] = irandom_range(1, 2);

if (instance_exists(obj_build_guildhall))
{
    global.chestReward[1][1] += round(obj_build_guildhall.level * 1000);
    global.chestReward[1][2] += round(obj_build_guildhall.level / 5);
    global.chestReward[2][1] += round(obj_build_guildhall.level * 1000);
    global.chestReward[2][2] += round(obj_build_guildhall.level * 2);
    global.chestReward[3][3] += round(obj_build_guildhall.level / 10);
    global.chestReward[3][4] += round(obj_build_guildhall.level / 10);
}

global.chestReward[1][1] += round(global.rewardChestProgress * 300);
global.chestReward[1][2] += round(global.rewardChestProgress / 1500);
global.chestReward[2][1] += round(global.rewardChestProgress * 200);
global.chestReward[2][2] += round(global.rewardChestProgress / 300);
global.chestReward[3][1] = irandom_range(1, 13);
global.chestReward[3][3] += round(global.rewardChestProgress / 50000);
global.chestReward[3][2] = irandom_range(1, 13);
global.chestReward[3][4] += round(global.rewardChestProgress / 50000);
ini_open(string(global.platformDir) + "Village Data/Data.ini");
ini_write_real("Buildings", "Chest 1 Gold", global.chestReward[1][1]);
ini_write_real("Buildings", "Chest 1 Gems", global.chestReward[1][2]);
ini_write_real("Buildings", "Chest 2 XP", global.chestReward[2][1]);
ini_write_real("Buildings", "Chest 2 TP", global.chestReward[2][2]);
ini_write_real("Buildings", "Chest 3 Relic 1 Type", global.chestReward[3][1]);
ini_write_real("Buildings", "Chest 3 Relics 1", global.chestReward[3][3]);
ini_write_real("Buildings", "Chest 3 Relic 2 Type", global.chestReward[3][2]);
ini_write_real("Buildings", "Chest 3 Relics 2", global.chestReward[3][4]);
ini_write_real("Guilds", "Last Chest Value", global.rewardChestProgress);
ini_close();
lastChestValue = global.rewardChestProgress;
