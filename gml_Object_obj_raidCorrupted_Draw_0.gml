if (global.raiding == true && !instance_exists(obj_raidPortalResults))
{
}

if (global.cameraMove == true && global.raiding == false && !instance_exists(obj_finalBoss))
{
    with (obj_raidObject)
        x -= (bgSpd / 10);
    
    with (obj_raidBackground)
        x -= (bgSpd / 10);
    
    with (obj_float)
    {
        if (y > (room_height - 300))
            x -= (bgSpd / 10);
    }
}
