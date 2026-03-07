if (gml_Script_live_call())
    return global.live_result;

if (alarm[0] == -1)
{
    if (x <= 800 && instance_exists(obj_warrior))
    {
        var _near = instance_nearest(room_width, y, obj_warrior);
        
        if (_near.x >= x)
        {
            x = _near.x + 20;
        }
        else
        {
            if ((x - _near.x) < 30)
                x += 5;
            
            if (x <= 570)
                x = 570;
        }
    }
}
