draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, 1, 0, c_white, alpha);
alpha -= 0.025;

if (alpha <= 0)
    instance_destroy();
