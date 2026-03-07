if (type[page] == 0)
{
    if (alarm[3] == -1)
    {
        alarm[3] = room_speed * 15;
        
        if (charCount < str_len)
        {
            charCount = string_length(text_NE);
        }
        else if ((page + 1) < array_length_1d(text))
        {
            event_perform(ev_other, ev_user0);
            
            switch (nextline[page])
            {
                case -1:
                    instance_destroy();
                    exit;
                
                case 0:
                    page += 1;
                    break;
                
                default:
                    page = nextline[page];
            }
            
            event_perform(ev_alarm, 0);
        }
        else
        {
            event_perform(ev_other, ev_user0);
            instance_destroy();
        }
    }
}
else
{
    if (chosen)
        exit;
    
    if (keyboard_check_pressed(interact_key))
    {
        chosen = true;
        alarm[2] = 10;
        audio_play_sound(select_snd_effect, priority_snd_effect, false);
    }
    
    var change_choice = keyboard_check_pressed(down_key) - keyboard_check_pressed(up_key);
    
    if (change_choice != 0)
    {
        choice += change_choice;
        audio_play_sound(choice_snd_effect, priority_snd_effect, false);
    }
    
    if (choice < 0)
        choice = array_length_1d(text[page]) - 1;
    else if (choice > (array_length_1d(text[page]) - 1))
        choice = 0;
}
