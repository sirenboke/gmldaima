in = false;
ended = true;

if (text1 == "Corrupted Dimension")
{
    global.stageType = "Corrupted Dimension";
    
    with (obj_raidObject)
        instance_destroy();
    
    for (var t = 0; t < 50; t += 1)
        instance_create_layer(random_range(0, (room_width * 2) + 600), room_height - 20, "Corrupted", obj_trees);
}

if (text1 == "Underworld")
{
    global.stageType = "Underworld";
    
    with (obj_warrior)
    {
        state = UnknownEnum.Value_10;
        x = room_width + sprite_width;
    }
    
    with (obj_raidObject)
        instance_destroy();
    
    if (global.portalTower != global.maxPortalTower)
    {
        theme = choose(s_underworld1, s_underworld2, s_underworld3, s_underworld4, s_underworld5, s_underworld6, s_underworld7);
        audio_sound_gain(obj_gameControl.theme, 0, 0);
        audio_sound_gain(obj_gameControl.theme, 1, 3000);
        audio_play_sound(obj_gameControl.theme, 1, 1);
    }
    
    for (var t = 0; t < 50; t += 1)
        gml_Script_instance_create(random_range(0, room_width * 2), random_range(room_height - 200, room_height - 30), obj_mist);
}

if (text1 == "Dungeons")
{
    with (obj_raidObject)
        instance_destroy();
    
    obj_gameControl.theme = s_dungeon1;
    audio_sound_gain(obj_gameControl.theme, 0, 0);
    audio_sound_gain(obj_gameControl.theme, 0.5, 3000);
    audio_play_sound(obj_gameControl.theme, 0, 0);
    global.stageType = "Dungeon";
    
    for (var t = 0; t < 20; t += 1)
        gml_Script_instance_create(0 + (400 * t), room_height - 20, obj_dungeonItems);
}

if (room != r_seasonEnd)
{
    if (text1 == "Forest" || text1 == "Grassland" || text1 == "Snow Trail")
    {
        global.stageType = global.stageTypeWorld;
        
        with (obj_raidObject)
            instance_destroy();
        
        for (var t = 0; t < 60; t += 1)
            gml_Script_instance_create(random_range(0, (room_width * 2) + 600), room_height - 20, obj_trees);
    }
}

with (obj_ground)
    alarm[1] = 1;

with (obj_mountains)
    alarm[1] = 1;

with (obj_mountainsNight)
    alarm[1] = 1;

enum UnknownEnum
{
    Value_10 = 10
}
