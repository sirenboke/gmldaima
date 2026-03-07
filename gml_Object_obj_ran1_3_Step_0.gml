if (y < (room_height - 20))
{
    y += 10;
}
else
{
    y = room_height - 20;
    
    if (alarm[1] == -1)
        alarm[1] = duration;
}
