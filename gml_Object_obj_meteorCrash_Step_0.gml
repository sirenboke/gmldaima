if (alpha > 0 && scale >= 3)
    alpha *= 0.9;

if (alpha2 == 0.8)
{
    scale += 0.12;
    image_xscale += (0.12 * sign(image_xscale));
    image_yscale += 0.05;
}
else
{
    scale = 3;
    image_xscale = 3 * sign(image_xscale);
    image_yscale = 2.5;
}

if (alpha <= 0.01)
{
    alpha = 0;
    
    if (alarm[0] == -1)
        alarm[0] = duration;
    
    audio_sound_gain(ember, 0, duration);
}

if (alpha == 0)
    alpha2 *= 0.95;
