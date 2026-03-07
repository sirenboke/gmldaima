if (global.stageType == "Forest" || global.stageType == "Grassland" || global.stageType == "Snow Trail")
{
    if (light < 215 && night == false)
        light += 1;
    else
        night = true;
    
    if (light > 0 && night == true)
        light -= 1;
    else
        night = false;
    
    if (light > 215)
        light = 0;
    
    lightColor = make_colour_hsv(0, 0, light);
    
    if (light < 145)
    {
        with (obj_lightSource)
            on = false;
        
        if (noTheme == true && global.raiding == false)
        {
            noTheme = false;
            audio_sound_gain(obj_gameControl.theme, 0.02, 10000);
        }
        
        if (audio_is_playing(s_crickets))
            audio_stop_sound(s_crickets);
        
        if (audio_is_playing(s_owls))
            audio_stop_sound(s_owls);
    }
    
    if (light > 145)
    {
        if (audio_is_paused(s_crickets))
        {
            audio_sound_gain(s_crickets, 0, 0);
            audio_sound_gain(s_crickets, 0.8, 20000);
            audio_resume_sound(s_crickets);
        }
        
        if (audio_is_paused(s_owls))
        {
            audio_sound_gain(s_owls, 0, 0);
            audio_sound_gain(s_owls, 0.8, 20000);
            audio_resume_sound(s_owls);
        }
        
        with (obj_lightSource)
            on = true;
        
        if (audio_is_playing(obj_gameControl.theme) && noTheme == false)
        {
            noTheme = true;
            audio_sound_gain(obj_gameControl.theme, 0, 10000);
            
            if (!audio_is_playing(s_crickets))
            {
                audio_sound_gain(s_crickets, 0, 0);
                audio_sound_gain(s_crickets, 0.8, 20000);
                audio_play_sound(s_crickets, 0, 0);
            }
            
            if (!audio_is_playing(s_owls))
            {
                audio_sound_gain(s_owls, 0, 0);
                audio_sound_gain(s_owls, 0.8, 20000);
                audio_play_sound(s_owls, 0, 0);
            }
        }
    }
}

if (room == r_corrupted)
    light = 0;

alarm[0] = timeSpeed;
