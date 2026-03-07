instance_destroy(obj_tempStat);

if (room == r_corrupted)
{
    global.stageType = "Corrupted Dimension";
    
    with (obj_raidObject)
        instance_destroy();
    
    with (obj_fog)
        light = 155;
    
    if (audio_is_playing(theme))
        audio_stop_sound(theme);
    
    theme = s_corrupted1;
    audio_sound_gain(theme, 1, 10000);
}

if (room == global.room_underworld)
{
    ds_list_clear(global.raidList0);
    ds_list_clear(global.raidList1);
    global.stageType = "Underworld";
    
    if (room == r_underworld)
    {
        if (instance_exists(obj_portal))
        {
            with (obj_portal)
                instance_destroy();
        }
        
        gml_Script_instance_create(x, y, obj_portal);
    }
    
    if (room == r_underworld_new)
    {
        if (!instance_exists(obj_portal))
            gml_Script_instance_create(x, y, obj_portal);
    }
    
    with (obj_raidObject)
        instance_destroy();
    
    with (obj_fog)
        light = 155;
    
    if (audio_is_playing(theme))
        audio_stop_sound(theme);
    
    theme = choose(s_underworld1, s_underworld2, s_underworld3, s_underworld4, s_underworld5, s_underworld6, s_underworld7);
    
    if (global.portalTower == 4 && global.onlyFinis == 1)
        theme = m_finis_1;
    
    for (var t = 0; t < 50; t += 1)
        gml_Script_instance_create(random_range(0, room_width * 2), random_range(room_height - 200, room_height - 30), obj_mist);
    
    audio_sound_gain(theme, 0.8, 10000);
}

if (room == r_1)
{
    audio_sound_gain(s_underworldBoss, 0, 200);
    ds_list_clear(global.rewardList);
    ds_list_clear(global.raidList0);
    ds_list_clear(global.raidList1);
    
    if (surface_exists(global.underworldFog))
        gml_Script_scr_surface_free(global.underworldFog);
    
    global.raiding = false;
    global.raidCall = false;
    
    with (obj_raidObject)
        instance_destroy();
    
    with (obj_raid)
    {
        if (alarm[4] <= (room_speed * 60))
            alarm[4] = room_speed * 120;
    }
    
    global.stageType = global.stageTypeWorld;
    
    for (var t = 0; t < 60; t += 1)
        gml_Script_instance_create(random_range(0, (room_width * 2) + 600), room_height - 20, obj_trees);
    
    with (obj_ground)
        image_index = 0;
    
    with (obj_fog)
        light = irandom_range(0, 145);
    
    with (obj_player)
        defeated = false;
    
    with (obj_playerCard)
        alarm[11] = room_speed;
    
    theme = choose(s_maintheme1, s_maintheme2, s_maintheme3, s_maintheme4);
    audio_sound_gain(theme, 0.8, 10000);
    ds_list_clear(global.islandVoting);
}

if (room != r_seasonEnd)
{
    audio_sound_gain(theme, 0, 0);
    audio_sound_gain(theme, 0.1, 10000);
    
    if (room == global.room_underworld || room == r_corrupted)
        audio_sound_gain(theme, 1, 10000);
    
    audio_play_sound(theme, 1, 0);
    
    with (obj_raidBackground)
        alarm[1] = 1;
}
else
{
    with (obj_raidBackground)
        instance_destroy();
    
    with (obj_raidObject)
        instance_destroy();
}
