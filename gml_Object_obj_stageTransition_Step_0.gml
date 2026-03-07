if (alpha < 1 && in == true)
{
    alpha += (1 / (room_speed * 3));
}
else if (alarm[0] == -1 && ended == false)
{
    if (room != r_underworld_new && global.portalTower != global.maxPortalTower)
    {
        if (room != r_corrupted)
            audio_stop_all();
    }
    else if (room != r_corrupted)
    {
        var _theme = obj_gameControl.theme;
        audio_stop_sound(_theme);
        audio_stop_sound(m_finis_1);
    }
    
    alarm[0] = room_speed;
}

if (in == false && alpha > 0)
{
    alpha -= (1 / (room_speed * 5));
    
    with (obj_mountainsNight)
    {
        if (global.stageType != "Grassland")
            alpha = 0;
        else
            alpha = 0.1 + (obj_fog.light / 215);
    }
}

if (in == false && alpha <= 0)
    instance_destroy();
