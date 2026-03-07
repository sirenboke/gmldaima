self.options_draw = function()
{
    var smaller = 0;
    var option_y, option_x;
    
    if (view_enabled == true && position_set == false)
    {
        option_x = (camera_get_view_x(view_camera[view_current]) + camera_get_view_width(view_camera[view_current])) - 20;
        option_y = (camera_get_view_y(view_camera[view_current]) + camera_get_view_height(view_camera[view_current])) - 140;
    }
    else if (position_set == false)
    {
        option_x = room_width - 20;
        option_y = room_height - 140;
    }
    else if (option1x == -4)
    {
        option_x = x2 - 20;
        option_y = y1 - 10;
    }
    else
    {
        option_x = option1x;
        option_y = option1y;
    }
    
    if (draw_gui == true && position_set == false)
    {
        option_x = display_get_gui_width() - 20;
        option_y = display_get_gui_height() - 140;
    }
    
    var textcolor = argument[0];
    var selectedcolor = argument[1];
    var fontt = argument[2];
    
    if (argument_count >= 4)
    {
        var opt1, option_count, opt_w, opt2, opt3;
        
        if (argument_count == 6)
        {
            option_count = 3;
            opt1 = argument[3];
            opt2 = argument[4];
            opt3 = argument[5];
            var opt1_w = string_width(opt1);
            var opt2_w = string_width(opt2);
            var opt3_w = string_width(opt3);
            opt_w = max(opt1_w, opt2_w, opt3_w);
        }
        else if (argument_count == 5)
        {
            option_count = 2;
            opt1 = argument[3];
            opt2 = argument[4];
            var opt1_w = string_width(opt1);
            var opt2_w = string_width(opt2);
            opt_w = max(opt1_w, opt2_w);
        }
        else if (argument_count == 4)
        {
            option_count = 1;
            opt1 = argument[3];
            opt_w = string_width(opt1);
        }
        else
        {
            option_count = 0;
        }
        
        draw_set_font(fontt);
        draw_set_halign(fa_right);
        var opt_h = string_height(opt1);
        var oy;
        
        if (option1y == -4)
        {
            if (option_count == 3)
                oy = (option_y - (opt_h * 3)) + smaller;
            else if (option_count == 2)
                oy = (option_y - (opt_h * 2)) + smaller;
            else if (option_count == 1)
                oy = (option_y - opt_h) + smaller;
        }
        else
        {
            oy = option1y;
        }
        
        if (selected == 1)
        {
            draw_set_colour(textcolor);
            draw_roundrect(option_x - opt_w, oy, option_x, oy + opt_h, false);
            draw_set_colour(selectedcolor);
        }
        else
        {
            draw_set_colour(textcolor);
        }
        
        draw_text(option_x, oy, opt1);
        
        if (mouse_enabled)
        {
            if (!instance_exists(option_object1))
            {
                instance_create_layer(option_x, oy, "hud", option_object1);
                option_object1.opt1 = opt1;
                option_object1.option_count = option_count;
            }
        }
        
        if (option_count >= 2)
        {
            if (option2y == -4)
            {
                if (option_count == 3)
                    oy = (option_y - (opt_h * 2)) + smaller;
                else if (option_count == 2)
                    oy = (option_y - opt_h) + smaller;
            }
            else
            {
                oy = option2y;
                option_x = option2x;
            }
            
            if (selected == 2)
            {
                draw_set_colour(textcolor);
                draw_roundrect(option_x - opt_w, oy, option_x, oy + opt_h, false);
                draw_set_colour(selectedcolor);
            }
            else
            {
                draw_set_colour(textcolor);
            }
            
            draw_text(option_x, oy, opt2);
            
            if (mouse_enabled)
            {
                if (!instance_exists(option_object2))
                {
                    instance_create_layer(option_x, oy, "hud", option_object2);
                    option_object2.opt2 = opt2;
                    option_object2.option_count = option_count;
                }
            }
        }
        
        if (option_count == 3)
        {
            if (option3y == -4)
            {
                oy = (option_y - opt_h) + smaller;
            }
            else
            {
                oy = option3y;
                option_x = option3x;
            }
            
            if (selected == 3)
            {
                draw_set_colour(textcolor);
                draw_roundrect(option_x - opt_w, oy, option_x, oy + opt_h, false);
                draw_set_colour(selectedcolor);
            }
            else
            {
                draw_set_colour(textcolor);
            }
            
            draw_text(option_x, oy, opt3);
            
            if (mouse_enabled)
            {
                if (!instance_exists(option_object3))
                {
                    instance_create_layer(option_x, oy, "hud", option_object3);
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
