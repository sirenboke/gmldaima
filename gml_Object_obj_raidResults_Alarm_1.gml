if (global.enemyRaid == true && result == 1)
    townLost = ((obj_raid.maxEnemies - global.raidKills) * (global.stage / 10)) / 3;

global.raidGold = power(global.raidGold, 1 + (global.stage / 5000));

if (instance_exists(obj_build_guildhall))
    global.raidGold *= (1 + (((global.hunterGuildLevel - 1) / 20) * global.hunterGuildLevel));
