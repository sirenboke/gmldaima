if (global.isTwitch != 0 || global.isKick != 0)
{
    draw_self();
    draw_set_valign(fa_middle);
    draw_set_halign(fa_center);
    gml_Script_scr_textshadow(x, y, "Confirm", 16777215, 0, 20, 1000);
    var _kick = "https://kick.com/";
    var _twitch = "https://www.twitch.tv/";
    var _platform = "";
    
    if (global.isTwitch == 1)
        _platform = _twitch;
    
    if (global.isKick == 1)
        _platform = _kick;
    
    if (alarm[2] != -1)
    {
        gml_Script_scr_textshadow(x, y + 40, "Go to that channel and type !confirm in chat with the same account. (" + string(round(alarm[2] / room_speed)) + "s)", 16777215, 0, 20, 1000);
        gml_Script_scr_textshadow(x, y + 60, "(Press 'spacebar' to open '" + string(_platform) + string_lower(obj_username.msg) + "/chat' on new tab.)", 16776960, 0, 20, 1000);
        
        if (keyboard_check_pressed(vk_space))
            url_open(string(_platform) + string(obj_username.msg) + "/chat");
    }
}

draw_set_font(f_mid);
gml_Script_scr_textshadow(room_width / 2, 1000, "Press 'F2' to play offline (single player)", 12632256, 0, 20, 600);
