if (room == r_1)
{
    alarm[0] = -1;
    
    if (obj_bossKey.alarm[1] == -1)
    {
        if (global.stage < global.ostage || global.stage > global.ostage)
        {
            global.stage = global.ostage;
        }
        else
        {
            global.stage -= 1;
            global.ostage -= 1;
            
            if (global.ostage <= 0)
                global.ostage = 1;
        }
        
        if (global.ostage > 10)
            global.raidCost = 0;
        
        global.stage = global.ostage;
    }
    else
    {
        global.stage = global.bossStage;
    }
    
    if (instance_exists(obj_bigBoss1))
        global.raidCost = 0;
    
    global.enemyRaid = false;
    ini_open(string(global.platformDir) + "Village Data/Data.ini");
    ini_write_real("Stats", "Stage", global.stage);
    ini_close();
}
