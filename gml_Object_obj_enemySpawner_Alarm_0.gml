if (summonUnits < summonMaxUnits)
{
    var regEnemy = choose(obj_skeleton, obj_enemy2, obj_bear);
    
    if (instance_number(obj_enemy) < 30)
    {
        with (gml_Script_instance_create(x, y, regEnemy))
        {
            myNumber = global.enemyNumber;
            x = other.x;
            summoned = 1;
        }
        
        summonUnits += 1;
        global.enemyNumber += 1;
    }
    
    alarm[0] = timer;
    gml_Script_scr_playsound(s_portalClose2, 0.9, 1.1, 0.3);
}
else
{
    instance_destroy();
    
    if (instance_exists(player))
        player.spd = player.ospd;
}
