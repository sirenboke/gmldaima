if (alarm[0] == -1)
{
    if (hp > myStatInfo[8][3])
        hp = myStatInfo[8][3];
}

if (alarm[7] > 0)
    immune = true;

if (!instance_exists(target))
    target = -1;
