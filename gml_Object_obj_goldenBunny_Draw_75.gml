draw_self();

if (surface_exists(global.raidFog))
{
    surface_set_target(global.raidFog);
    gml_Script_draw_set_blend_mode(bm_subtract);
    draw_ellipse_colour(x - 120, y - sprite_height - 60, x + 120, (y - sprite_height) + 180, c_orange, c_black, 0);
    gml_Script_draw_set_blend_mode(bm_normal);
    surface_reset_target();
}

draw_set_font(f_mid);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
gml_Script_scr_textshadow(x, y - sprite_height, string(global.cmdPrefix) + string(word), 65535, 0, 20, 300);
