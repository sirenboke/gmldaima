if (alarm[2] == -1 && alarm[1] == -1)
{
    draw_sprite_ext(spr_shine, 0, x, y, 1, 1, rot, c_white, alpha * 2);
    rot += 2;
    draw_sprite_ext(spr_black, 0, 0, 0, room_width - 500, room_height - 300, 0, c_white, alpha);
    
    if (alarm[0] == -1)
    {
        if (alpha > 0)
            alpha -= 0.04;
        else
            instance_destroy();
    }
    
    draw_set_font(f_mid);
    draw_set_halign(fa_center);
    
    if (alpha > 0.01)
    {
        draw_sprite_ext(sprite_index, icon, x, y, 1, 1, 0, c_white, 1);
        gml_Script_scr_textoutline(x, y - 50, title, 16777215, 0, 30, 500);
        gml_Script_scr_textoutline(x, y + 50, name, 16777215, 0, 30, 500);
        gml_Script_scr_textoutline(x, y + 70, description, 16777215, 0, 30, 500);
    }
}
else
{
    alpha = 0.5;
    rot = 0;
}
