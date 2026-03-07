if (global.dev == 1 && global.console == false)
{
    with (obj_player)
        energy = maxEnergy;
    
    with (obj_enemy)
    {
        if (alarm[0] == -1)
            gml_Script_scr_death_enemy();
    }
}
