draw_sprite_ext(spr_black, 0, 0, 0, room_width, room_height, 0, -1, 0.9);
draw_set_font(font[page]);

if (type[page] == 1)
{
    var col = default_col;
    var tp = text[page];
    var tpl = array_length_1d(tp);
    var txtwidth = boxWidth - (2 * x_buffer);
    var cc = 1;
    var yy = pos_y + y_buffer;
    var xx = pos_x + x_buffer;
    var ii = 0;
    var iy = 0;
    
    repeat (tpl)
    {
        if (choice == ii)
        {
            if (chosen)
                col = select_col;
            else
                col = choice_col;
        }
        else
        {
            col = 16777215;
        }
        
        var ctext = "* " + tp[ii];
        draw_text_ext_color(xx, yy + ((ii + iy) * stringHeight), ctext, stringHeight, txtwidth, col, col, col, col, 1);
        
        if (string_width(ctext) > txtwidth)
            iy++;
        
        ii++;
    }
}
else
{
    if (charCount < str_len && !pause)
    {
        var tsc2 = text_speed_c * 2;
        var txtspd = text_speed[page];
        
        if ((text_speed_c + 1) < text_speed_al && charCount == txtspd[tsc2 + 2])
        {
            text_speed_c++;
            tsc2 = text_speed_c * 2;
        }
        
        charCount += txtspd[tsc2 + 1];
        var ch = string_char_at(text_NE, floor(charCount));
        
        switch (ch)
        {
            case " ":
                break;
            
            case ",":
            case ".":
                pause = true;
                alarm[1] = 10;
                break;
            
            case "?":
            case "!":
                pause = true;
                alarm[1] = 20;
                break;
            
            default:
                var audio_increment = 2;
                
                if (charCount >= audio_c)
                {
                    audio_play_sound(voice[page], 1, false);
                    audio_c = charCount + audio_increment;
                }
        }
    }
    
    var col = default_col;
    var cc = 1;
    var yy = pos_y + y_buffer;
    var xx = pos_x + x_buffer;
    var cx = 0;
    var cy = 0;
    var ty = 0;
    var by = 0;
    var bp_len = -1;
    var effect = 0;
    var breakpoint = 0;
    var effects_c = 0;
    var text_col_c = 0;
    var bp_array = breakpoints;
    var txtwidth = boxWidth - (2 * x_buffer);
    var char_max = txtwidth div charSize;
    var next_space;
    
    if (bp_array != -1)
    {
        bp_len = array_length_1d(bp_array);
        next_space = breakpoints[by];
        by++;
    }
    
    t += 1;
    var so = t;
    var shift = sin((t * pi * 2) / 60) * 3;
    
    repeat (charCount)
    {
        letter = string_char_at(text_NE, cc);
        var ec2 = effects_c * 2;
        
        if (effects_c < effects_al && effects_p[ec2] == cc)
        {
            effects_c++;
            effect = effects_p[ec2 + 1];
        }
        
        var tc2 = text_col_c * 2;
        
        if (text_col_c < text_col_al && text_col_p[tc2] == cc)
        {
            text_col_c++;
            col = text_col_p[tc2 + 1];
        }
        
        if (bp_len != -1 && cc == next_space)
        {
            cy += 1;
            cx = 0;
            
            if (by < bp_len)
            {
                next_space = breakpoints[by];
                by++;
            }
        }
        
        switch (effect)
        {
            case 0:
                draw_text_color(xx + (cx * charSize), yy + (cy * stringHeight), letter, col, col, col, col, 1);
                break;
            
            case 1:
                draw_text_color(xx + (cx * charSize) + random_range(-1, 1), yy + (cy * stringHeight) + random_range(-1, 1), letter, col, col, col, col, 1);
                break;
            
            case 2:
                so = t;
                shift = sin((so * pi * freq) / room_speed) * amplitude;
                draw_text_color(xx + (cx * charSize), yy + (cy * stringHeight) + shift, letter, col, col, col, col, 1);
                break;
            
            case 3:
                var c1 = make_colour_hsv(t + cc, 255, 255);
                var c2 = make_colour_hsv(t + cc + 34, 255, 255);
                draw_text_color(xx + (cx * charSize), yy + (cy * stringHeight), letter, c1, c1, c2, c2, 1);
                break;
            
            case 4:
                so = t + cc;
                shift = sin((so * pi * freq) / room_speed) * amplitude;
                var c1 = make_colour_hsv(t + cc, 255, 255);
                var c2 = make_colour_hsv(t + cc + 45, 255, 255);
                draw_text_color(xx + (cx * charSize), yy + (cy * stringHeight) + shift, letter, c1, c1, c2, c2, 1);
                break;
            
            case 5:
                so = t + cc;
                shift = sin((so * pi * freq) / room_speed);
                var mv = charSize / 2;
                draw_set_valign(fa_middle);
                draw_set_halign(fa_center);
                draw_text_transformed_color(xx + (cx * charSize) + mv, yy + (cy * stringHeight) + (stringHeight / 2), letter, 1, 1, shift * 20, col, col, col, col, 1);
                draw_set_valign(fa_top);
                draw_set_halign(fa_left);
                break;
            
            case 6:
                so = t + cc;
                shift = abs(sin((so * pi * freq) / room_speed));
                var mv = charSize / 2;
                draw_set_valign(fa_middle);
                draw_set_halign(fa_center);
                draw_text_transformed_color(xx + (cx * charSize) + mv, yy + (cy * stringHeight) + (stringHeight / 2), letter, shift, shift, 0, col, col, col, col, 1);
                draw_set_valign(fa_top);
                draw_set_halign(fa_left);
                break;
            
            case 7:
                so = t + cc;
                shift = sin((so * pi * freq) / room_speed);
                draw_text_color(xx + (cx * charSize), yy + (cy * stringHeight), letter, col, col, col, col, shift + random_range(-1, 1));
                break;
        }
        
        cc += 1;
        cx += 1;
    }
    
    if (charCount >= str_len)
    {
        shift = sin(((t + cc) * pi * freq) / room_speed) * amplitude;
        finishede_count += finishede_spd;
        
        if (finishede_count >= finishede_num)
            finishede_count = 0;
    }
}
