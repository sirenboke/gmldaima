if (room == r_1)
{
    timer = (room_speed * 4) / (1 + (global.stage / 200));
    
    if (timer < (room_speed / 4))
        timer = room_speed / 4;
    
    if (enemies < maxEnemies)
    {
        var regEnemy = obj_enemy2;
        
        if (global.stage >= 20)
            regEnemy = choose(obj_skeleton, obj_enemy2);
        
        if (global.stage >= 50)
        {
            var bear = choose(0, 1, 2);
            
            if (bear == 0)
                regEnemy = choose(obj_skeleton, obj_enemy2, obj_bear);
            else
                regEnemy = choose(obj_skeleton, obj_enemy2);
        }
        
        if (global.stage >= 100)
            regEnemy = choose(obj_skeleton, obj_enemy2, obj_bear, obj_enemyRanged);
        
        if (instance_number(obj_enemy) < 30)
        {
            with (gml_Script_instance_create(x, y, regEnemy))
                myNumber = global.enemyNumber;
            
            global.enemyNumber += 1;
            enemies += 1;
        }
        
        if ((global.stage % 50) == 0)
        {
            with (gml_Script_instance_create(x, y, obj_bigBoss1))
            {
                myNumber = global.enemyNumber;
                finalWarSpawn = global.stage;
                global.enemyNumber += 1;
                other.enemies += 1;
            }
        }
        
        global.stage += 1;
        alarm[10] = timer;
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
    
    for (var t = 0; t < 60; t += 1)
    {
        if (t > instance_number(obj_trees))
            gml_Script_instance_create(random_range(room_width + 600, (room_width * 2) + 600), room_height - 20, obj_trees);
    }
}
