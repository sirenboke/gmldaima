self.options_draw_bubble = function()
{
    if (argument_count >= 6)
    {
        var opt1, option_count, opt_w, opt2, opt3;
        
        if (argument_count == 8)
        {
            option_count = 3;
            opt1 = argument[5];
            opt2 = argument[6];
            opt3 = argument[7];
            var opt1_w = string_width(opt1);
            var opt2_w = string_width(opt2);
            var opt3_w = string_width(opt3);
            opt_w = max(opt1_w, opt2_w, opt3_w);
        }
        else if (argument_count == 7)
        {
            option_count = 2;
            opt1 = argument[5];
            opt2 = argument[6];
            var opt1_w = string_width(opt1);
            var opt2_w = string_width(opt2);
            opt_w = max(opt1_w, opt2_w);
        }
        else if (argument_count == 6)
        {
            option_count = 1;
            opt1 = argument[5];
            opt_w = string_width(opt1);
        }
        else
        {
            option_count = 0;
        }
        
        var textcolor = argument[0];
        var selectedcolor = argument[1];
        var fontt = argument[2];
        var xx = argument[3];
        var yy = argument[4];
        draw_set_font(fontt);
        draw_set_halign(fa_center);
        var opt_h = string_height(opt1);
        var oy;
        
        if (option_outside_view == false)
        {
            if (option_count == 3)
                oy = yy - (opt_h * 3);
            else if (option_count == 2)
                oy = yy - (opt_h * 2);
            else if (option_count == 1)
                oy = yy - opt_h;
        }
        else
        {
            oy = yy + opt_h;
        }
        
        if (selected == 1)
        {
            draw_set_colour(textcolor);
            draw_roundrect(xx - (opt_w / 2), oy, xx + (opt_w / 2), oy + opt_h, false);
            draw_set_colour(selectedcolor);
        }
        else
        {
            draw_set_colour(textcolor);
        }
        
        draw_text(xx, oy, opt1);
        
        if (mouse_enabled)
        {
            if (!instance_exists(option_object1))
            {
                instance_create_layer(xx, oy, "hud", option_object1);
                option_object1.opt1 = opt1;
                option_object1.option_count = option_count;
            }
        }
        
        if (option_count >= 2)
        {
            if (option_outside_view == false)
            {
                if (option_count == 3)
                    oy = yy - (opt_h * 2);
                else if (option_count == 2)
                    oy = yy - opt_h;
            }
            else
            {
                oy = yy + (opt_h * 2);
            }
            
            if (selected == 2)
            {
                draw_set_colour(textcolor);
                draw_roundrect(xx - (opt_w / 2), oy, xx + (opt_w / 2), oy + opt_h, false);
                draw_set_colour(selectedcolor);
            }
            else
            {
                draw_set_colour(textcolor);
            }
            
            draw_text(xx, oy, opt2);
            
            if (mouse_enabled)
            {
                if (!instance_exists(option_object2))
                {
                    instance_create_layer(xx, oy, "hud", option_object2);
                    option_object2.opt2 = opt2;
                    option_object2.option_count = option_count;
                }
            }
        }
        
        if (option_count >= 3)
        {
            if (option_outside_view == false)
                oy = yy - opt_h;
            else
                oy = yy + (opt_h * 3);
            
            if (selected == 3)
            {
                draw_set_colour(textcolor);
                draw_roundrect(xx - (opt_w / 2), oy, xx + (opt_w / 2), oy + opt_h, false);
                draw_set_colour(selectedcolor);
            }
            else
            {
                draw_set_colour(textcolor);
            }
            
            if (option_count == 3)
                draw_text(xx, oy, opt3);
            
            if (mouse_enabled)
            {
                if (!instance_exists(option_object3))
                {
                    instance_create_layer(xx, oy, "hud", option_object3);
                    option_object3.opt3 = opt3;
                    option_object3.option_count = option_count;
                }
            }
        }
        
        if (backlog_visible == false)
        {
            if (keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W")))
            {
                if (option_count == 2)
                {
                    switch (selected)
                    {
                        case 1:
                            selected = 2;
                            break;
                        
                        case 2:
                            selected = 1;
                            break;
                    }
                }
                
                if (option_count == 3)
                {
                    switch (selected)
                    {
                        case 1:
                            selected = 3;
                            break;
                        
                        case 2:
                            selected = 1;
                            break;
                        
                        case 3:
                            selected = 2;
                            break;
                    }
                }
            }
            
            if (keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S")))
            {
                if (option_count == 2)
                {
                    switch (selected)
                    {
                        case 1:
                            selected = 2;
                            break;
                        
                        case 2:
                            selected = 1;
                            break;
                    }
                }
                
                if (option_count == 3)
                {
                    switch (selected)
                    {
                        case 1:
                            selected = 2;
                            break;
                        
                        case 2:
                            selected = 3;
                            break;
                        
                        case 3:
                            selected = 1;
                            break;
                    }
                }
            }
        }
    }
    
    draw_set_halign(fa_left);
};
