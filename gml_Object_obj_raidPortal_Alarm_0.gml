if (room == r_underworld)
{
    if (enemies < maxEnemies)
    {
        var regEnemy = choose(obj_skeleton, obj_enemy2, obj_bear);
        
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
        enemies += 1;
        
        if (global.portalStage < 8)
        {
            with (gml_Script_instance_create(x, y, obj_portalBoss1))
                myNumber = global.enemyNumber;
        }
        else if (!instance_exists(obj_finalBoss))
        {
            with (gml_Script_instance_create(x, y, obj_finalBoss))
                myNumber = global.enemyNumber;
        }
        
        global.enemyNumber += 1;
        global.raidEnd = true;
    }
}

if (room == r_underworld_new)
{
    if (enemies < maxEnemies)
    {
        var regEnemy = choose(obj_skeleton, obj_enemy2, obj_bear);
        
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
        enemies += 1;
        
        if (global.onlyFinis == 0)
        {
            if (global.portalTower < global.maxPortalTower || (global.portalTower == global.maxPortalTower && global.portalFloor < global.maxPortalFloor))
            {
                if (global.portalFloor == global.maxPortalFloor)
                {
                    with (gml_Script_instance_create(x, y, obj_portalBoss1))
                        myNumber = global.enemyNumber;
                }
                else if (global.portalTower != global.maxPortalTower)
                {
                    with (gml_Script_instance_create(x, y, obj_bigBoss1))
                        myNumber = global.enemyNumber;
                }
            }
            
            if (global.portalTower == global.maxPortalTower)
            {
                if (!instance_exists(obj_finalBoss))
                {
                    with (gml_Script_instance_create(x, y, obj_finalBoss))
                        myNumber = global.enemyNumber;
                }
            }
        }
        else if (!instance_exists(obj_finalBoss))
        {
            with (gml_Script_instance_create(x, y, obj_finalBoss))
                myNumber = global.enemyNumber;
        }
        
        global.enemyNumber += 1;
        global.raidEnd = true;
    }
}
