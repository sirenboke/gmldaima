global.redPortalID += 1;

if (ds_list_size(global.raidListRedPortalName) > 0)
{
    for (var i = 0; i < ds_list_size(global.raidListRedPortalName); i += 1)
    {
        var spawnPlayerName = ds_list_find_value(global.raidListRedPortalName, i);
        var spawnPlayerClass = ds_list_find_value(global.raidListRedPortalClass, i);
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
                    toRedPortal = true;
                    path_end();
                    actionPath = path_add();
                    gotoX = obj_corruptedPortal.x;
                    gotoY = obj_corruptedPortal.y;
                    
                    if (mp_grid_path(global.gameGrid, actionPath, x, y, gotoX, gotoY, 1))
                        path_start(actionPath, moveSpeed * global.roomSpeed, path_action_stop, 0);
                }
                else
                {
                    alarm[10] = 1;
                    state = UnknownEnum.Value_0;
                    toPortal = false;
                    toRedPortal = false;
                }
            }
        }
    }
}
else
{
    ds_list_clear(global.raidListRedPortalName);
    ds_list_clear(global.raidListRedPortalClass);
    ini_open(string(global.platformDir) + "Village Data/Data.ini");
    ini_key_delete("Corrupted Dimension", "Red Portal List Names");
    ini_key_delete("Corrupted Dimension", "Red Portal List Classes");
    ini_close();
    obj_corruptedControl.alarm[1] = -1;
    global.redPortalOpen = false;
}

enum UnknownEnum
{
    Value_0,
    Value_1
}
