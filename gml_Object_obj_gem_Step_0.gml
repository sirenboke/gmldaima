if (alarm[0] == -1)
{
    goto = -4;
    global.raidGems += status;
    
    with (gml_Script_instance_create(x, y - 50, obj_float))
    {
        type = 26;
        value = other.status;
        text = "+" + string(round(value)) + " gems";
        c1 = 65535;
        c2 = 16776960;
        parent = type;
    }
    
    gml_Script_scr_playsound(s_gem, 1, 1.1, 1);
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
    
    if (y > (room_height - 25))
        grav = ograv / 2;
    
    ograv /= 2;
}
