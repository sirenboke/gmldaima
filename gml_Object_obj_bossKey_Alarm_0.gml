if (global.raiding == false && global.raidCall == false)
{
    portalReady = false;
    global.portalPoints = 0;
    global.portalID += 1;
    global.randAura = irandom_range(1, global.totalAuras);
    audio_stop_sound(s_portalLoop);
    
    with (obj_player)
    {
        usePortal = -1;
        gml_Script_scr_savePlayer();
    }
    
    gml_Script_twitch_chat_say("/color BlueViolet");
    
    if (ds_list_size(global.raidListPortalName) > 0)
    {
        for (var i = 0; i < ds_list_size(global.raidListPortalName); i += 1)
        {
            var spawnPlayerName = ds_list_find_value(global.raidListPortalName, i);
            var spawnPlayerClass = ds_list_find_value(global.raidListPortalClass, i);
            var spawnSaveName = string(spawnPlayerName) + string(spawnPlayerClass);
            gml_Script_scr_createCharacter(spawnPlayerClass, spawnPlayerName);
            
            with (obj_player)
            {
                if (name == spawnPlayerName)
                {
                    if (class == spawnPlayerClass)
                    {
                        state = UnknownEnum.Value_1;
                        toPortal = true;
                        path_end();
                        actionPath = path_add();
                        gotoX = obj_townPortal.x;
                        gotoY = obj_townPortal.y;
                        
                        if (mp_grid_path(global.gameGrid, actionPath, x, y, gotoX, gotoY, 1))
                            path_start(actionPath, moveSpeed * global.roomSpeed, path_action_stop, 0);
                    }
                    else
                    {
                        alarm[10] = 1;
                        state = UnknownEnum.Value_0;
                        toPortal = false;
                    }
                }
            }
        }
    }
    else
    {
        global.portalPointsDisplay = 0;
        ds_list_clear(global.raidListPortalName);
        ds_list_clear(global.raidListPortalClass);
        ini_open(string(global.platformDir) + "Village Data/Data.ini");
        ini_key_delete("Underworld", "Portal List Names");
        ini_key_delete("Underworld", "Portal List Classes");
        ini_close();
        
        with (obj_player)
        {
            ini_open(string(global.platformDir) + string(myAccDir) + "Character Data.ini");
            toPortal = false;
            usePortal = -1;
            ini_write_real("Portal", "Portal ID", -1);
            ini_close();
        }
        
        gml_Script_twitch_chat_say_direct("/me Portal closed.");
    }
    
    gml_Script_twitch_chat_say("/color FireBrick");
}
else
{
    alarm[0] = room_speed * 10;
}

enum UnknownEnum
{
    Value_0,
    Value_1
}
