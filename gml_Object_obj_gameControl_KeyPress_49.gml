if (global.dev == 1 && global.console == false)
{
    if (!keyboard_check(vk_shift))
    {
        with (obj_enemy)
        {
            if (class != "alpha" && class != "boss")
                gml_Script_scr_death_enemy();
        }
    }
    else
    {
        with (obj_bigBoss1)
            gml_Script_scr_death_enemy();
        
        with (obj_finalBoss)
            gml_Script_scr_death_enemy();
        
        with (obj_portalBoss1)
            gml_Script_scr_death_enemy();
    }
}
