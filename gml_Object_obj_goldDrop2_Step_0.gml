if (alarm[0] == -1)
{
    goto = -4;
    
    if (value <= 0)
        value = 1;
    
    var _value = value;
    
    if (instance_exists(obj_warrior))
    {
        with (obj_warrior)
        {
            with (player)
                gml_Script_scr_player_reward(_value, 1);
        }
    }
    
    instance_destroy();
}
else
{
    y -= grav;
    grav -= (0.01 * global.roomSpeed * global.roomSpeed);
    x += dir;
    
    if (dir < 0)
        dir += 0.02;
    
    if (dir > 0)
        dir -= 0.02;
    
    if (y > (room_height - 20))
        grav = ograv / 2;
    
    ograv /= 2;
}
