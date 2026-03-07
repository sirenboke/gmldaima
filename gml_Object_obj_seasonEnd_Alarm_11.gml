seconds += 1;

if (seconds >= 60)
{
    seconds -= 60;
    minutes += 1;
}

if (minutes >= 60)
{
    minutes -= 60;
    hours += 1;
}

if (hours >= 24)
{
    hours -= 24;
    days += 1;
}

alarm[11] = room_speed;
