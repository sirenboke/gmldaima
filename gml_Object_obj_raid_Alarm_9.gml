global.inFinalWar = true;
maxEnemies = 100000;
audio_sound_gain(obj_gameControl.theme, 0, 3000);
fightTheme = s_finalWarLoop;
audio_sound_gain(fightTheme, 0, 0);
audio_sound_gain(fightTheme, 0.2, 10000);
audio_play_sound(fightTheme, 0, 1);
global.extraRewardsTimerMax = 0;
global.extraRewardsTimer = 0;

for (i = 0; i < ds_list_size(global.finalWarListName); i += 1)
{
    var spawnPlayerName = ds_list_find_value(global.finalWarListName, i);
    var spawnPlayerClass = ds_list_find_value(global.finalWarListClass, i);
    var spawnSaveName = string(spawnPlayerName) + string(spawnPlayerClass);
    show_debug_message("Final War spawning allies: " + string(spawnPlayerName) + " (" + string(spawnPlayerClass) + ")");
    gml_Script_scr_createCharacter(spawnPlayerClass, spawnPlayerName);
}

with (obj_player)
{
    gml_Script_scr_player_notafk();
    readyRaid = 1;
    levelRaid = level;
    
    if (ds_list_find_index(raidList, string(levelRaid) + string(name)) == -1)
    {
        if (ascended == true)
        {
            ds_list_add(raidList, string("Z" + string(raidPos) + string(levelRaid) + string(name)));
        }
        else
        {
            if (levelRaid < 10)
                ds_list_add(raidList, string(string(raidPos) + "A" + string(levelRaid) + string(name)));
            
            if (levelRaid >= 10 && level <= 99)
                ds_list_add(raidList, string(string(raidPos) + "B" + string(levelRaid) + string(name)));
            
            if (levelRaid >= 100 && level <= 999)
                ds_list_add(raidList, string(string(raidPos) + "C" + string(levelRaid) + string(name)));
            
            if (levelRaid >= 1000 && levelRaid <= 9999)
                ds_list_add(raidList, string(string(raidPos) + "D" + string(levelRaid) + string(name)));
            
            if (levelRaid >= 10000 && levelRaid <= 99999)
                ds_list_add(raidList, string(string(raidPos) + "E" + string(levelRaid) + string(name)));
            
            if (levelRaid >= 100000)
                ds_list_add(raidList, string(string(raidPos) + "F" + string(levelRaid) + string(name)));
        }
        
        var _partyBonusSpecialized = specialized;
        
        if (_partyBonusSpecialized > 0)
            _partyBonusSpecialized = 3;
        else
            _partyBonusSpecialized = 1;
        
        if (class == "rogue")
            global.rogueBonus += ((1 + myTier) * _partyBonusSpecialized);
        
        if (class == "warrior")
            global.warriorBonus += ((1 + myTier) * _partyBonusSpecialized);
        
        if (class == "archer")
            global.rangerBonus += ((1 + myTier) * _partyBonusSpecialized);
        
        if (class == "mage")
            global.wizardBonus += ((1 + myTier) * _partyBonusSpecialized);
        
        global.raiders += 1;
    }
}

global.stage = global.ostage;
global.raiding = 1;

with (obj_player)
{
    if (readyRaid == 1 && state != UnknownEnum.Value_8)
    {
        path_end();
        state = UnknownEnum.Value_8;
        targetX = 1450;
        targetY = 450;
        actionPath = path_add();
        
        if (mp_grid_path(global.gameGrid, actionPath, x, y, targetX, targetY, 1))
            path_start(actionPath, moveSpeed * global.roomSpeed, path_action_stop, 0);
        
        if (raidAura != 0)
        {
            myAura = raidAura;
            auraIcon = oauraIcon[myAura];
            spr_aura = auraIcon;
            gml_Script_scr_updateStats();
        }
        
        myWarrior = gml_Script_instance_create(-60, room_height - 30, obj_warrior);
        
        with (myWarrior)
        {
            raidList = other.raidList;
            sprite_index = other.sprite_index;
            class = string(other.class);
            name = other.name;
            saveName = other.saveName;
            player = other.id;
            myRaidNumber = ds_list_size(raidList);
            
            if (raidList == global.raidList0)
                xx = 400 - (myRaidNumber * 100);
            
            if (raidList == global.raidList1)
                xx = 300 - (myRaidNumber * 100);
            
            statsNumber[0] = global.raidNumber;
            statsNumber[1] = statsNumber[0];
            statsNumber[2] = statsNumber[0];
            ds_grid_set(global.combatStats1, 0, statsNumber[1], name);
            ds_grid_set(global.combatStats2, 0, statsNumber[2], name);
            global.raidNumber += 1;
        }
    }
}

ds_list_sort(global.raidList0, true);
ds_list_sort(global.raidList1, true);
ds_list_copy(global.raidListMelee, global.raidList0);
ds_list_copy(global.raidListRanged, global.raidList1);
alarm[8] = 1;
alarm[10] = room_speed;
gml_Script_instance_create(x, y, obj_deathRain);

if (instance_number(obj_warrior) <= 0)
{
    obj_seasonControl.alarm[1] = room_speed;
    audio_sound_gain(obj_raid.fightTheme, 0, 20000);
}

enum UnknownEnum
{
    Value_8 = 8
}
