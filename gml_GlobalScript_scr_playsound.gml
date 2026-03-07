self.scr_playsound = function(arg0, arg1, arg2, arg3)
{
    if (instance_exists(obj_cinematic))
        arg3 = 0;
    
    audio_sound_gain(arg0, arg3, 0);
    audio_sound_pitch(arg0, random_range(arg1, arg2));
    return audio_play_sound(arg0, 0, 0);
};
