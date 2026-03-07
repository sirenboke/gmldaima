if (room == r_corrupted)
{
    if (result == 0)
    {
        c1 = 65280;
        c2 = 32768;
        text1 = "Sector " + string(global.corruptedSector) + ":" + string(global.corruptedLevel) + " cleared! Universe corruption reduced by 5%.";
    }
    else
    {
        c1 = 255;
        c2 = 128;
        text1 = "You died on Sector " + string(global.corruptedSector) + ":" + string(global.corruptedLevel) + "... Universe corruption increased by 4%.";
    }
}
