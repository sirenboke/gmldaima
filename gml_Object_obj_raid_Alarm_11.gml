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
        
        var _buildType = "";
        
        if (global.enemyRaid == true)
            _buildType = "guard";
        
        if (global.enemyRaid == false)
            _buildType = "raid";
        
        var _raidBuild = 0;
        ini_open(string(global.platformDir) + string(myCharDir) + "Data.ini");
        
        for (var i = 0; i <= myBuildSlots; i++)
        {
            var _checkRaidBuild = ini_read_string("Build", "Build " + string(i) + " Name", "!renamebuild" + string(i));
            
            if (string_lower(_checkRaidBuild) == _buildType)
                _raidBuild = i;
        }
        
        ini_close();
        
        if (_raidBuild > 0)
            gml_Script_scr_player_loadbuild(_raidBuild);
        
        if (raidAura != 0)
        {
            myAura = raidAura;
            auraIcon = oauraIcon[myAura];
            spr_aura = auraIcon;
            gml_Script_scr_updateStats();
        }
        
        myWarrior = gml_Script_instance_create(-50, room_height - 30, obj_warrior);
        
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
            {
                xx = 400 - (global.raidNumber * 100);
                x = -50 - (global.raidNumber * 100);
            }
            
            if (raidList == global.raidList1)
            {
                xx = 350 - (global.raidNumber * 100);
                x = -100 - (global.raidNumber * 100);
            }
            
            statsNumber[0] = global.raidNumber;
            statsNumber[1] = statsNumber[0];
            statsNumber[2] = statsNumber[0];
            ds_grid_set(global.combatStats1, 0, statsNumber[1], name);
            ds_grid_set(global.combatStats2, 0, statsNumber[2], name);
            global.raidNumber += 1;
            alarm[0] = 1;
        }
    }
}

ds_list_copy(global.raidListMelee, global.raidList0);
ds_list_copy(global.raidListRanged, global.raidList1);
show_debug_message("Type size start: " + string(ds_list_size(global.raidListRanged)));
global.raiding = true;

enum UnknownEnum
{
    Value_8 = 8
}
