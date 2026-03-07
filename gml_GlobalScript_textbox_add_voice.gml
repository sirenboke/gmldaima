self.textbox_add_voice = function()
{
    with (textbox)
    {
        voice_volume = argument[0];
        voice_sync_text = argument[1];
        voice_sync_sprite = argument[2];
        var maxmsg = array_length(msg);
        
        for (var i = 0; i < maxmsg; i++)
        {
            if ((argument_count + 3) > i)
                voice[i] = argument[i + 3];
            else
                voice[i] = -4;
            
            if (voice_sync_text == true)
            {
                if (voice[i] != -4)
                {
                    var vlength = audio_sound_length(voice[i]);
                    message_speed[i] = (vlength / string_width(msg[i])) * game_get_speed(gamespeed_fps);
                }
                else
                {
                    message_speed[i] = 0.5;
                }
                
                speed_set = true;
            }
        }
    }
};
