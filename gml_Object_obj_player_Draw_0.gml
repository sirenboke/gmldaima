if (afkdraw == true)
    exit;

if (global.dev)
{
    if (path_exists(actionPath))
        draw_path(actionPath, x, y, 1);
}

draw_sprite_ext(spr_player_shadow, 0, x, y, 0.5, 0.5, 0, c_black, 0.5);

if (obj_fog.light > 100)
{
    if (surface_exists(global.townFog))
    {
        surface_set_target(global.townFog);
        gml_Script_draw_set_blend_mode(bm_subtract);
        draw_ellipse_colour(x - 50, y - (height / 2) - 50, x + 50, (y - (height / 2)) + 50, c_orange, c_black, 0);
        
        if (myPlayerPet != 0)
        {
            with (myPlayerPet)
            {
                if (alarm[11] == -1)
                    draw_ellipse_colour(x - 20, y - 20, x + 20, y + 20, c_pet, c_black, 0);
            }
        }
        
        gml_Script_draw_set_blend_mode(bm_normal);
        surface_reset_target();
    }
}

var _x = round(x / 2) * 2;
var _y = round(y / 2) * 2;
var _alpha = 1;
var _color = 16777215;

if (ascended == true)
{
    _alpha = 0.6;
    _color = 65535;
}

draw_sprite_ext(sprite_index, image_index, _x, _y, image_xscale, image_yscale, image_angle, _color, _alpha);
