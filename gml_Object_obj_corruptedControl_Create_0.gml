global.corruptedLevel = 1;
global.corruptedSector = 0;
global.redPortalOpen = false;
ini_open(string(global.platformDir) + "Village Data/Data.ini");
global.redPortalCost = ini_read_real("Corrupted Dimension", "Portal Ritual", 5);
corruptedChallenge[0][0] = 0.4;
corruptedChallenge[0][1] = "Your healing is reduced by *%";
corruptedChallenge[1][0] = 0.3;
corruptedChallenge[1][1] = "Enemies have +*% physical resistance";
corruptedChallenge[2][0] = 0.3;
corruptedChallenge[2][1] = "Enemies have +*% special resistance";
corruptedChallenge[3][0] = 0.3;
corruptedChallenge[3][1] = "Enemies have +*% status resistance";
corruptedChallenge[4][0] = 0.25;
corruptedChallenge[4][1] = "Enemies have *% chance of going through units";
corruptedChallenge[5][0] = 1;
corruptedChallenge[5][1] = "Switching is disabled (auto-switch included)";
corruptedChallenge[6][0] = 1;
corruptedChallenge[6][1] = "You can not use consumables";
corruptedChallenge[7][0] = 3;
corruptedChallenge[7][1] = "Your abilities have *x cost and casting time";
corruptedChallenge[8][0] = 0.1;
corruptedChallenge[8][1] = "All your stats are reduced by *%";
corruptedChallenge[9][0] = 0.4;
corruptedChallenge[9][1] = "Pet Relic effects are reduced by *%";
corruptedChallenge[10][0] = 0.2;
corruptedChallenge[10][1] = "All your Relic effects are reduced by *%";
corruptedChallenge[11][0] = 0.4;
corruptedChallenge[11][1] = "Meteors periodically damage you for *% HP";
corruptedChallenge[12][0] = 0.25;
corruptedChallenge[12][1] = "Blood Rain starts *% faster";
corruptedChallenge[13][0] = 0.05;
corruptedChallenge[13][1] = "*% chance for Bosses to spawn";
corruptedChallenge[14][0] = 0.2;
corruptedChallenge[14][1] = "Enemies have *% increased stamina";
corruptedChallenge[15][0] = 0.1;
corruptedChallenge[15][1] = "Your stamina drains *% faster";
corruptedChallenge[16][0] = 0.1;
corruptedChallenge[16][1] = "Your basic attacks have *% chance to miss";
corruptedChallenge[17][0] = 0.1;
corruptedChallenge[17][1] = "Your true damage is *% weaker";
corruptedChallenge[18][0] = 0.25;
corruptedChallenge[18][1] = "Your special damage has 50% of being *% weaker";
corruptedChallenge[19][0] = 0.1;
corruptedChallenge[19][1] = "Enemies have *% increased constitution";
corruptedChallenge[20][0] = 1;
corruptedChallenge[20][1] = "Corruption Level does not decrease";
corruptedChallenge[21][0] = 0.1;
corruptedChallenge[21][1] = "Enemies have *% chance to block physical damage";
corruptedChallenge[22][0] = 0.05;
corruptedChallenge[22][1] = "You have a *% chance per second of getting interrupted";
corruptedChallenge[23][0] = 0.1;
corruptedChallenge[23][1] = "Enemies gain +*% resistance to debuffs";
corruptedChallenge[24][0] = 0.1;
corruptedChallenge[24][1] = "Enemies gain +*% resistance to CC";
corruptedChallenge[25][0] = 0.05;
corruptedChallenge[25][1] = "Enemies have *% chance of reviving once";
corruptedReward[0][0] = 0.02;
corruptedReward[0][1] = "+*%[x] extra critical damage";
corruptedReward[0][2] = "Shard of Wrath";
corruptedReward[1][0] = 0.02;
corruptedReward[1][1] = "+*%[x] extra healing";
corruptedReward[1][2] = "Shard of Life";
corruptedReward[2][0] = 0.05;
corruptedReward[2][1] = "+*%[x] food from farming";
corruptedReward[2][2] = "Shard of Abundance";
corruptedReward[3][0] = 0.05;
corruptedReward[3][1] = "+*%[x] gold from mining";
corruptedReward[3][2] = "Shard of Greed";
corruptedReward[4][0] = 0.05;
corruptedReward[4][1] = "+*%[x] XP from training";
corruptedReward[4][2] = "Shard of Discipline";
corruptedReward[5][0] = 0.05;
corruptedReward[5][1] = "+*%[x] souls harvested";
corruptedReward[5][2] = "Shard of Death";
corruptedReward[6][0] = 0.01;
corruptedReward[6][1] = "+*%[x] damage output";
corruptedReward[6][2] = "Shard of Focus";
corruptedReward[7][0] = 0.05;
corruptedReward[7][1] = "+*%[x] Gods Favor effect";
corruptedReward[7][2] = "Shard of Faith";
corruptedReward[8][0] = 0.01;
corruptedReward[8][1] = "+*%[x] gem finding while mining";
corruptedReward[8][2] = "Shard of Luck";
corruptedReward[9][0] = 0.01;
corruptedReward[9][1] = "+*%[x] Guilds XP gain";
corruptedReward[9][2] = "Shard of Commitment";
corruptedReward[10][0] = 3;
corruptedReward[10][1] = "+* Blood Gems";
corruptedReward[10][2] = "Shard of Blood";
corruptedReward[11][0] = 500;
corruptedReward[11][1] = "+* Gems (Town only)";
corruptedReward[11][2] = "Shard of Riches";
corruptedReward[12][0] = 0.05;
corruptedReward[12][1] = "+*%[x] Pets XP gain";
corruptedReward[12][2] = "Shard of Beasts";
corruptedReward[13][0] = 0.05;
corruptedReward[13][1] = "+*%[x] VP gain";
corruptedReward[13][2] = "Shard of Vocation";
corruptedReward[14][0] = 0.05;
corruptedReward[14][1] = "+*%[x] constitution";
corruptedReward[14][2] = "Shard of Constitution";
corruptedReward[15][0] = 0.05;
corruptedReward[15][1] = "+*%[x] energy and stamina";
corruptedReward[15][2] = "Shard of Endurance";
global.maxCorruptedChallenges = array_length(corruptedChallenge) - 1;
global.maxCorruptedRewards = array_length(corruptedReward) - 1;

