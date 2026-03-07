if (textbox_visible == true && backlog_visible == false)
{
    if (mouse_enabled)
    {
        if (options_show == false)
        {
            if (mouse_check_button_pressed(mb_left))
                keyboard_key_press(speak_key);
            
            if (mouse_check_button_released(mb_left))
                keyboard_key_release(speak_key);
            
            if (mouse_check_button_pressed(mb_right))
                keyboard_key_press(skip_key);
            
            if (mouse_check_button_released(mb_right))
                keyboard_key_release(skip_key);
        }
        else if (mouse_on_option)
        {
            if (mouse_check_button_pressed(mb_left))
                keyboard_key_press(speak_key);
            
            if (mouse_check_button_released(mb_left))
                keyboard_key_release(speak_key);
            
            if (mouse_check_button_pressed(mb_right))
                keyboard_key_press(skip_key);
            
            if (mouse_check_button_released(mb_right))
                keyboard_key_release(skip_key);
        }
        
        if (instance_exists(option_object1))
        {
            with (option_object1)
            {
                if (distance_to_point(mouse_x, mouse_y) < 1)
                {
                    textbox.mouse_on_option = true;
                }
                else
                {
                    with (option_object2)
                    {
                        if (distance_to_point(mouse_x, mouse_y) < 1)
                        {
                            textbox.mouse_on_option = true;
                        }
                        else
                        {
                            with (option_object3)
                            {
                                if (distance_to_point(mouse_x, mouse_y) < 1)
                                    textbox.mouse_on_option = true;
                                else
                                    textbox.mouse_on_option = false;
                            }
                        }
                    }
                }
            }
        }
    }
    
    if (characters < message_length)
    {
        characters += increase;
        alarm[4] = room_speed * 3;
        
        if (text_sound == true)
        {
            if (itstime == true)
            {
                audio_sound_gain(textsound, text_sound_volume, 0);
                audio_play_sound(textsound, 1, false);
                itstime = false;
                alarm[0] = text_sound_interval;
            }
        }
        
        if (itstime2)
        {
            if (keyboard_check_released(skip_key))
            {
                characters = message_length;
                itstime2 = false;
                alarm[1] = 5;
            }
        }
        
        message_draw = string_copy(msg[message_current], 0, characters);
    }
    else if (keyboard_check_released(speak_key) || alarm[4] == -1)
    {
        if (message_current < message_end)
        {
            if (delay == false)
            {
                message_current += 1;
                characters = 0;
                message_draw = "";
                message_length = string_length(msg[message_current]);
                voice_played = false;
                delay = true;
                itstime3 = true;
                texts_in_backlog++;
                
                for (var i = 0; i < texts_in_backlog; i++)
                    backlog[texts_in_backlog - i] = backlog[texts_in_backlog - i - 1];
                
                backlog[0] = msg[message_current];
            }
        }
        else if (delay == false)
        {
            message_current = 0;
            characters = 0;
            message_draw = "";
            message_length = string_length(msg[message_current]);
            
            if (var_to_change != -4)
                variable_instance_set(var_object, var_to_change, var_value);
            
            instance_destroy();
            
            if (asset_get_index("control_cutscene") > -1)
            {
                if (cutscene_going())
                {
                    with (control_cutscene)
                    {
                        if (current_cutscene == cutscene_id)
                            cutscene_next();
                    }
                }
            }
        }
    }
    
    var game_spd = game_get_speed(gamespeed_fps);
    
    if (characters >= message_length && delay == true && itstime3 == true)
    {
        itstime3 = false;
        alarm[3] = game_spd / 5;
    }
    
    if (options_set == true)
    {
        if (message_current == show_options_when)
            options_show = true;
        else
            options_show = false;
        
        if (message_to_change != 0)
        {
            if (selected == 1)
                msg[message_to_change] = ifoption1;
            else if (selected == 2)
                msg[message_to_change] = ifoption2;
            else if (selected == 3)
                msg[message_to_change] = ifoption3;
        }
    }
    
    if (speed_set == true)
        increase = message_speed[message_current];
    
    if (array_length(portrait) > 0)
        sprite = portrait[message_current];
    
    if (sync_sprite == true)
    {
        if (characters < message_length)
        {
            image_speed = sprite_spd;
        }
        else
        {
            image_speed = 0;
            image_index = 0;
        }
    }
    
    if (array_length(voice) > 0)
    {
        if (voice[message_current] != -4)
        {
            if (voice_played == false)
            {
                voice_played = true;
                audio_play_sound(voice[message_current], 1, false);
                audio_sound_gain(voice[message_current], voice_volume, 0);
                
                if (message_current > 0)
                {
                    if (audio_is_playing(voice[message_current - 1]))
                        audio_stop_sound(voice[message_current - 1]);
                }
            }
            
            if (voice_sync_sprite == true)
            {
                if (audio_is_playing(voice[message_current]))
                {
                    image_speed = sprite_spd;
                }
                else
                {
                    image_speed = 0;
                    image_index = 0;
                }
            }
        }
    }
    
    if (continue_icon != -4)
    {
        if (continue_icon_frame >= sprite_get_number(continue_icon))
            continue_icon_frame = 0;
        else
            continue_icon_frame += ((sprite_spd * game_spd) / game_spd);
    }
}

if (backlog_visible)
{
    if (mouse_wheel_down() && backlog_stop_down == false)
        backlog_position += scroll_speed;
    else if (mouse_wheel_up() && backlog_stop_up == false)
        backlog_position -= scroll_speed;
    
    if (keyboard_check(vk_down) && backlog_stop_down == false)
        backlog_position += (scroll_speed / 4);
    else if (keyboard_check(vk_up) && backlog_stop_up == false)
        backlog_position -= (scroll_speed / 4);
}
