instance_destroy(obj_tempStat);
global.xpGoto[0] = -2;
global.xpGoto[1] = -2;
gml_Script_scr_clearDeathRain();

if (global.extraRewardsTimer < global.extraRewardsTimerMax && global.enemyRaid == false)
{
    global.raidXP *= 1.5;
    global.raidHonor *= 1.5;
    global.raidGold *= 1.5;
}

with (obj_player)
{
    if (getRaidItems == true)
    {
        myRewardXP = global.raidXP;
        myRewardGold = round(global.raidGold / global.raidNumber);
        gml_Script_scr_player_reward(myRewardXP, 0);
        gml_Script_scr_player_reward(myRewardGold, 1);
        gml_Script_scr_updatePlayerItems();
        
        with (gml_Script_instance_create(x, y - (height / 2), obj_float))
        {
            type = 0;
            value = other.myRewardXP;
            text = "+" + gml_Script_scr_bigNumber(round(value)) + "xp";
            c1 = 16711935;
            c2 = 8388736;
            parent = other.id;
        }
        
        with (gml_Script_instance_create(x, y - (height / 2) - 15, obj_float))
        {
            type = 1;
            value = other.myRewardGold;
            text = "+" + gml_Script_scr_bigNumber(round(value)) + "g";
            c1 = 65535;
            c2 = 4235519;
            parent = other.id;
        }
    }
}

with (obj_warrior)
{
    xp += player.myRewardXP;
    
    if (global.enemyRaid == true)
        player.wasGuarding = true;
    else
        player.wasGuarding = false;
}

ds_list_clear(global.raidList0);
ds_list_clear(global.raidList1);

