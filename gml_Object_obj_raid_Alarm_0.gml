if (instance_exists(obj_bigBoss1))
    global.raidEnd = true;

timer = (room_speed * 4) / (1 + (global.stage / 200));

if (timer < (room_speed / 4))
    timer = room_speed / 4;

if (!instance_exists(obj_bigBoss1))
{
    if (boss == false)
    {
        if (enemies < maxEnemies)
        {
            var regEnemy = obj_enemy2;
            
            if (global.stage > 20)
                regEnemy = choose(obj_skeleton, obj_enemy2);
            
            if (global.stage > 50)
            {
                var bear = choose(0, 1, 2);
                
                if (bear == 0)
                    regEnemy = choose(obj_skeleton, obj_enemy2, obj_bear);
                else
                    regEnemy = choose(obj_skeleton, obj_enemy2);
            }
            
            if (global.stage > 100)
                regEnemy = choose(obj_skeleton, obj_enemy2, obj_bear, obj_enemyRanged);
            
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
            if (raidType != 0 && gml_Script_scr_alarm_get(floor(50 + (global.stage / 50))) == -1 && global.enemyRaid == false)
            {
                if (enemies == maxEnemies)
                {
                    with (gml_Script_instance_create(x, y, obj_bigBoss1))
                        myNumber = global.enemyNumber;
                    
                    enemies += 1;
                    global.enemyNumber += 1;
                    global.raidEnd = true;
                }
            }
            
            global.raidEnd = true;
        }
    }
}

if (!instance_exists(obj_bigBoss1))
{
    if (boss == true)
    {
        if (enemies < maxEnemies)
        {
            var regEnemy = choose(obj_skeleton, obj_enemy2, obj_bear);
            
            with (gml_Script_instance_create(x, y, regEnemy))
                myNumber = global.enemyNumber;
            
            enemies += 1;
            global.enemyNumber += 1;
            alarm[0] = timer;
        }
        else
        {
            with (gml_Script_instance_create(x, y, obj_bigBoss1))
                myNumber = global.enemyNumber;
            
            enemies += 1;
            global.enemyNumber += 1;
            global.raidEnd = true;
        }
    }
}

if (instance_number(obj_warrior) <= 0 && global.enemyRaid == true && alarm[5] == -1)
{
    alarm[5] = room_speed * 10;
    
    with (gml_Script_instance_create(room_width / 2, room_height - 300, obj_raidResults))
    {
        result = 1;
        alarm[0] = room_speed * 10;
    }
}
