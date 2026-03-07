if (instance_exists(target))
{
    target.burnStacks -= totalstacks;
    var _resistance = 0.01 * totalstacks;
    
    with (target)
        gml_Script_scr_statChange(_resistance * myResistance[2][0], -1, 11, undefined, undefined);
}

instance_destroy();
