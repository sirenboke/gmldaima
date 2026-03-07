if (global.inFinalWar == true)
    global.shake = random_range(4, 6);

if (finalLight < 110)
{
    warColor = make_colour_hsv(80, finalLight, finalLight);
    finalLight += 1;
    alarm[3] = room_speed * 5;
}

if (finalLight >= 110 && finalLight < 130)
{
    warColor = make_colour_hsv(80, finalLight, finalLight);
    finalLight += 1;
    alarm[3] = room_speed * 5;
}

if (finalLight >= 130)
    alarm[3] = random_range(room_speed / 2, room_speed);
