if (instance_exists(player))
{
    if (player.afkdraw == false)
        draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, 0, c_pet, 1);
}
