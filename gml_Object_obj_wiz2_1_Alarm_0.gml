part_emitter_clear(global.over_partsys, global.blessing_partemitter);

if (instance_exists(obj_warrior))
{
    with (obj_warrior)
    {
        if (__fury > 0)
        {
            gml_Script_scr_statChange(__fury, -1, 4, undefined, undefined, 1);
            gml_Script_scr_statChange(__int, -1, 9, undefined, undefined, 1);
            gml_Script_scr_statChange(__specialBuff, -1, 22, undefined, undefined);
            __fury = 0;
        }
    }
}

if (instance_exists(obj_enemy))
{
    with (obj_enemy)
        gml_Script_scr_interrupt();
}

instance_destroy();