if (result == 0 || result == -1)
{
    with (obj_auraItem)
        instance_destroy();
    
    if (room == r_underworld)
    {
        global.portalStage += 1;
        
        if (global.maxPortalStage < global.portalStage)
        {
            ini_open(string(global.platformDir) + "Village Data/Data.ini");
            global.maxPortalStage = global.portalStage;
            ini_write_real("Underworld", "Stage", global.maxPortalStage);
            ini_close();
        }
    }
    
    if (room == r_underworld_new)
    {
        ini_open(string(global.platformDir) + "Village Data/Data.ini");
        global.portalFloor += 1;
        show_debug_message("Floor " + string(global.portalFloor) + "/" + string(global.maxPortalFloor));
        
        if (global.portalFloor > global.maxPortalFloor)
        {
            if (global.portalTower < 4)
            {
                show_debug_message("Should create Djinn");
                
                with (instance_create_depth(x, y, -100, obj_djinn))
                {
                    type = global.djinnOrder[global.portalTower - 1];
                    image_index = type;
                    show_debug_message("Djinn " + string(type) + " created");
                }
                
                global.djinnInfo[global.djinnOrder[global.portalTower - 1]][0] = 1;
                ini_write_real("Djinns", "Djinn " + string(global.djinnOrder[global.portalTower - 1]) + " Free", 1);
            }
            
            global.portalFloor = 1;
            global.portalTower += 1;
            
            if (global.portalTower > 5)
                global.portalTower = 5;
            
            show_debug_message("Going to next Tower, Floor " + string(global.portalFloor) + "/" + string(global.maxPortalFloor));
            global.maxPortalFloor = 4 + global.portalTower;
        }
        
        ini_write_real("Underworld", "Tower", global.portalTower);
        ini_write_real("Underworld", "Tower Floor", global.portalFloor);
        ini_close();
    }
    
    with (obj_player)
    {
        if (hp > 1)
        {
            if (ds_list_find_index(global.raidListPortalName, string(name)) != -1)
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
    
    if (room == r_underworld)
    {
        if (global.portalStage < 9)
        {
            with (obj_raidPortal)
            {
                alarm[1] = room_speed * 7;
                alarm[11] = (room_speed * 7) - 1;
            }
            
            with (gml_Script_instance_create(x, y, obj_stageTransition))
            {
                c1 = 8421376;
                text1 = "Underworld";
                
                if (global.portalStage < 8)
                    text2 = "Floor " + string(0 - (global.portalStage - 1)) + " - " + string(global.floorName[global.portalStage][1]);
                else
                    text2 = "Underworld Core";
            }
        }
        else
        {
            audio_sound_gain(s_underworld1, 0, 10000);
            ds_list_clear(global.raidListPortalName);
            ds_list_clear(global.raidListPortalClass);
            ini_open(string(global.platformDir) + "Village Data/Data.ini");
            ini_key_delete("Underworld", "Portal List Names");
            ini_key_delete("Underworld", "Portal List Classes");
            ini_close();
            
            with (gml_Script_instance_create(x, y, obj_raidTransition))
            {
                c1 = 32768;
                text1 = global.stageTypeWorld;
                text2 = "Stage " + string(global.ostage);
            }
            
            with (obj_raidPortal)
            {
                alarm[0] = -1;
                alarm[1] = -1;
            }
        }
    }
    
    if (room == r_underworld_new)
    {
        if (global.portalTower < global.maxPortalTower || (global.portalTower == global.maxPortalTower && global.portalFloor == 1))
        {
            with (obj_raidPortal)
            {
                alarm[1] = room_speed * 7;
                alarm[11] = (room_speed * 7) - 1;
            }
            
            with (gml_Script_instance_create(x, y, obj_stageTransition))
            {
                c1 = 8421376;
                
                if (global.portalTower != global.maxPortalTower)
                {
                    text1 = "Underworld";
                    text2 = "Tower " + string(global.portalTower) + ", Floor " + string(global.portalFloor);
                }
                else
                {
                    text1 = "Underworld";
                    text2 = "Underworld Core";
                }
            }
        }
        else
        {
            audio_sound_gain(obj_gameControl.theme, 0, 10000);
            ds_list_clear(global.raidListPortalName);
            ds_list_clear(global.raidListPortalClass);
            ini_open(string(global.platformDir) + "Village Data/Data.ini");
            ini_key_delete("Underworld", "Portal List Names");
            ini_key_delete("Underworld", "Portal List Classes");
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
                show_debug_message("transitioning from underworld to " + string(global.stageTypeWorld));
                c1 = 32768;
                text1 = global.stageTypeWorld;
                text2 = "Stage " + string(global.ostage);
            }
            
            with (obj_raidPortal)
            {
                alarm[0] = -1;
                alarm[1] = -1;
            }
        }
    }
}

if (result == 1)
{
    audio_sound_gain(s_underworld1, 0, 10000);
    ds_list_clear(global.raidListPortalName);
    ds_list_clear(global.raidListPortalClass);
    ini_open(string(global.platformDir) + "Village Data/Data.ini");
    ini_key_delete("Underworld", "Portal List Names");
    ini_key_delete("Underworld", "Portal List Classes");
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
        show_debug_message("transitioning from underworld to " + string(global.stageTypeWorld));
        c1 = 32768;
        text1 = global.stageTypeWorld;
        text2 = "Stage " + string(global.ostage);
    }
    
    if (room == r_underworld)
    {
        if (global.portalStage < 8)
            gml_Script_twitch_chat_say("/me You got defeated on Floor " + string(0 - (global.portalStage - 1)) + "...");
        else
            gml_Script_twitch_chat_say("/me You got defeated on the Underworld Core...");
    }
    
    if (room == r_underworld_new)
    {
        if (global.portalTower < global.maxPortalTower)
            gml_Script_twitch_chat_say_direct("/me You got defeated in Tower " + string(global.portalTower) + ", Floor " + string(global.portalFloor) + "...");
        else
            gml_Script_twitch_chat_say_direct("/me You got defeated in the Underworld Core...");
        
        global.portalFloor = 1;
    }
    
    with (obj_raidPortal)
    {
        alarm[0] = -1;
        alarm[1] = -1;
    }
    
    if (instance_exists(obj_finalBoss))
    {
        ini_open(string(global.platformDir) + "Village Data/Data.ini");
        ini_write_real("Underworld", "Final Boss HP", obj_finalBoss.hp / (1 + ((global.underworldLevel - 1) * 0.05 * (1 + (global.underworldLevel / 5)))));
        ini_close();
    }
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
obj_raidPortal.enemies = 0;
obj_raidPortal.maxEnemies = round(30 + (global.portalStage / 10));
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
instance_destroy();

enum UnknownEnum
{
    Value_0,
    Value_8 = 8
}
