self.textbox_create = function()
{
    instance_create_layer(x, y, "hud", textbox);
    
    with (textbox)
    {
        var maxmessages = argument_count;
        
        for (var i = 0; i < maxmessages; i++)
        {
            if (argument_count > i)
                msg[i] = argument[i];
        }
        
        message_current = 0;
        message_end = argument_count - 1;
        increase = 0.5;
        characters = 0;
        message_draw = "";
        message_length = string_length(msg[message_current]);
        name = -4;
        general_colour = 0;
        text_colour = 16777215;
        outline_colour = 16777215;
        s_text_colour = 0;
        alpha = 1;
        font = -4;
        separation = 35;
        mouse_enabled = false;
        continue_icon = -4;
        continue_icon_frame = 0;
        smart_linebreak = false;
        last_space = 0;
        bubble_width = 300;
        object_talking = -4;
        sprite = -4;
        portrait = [];
        sync_sprite = false;
        sprite_spd = 0.2;
        image_speed = sprite_spd;
        speak_key = 32;
        skip_key = 32;
        textbox_sprite_set = false;
        textbox_sprite = -4;
        textbox_sprite2 = -4;
        position_set = false;
        x1 = 0;
        x2 = 0;
        y1 = 0;
        y2 = 0;
        namex1 = 0;
        namex2 = 0;
        namey1 = 0;
        namey2 = 0;
        sprite_position_set = false;
        spritex = 0;
        spritey = 0;
        text_position_set = false;
        textx = 0;
        texty = 0;
        name_text_position_set = false;
        nametextx = 0;
        nametexty = 0;
        option1x = -4;
        option1y = -4;
        option2x = -4;
        option2y = -4;
        option3x = -4;
        option3y = -4;
        options_set = false;
        options_show = false;
        selected = 1;
        optioncount = 0;
        show_options_when = 0;
        option1 = -4;
        option2 = -4;
        option3 = -4;
        message_to_change = 0;
        ifoption1 = "";
        ifoption2 = "";
        ifoption3 = "";
        option_outside_view = false;
        speed_set = false;
        message_speed = [];
        text_sound = false;
        text_sound_volume = 1;
        text_sound_interval = 5;
        textsound = -4;
        voice = [];
        voice_volume = 1;
        voice_sync_text = false;
        voice_sync_sprite = false;
        voice_played = false;
        textbox_visible = true;
        var_object = -4;
        var_to_change = -4;
        var_value = -4;
        backlog_visible = false;
        texts_in_backlog = 0;
        backlog_position = 0;
        backlog_stop_down = false;
        backlog_stop_up = false;
        scroll_speed = 30;
        
        for (var i = 0; i < maxmessages; i++)
        {
            if (argument_count > i)
                backlog[i] = "";
        }
        
        backlog[0] = msg[0];
        mode = "box";
    }
};
