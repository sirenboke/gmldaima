draw_sprite_ext(sprite_index, image_index, x, y, 4, 4, 0, c_white, 0.3);
draw_sprite_ext(spr_blackbar, 0, x - 30, y - 150, 60, 1, 0, c_white, 1);
draw_sprite_ext(spr_bluebarsmall, 0, x - 28, y - 150, (hp / maxhp) * 56, 1, 0, c_white, 1);
gml_Script_scr_textoutline(x, y - 170, gml_Script_scr_bigNumber(hp), 16777215, 0, 20, 100);

if (alarm[0] < room_speed)
    alpha -= 0.02;

if (surface_exists(global.raidFog))
{
    surface_set_target(global.raidFog);
    gml_Script_draw_set_blend_mode(bm_subtract);
    draw_ellipse_colour(x - 185, y - 15, x + 185, y + 15, c_white, c_black, 0);
    gml_Script_draw_set_blend_mode(bm_normal);
    surface_reset_target();
}
