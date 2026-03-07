with (gml_Script_instance_create(x, y, obj_transition_out))
    blank = true;

audio_sound_gain(s_menutheme, 0, 10000);
audio_sound_gain(m_peaceful_1, 0, 10000);
gml_Script_scr_playsound(s_execute, 1, 1, 1);
