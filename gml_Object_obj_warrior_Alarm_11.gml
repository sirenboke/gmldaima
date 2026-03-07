player.readyRaid = 0;

if (instance_exists(obj_enemy))
{
    with (obj_enemy)
        instance_destroy();
}

if (instance_exists(obj_bigBoss1))
{
    with (obj_bigBoss1)
        instance_destroy();
}

if (instance_exists(obj_warrior))
{
    with (obj_warrior)
        instance_destroy();
}

if (instance_exists(obj_item))
{
    with (obj_item)
        instance_destroy();
}

if (global.enemyRaid == true)
{
    with (obj_raid)
        alarm[5] = room_speed * 10;
    
    with (gml_Script_instance_create(room_width / 2, room_height - 300, obj_raidResults))
    {
        result = 1;
        global.raidHonor /= 4;
        alarm[0] = room_speed * 10;
    }
}
else
{
    with (obj_raid)
        alarm[3] = room_speed * 10;
    
    with (gml_Script_instance_create(room_width / 2, room_height - 300, obj_raidResults))
    {
        result = 1;
        global.raidHonor /= 4;
        alarm[0] = room_speed * 10;
    }
}
