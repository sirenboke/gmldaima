if (sequence == "finis start")
    _id = 0;

if (sequence == "finis phase 2")
    _id = 1;

if (sequence == "test")
    _id = 2;

if (current_id > (array_length(global.cinematicInfo[_id]) - 1))
    exit;

current_text = global.cinematicInfo[_id][current_id];
gml_Script_twitch_chat_say_direct("/me " + string_replace_all(current_text, "\n", " "));
current_id += 1;
counter = 0;
extra_time = false;

if (_id == 2)
{
    if (!audio_is_playing(m_finis_cinematic1))
    {
        audio_sound_gain(obj_gameControl.theme, 0, 2000);
        audio_sound_gain(m_finis_cinematic1, 0, 0);
        audio_play_sound(m_finis_cinematic1, 1, 0);
        audio_sound_gain(m_finis_cinematic1, 1.5, 5000);
    }
}

if (_id == 0)
{
    if (!audio_is_playing(m_finis_cinematic1))
    {
        audio_sound_gain(obj_gameControl.theme, 0, 2000);
        audio_sound_gain(m_finis_cinematic1, 0, 0);
        audio_play_sound(m_finis_cinematic1, 1, 0);
        audio_sound_gain(m_finis_cinematic1, 1.5, 5000);
    }
}

if (_id == 1)
{
    if (!audio_is_playing(s_underworldBoss))
    {
        audio_sound_gain(obj_gameControl.theme, 0, 5000);
        audio_sound_gain(s_underworldBoss, 0, 0);
        audio_play_sound(s_underworldBoss, 1, 1);
        audio_sound_gain(s_underworldBoss, 0.7, 10000);
    }
    
    if (alpha == 1)
    {
        with (obj_finalBoss)
            instance_destroy();
        
        with (obj_warrior)
            instance_destroy();
    }
}

if (current_id < array_length(global.cinematicInfo[_id]))
{
    alarm[0] = clamp((string_length(global.cinematicInfo[_id][current_id - 1]) / 20) * room_speed, room_speed * 2, room_speed * 20);
    current_timer = alarm[0];
}
else
{
    if (_id == 0 || _id == 2)
    {
        if (audio_is_playing(m_finis_cinematic1))
            audio_sound_gain(m_finis_cinematic1, 0, 5000);
    }
    
    if (_id == 1)
    {
        if (instance_exists(obj_raidPortalResults))
        {
            if (obj_raidPortalResults.result == -1)
                obj_raidPortalResults.alarm[0] = 1;
        }
    }
    
    cinematic_end = true;
}
