if (alarm[0] == -1)
{
    goto = -4;
    global.raidTalents += status;
    
    with (gml_Script_instance_create(x, y - 50, obj_float))
    {
        type = 11;
        value = other.status;
        text = "+" + string(round(value)) + " TP";
        c1 = 16776960;
        c2 = 8421376;
        parent = type;
    }
    
    gml_Script_scr_playsound(s_talent1, 0.9, 1.1, 0.5);
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
