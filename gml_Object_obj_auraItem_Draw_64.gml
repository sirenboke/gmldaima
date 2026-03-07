draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, global.auraRot, c_white, 1);

if (alarm[1] == -1 && image_xscale == 1.5)
{
    draw_set_font(f_mid);
    draw_set_halign(fa_center);
    draw_set_valign(fa_top);
    var _type = type;
    
    if (_type == 0)
        _type = "Power";
    
    gml_Script_scr_textoutline(x, y + (sprite_height / 2) + 25, string(description), 4235519, 0, 20, 400);
    gml_Script_scr_textoutline(x, y - (sprite_height / 2) - 25, string(name) + " (Aura " + string(_type) + ")", 4235519, 0, 20, 400);
    gml_Script_scr_textoutline(x, y + (sprite_height / 2), "Everyone", 16777215, 0, 20, 400);
    draw_set_font(f_big);
    draw_set_valign(fa_middle);
    gml_Script_scr_textoutline(x, y, "+5%", 16777215, 0, 20, 400);
}
