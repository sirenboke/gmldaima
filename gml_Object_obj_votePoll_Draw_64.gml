if (alarm[0] == -1)
{
    draw_sprite_ext(spr_building, 0, (room_width / 2) - 250, (room_height / 2) - 120, 20, 4, 0, c_white, 1);
    draw_sprite_ext(spr_building, 0, (room_width / 2) - 250, (room_height / 2) - 120, 20, 4, 0, c_white, 1);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_font(f_mid);
    gml_Script_scr_textshadow((room_width / 2) - 250, (room_height / 2) - 150, string(name) + " proposes to upgrade " + string(buildName) + " for " + string(buildObj.costText) + ", type !y to accept or !n to oppose.", 16777215, 0, 20, 600);
    gml_Script_scr_textshadow((room_width / 2) - 250 - 100, (room_height / 2) - 110, "Yes: " + string(yesVotes), 65280, 0, 20, 600);
    gml_Script_scr_textshadow(((room_width / 2) - 250) + 100, (room_height / 2) - 110, "No: " + string(noVotes), 255, 0, 20, 600);
    draw_set_font(f_special);
    gml_Script_scr_textshadow((room_width / 2) - 250, (room_height / 2) - 80, "(Need " + string(minVotes - votes) + " more votes to accept/cancel this action). [" + string(round(alarm[1] / room_speed)) + "s left]", 16777215, 0, 20, 600);
    
    if (yesVotes >= minVotes || noVotes >= minVotes)
        alarm[1] = 1;
}
