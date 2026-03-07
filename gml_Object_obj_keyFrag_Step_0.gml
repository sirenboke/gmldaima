if (alarm[0] > -1)
{
    y -= grav;
    grav -= (0.01 * global.roomSpeed * global.roomSpeed);
    x += dir;
}
else if (distance_to_point(obj_bossKey.x + obj_bossKey.xx, obj_bossKey.y + 4) > 4)
{
    move_towards_point(obj_bossKey.x + obj_bossKey.xx, obj_bossKey.y + 4, 1 * global.roomSpeed);
}
else
{
    x = obj_bossKey.x + obj_bossKey.xx;
    y = obj_bossKey.y + 4;
    speed = 0;
    
    if (locked == false)
    {
        gml_Script_scr_playsound(s_click1, 1.4, 1.7, 2);
        locked = true;
        
        if (global.keyFrags > 6)
        {
            global.bossTier += 1;
            instance_destroy();
        }
    }
}
