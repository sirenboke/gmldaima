timer = room_speed;
alarm[4] = room_speed * 600;
fightTheme = s_fight1;
instance_create_layer(x, y, "hud", obj_tips);
specialRaid[0][0] = 0;
specialRaid[0][1] = 0;
specialRaid[0][2] = 0;
specialRaid[0][3] = 0;
specialRaid[0][4] = 0;
gml_Script_scr_alarm_initialize(10000);
territoryRewardsCycle = 0;
territoryBossesDisplayPage = 0;
territoryBossesDisplayMain = 1;
territoryBossesDisplay = 0;
raidAnnounceText = "Raid " + string(global.stage);
instance_create_depth(x, y, -102, obj_raidPlayerCard);
instance_create_depth(x, y, -102, obj_raidEnemyCard);
global.cameraMove = true;
global.rainDmg = 10;
maxEnemies = 3 + global.stage;
enemies = 0;
boss = false;
global.ostage = global.stage;
ini_open(string(global.platformDir) + "Village Data/Data.ini");

for (var i = 0; i <= floor(global.ostage / 50); i++)
{
    specialRaid[i][0] = ini_read_real("Minibosses", "Miniboss " + string(i) + " Respawn Time", -1);
    specialRaid[i][1] = ini_read_real("Minibosses", "Miniboss " + string(i) + " Relic 1", 1 + irandom(global.maxUniqueItems - 1));
    specialRaid[i][2] = ini_read_real("Minibosses", "Miniboss " + string(i) + " Relic 2", 1 + irandom(global.maxUniqueItems - 1));
    specialRaid[i][3] = ini_read_real("Minibosses", "Miniboss " + string(i) + " Relic 3", 1 + irandom(global.maxUniqueItems - 1));
    specialRaid[i][4] = ini_read_real("Minibosses", "Miniboss " + string(i) + " Type", irandom(2));
    
    if (specialRaid[i][0] != -1)
    {
        gml_Script_scr_alarm_start(50 + i, specialRaid[i][0], gml_Script_scr_territoryBoss_spawn, i);
        show_debug_message("Territory Boss " + string(i) + " spawning in " + string(custom_alarm[50 + i][0]));
    }
    else
    {
        custom_alarm[50 + i][0] = specialRaid[i][0];
        show_debug_message("Territory Boss " + string(i) + " spawning available");
    }
}

ini_close();
global.enemyNumber = 0;
global.raidCall = false;
global.raidEnd = false;
global.raidNumber = 0;
global.raidTime = 0;
global.raidList0 = gml_Script_scr_ds_list_create();
global.raidList1 = gml_Script_scr_ds_list_create();
global.raidListMelee = gml_Script_scr_ds_list_create();
global.raidListRanged = gml_Script_scr_ds_list_create();
raidType = 0;
c_dmgType[0] = 16777215;
c_dmgType[1] = 255;
c_dmgType[2] = 16776960;
c_dmgType[3] = 65535;
c_dmgType[4] = 16777215;
c_dmgType[5] = 16777215;
global.combatStats1 = gml_Script_scr_ds_grid_create(50, 50);
ds_grid_clear(global.combatStats1, 0);
global.combatStats2 = gml_Script_scr_ds_grid_create(50, 50);
ds_grid_clear(global.combatStats2, 0);
global.enemyRaid = false;
global.raidItems = 0;
global.displayRaidItems = 0;
global.extraRewardsTimer = 0;
global.extraRewardsTimerMax = 120 * room_speed;
global.warriorBonusAmount = 0;
global.rogueBonusAmount = 0;
global.rangerBonusAmount = 0;
global.wizardBonusAmount = 0;
gml_Script_instance_create(room_width / 2, room_height - 20, obj_chest);
gml_Script_instance_create(room_width / 2, room_height - 20, obj_mountains);
gml_Script_instance_create(room_width / 2, room_height - 20, obj_ground);
