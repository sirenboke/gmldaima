if (value == 0)
{
    x -= 180;
    y -= 40;
}

if (value == 1)
{
    x -= 85;
    y -= 170;
}

if (value == 2)
{
    x += 85;
    y -= 170;
}

if (value == 3)
{
    x += 180;
    y -= 40;
}

if (value == 4)
{
    x += 150;
    y += 120;
}

if (value == 5)
    y += 190;

if (value == 6)
{
    x -= 150;
    y += 120;
}

name = global.floorName[value + 1][1];
