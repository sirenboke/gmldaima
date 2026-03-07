if (global.dev == 1)
{
    forgeItem[0][0] += (forgeItem[0][1] / 10);
    forgeItem[1][0] += (forgeItem[1][1] / 10);
    
    if (forgeItem[0][0] >= forgeItem[0][1])
    {
        alarm[0] = room_speed * 600;
        forgeItem[0][0] = forgeItem[0][1];
    }
    
    if (forgeItem[1][0] >= forgeItem[1][1])
    {
        alarm[1] = room_speed * 600;
        forgeItem[1][0] = forgeItem[1][1];
    }
}
