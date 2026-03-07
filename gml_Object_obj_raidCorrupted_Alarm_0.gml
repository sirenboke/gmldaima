if (room == r_corrupted)
{
    if (enemies < maxEnemies)
    {
        var regEnemy;
        
        if ((global.challenge_bossChance * 100) > irandom_range(0, 99))
            regEnemy = obj_bigBoss1;
        else
            regEnemy = choose(obj_skeleton, obj_enemy2, obj_bear);
        
        if (instance_number(obj_enemy) < 30)
        {
            with (gml_Script_instance_create(x, y, regEnemy))
                myNumber = global.enemyNumber;
            
            enemies += 1;
            global.enemyNumber += 1;
        }
        
        alarm[0] = timer;
    }
    else
    {
        var regEnemy = choose(obj_skeleton, obj_enemy2, obj_bear);
        enemies += 1;
        
        with (gml_Script_instance_create(x, y, regEnemy))
            myNumber = global.enemyNumber;
        
        global.enemyNumber += 1;
        global.raidEnd = true;
    }
}