for (var r = 0; r <= global.maxCorruptedRewards; r++)
    corruptedReward[r][3] = ini_read_real("Corrupted Dimension", "Reward " + string(r) + " Amount", 0);

for (var r = 0; r <= global.maxCorruptedRewards; r++)
    global.corruptionShardEffect[r] = corruptedReward[r][0] * corruptedReward[r][3];

global.challenge_canSwitch = 1;
global.challenge_canPot = 1;
global.challenge_relicEffect = 1;
global.challenge_petRelicEffect = 1;
global.challenge_enemyCollision = 0;
global.challenge_bossChance = 0;
global.challenge_bloodRain = 1;
global.challenge_enemyStamina = 1;
global.challenge_allyStamina = 1;
global.challenge_basicMiss = 0;
global.challenge_trueReduction = 1;
global.challenge_specialReduction = 1;
global.challenge_enemyConst = 1;
global.challenge_lessRewards = 1;
global.challenge_blockPhysical = 0;
global.challenge_interruption = 20;
global.challenge_enemyRevive = 0;
var pool = gml_Script_scr_generateUniqueIndices(global.maxCorruptedChallenges + 1);
show_debug_message("Corrupted Challenges: " + string(pool));
corruptedName[0] = "Forgotten";
corruptedName[1] = "Broken";
corruptedName[2] = "Ancient";
corruptedName[3] = "Lost";
corruptedName[4] = "Timeless";
corruptedName[5] = "Scattered";
corruptedName[6] = "Twisted";
corruptedName[7] = "Erased";
corruptedName[8] = "Stolen";
corruptedName2[0] = "Memory";
corruptedName2[1] = "Promise";
corruptedName2[2] = "Secret";
corruptedName2[3] = "Hope";
corruptedName2[4] = "River";
corruptedName2[5] = "Faith";
corruptedName2[6] = "Heart";
corruptedName2[7] = "Forest";
corruptedName2[8] = "Treasure";
global.corruptedNames = array_length(corruptedName) - 1;
global.unlockCorrupted = ini_read_real("Corrupted Dimension", "Unlocked", 0);
var _timer = ini_read_real("Corrupted Dimension", "Red Portal Timer", -1);
global.corruptedSector = ini_read_real("Corrupted Dimension", "Sector", 0);
global.corruptedLevel = ini_read_real("Corrupted Dimension", "Level", 1);

if (_timer > 0)
    alarm[0] = _timer;

if (alarm[0] != -1)
    global.redPortalOpen = true;

ini_close();
accepted = false;
global.globalChallengeValue = [];
obj_seasonControl.corruptionTimer = 86400 * room_speed;

if (global.unlockCorrupted == 1)
{
    instance_create_depth(x, y, depth - 1, obj_corruptedPortal);
    obj_seasonControl.alarm[4] = obj_seasonControl.corruptionTimer;
}
else
{
}

layer = layer_get_id("Cleared");
