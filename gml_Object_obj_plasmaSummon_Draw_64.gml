draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, 0, c_white, alpha);
x += (movespd * move);

if (x > (room_width - 200))
    alarm[1] = -1;

if (alarm[1] != -1)
{
    if (image_index > 9)
        image_index = 0;
}
else if (image_index == image_number)
{
    instance_destroy();
}

if (alarm[1] == -1)
    alpha -= 0.025;

if (alpha <= 0)
    instance_destroy();
