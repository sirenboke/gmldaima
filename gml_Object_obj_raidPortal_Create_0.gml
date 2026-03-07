maxEnemies = 5;
enemies = 0;
global.raidKills = 0;
c_dmgType[0] = 16777215;
c_dmgType[1] = 255;
c_dmgType[2] = 16776960;
c_dmgType[3] = 65535;
c_dmgType[4] = 16777215;
c_dmgType[5] = 16777215;
global.extraRewardsTimerMax = 30 * room_speed;
global.extraRewardsTimer = 0;
global.raidListPortalName = gml_Script_scr_ds_list_create();
global.raidListPortalClass = gml_Script_scr_ds_list_create();
ini_open(string(global.platformDir) + "Village Data/Data.ini");
var portalListName = ini_read_string("Underworld", "Portal List Names", "");
var portalListClass = ini_read_string("Underworld", "Portal List Classes", "");

if (portalListName != "")
{
    ds_list_read(global.raidListPortalName, portalListName);
    ds_list_read(global.raidListPortalClass, portalListClass);
}

ini_close();
timer = room_speed;
