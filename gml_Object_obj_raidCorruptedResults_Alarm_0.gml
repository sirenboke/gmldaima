instance_destroy(obj_tempStat);
global.xpGoto[0] = -2;
global.xpGoto[1] = -2;
gml_Script_scr_clearDeathRain();
ds_list_clear(global.raidList0);
ds_list_clear(global.raidList1);

if (result == 0 || result == -1)
{
    if (room == r_corrupted)
    {
        var _extraText = "";
        
        if (global.totalCorruption < 50)
            _extraText = " The Red Portal suddenly teleports you back to your dimension...";
        else
            _extraText = " The Red Portal is also being affected by Corruption! You will keep fighting through the Shattered Islands.";
        
        gml_Script_twitch_chat_say_direct("/me" + string(_extraText));
        
        if (global.challenge_lessRewards == 1)
            gml_Script_scr_corruptionDecrease();
        
        global.corruptedLevel += 1;
        
        if (global.corruptedLevel > 5)
        {
            global.corruptedLevel = 1;
            global.corruptedSector += 1;
        }
        
        ini_open(string(global.platformDir) + "Village Data/Data.ini");
        ini_write_real("Corrupted Dimension", "Sector", global.corruptedSector);
        ini_write_real("Corrupted Dimension", "Level", global.corruptedLevel);
        ini_key_delete("Corrupted Dimension", "Islands Amount");
        ini_close();
        
        if (global.totalCorruption >= 50)
            gml_Script_scr_loadCorruptedDimension();
        
        audio_sound_gain(obj_gameControl.theme, 0, 10000);
        global.stage = global.ostage;
        
        if (global.totalCorruption < 50)
        {
            ds_list_clear(global.raidListRedPortalName);
            ds_list_clear(global.raidListRedPortalClass);
            ini_open(string(global.platformDir) + "Village Data/Data.ini");
            ini_key_delete("Corrupted Dimension", "Red Portal List Names");
            ini_key_delete("Corrupted Dimension", "Red Portal List Classes");
            ini_close();
            alarm[3] = room_speed * 7;
            obj_corruptedControl.alarm[2] = room_speed * 5;
            
            with (obj_raidCorrupted)
            {
                alarm[0] = -1;
                alarm[1] = -1;
            }
        }
        else
        {
            show_debug_message("Destroying corruption shards in 3s...");
            alarm[3] = room_speed * 7;
            obj_corruptedControl.alarm[1] = room_speed * 67;
        }
    }
    
    with (obj_player)
    {
        if (hp > 1)
        {
            if (ds_list_find_index(global.raidListRedPortalName, string(name)) != -1)
            {
                readyRaid = 1;
                state = UnknownEnum.Value_8;
                x = 2000;
                y = 450;
            }
        }
        else
        {
            defeated = true;
            readyRaid = 0;
            state = UnknownEnum.Value_0;
        }
    }
}

if (result == 1)
{
    audio_sound_gain(s_underworld1, 0, 10000);
    ds_list_clear(global.raidListRedPortalName);
    ds_list_clear(global.raidListRedPortalClass);
    ini_open(string(global.platformDir) + "Village Data/Data.ini");
    ini_key_delete("Corrupted Dimension", "Red Portal List Names");
    ini_key_delete("Corrupted Dimension", "Red Portal List Classes");
    ini_close();
    global.stage = global.ostage;
    
    if (global.stage < 251)
        global.stageTypeWorld = "Forest";
    
    if (global.stage >= 251)
        global.stageTypeWorld = "Grassland";
    
    if (global.stage >= 501)
        global.stageTypeWorld = "Snow Trail";
    
    with (gml_Script_instance_create(x, y, obj_raidTransition))
    {
        show_debug_message("transitioning from corrupted dimension to " + string(global.stageTypeWorld));
        c1 = 32768;
        text1 = global.stageTypeWorld;
        text2 = "Stage " + string(global.ostage);
    }
    
    if (room == r_corrupted)
        gml_Script_twitch_chat_say_direct("/me You got defeated on Sector " + string(global.corruptedSector) + ":" + string(global.corruptedLevel) + "...");
    
    with (obj_raidCorrupted)
    {
        alarm[0] = -1;
        alarm[1] = -1;
    }
    
    instance_destroy();
}

with (obj_warriorDeath)
    sprite_index = spr_warriorRIP;

global.raidGold = 0;
global.raidXP = 0;
global.raidHonor = 0;
global.raidKills = 0;
global.raidNumber = 0;
global.raidItems = 0;
global.raiding = false;
global.raidCall = false;
global.raidEnd = false;
obj_raidCorrupted.enemies = 0;
obj_raidCorrupted.maxEnemies = 10;
global.enemyNumber = 0;
ds_grid_clear(global.combatStats1, 0);
ds_grid_clear(global.combatStats2, 0);

with (obj_item)
{
    if (equipped == true)
        instance_destroy();
}

global.warriorBonus = 0;
global.rogueBonus = 0;
global.rangerBonus = 0;
global.wizardBonus = 0;

if (global.gold < 0)
    global.gold = 0;

with (obj_trees)
{
    if (alpha != 1)
        alpha = 1;
}

with (obj_player)
    getRaidItems = false;

global.raiders = 0;
global.extraRewardsTimerMax = 100;
global.extraRewardsTimer = 0;

enum UnknownEnum
{
    Value_0,
    Value_8 = 8
}
