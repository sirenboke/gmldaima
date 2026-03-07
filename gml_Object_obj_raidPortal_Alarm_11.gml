ds_list_clear(global.rewardList);

with (obj_player)
{
    if (ds_list_find_index(global.raidListPortalName, name) != -1 && defeated == false)
    {
        levelRaid = level;
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
        
        tempNumber = global.raiders;
        global.raiders += 1;
        readyRaid = 1;
        
        if (energy <= 0)
            energy = 1;
        
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
                
                if (levelRaid >= 10 && levelRaid <= 99)
                    ds_list_add(raidList, string(string(raidPos) + "B" + string(levelRaid) + string(name)));
                
                if (levelRaid >= 100 && levelRaid <= 999)
                    ds_list_add(raidList, string(string(raidPos) + "C" + string(levelRaid) + string(name)));
                
                if (levelRaid >= 1000 && levelRaid <= 9999)
                    ds_list_add(raidList, string(string(raidPos) + "D" + string(levelRaid) + string(name)));
                
                if (levelRaid >= 10000 && levelRaid <= 99999)
                    ds_list_add(raidList, string(string(raidPos) + "E" + string(levelRaid) + string(name)));
                
                if (levelRaid >= 100000)
                    ds_list_add(raidList, string(string(raidPos) + "F" + string(levelRaid) + string(name)));
            }
        }
        
        path_end();
        state = UnknownEnum.Value_8;
        targetX = 2000;
        targetY = 450;
        actionPath = path_add();
        
        if (mp_grid_path(global.gameGrid, actionPath, x, y, targetX, targetY, 1))
            path_start(actionPath, moveSpeed * global.roomSpeed, path_action_stop, 0);
        
        if (portalAura != 0)
            myAura = portalAura;
        else if (raidAura != 0)
            myAura = raidAura;
        
        auraIcon = oauraIcon[myAura];
        spr_aura = auraIcon;
        gml_Script_scr_updateStats();
        myWarrior = gml_Script_instance_create(-60, room_height - 30, obj_warrior);
        
        with (myWarrior)
        {
            raidList = other.raidList;
            sprite_index = other.sprite_index;
            class = other.class;
            name = other.name;
            
            if (ds_list_find_index(global.rewardList, name) == -1)
                ds_list_add(global.rewardList, name);
            
            saveName = other.saveName;
            player = other.id;
            myRaidNumber = ds_list_size(raidList);
            
            if (raidList == global.raidList0)
            {
                xx = 400 - (myRaidNumber * 100);
                x = -50 - (myRaidNumber * 100);
                mainChar = true;
            }
            
            if (raidList == global.raidList1)
            {
                xx = 350 - (myRaidNumber * 100);
                x = -100 - (myRaidNumber * 100);
            }
            
            statsNumber[0] = global.raidNumber;
            statsNumber[1] = statsNumber[0];
            statsNumber[2] = statsNumber[0];
            ds_grid_set(global.combatStats1, 0, statsNumber[1], name);
            ds_grid_set(global.combatStats2, 0, statsNumber[2], name);
            global.raidNumber += 1;
        }
    }
}

ds_list_copy(global.raidListMelee, global.raidList0);
ds_list_copy(global.raidListRanged, global.raidList1);
global.raiding = true;

enum UnknownEnum
{
    Value_8 = 8
}
