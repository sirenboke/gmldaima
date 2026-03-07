if (instance_exists(player))
{
    if (instance_exists(player.myWarrior))
    {
        with (player.myWarrior)
        {
            canAttack = true;
            alarm[2] = 0;
        }
    }
}
