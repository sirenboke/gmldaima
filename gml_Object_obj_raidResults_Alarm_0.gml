var _lastStage = lastStage;
instance_destroy(obj_tempStat);

if (room != r_1)
    instance_destroy();

global.xpGoto[0] = -2;
global.xpGoto[1] = -2;
gml_Script_scr_clearDeathRain();

if (global.extraRewardsTimer < global.extraRewardsTimerMax && global.enemyRaid == false)
{
    global.raidXP *= 1.5;
    global.raidHonor *= 1.5;
    global.raidGold *= 1.5;
}

global.partBgPos = 0;
gml_Script_scr_townXP(global.raidXP);

if (instance_exists(obj_bigBoss1))
{
    with (obj_bigBoss1)
        myStatInfo[1][3] = myStatInfo[1][2];
}

with (obj_player)
{
    if (getRaidItems == true)
    {
        if (other.result == 0)
        {
            gml_Script_scr_addDiaryProgress(3, 1);
            raids += 1;
        }
        
        myRewardXP = global.raidXP;
        myRewardGold = round(global.raidGold / global.raidNumber);
        var _timeAliveMultiplier = clamp(lastRaidTime / global.extraRewardsTimer, 0, 1);
        show_debug_message(string(name) + "'s raid reward penalty: " + string(_timeAliveMultiplier));
        myRewardXP *= _timeAliveMultiplier;
        myRewardGold *= _timeAliveMultiplier;
        gml_Script_scr_player_reward(myRewardXP, 0);
        gml_Script_scr_player_reward(myRewardGold, 1);
        lastRaidTime = 0;
        
        if (ascended == false)
        {
            skillPoints += global.raidTalents;
            totalSkillPoints += global.raidTalents;
            myGems += global.raidGems;
            gml_Script_scr_updatePlayerItems();
            
            with (gml_Script_instance_create(x, y - (height / 2), obj_float))
            {
                type = 0;
                value = other.myRewardXP;
                text = "+" + gml_Script_scr_bigNumber(round(value));
                c1 = 16711935;
                c2 = 8388736;
                parent = other.id;
                alarm[1] = 1;
            }
            
            with (gml_Script_instance_create(x, y - (height / 2) - 15, obj_float))
            {
                type = 1;
                value = other.myRewardGold;
                text = "+" + gml_Script_scr_bigNumber(round(value));
                c1 = 65535;
                c2 = 4235519;
                parent = other.id;
                alarm[1] = 1;
            }
            
            if (other.result == 0)
            {
                achievement[12] += 1;
                
                if (_lastStage == 50 && global.raidTime <= 180)
                {
                    if (diaryQuest[25][0] < 50)
                        gml_Script_scr_addDiaryProgress(6, _lastStage);
                }
                
                if (_lastStage == 250 && global.raidTime <= 180 && diaryQuest[26][0] < 250)
                    gml_Script_scr_addDiaryProgress(6, 200);
                
                if (_lastStage == 500 && global.raidTime <= 180 && diaryQuest[27][0] < 500)
                    gml_Script_scr_addDiaryProgress(6, 250);
                
                if (_lastStage == 750 && global.raidTime <= 180 && diaryQuest[28][0] < 750)
                    gml_Script_scr_addDiaryProgress(6, 250);
                
                if (_lastStage == 1000 && global.raidTime <= 180)
                {
                    if (diaryQuest[29][0] < 1000)
                        gml_Script_scr_addDiaryProgress(6, 250);
                }
            }
        }
    }
}

with (obj_warrior)
{
    if (player.ascended == false)
        xp += player.myRewardXP;
    
    if (global.enemyRaid == true)
        player.wasGuarding = true;
    else
        player.wasGuarding = false;
}

ini_close();

