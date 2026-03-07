draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, c_white, 1);

if (alarm[1] == -1 && image_xscale == 1.5)
{
    draw_set_halign(fa_center);
    draw_set_valign(fa_top);
    draw_set_font(f_mid);
    gml_Script_scr_textoutline(x, y + (sprite_height / 2), string(description), 4235519, 0, 20, 500);
    gml_Script_scr_textoutline(x, y - (sprite_height / 2) - 25, string(amount) + "x " + string(name) + " (" + string(class) + ")", 4235519, 0, 20, 400);
    draw_set_font(f_special);
    
    if (alarm[3] == -1)
    {
        gml_Script_scr_textoutline(x, y + (sprite_height / 2) + 60, "Type !loot to participate in the drop", 16777215, 0, 20, 400);
        
        if (ds_list_size(global.relicList) > 0)
            gml_Script_scr_textoutline(x, y + (sprite_height / 2) + 80, "(Rolling between " + string(ds_list_size(global.relicList)) + " players in " + string(round(alarm[4] / room_speed)) + "s)", 16777215, 0, 20, 1620);
        else
            gml_Script_scr_textoutline(x, y + (sprite_height / 2) + 80, "(Rolling between " + string(ds_list_size(global.rewardList)) + " players in " + string(round(alarm[4] / room_speed)) + "s)", 16777215, 0, 20, 1620);
    }
    else
    {
        gml_Script_scr_textoutline(x, y + (sprite_height / 2) + 60, "Looted by " + string(rewardedPlayers) + " raiders.", 16777215, 0, 20, 1800);
        gml_Script_scr_textoutline(x, y + (sprite_height / 2) + 80, rewardText, 16777215, 0, 20, 1800);
    }
}
