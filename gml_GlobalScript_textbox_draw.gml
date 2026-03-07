self.textbox_draw = function()
{
    var smaller = 60;
    var linebreak_addition = 0;
    var main_rect_y2, main_rect_y1, main_rect_x1, main_rect_x2, name_rect_x1, name_rect_y1, name_rect_x2, name_rect_y2, text_y, name_x, name_y;
    
    if (view_enabled == true && position_set == false)
    {
        var cam_x = camera_get_view_x(view_camera[view_current]);
        var cam_y = camera_get_view_y(view_camera[view_current]);
        var cam_w = camera_get_view_width(view_camera[view_current]);
        var cam_h = camera_get_view_height(view_camera[view_current]);
        main_rect_x1 = cam_x + 10;
        main_rect_y1 = ((cam_y + cam_h) - 187) + smaller;
        main_rect_x2 = (cam_x + cam_w) - 10;
        main_rect_y2 = (cam_y + cam_h) - 10;
        text_x = cam_x + 20;
        text_y = ((cam_y + cam_h) - 177) + smaller;
        text_w = cam_w - 40;
        name_rect_x1 = cam_x + 10;
        name_rect_y1 = ((cam_y + cam_h) - 257) + (smaller * 1.3);
        name_rect_x2 = cam_x + 290;
        name_rect_y2 = (((cam_y + cam_h) - 180) + smaller) - 10;
        name_x = cam_x + 150;
        name_y = ((cam_y + cam_h) - 240) + (smaller * 1.2);
    }
    else if (position_set == false)
    {
        main_rect_x1 = 10;
        main_rect_y1 = (room_height - 187) + smaller;
        main_rect_x2 = room_width - 10;
        main_rect_y2 = room_height - 10;
        text_x = 20;
        text_y = (room_height - 177) + smaller;
        text_w = room_width - 40;
        name_rect_x1 = 10;
        name_rect_y1 = (room_height - 257) + (smaller * 1.3);
        name_rect_x2 = 300;
        name_rect_y2 = ((room_height - 180) + smaller) - 10;
        name_x = 160;
        name_y = (room_height - 240) + (smaller * 1.2);
    }
    else
    {
        main_rect_x1 = x1;
        main_rect_y1 = y1;
        main_rect_x2 = x2;
        main_rect_y2 = y2;
        name_rect_x1 = namex1;
        name_rect_y1 = namey1;
        name_rect_x2 = namex2;
        name_rect_y2 = namey2;
        
        if (text_position_set == false)
        {
            text_x = x1 + 10;
            text_y = y1 + 10;
        }
        else
        {
            text_x = textx;
            text_y = texty;
        }
        
        text_w = x2 - x1 - 40;
        
        if (name_text_position_set == false)
        {
            name_x = namex1 + ((namex2 - namex1) / 2);
            name_y = (namey1 + ((namey2 - namey1) / 2)) - 15;
        }
        else
        {
            name_x = nametextx;
            name_y = nametexty;
        }
    }
    
    if (draw_gui == true && position_set == false)
    {
        var gui_w = display_get_gui_width();
        var gui_h = display_get_gui_height();
        main_rect_x1 = 10;
        main_rect_y1 = (gui_h - 187) + smaller;
        main_rect_x2 = gui_w - 10;
        main_rect_y2 = gui_h - 10;
        text_x = 20;
        text_y = (gui_h - 177) + smaller;
        text_w = gui_w - 40;
        name_rect_x1 = 10;
        name_rect_y1 = (gui_h - 257) + (smaller * 1.3);
        name_rect_x2 = 300;
        name_rect_y2 = ((gui_h - 180) + smaller) - 10;
        name_x = 160;
        name_y = (gui_h - 240) + (smaller * 1.2);
    }
    
    var main_rect_height = main_rect_y2 - main_rect_y1;
    var sprite_new_w;
    
    if (argument[7] != -4)
    {
        var sprite_w = sprite_get_width(argument[7]);
        var spr_newsize;
        
        if (sprite_w > main_rect_height)
            spr_newsize = 1 - ((sprite_w - main_rect_height) / sprite_w);
        else
            spr_newsize = main_rect_height / sprite_w;
        
        sprite_new_w = sprite_w * spr_newsize;
    }
    else
    {
        sprite_new_w = 0;
    }
    
    var text_x = text_x + sprite_new_w;
    var text_w = text_w - sprite_new_w - 5;
    var message_text;
    
    if (smart_linebreak == true)
    {
        if (string_char_at(msg[message_current], characters) == " " || string_char_at(msg[message_current], characters) == "")
            last_space = characters;
        
        var t = gml_Script_copy_words(msg[message_current], 0, characters);
        
        if (string_width(t) >= text_w)
        {
            msg[message_current] = string_delete(msg[message_current], last_space, 1);
            msg[message_current] = string_insert("\n", msg[message_current], last_space);
            
            if (message_current == message_to_change)
            {
                ifoption1 = string_delete(ifoption1, last_space, 1);
                ifoption1 = string_insert("\n", ifoption1, last_space);
                ifoption2 = string_delete(ifoption2, last_space, 1);
                ifoption2 = string_insert("\n", ifoption2, last_space);
                ifoption3 = string_delete(ifoption3, last_space, 1);
                ifoption3 = string_insert("\n", ifoption3, last_space);
            }
        }
        
        if (characters >= message_length)
            msg[message_current] = string_replace_all(msg[message_current], "\n", " ");
        
        message_text = string_copy(msg[message_current], 0, characters);
    }
    else
    {
        message_text = argument[0];
    }
    
    if (textbox_sprite_set == false)
    {
        draw_set_colour(argument[2]);
        draw_set_alpha(argument[5]);
        draw_rectangle(main_rect_x1, main_rect_y1, main_rect_x2, main_rect_y2, false);
        
        if (argument[1] != -4)
            draw_rectangle(name_rect_x1, name_rect_y1, name_rect_x2, name_rect_y2, false);
        
        if (argument[4] != -4)
        {
            draw_set_colour(argument[4]);
            draw_rectangle(main_rect_x1, main_rect_y1, main_rect_x2, main_rect_y2, true);
        }
        
        if (argument[1] != -4)
        {
            if (argument[4] != -4)
            {
                draw_set_colour(argument[4]);
                draw_rectangle(name_rect_x1, name_rect_y1, name_rect_x2, name_rect_y2, true);
            }
        }
        
        if (argument[7] != -4)
        {
            var sprite_h = sprite_get_height(argument[7]);
            var spr_newsize;
            
            if (sprite_h > main_rect_height)
                spr_newsize = 1 - ((sprite_h - main_rect_height) / sprite_h);
            else
                spr_newsize = main_rect_height / sprite_h;
            
            if (position_set == false)
                draw_sprite_ext(argument[7], -1, main_rect_x1, main_rect_y1, spr_newsize, spr_newsize, 0, c_white, 1);
            else
                draw_sprite_ext(argument[7], -1, spritex, spritey, spr_newsize, spr_newsize, 0, c_white, 1);
        }
        
        draw_set_colour(argument[3]);
        draw_set_alpha(1);
        draw_set_halign(fa_left);
        draw_set_font(argument[6]);
        draw_text_ext(text_x, text_y, message_text, separation, text_w - linebreak_addition);
        
        if (argument[1] != -4)
        {
            draw_set_halign(fa_center);
            draw_text(name_x, name_y, argument[1]);
        }
    }
    else
    {
        var slice_width = sprite_get_width(textbox_sprite) / 3;
        var slice_height = sprite_get_height(textbox_sprite) / 3;
        var width = abs(main_rect_x2 - main_rect_x1);
        var height = abs(main_rect_y2 - main_rect_y1);
        draw_sprite_part_ext(textbox_sprite, 0, 0, 0, slice_width, slice_height, main_rect_x1, main_rect_y1, 1, 1, c_white, 1);
        draw_sprite_part_ext(textbox_sprite, 0, slice_width, 0, slice_width, slice_height, main_rect_x1 + slice_width, main_rect_y1, (width - (slice_width * 2)) / slice_width, 1, c_white, 1);
        draw_sprite_part_ext(textbox_sprite, 0, slice_width * 2, 0, slice_width, slice_height, main_rect_x2 - slice_width, main_rect_y1, 1, 1, c_white, 1);
        draw_sprite_part_ext(textbox_sprite, 0, 0, slice_height, slice_width, slice_height, main_rect_x1, main_rect_y1 + slice_height, 1, (height - (slice_height * 2)) / slice_height, c_white, 1);
        draw_sprite_part_ext(textbox_sprite, 0, slice_width, slice_height, slice_width, slice_height, main_rect_x1 + slice_width, main_rect_y1 + slice_height, (width - (slice_width * 2)) / slice_width, (height - (slice_height * 2)) / slice_height, c_white, 1);
        draw_sprite_part_ext(textbox_sprite, 0, slice_width * 2, slice_height, slice_width, slice_height, main_rect_x2 - slice_width, main_rect_y1 + slice_height, 1, (height - (slice_height * 2)) / slice_height, c_white, 1);
        draw_sprite_part_ext(textbox_sprite, 0, 0, slice_height * 2, slice_width, slice_height * 2, main_rect_x1, main_rect_y2 - slice_height, 1, 1, c_white, 1);
        draw_sprite_part_ext(textbox_sprite, 0, slice_width, slice_height * 2, slice_width, slice_height, main_rect_x1 + slice_width, main_rect_y2 - slice_height, (width - (slice_width * 2)) / slice_width, 1, c_white, 1);
        draw_sprite_part_ext(textbox_sprite, 0, slice_width * 2, slice_height * 2, slice_width, slice_height, main_rect_x2 - slice_width, main_rect_y2 - slice_height, 1, 1, c_white, 1);
        draw_set_colour(argument[3]);
        draw_set_alpha(1);
        draw_set_halign(fa_left);
        draw_set_font(argument[6]);
        draw_text_ext(text_x, text_y, message_text, separation, text_w - linebreak_addition);
        
        if (argument[1] != -4)
        {
            slice_width = sprite_get_width(textbox_sprite2) / 3;
            slice_height = sprite_get_height(textbox_sprite2) / 3;
            width = abs(name_rect_x2 - name_rect_x1);
            height = abs(name_rect_y2 - name_rect_y1);
            draw_sprite_part_ext(textbox_sprite2, 0, 0, 0, slice_width, slice_height, name_rect_x1, name_rect_y1, 1, 1, c_white, 1);
            draw_sprite_part_ext(textbox_sprite2, 0, slice_width, 0, slice_width, slice_height, name_rect_x1 + slice_width, name_rect_y1, (width - (slice_width * 2)) / slice_width, 1, c_white, 1);
            draw_sprite_part_ext(textbox_sprite2, 0, slice_width * 2, 0, slice_width, slice_height, name_rect_x2 - slice_width, name_rect_y1, 1, 1, c_white, 1);
            draw_sprite_part_ext(textbox_sprite2, 0, 0, slice_height, slice_width, slice_height, name_rect_x1, name_rect_y1 + slice_height, 1, (height - (slice_height * 2)) / slice_height, c_white, 1);
            draw_sprite_part_ext(textbox_sprite2, 0, slice_width, slice_height, slice_width, slice_height, name_rect_x1 + slice_width, name_rect_y1 + slice_height, (width - (slice_width * 2)) / slice_width, (height - (slice_height * 2)) / slice_height, c_white, 1);
            draw_sprite_part_ext(textbox_sprite2, 0, slice_width * 2, slice_height, slice_width, slice_height, name_rect_x2 - slice_width, name_rect_y1 + slice_height, 1, (height - (slice_height * 2)) / slice_height, c_white, 1);
            draw_sprite_part_ext(textbox_sprite2, 0, 0, slice_height * 2, slice_width, slice_height * 2, name_rect_x1, name_rect_y2 - slice_height, 1, 1, c_white, 1);
            draw_sprite_part_ext(textbox_sprite2, 0, slice_width, slice_height * 2, slice_width, slice_height, name_rect_x1 + slice_width, name_rect_y2 - slice_height, (width - (slice_width * 2)) / slice_width, 1, c_white, 1);
            draw_sprite_part_ext(textbox_sprite2, 0, slice_width * 2, slice_height * 2, slice_width, slice_height, name_rect_x2 - slice_width, name_rect_y2 - slice_height, 1, 1, c_white, 1);
            draw_set_halign(fa_center);
            draw_text(name_x, name_y, argument[1]);
        }
        
        if (argument[7] != -4)
        {
            var sprite_h = sprite_get_height(argument[7]);
            var spr_newsize;
            
            if (sprite_h > main_rect_height)
                spr_newsize = 1 - ((sprite_h - main_rect_height) / sprite_h);
            else
                spr_newsize = main_rect_height / sprite_h;
            
            if (sprite_position_set == false)
                draw_sprite_ext(argument[7], -1, main_rect_x1, main_rect_y1, spr_newsize, spr_newsize, 0, c_white, 1);
            else
                draw_sprite_ext(argument[7], -1, spritex, spritey, 1, 1, 0, c_white, 1);
        }
    }
    
    if (characters >= message_length)
    {
        if (continue_icon != -4 && delay == false)
        {
            draw_set_alpha(1);
            draw_sprite(continue_icon, continue_icon_frame, main_rect_x2 - 10, main_rect_y2 - 10);
        }
        
        if (options_show == true)
        {
            if (argument_count >= 12)
                gml_Script_options_draw(argument[3], argument[8], argument[6], argument[9], argument[10], argument[11]);
            else if (argument_count >= 11)
                gml_Script_options_draw(argument[3], argument[8], argument[6], argument[9], argument[10]);
            else if (argument_count >= 10)
                gml_Script_options_draw(argument[3], argument[8], argument[6], argument[9]);
        }
    }
    
    draw_set_halign(fa_left);
};
