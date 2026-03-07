if (instance_exists(obj_warrior))
{
    if (!instance_exists(goto))
        goto = instance_nearest(x, y, obj_warrior);
    
    if (alarm[0] == -1)
    {
        motion_add(point_direction(x, y, goto.x, goto.y - (goto.height / 2)), 0.02 * global.roomSpeed);
        
        if (speed > 10)
            speed = 10;
        
        if (distance_to_point(goto.x, y) <= 7)
        {
            gml_Script_scr_playsound(s_xpOrb, 2.9, 3.1, 0.1);
            value *= goto.player.myMultiplier[2];
            goto.xp += value;
            global.creditsXP += value;
            
            with (gml_Script_instance_create(goto.x, goto.y - (goto.height * 1.5) - 50, obj_float))
            {
                type = 0;
                value = round(other.value);
                text = "+" + gml_Script_scr_bigNumber(value);
                c1 = 16711935;
                c2 = 8388736;
                parent = 1;
                alarm[1] = 1;
            }
            
            instance_destroy();
        }
        else if (x < 200)
        {
            if (alarm[1] > 1)
                alarm[1] = 1;
        }
    }
}
else
{
    goto = obj_build_farm;
    global.creditsXP += value;
    instance_destroy();
}

if (alarm[0] != -1)
{
    y -= grav;
    grav -= (0.01 * global.roomSpeed * global.roomSpeed);
    x += dir;
    
    if (y > (room_height - 20))
    {
        y = room_height - 20;
        grav = ograv / 2;
        alarm[0] = 1;
    }
    
    ograv /= 2;
}
