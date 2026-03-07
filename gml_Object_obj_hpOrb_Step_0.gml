if (alarm[0] == -1)
{
    if (instance_exists(obj_warrior))
    {
        with (obj_warrior)
        {
            if (myRaidNumber == 0)
                other.goto = id;
        }
        
        if (instance_exists(goto))
        {
            motion_add(point_direction(x, y, goto.x, goto.y - (goto.height / 2)), 0.02 * global.roomSpeed);
            
            if (speed > 7)
                speed = 7;
            
            if (distance_to_point(goto.x, y) <= 7)
            {
                gml_Script_scr_playsound(s_xpOrb, 0.9, 1.1, 0.2);
                value *= goto.player.myMultiplier[1];
                goto.hp += value;
                
                with (gml_Script_instance_create(goto.x, (goto.y - (goto.height / 1.5)) + 20, obj_float))
                {
                    type = 3;
                    value = round(other.value);
                    text = "+" + string(value);
                    c1 = 65280;
                    c2 = 32768;
                    parent = type;
                }
                
                instance_destroy();
            }
        }
        else
        {
            goto = obj_gameControl;
            instance_destroy();
        }
    }
    else
    {
        goto = obj_gameControl;
        instance_destroy();
    }
}

if (alarm[0] != -1)
{
    y -= grav;
    grav -= (0.01 * global.roomSpeed * global.roomSpeed);
    x += dir;
    
    if (y > (room_height - 20))
        grav = ograv / 2;
    
    ograv /= 2;
}
