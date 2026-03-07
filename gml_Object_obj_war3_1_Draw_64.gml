draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, 0, c_red, 0.4);
draw_sprite_ext(spr_bubble1, image, x, y, 3, 3, 0, c_maroon, 0.4);
image += 0.5;

if (!instance_exists(target))
    alarm[0] = 1;
