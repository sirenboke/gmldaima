self.textbox_draw_bubble = function()
{
    var vtext = argument[0];
    var vcharactername = argument[1];
    var vcolour = argument[2];
    var vtextcolour = argument[3];
    var valpha = argument[4];
    var vfont = argument[5];
    var vseparation = argument[6];
    var vbubblewidth = argument[7];
    var vobject = argument[8];
    var vselectedtextcolour;
    
    if (argument_count >= 10)
        vselectedtextcolour = argument[9];
    
    var voption1;
    
    if (argument_count >= 11)
        voption1 = argument[10];
    
    var voption2;
    
    if (argument_count >= 12)
        voption2 = argument[11];
    
    var voption3;
    
    if (argument_count >= 13)
        voption3 = argument[12];
    
    draw_set_font(vfont);
    var text_height = string_height_ext(vtext, vseparation, vbubblewidth - 6);
    var nameheight = string_height(vcharactername);
    var DistFromObj = sprite_get_height(vobject.sprite_index);
    var xx1 = vobject.x - (vbubblewidth / 2);
    var yy1;
    
    if (vcharactername != -4)
        yy1 = vobject.y - DistFromObj - 2 - nameheight - text_height;
    else
        yy1 = vobject.y - DistFromObj - 2 - text_height;
    
    var xx2 = vobject.x + (vbubblewidth / 2);
    var yy2 = vobject.y - DistFromObj;
    var text_yy = vobject.y - DistFromObj - text_height;
    var show_pointer = true;
    var pointer_x1 = vobject.x - 8;
    var pointer_x2 = vobject.x + 8;
    var pointer_x3 = vobject.x;
    var pointer_y3 = vobject.y - (DistFromObj / 1.3);
    var continue_icon_x = vobject.x + (vbubblewidth / 2);
    var text_xx = xx2 - ((xx2 - xx1) / 2);
    
    if (draw_gui == true)
    {
        var gui_coords = gml_Script_x_to_gui(xx1, yy1);
        xx1 = gui_coords[0];
        yy1 = gui_coords[1];
        gui_coords = gml_Script_x_to_gui(xx2, yy2);
        xx2 = gui_coords[0];
        yy2 = gui_coords[1];
        gui_coords = gml_Script_x_to_gui(text_xx, text_yy);
        text_xx = gui_coords[0];
        text_yy = gui_coords[1];
        gui_coords = gml_Script_x_to_gui(pointer_x1, yy2);
        pointer_x1 = gui_coords[0];
        gui_coords = gml_Script_x_to_gui(pointer_x2, yy2);
        pointer_x2 = gui_coords[0];
        gui_coords = gml_Script_x_to_gui(pointer_x3, pointer_y3);
        pointer_x3 = gui_coords[0];
        pointer_y3 = gui_coords[1];
        gui_coords = gml_Script_x_to_gui(continue_icon_x, yy2);
        continue_icon_x = gui_coords[0];
    }
    
    if (draw_gui == true)
    {
        if (xx1 < 0)
        {
            xx2 = xx2 - xx1;
            xx1 = 0;
        }
        
        if (xx2 > display_get_gui_width())
        {
            xx1 = display_get_gui_width() - (xx2 - xx1);
            xx2 = display_get_gui_width();
        }
        
        if (yy1 <= 0)
        {
            yy1 = 0;
            
            if (vcharactername == -4)
            {
                text_yy = yy1;
                yy2 = yy1 + text_height + 5;
            }
            else
            {
                text_yy = nameheight;
                yy2 = yy1 + text_height + nameheight + 5;
            }
            
            show_pointer = false;
        }
    }
    else if (view_enabled == false)
    {
        if (xx1 < 0)
        {
            xx2 = xx2 - xx1;
            xx1 = 0;
        }
        
        if (xx2 > room_width)
        {
            xx1 = room_width - (xx2 - xx1);
            xx2 = room_width;
        }
        
        if (yy1 <= 0)
        {
            yy1 = 0;
            
            if (vcharactername == -4)
            {
                text_yy = yy1;
                yy2 = yy1 + text_height + 5;
            }
            else
            {
                text_yy = nameheight;
                yy2 = yy1 + text_height + nameheight + 5;
            }
            
            show_pointer = false;
        }
    }
    else
    {
        if (xx1 < camera_get_view_x(view_camera[view_current]))
        {
            xx2 = xx2 - xx1;
            xx1 = 0;
        }
        
        if (xx2 > (camera_get_view_x(view_camera[view_current]) + camera_get_view_width(view_camera[view_current])))
        {
            xx1 = (camera_get_view_x(view_camera[view_current]) + camera_get_view_width(view_camera[view_current])) - (xx2 - xx1);
            xx2 = camera_get_view_x(view_camera[view_current]) + camera_get_view_width(view_camera[view_current]);
        }
        
        if (yy1 <= camera_get_view_y(view_camera[view_current]))
        {
            yy1 = camera_get_view_y(view_camera[view_current]);
            
            if (vcharactername == -4)
            {
                text_yy = yy1;
                yy2 = yy1 + text_height + 5;
            }
            else
            {
                text_yy = nameheight;
                yy2 = yy1 + text_height + nameheight + 5;
            }
            
            show_pointer = false;
        }
    }
    
    text_xx = xx2 - ((xx2 - xx1) / 2);
    draw_set_colour(vcolour);
    draw_set_alpha(valpha);
    draw_roundrect(xx1, yy1, xx2, yy2, false);
    
    if (show_pointer)
        draw_triangle(pointer_x1, yy2, pointer_x2, yy2, pointer_x3, pointer_y3, false);
    
    draw_set_colour(vtextcolour);
    draw_set_alpha(1);
    draw_set_halign(fa_center);
    draw_text_ext(text_xx, text_yy, vtext, vseparation, vbubblewidth - 6);
    
    if (vcharactername != -4)
    {
        draw_set_alpha(0.7);
        draw_text(text_xx, text_yy - vseparation, vcharactername);
    }
    
    if (characters >= message_length)
    {
        if (continue_icon != -4 && delay == false)
        {
            draw_set_alpha(1);
            draw_sprite(continue_icon, 0, continue_icon_x, yy2);
        }
        
        var posx = text_xx;
        var posy = yy1;
        option_outside_view = false;
        
        if (view_enabled == false)
        {
            if (yy1 <= 0)
            {
                posy = (yy2 - vseparation) + 5;
                option_outside_view = true;
            }
        }
        else if (yy1 <= camera_get_view_y(view_camera[view_current]))
        {
            posy = (yy2 - vseparation) + 5;
            option_outside_view = true;
        }
        
        if (options_show == true)
        {
            if (argument_count >= 13)
                gml_Script_options_draw_bubble(vtextcolour, vselectedtextcolour, vfont, posx, posy, voption1, voption2, voption3);
            else if (argument_count >= 12)
                gml_Script_options_draw_bubble(vtextcolour, vselectedtextcolour, vfont, posx, posy, voption1, voption2);
            else if (argument_count >= 11)
                gml_Script_options_draw_bubble(vtextcolour, vselectedtextcolour, vfont, posx, posy, voption1);
        }
    }
    
    draw_set_halign(fa_left);
    draw_set_alpha(1);
};
