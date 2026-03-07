in = false;
ended = true;

if (text1 == "Corrupted Dimension")
{
    if (room != r_corrupted)
    {
        room_goto(r_corrupted);
        show_debug_message("transitioned to corrupted dimension");
    }
}

if (text1 == "Underworld")
{
    if (room != global.room_underworld)
    {
        global.portalPointsDisplay = 0;
        room_goto(global.room_underworld);
        show_debug_message("transitioned to underworld");
    }
}

if (text1 == global.stageTypeWorld)
{
    with (obj_warrior)
        instance_destroy();
    
    if (room != r_1)
    {
        with (obj_player)
        {
            if (room == global.room_underworld)
            {
                ds_list_delete(global.raidListPortalName, ds_list_find_index(global.raidListPortalName, name));
                ds_list_delete(global.raidListPortalClass, ds_list_find_index(global.raidListPortalClass, name));
            }
            else if (room == r_corrupted)
            {
                ds_list_delete(global.raidListRedPortalName, ds_list_find_index(global.raidListRedPortalName, name));
                ds_list_delete(global.raidListRedPortalClass, ds_list_find_index(global.raidListRedPortalClass, name));
            }
        }
        
        room_goto(r_1);
        show_debug_message("transitioned to " + string(global.stageTypeWorld));
        gml_Script_scr_playsound(s_intro, 1, 1, 1);
    }
}

with (obj_ground)
    alarm[1] = 1;

with (obj_mountains)
    alarm[1] = 1;

with (obj_mountainsNight)
    alarm[1] = 1;
