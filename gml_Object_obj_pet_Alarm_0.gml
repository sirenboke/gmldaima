if (instance_exists(player))
{
    if (instance_exists(myTarget))
    {
        with (myTarget)
            myDamage[0] -= other.buff;
    }
}
