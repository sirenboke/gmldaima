global.portalTimerMax = 900;
global.portalTimer = 0;
global.portalPoints = 0;

if (room == r_underworld)
{
    persistent = false;
    sprite_index = spr_portalSouls;
    image_speed = 0;
    global.portalStage = 1;
    x = room_width / 2;
    y = 400;
    gml_Script_twitch_chat_say("/color BlueViolet");
    gml_Script_twitch_chat_say_direct("/me You entered the Underworld... Obtain Aura power and capture enemies souls, but be careful, you do not want to lose yours... (Floor " + string(0 - (global.portalStage - 1)) + ")");
    gml_Script_twitch_chat_say("/color FireBrick");
    ini_open(string(global.platformDir) + "Village Data/Data.ini");
    
    if (!instance_exists(obj_bossSouls))
    {
        for (ss = 0; ss < 7; ss += 1)
        {
            global.bossSouls[ss] = ini_read_real("Underworld", "Boss Soul " + string(ss), 0);
            
            with (gml_Script_instance_create(x, y, obj_bossSouls))
            {
                value = other.ss;
                image_index = 0;
                soulCount = global.bossSouls[value];
                
                if (soulCount > 0)
                    image_index = value + 1;
            }
        }
    }
    
    ini_close();
    
    with (obj_player)
    {
        state = UnknownEnum.Value_0;
        
        if (ds_list_find_index(global.raidListPortalName, string(name)) != -1)
        {
            readyRaid = 1;
            x = 2000;
            y = 450;
        }
    }
    
    with (obj_raidPortal)
    {
        alarm[1] = room_speed * 5;
        alarm[11] = (room_speed * 5) - 1;
    }
    
    bossMaxHP = 10000000000000;
    ini_open(string(global.platformDir) + "Village Data/Data.ini");
    bossHP = ini_read_real("Underworld", "Final Boss HP", bossMaxHP);
    
    if (bossHP > bossMaxHP)
        bossHP = bossMaxHP;
    
    ini_close();
}

