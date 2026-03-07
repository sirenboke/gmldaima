if (alarm[0] != -1 && global.newVersion != global.gameVersion)
{
    draw_set_font(f_mid);
    gml_Script_scr_textshadow(x, y + 25, "Checking for updates...", 16777215, 0, 20, 1000);
}

if (alarm[0] == -1)
{
    if (global.newVersion <= global.gameVersion)
    {
        gml_Script_scr_textshadow(x, y, "Running on last update!", 16777215, 0, 20, 1000);
    }
    else
    {
        draw_sprite_ext(sprite_index, 0, x, y, 1, 1, 0, c_white, 1);
        draw_set_font(f_big);
        draw_set_valign(fa_middle);
        draw_set_halign(fa_center);
        var _version = string_insert(".", global.newVersion, 2);
        _version = string_insert(".", _version, 4);
        gml_Script_scr_textshadow(x, y, string(text) + " to v" + string(_version), 16777215, 0, 20, 1000);
    }
}
