if (value > 0)
{
    c1 = 65280;
    text = "+" + gml_Script_scr_bigNumber(value);
    arrow = 0;
}

if (value < 0)
{
    c1 = 255;
    arrow = 1;
    text = gml_Script_scr_bigNumber(value);
}

if (value == 0)
{
    alarm[0] = 1;
    exit;
}

if (instance_exists(player))
    x = player.x;

show = true;
