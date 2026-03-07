_depth = depth;
tabDisplay = 0;
global.season = 1;
var seasonText = "Season " + string(global.season);

if (!directory_exists(string(global.platformDir) + "Campaign Data"))
    directory_create(string(global.platformDir) + "Campaign Data");

if (!directory_exists(string(global.platformDir) + "Campaign Data/Past Campaigns"))
    directory_create(string(global.platformDir) + "Campaign Data/Past Campaigns");

if (!directory_exists(string(global.platformDir) + "Player Data"))
    directory_create(string(global.platformDir) + "Player Data");

if (!directory_exists(string(global.platformDir) + "Core Data"))
    directory_create(string(global.platformDir) + "Core Data");

if (!directory_exists(string(global.platformDir) + "Village Data"))
    directory_create(string(global.platformDir) + "Village Data");

ini_open(string(global.platformDir) + "Campaign Data/Season Results.ini");
seasonMaxTime = ini_read_real("Time", "Max Time", 2592000);
totalSeconds = ini_read_real("Time", "Current Time", 0);
timePlayedString = "";
corruptionTimer = 86400 * room_speed;
global.corruptionIncrease = ini_read_real("Corrupted Dimension", "Corruption Increase", 3);
var savedTime = ini_read_real("Time", "Current Time", totalSeconds);
global.totalCorruption = ini_read_real("Corrupted Dimension", "Current Corruption", 0);
alarm[3] = ini_read_real("Time", "Final War Timer", -1);
alarm[4] = ini_read_real("Corrupted Dimension", "Corruption Timer", -1);
global.season = ini_read_real("Season", "Season", 1);
ini_close();
maxDays = 0;
maxHours = 0;
maxMinutes = 0;
maxSeconds = 0;
global.seasonTime = savedTime;
gml_Script_scr_updateTime();
alarm[0] = room_speed;
