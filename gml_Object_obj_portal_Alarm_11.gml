if (!instance_exists(obj_raidTransition))
{
    gml_Script_twitch_chat_say_direct("/me Entering the Corrupted Dimension.");
    
    for (var i = 0; i < ds_list_size(global.raidListRedPortalName); i += 1)
    {
        var spawnPlayerName = ds_list_find_value(global.raidListRedPortalName, i);
        var spawnPlayerClass = ds_list_find_value(global.raidListRedPortalClass, i);
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
        
        if (ds_list_find_index(global.raidListRedPortalName, name) != -1)
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
    
    if (instance_exists(obj_raidTransition))
    {
    }
    
    with (gml_Script_instance_create(x, y, obj_raidTransition))
    {
        c1 = 128;
        text1 = "Corrupted Dimension";
        text2 = "Sector 1";
    }
}
