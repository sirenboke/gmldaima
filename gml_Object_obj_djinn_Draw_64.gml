if (surface_exists(djinnFog))
{
    gml_Script_draw_set_blend_mode(bm_subtract);
    draw_surface(djinnFog, 0, 0);
    gml_Script_draw_set_blend_mode(bm_normal);
    surface_set_target(djinnFog);
    var _fogColor = make_color_hsv(0, 0, 240 - clamp((path_position - 0.7) * 500, 0, 250));
    draw_set_color(_fogColor);
    draw_rectangle(0, 0, 1420, 800, 0);
    gml_Script_draw_set_blend_mode(bm_subtract);
    draw_ellipse_colour(x - (80 * size * 2), y - (80 * size * 2), x + (80 * size * 2), y + (80 * size * 2), c_orange, c_black, 0);
    gml_Script_draw_set_blend_mode(bm_normal);
    surface_reset_target();
}

draw_self();

if (path_position == 0)
    size = 8;

if (path_position > 0.62 && path_position < 0.68)
{
    if (path_position < 0.65)
    {
        if (alpha < 1)
            alpha += 0.1;
    }
    
    if (path_position >= 0.65)
        alpha -= 0.1;
    
    draw_set_font(f_big);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    gml_Script_scr_textgradient(x, y - 80, string(global.djinnInfo[type][1]), global.djinnInfo[type][4], global.djinnInfo[type][5], undefined, 20, 600, undefined, undefined, alpha);
    gml_Script_scr_textgradient(x, y + 20, string_replace(global.djinnInfo[type][3], "*", global.djinnInfo[type][2]), undefined, undefined, undefined, 20, 600, undefined, undefined, alpha);
}

if (path_position < 0.5)
{
    if (size > 2)
        size -= 0.05;
}

if (path_position > 0.7)
    size += 0.08;

image_xscale = size;
image_yscale = size;

if (path_position >= 1)
{
    gml_Script_scr_surface_free(djinnFog);
    instance_destroy();
}
