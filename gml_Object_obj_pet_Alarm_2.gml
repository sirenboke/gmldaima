if (type == 1)
{
    player.omyResistance[0][0] -= (0.04 + (0.01 * level));
    player.myResistance[0][0] -= (0.04 + (0.01 * level));
    attacking = false;
    c_pet = 16776960;
    myStatInfo[1][3] = 0;
    shield = 0;
    maxshield = ceil(player.myStatInfo[8][3] * (0.25 + (level / 50)));
    alarm[4] = room_speed / 5;
}

if (type == 2)
{
    myTarget = 0;
    buff = 0;
    alarm[3] = room_speed * 3;
    attacking = true;
    c_pet = 65280;
    myStatInfo[1][3] = 3 / (1 + (level / 20));
}

if (type == 3)
{
    attacking = true;
    c_pet = 255;
    thirdAttack = 0;
    myStatInfo[1][3] = 2 / (1 + (level / 10));
}

manaGain += (level / 10);