if (global.newUnderworld == true)
{
    persistent = true;
    x = room_width / 2;
    y = 400;
    sprite_index = spr_enemySpawner;
    image_speed = 0.2;
    global.portalTimerMax = 180 - (global.portalTower * 30);
    
    if (global.dev == 1)
        global.portalTimerMax = 100000;
    
    if (global.portalTower == 5)
        global.portalTimerMax = 0;
    
    ini_open(string(global.platformDir) + "Village Data/Data.ini");
    
    for (var i = 0; i <= global.maxPortalTower; i++)
    {
        global.towerBuilding[i][0] = ini_read_string("Underworld", "Tower " + string(i) + " Building", "undefined");
        
        for (var ii = 0; ii < 10; ii++)
            global.towerBuilding[i][ii] = 0;
    }
    
    global.onlyFinis = ini_read_real("Underworld", "Only Finis", 0);
    global.towerBuilding[0][0] = "Outpost";
    global.towerBuilding[0][1] = ini_read_real("Underworld", "Outpost Level", 0);
    global.towerBuilding[0][2] = round(global.towerBuilding[0][1] * 1000 * (1 + (global.towerBuilding[0][1] / 10)));
    global.towerBuilding[0][3] = round(floor(global.towerBuilding[0][2] / 5000) * (1 + (global.towerBuilding[0][1] / 10)));
    global.towerBuilding[0][4] = ini_read_real("Underworld", "Outpost Gold Production", 100000000);
    global.towerBuilding[0][5] = 3600;
    global.towerBuilding[0][6] = ini_read_real("Underworld", "Outpost Gold Timer", global.towerBuilding[0][5]);
    global.towerBuilding[0][7] = ini_read_real("Underworld", "Outpost XP Production", 5000000);
    global.towerBuilding[0][8] = 3600;
    global.towerBuilding[0][9] = ini_read_real("Underworld", "Outpost XP Timer", global.towerBuilding[0][8]);
    global.towerBuilding[0][10] = ini_read_real("Underworld", "Outpost TP Production", 5);
    global.towerBuilding[0][11] = 3600;
    global.towerBuilding[0][12] = ini_read_real("Underworld", "Outpost TP Timer", global.towerBuilding[0][11]);
    global.towerBuilding[0][13] = ini_read_real("Underworld", "Outpost Gem Production", 1);
    global.towerBuilding[0][14] = 3600;
    global.towerBuilding[0][15] = ini_read_real("Underworld", "Outpost Gem Timer", global.towerBuilding[0][14]);
    
    if (global.towerBuilding[0][1] > 0)
    {
        if (global.towerBuilding[0][6] <= 0)
            global.towerBuilding[0][6] = global.towerBuilding[0][5];
        
        alarm[5] = global.towerBuilding[0][6] * room_speed;
    }
    
    if (global.towerBuilding[0][1] > 4)
    {
        if (global.towerBuilding[0][9] <= 0)
            global.towerBuilding[0][9] = global.towerBuilding[0][8];
        
        alarm[6] = global.towerBuilding[0][9] * room_speed;
    }
    
    if (global.towerBuilding[0][1] > 9)
    {
        if (global.towerBuilding[0][12] <= 0)
            global.towerBuilding[0][12] = global.towerBuilding[0][11];
        
        alarm[7] = global.towerBuilding[0][12] * room_speed;
    }
    
    if (global.towerBuilding[0][1] > 14)
    {
        if (global.towerBuilding[0][15] <= 0)
            global.towerBuilding[0][15] = global.towerBuilding[0][14];
        
        alarm[8] = global.towerBuilding[0][15] * room_speed;
    }
    
    global.towerBuilding[1][0] = "Aura Generator";
    global.towerBuilding[1][1] = ini_read_real("Underworld", "Tower 1 Building Production", 1);
    global.towerBuilding[1][2] = 14400;
    global.towerBuilding[1][3] = ini_read_real("Underworld", "Tower 1 Building Timer", global.towerBuilding[1][2]);
    global.towerBuilding[1][4] = ini_read_real("Underworld", "Tower 1 Level", 0);
    global.towerBuilding[1][5] = round(global.towerBuilding[1][4] * 100 * 10 * (1 + (global.towerBuilding[1][4] / 5)));
    global.towerBuilding[1][6] = round(floor(global.towerBuilding[1][5] / 50000) * (1 + (global.towerBuilding[1][4] / 10)));
    
    if (global.towerBuilding[1][4] > 0)
        alarm[1] = global.towerBuilding[1][3] * room_speed;
    
    global.towerBuilding[2][0] = "Soul Extractor";
    global.towerBuilding[2][1] = ini_read_real("Underworld", "Tower 2 Building Production", 100);
    global.towerBuilding[2][2] = 3600;
    global.towerBuilding[2][3] = ini_read_real("Underworld", "Tower 2 Building Timer", global.towerBuilding[2][2]);
    global.towerBuilding[2][4] = ini_read_real("Underworld", "Tower 2 Level", 0);
    global.towerBuilding[2][5] = round(global.towerBuilding[2][4] * 100 * 20 * (1 + (global.towerBuilding[2][4] / 5)) * 2);
    global.towerBuilding[2][6] = round(floor(global.towerBuilding[2][5] / 50000) * (1 + (global.towerBuilding[2][4] / 10)));
    
    if (global.towerBuilding[2][4] > 0)
        alarm[2] = global.towerBuilding[2][3] * room_speed;
    
    global.towerBuilding[3][0] = "Relic Enchanter";
    global.towerBuilding[3][1] = ini_read_real("Underworld", "Tower 3 Building Production", 2);
    global.towerBuilding[3][2] = 21600;
    global.towerBuilding[3][3] = ini_read_real("Underworld", "Tower 3 Building Timer", global.towerBuilding[3][2]);
    global.towerBuilding[3][4] = ini_read_real("Underworld", "Tower 3 Level", 0);
    global.towerBuilding[3][5] = round(global.towerBuilding[3][4] * 100 * 30 * (1 + (global.towerBuilding[3][4] / 5)) * 3);
    global.towerBuilding[3][6] = round(floor(global.towerBuilding[3][5] / 50000) * (1 + (global.towerBuilding[3][4] / 10)));
    
    if (global.towerBuilding[3][4] > 0)
        alarm[3] = global.towerBuilding[3][3] * room_speed;
    
    global.towerBuilding[4][0] = "Blood Gem Mine";
    global.towerBuilding[4][1] = ini_read_real("Underworld", "Tower 4 Building Production", 1);
    global.towerBuilding[4][2] = 86400;
    global.towerBuilding[4][3] = ini_read_real("Underworld", "Tower 4 Building Timer", global.towerBuilding[4][2]);
    global.towerBuilding[4][4] = ini_read_real("Underworld", "Tower 4 Level", 0);
    global.towerBuilding[4][5] = round(global.towerBuilding[4][4] * 100 * 40 * (1 + (global.towerBuilding[4][4] / 5)) * 4);
    global.towerBuilding[4][6] = round(floor(global.towerBuilding[4][5] / 50000) * (1 + (global.towerBuilding[4][4] / 10)));
    
    if (global.towerBuilding[4][4] > 0)
        alarm[4] = global.towerBuilding[4][3] * room_speed;
    
    global.portalTower = ini_read_real("Underworld", "Tower", 1);
    global.portalFloor = 1;
    
    if ((global.portalTower == 4 || global.portalTower == 5) && global.onlyFinis == 1)
        global.portalFloor = 8;
    
    ini_close();
    gml_Script_scr_updateTowers();
    alarm[9] = room_speed;
    global.redPortalID = 0;
    
    with (obj_player)
    {
        useRedPortal = -1;
        gml_Script_scr_savePlayer();
    }
    
    global.raidListRedPortalName = gml_Script_scr_ds_list_create();
    global.raidListRedPortalClass = gml_Script_scr_ds_list_create();
    ini_open(string(global.platformDir) + "Village Data/Data.ini");
    var portalListName = ini_read_string("Corrupted Dimension", "Red Portal List Names", "");
    var portalListClass = ini_read_string("Corrupted Dimension", "Red Portal List Classes", "");
    
    if (portalListName != "")
    {
        ds_list_read(global.raidListRedPortalName, portalListName);
        ds_list_read(global.raidListRedPortalClass, portalListClass);
    }
    
    ini_close();
    
    if (!instance_exists(obj_raidCorrupted))
        gml_Script_instance_create(x, y, obj_raidCorrupted);
}

enum UnknownEnum
{
    Value_0
}
