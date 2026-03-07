event_inherited();
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, 0, c_pet, 1);

if (instance_exists(player))
{
    if (player.state != UnknownEnum.Value_9 && player.state != UnknownEnum.Value_10)
    {
        draw_sprite_ext(spr_blackbar, 0, x - 20, y - 20, 40, 1, 0, c_white, 1);
        draw_sprite_ext(spr_manabarsmall, 0, x - 18, y - 20, (mana / maxMana) * 36, 1, 0, c_white, 1);
    }
}

if (surface_exists(global.raidFog))
{
    surface_set_target(global.raidFog);
    gml_Script_draw_set_blend_mode(bm_subtract);
    draw_ellipse_colour(x - 60, y - 60, x + 60, y + 60, c_pet, c_black, 0);
    gml_Script_draw_set_blend_mode(bm_normal);
    surface_reset_target();
}

enum UnknownEnum
{
    Value_9 = 9,
    Value_10
}
