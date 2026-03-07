if (global.dev)
{
    if (myNumber == 0)
    {
        with (instance_nearest(0, 0, obj_enemy))
        {
            var _value = irandom(100);
            var _stat = irandom(9);
            var _sign = choose(-1, 1);
            var _duration = irandom(4) + 1;
            gml_Script_scr_statChange(_value, _sign, _stat, _duration, undefined, undefined);
        }
    }
}
