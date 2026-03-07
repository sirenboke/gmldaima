if (triggered == false)
    draw_sprite_ext(spr_kenjiParticles, 0, x, y, 1, 1, 0, c_red, 0.4);
else if (alarm[0] == -1)
    image_alpha -= 0.05;

event_inherited();

if (image_alpha < 0.1)
    instance_destroy();