if (result == 0)
{
    if (global.stageType != global.stageTypeWorld)
    {
        global.stageType = global.stageTypeWorld;
        
        with (gml_Script_instance_create(x, y, obj_stageTransition))
        {
            c1 = 32768;
            text1 = global.stageTypeWorld;
            text2 = "Stage " + string(global.ostage);
        }
    }
    
    if (global.enemyRaid == false)
    {
        var _tpDrop = "";
        
        if (global.raidTalents > 0)
            _tpDrop = gml_Script_scr_bigNumber(global.raidTalents) + " room00Talent , ";
        
        var _gemDrop = "";
        
        if (global.raidGems > 0)
            _gemDrop = gml_Script_scr_bigNumber(global.raidGems) + " room00Gem , ";
        
        gml_Script_twitch_chat_say_direct("/me " + string(obj_raid.raidAnnounceText) + " successful! [" + string(global.raidTime) + "s] The Town obtained " + gml_Script_scr_bigNumber(round(global.raidGold) * global.globalGoldBonus) + " gold. Everyone in the raid won " + string(_tpDrop) + string(_gemDrop) + gml_Script_scr_bigNumber(round(global.raidXP * global.globalXPBonus)) + " XP and " + gml_Script_scr_bigNumber(round((global.raidGold / global.raidNumber) * global.globalGoldBonus)) + " gold!");
    }
    
    if (global.enemyRaid == true)
        gml_Script_twitch_chat_say_direct("/me You defended your town against difficulty " + gml_Script_scr_bigNumber(_lastStage) + " enemies! [" + string(global.raidTime) + "s] The Town obtained " + gml_Script_scr_bigNumber(round(global.raidGold + (global.raidCost / 2)) * global.globalGoldBonus) + " gold. Everyone in the raid won " + gml_Script_scr_bigNumber(round(global.raidXP * global.globalXPBonus)) + " XP and " + gml_Script_scr_bigNumber(round((global.raidGold / global.raidNumber) * global.globalGoldBonus)) + " gold!");
    
    raidGoldReward = (global.raidGold + (global.raidCost / 2)) * global.globalGoldBonus;
    global.gold += raidGoldReward;
    
    with (gml_Script_instance_create(370, 25, obj_float))
    {
        type = 1;
        value = round(other.raidGoldReward);
        text = "+" + gml_Script_scr_bigNumber(value);
        c1 = 65535;
        c2 = 4235519;
        parent = type;
        alarm[1] = 1;
    }
}

if (result == 1)
{
    if (global.enemyRaid == true)
    {
        if (round(global.townHP - townLost) > 0)
        {
            gml_Script_twitch_chat_say_direct("/me Raid " + gml_Script_scr_bigNumber(_lastStage) + " enemies defeated you... [" + string(global.raidTime) + "s] The Town lost " + gml_Script_scr_bigNumber(townLost) + " HP. Everyone in the town fainted and enemies looted " + gml_Script_scr_bigNumber(round(townLost * (1 + (_lastStage / 100)))) + " gold and " + gml_Script_scr_bigNumber(round(townLost * (1 + (_lastStage / 100)) * 1.5)) + " food. [" + gml_Script_scr_bigNumber(round(clamp(global.townHP - townLost, 0, global.townHP))) + " Town HP left]. If the Town HP reaches 0 you will lose all your gold, food and room00Gem !");
            global.gold -= (townLost * (1 + (_lastStage / 100)));
            global.food -= (townLost * (1 + (_lastStage / 100)) * 1.5);
            global.townHP -= townLost;
        }
        else
        {
            global.townHP = 0;
            global.gold = 0;
            global.food = 0;
            global.gems = 0;
            gml_Script_twitch_chat_say("/color Red");
            gml_Script_twitch_chat_say_direct("/me Enemies have entirely looted the Town (gold, food and room00Gem )... They will not attack again for a while...");
            gml_Script_twitch_chat_say("/color FireBrick");
            obj_raid.alarm[4] += room_speed * 7800;
        }
        
        if (global.gold < 0)
            global.gold = 0;
        
        if (global.food < 0)
            global.food = 0;
        
        with (obj_player)
        {
            hp = 0;
            energy = 0;
        }
    }
    else
    {
        gml_Script_twitch_chat_say_direct("/me " + string(obj_raid.raidAnnounceText) + " enemies defeated you... [" + string(global.raidTime) + "s] The Town obtained " + gml_Script_scr_bigNumber(round(global.raidGold + (global.raidCost / 2)) * global.globalGoldBonus) + " gold. Everyone in the raid won " + gml_Script_scr_bigNumber(round(global.raidXP * global.globalXPBonus)) + " XP and " + gml_Script_scr_bigNumber(round((global.raidGold / global.raidNumber) * global.globalGoldBonus)) + " gold.");
    }
}
else
{
    with (obj_raid)
    {
        if (raidType != 0)
        {
            if ((global.stage % 50) == 0)
            {
                if (gml_Script_scr_alarm_get(50 + (global.stage / 50)) == -1)
                {
                    ini_open(string(global.platformDir) + "Village Data/Data.ini");
                    specialRaid[global.stage / 50][0] = room_speed * 3600;
                    
                    if ((global.stage % 250) == 0)
                        specialRaid[global.stage / 50][0] *= 2;
                    
                    if ((global.stage % 1000) == 0)
                        specialRaid[global.stage / 50][0] *= 2;
                    
                    ini_write_real("Minibosses", "Miniboss " + string(floor(global.stage / 50)) + " Respawn Time", specialRaid[global.stage / 50][0]);
                    ini_close();
                    gml_Script_scr_alarm_start(50 + (global.stage / 50), specialRaid[global.stage / 50][0], gml_Script_scr_territoryBoss_spawn, global.stage / 50);
                    show_debug_message("Territory Boss " + string(global.stage / 50) + " defeated!");
                }
            }
        }
    }
    
    if (global.enemyRaid == false)
        obj_raid.alarm[2] = 1;
}

