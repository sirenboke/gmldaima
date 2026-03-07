if (global.dev == 1)
{
    global.minerGuildLevel += 1;
    global.hunterGuildLevel += 1;
    global.farmerGuildLevel += 1;
    global.mineBonusValue = 1 + ((global.minerGuildLevel - 1) / 10);
    global.farmBonusValue = 1 + ((global.farmerGuildLevel - 1) / 10);
    global.maxChestUses = 0 + floor((level + 1) / 10);
    ini_open(string(global.platformDir) + "Village Data/Data.ini");
    ini_write_real("Buildings", "Guilds Level", level);
}
