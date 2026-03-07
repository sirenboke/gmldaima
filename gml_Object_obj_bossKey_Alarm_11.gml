if (!instance_exists(obj_raidTransition))
{
    gml_Script_twitch_chat_say_direct("/me Entering the portal.");
    
    for (var i = 0; i < ds_list_size(global.raidListPortalName); i += 1)
    {
        var spawnPlayerName = ds_list_find_value(global.raidListPortalName, i);
        var spawnPlayerClass = ds_list_find_value(global.raidListPortalClass, i);
        var spawnSaveName = string(spawnPlayerName) + string(spawnPlayerClass);
        gml_Script_scr_spawnCharacter(spawnPlayerName, spawnPlayerClass, spawnSaveName);
    }
    
    with (obj_player)
    {
        lastX = x;
        lastY = y;
        
        if (path_exists(actionPath))
            lastPath = actionPath;
        else
            lastPath = -1;
        
        lastState = state;
        
        if (ds_list_find_index(global.raidListPortalName, name) != -1)
        {
            x = 2000;
            y = 450;
            hp = myStatInfo[8][3];
            inPortal = true;
            show_debug_message(string(name) + " spawned in portal.");
            var _portalBuild = 0;
            ini_open(string(global.platformDir) + string(myCharDir) + "Data.ini");
            
            for (var i = 0; i <= myBuildSlots; i++)
            {
                var _checkPortalBuild = ini_read_string("Build", "Build " + string(i) + " Name", "!renamebuild" + string(i));
                
                if (string_lower(_checkPortalBuild) == "portal")
                    _portalBuild = i;
            }
            
            ini_close();
            
            if (_portalBuild > 0)
                gml_Script_scr_player_loadbuild(_portalBuild);
        }
        else
        {
            inPortal = false;
            show_debug_message(string(name) + " stays in the village (X: " + string(lastX) + ", Y: " + string(lastY) + ".)");
        }
    }
    
    if (global.room_underworld == r_underworld)
    {
        with (gml_Script_instance_create(x, y, obj_raidTransition))
        {
            c1 = 8421376;
            text1 = "Underworld";
            text2 = "Floor 0 - " + string(global.floorName[1][1]);
        }
    }
    
    if (global.room_underworld == r_underworld_new)
    {
        with (gml_Script_instance_create(x, y, obj_raidTransition))
        {
            c1 = 8421376;
            text1 = "Underworld";
            
            if (global.portalTower < global.maxPortalTower)
                text2 = "Tower " + string(global.portalTower) + ", Floor 1";
            
            if (global.portalTower >= global.maxPortalTower)
                text2 = "Underworld Core";
        }
    }
}