with (obj_warriorDeath)
    sprite_index = spr_warriorRIP;

var _theme = obj_gameControl.theme;
var _raidTheme = obj_raid.fightTheme;
audio_sound_gain(_theme, 0.04, 3000);
audio_stop_sound(_raidTheme);

with (obj_player)
{
    if (state == UnknownEnum.Value_8)
    {
        if (myTier > 0)
        {
            if (hp < myStatInfo[8][0] || energy < maxEnergy)
            {
                path_end();
                state = UnknownEnum.Value_5;
                target = obj_build_inn;
                actionPath = path_add();
                var w = 20;
                var h = 15;
                gotoX = irandom_range(target.x - w, target.x + w);
                gotoY = target.y;
                
                if (mp_grid_path(global.gameGrid, actionPath, x, y, gotoX, gotoY, 1))
                    path_start(actionPath, moveSpeed * global.roomSpeed, path_action_stop, 0);
            }
            else if (global.enemyRaid == true)
            {
                path_end();
                state = UnknownEnum.Value_7;
                target = obj_idleZone;
                actionPath = path_add();
                var w = 0;
                var h = 0;
                gotoX = random_range(target.x - w, target.x + w);
                gotoY = random_range(target.y - h, target.y + h);
                
                if (mp_grid_path(global.gameGrid, actionPath, x, y, gotoX, gotoY, 1))
                    path_start(actionPath, moveSpeed * global.roomSpeed, path_action_stop, 0);
            }
            else
            {
                state = UnknownEnum.Value_0;
                
                if (alarm[1] == -1)
                    alarm[1] = 1;
            }
        }
        else if (global.enemyRaid == true)
        {
            path_end();
            state = UnknownEnum.Value_7;
            target = obj_idleZone;
            actionPath = path_add();
            var w = 0;
            var h = 0;
            gotoX = random_range(target.x - w, target.x + w);
            gotoY = random_range(target.y - h, target.y + h);
            
            if (mp_grid_path(global.gameGrid, actionPath, x, y, gotoX, gotoY, 1))
                path_start(actionPath, moveSpeed * global.roomSpeed, path_action_stop, 0);
        }
        else
        {
            state = UnknownEnum.Value_0;
            
            if (alarm[1] == -1)
                alarm[1] = 1;
        }
    }
}

if (!instance_exists(obj_uniqueItem))
    ds_list_clear(global.rewardList);

ds_list_clear(global.raidList0);
ds_list_clear(global.raidList1);
ds_list_clear(global.raidListMelee);
ds_list_clear(global.raidListRanged);
global.raidGold = 0;
global.raidXP = 0;
global.raidTalents = 0;
global.raidGems = 0;
global.raidHonor = 0;
global.raidKills = 0;
global.raidNumber = 0;
ds_grid_clear(global.combatStats1, 0);
ds_grid_clear(global.combatStats2, 0);
global.raidItems = 0;
global.displayRaidItems = 0;
global.raiding = false;
global.raidCall = false;
global.raidEnd = false;
obj_raid.enemies = 0;

if (obj_raid.alarm[4] < (room_speed * 180))
    obj_raid.alarm[4] = room_speed * 180;

obj_raid.raidAnnounceText = "Raid " + string(_lastStage);
obj_raid.raidType = 0;
global.enemyNumber = 0;
global.enemyRaid = false;

with (obj_item)
{
    if (equipped == true)
        instance_destroy();
}

global.warriorBonus = 0;
global.rogueBonus = 0;
global.rangerBonus = 0;
global.wizardBonus = 0;
global.raidTime = 0;

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

with (obj_raidBounty)
    alarm[0] = 1;

if (!instance_exists(obj_build_forge))
{
    with (obj_item)
        instance_destroy();
}

global.extraRewardsTimerMax = 100;
global.extraRewardsTimer = 0;
instance_destroy();

enum UnknownEnum
{
    Value_0,
    Value_5 = 5,
    Value_7 = 7,
    Value_8
}
