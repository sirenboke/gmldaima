if (instance_exists(target))
{
    if (target.freezeStacks != maxStacks)
        target.freezeStacks -= stack;
    else
        target.freezeStacks -= maxStacks;
    
    if (target.freezeStacks <= 0)
        target.canFreeze = true;
}

instance_destroy();
