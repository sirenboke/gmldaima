x += spd;
spd *= 0.9;

if (spd <= 1)
    instance_destroy();
