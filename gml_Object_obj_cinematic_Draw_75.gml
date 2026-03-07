with (obj_enemy)
{
    canAttack = false;
    canMove = false;
}

with (obj_warrior)
{
    canAttack = false;
    canMove = false;
    alarm[11] = room_speed * 60;
}

text_wrapped = gml_Script_scr_string_wrap(current_text, 800);

if (counter < string_length(current_text))
{
    var _lastCounter = round(counter);
    counter += ((string_length(current_text) / current_timer) * 1.2);
    
    if (round(counter) != _lastCounter && current_id > 1 && cinematic_end == false)
        gml_Script_scr_playsound(snd_voice1, 0.7, 0.9, 0.3);
}
else if (extra_time == false)
{
    extra_time = true;
    alarm[0] += room_speed * 2;
}

var substr = string_copy(current_text, 1, counter);

if (counter >= string_length(current_text))
    substr = current_text;

draw_set_font(f_big);
draw_set_halign(fa_center);
draw_set_valign(fa_top);
draw_sprite_ext(spr_black, 0, 0, 0, room_width, room_height, 0, -1, alpha);

if (cinematic_end == true)
{
    gml_Script_scr_textgradient(room_width / 2, (room_height / 2) - (string_height_ext(current_text, 40, 1000) / 2), global.cinematicInfo[_id][current_id - 2], undefined, undefined, undefined, 40, 1000, undefined, undefined, alpha - 0.2);
    alpha -= 0.007;
    
    if (alpha <= 0.01)
    {
        with (obj_enemy)
        {
            canAttack = true;
            canMove = true;
        }
        
        with (obj_warrior)
        {
            canAttack = true;
            canMove = true;
        }
        
        if (_id == 0)
        {
            audio_stop_sound(obj_gameControl.theme);
            obj_gameControl.theme = m_finis_1;
            audio_sound_gain(obj_gameControl.theme, 0.8, 2000);
            audio_play_sound(obj_gameControl.theme, 1, 1);
        }
        
        instance_destroy();
    }
}
else
{
    if (alpha < 1)
        alpha += 0.02;
    
    if (current_id > 1)
        gml_Script_scr_textgradient(room_width / 2, (room_height / 2) - (string_height_ext(current_text, 40, 1000) / 2), substr, undefined, undefined, undefined, 40, 1000);
}
