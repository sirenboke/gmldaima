event_inherited();

switch (state)
{
    case UnknownEnum.Value_1:
        gml_Script_scr_move_enemy();
        break;
    
    case UnknownEnum.Value_2:
        gml_Script_scr_attack_enemy();
        break;
    
    case UnknownEnum.Value_0:
        gml_Script_scr_boss_idle();
        break;
    
    case UnknownEnum.Value_5:
        gml_Script_scr_rest_enemy();
        break;
}

if (global.newUnderworld == true)
{
    if (alarm[0] == -1)
    {
        if (instance_exists(obj_portalBoss1) || instance_exists(obj_cinematic))
            x = room_width + 1000;
        
        if (global.portalTower == 4)
        {
            if (hp <= (myStatInfo[8][3] * 0.1))
            {
                immune = true;
                hp = myStatInfo[8][3];
                global.portalTower = 5;
                global.portalFloor = 0;
                
                with (obj_warrior)
                    state = UnknownEnum.Value_10;
                
                with (gml_Script_instance_create(room_width / 2, room_height - 300, obj_raidPortalResults))
                {
                    result = -1;
                    global.raidXP += (10 + (global.stage * 5 * (1 + (global.stage / 60))));
                    global.raidGold += (10 + (global.stage * 5 * (1 + (global.stage / 100))));
                    alarm[0] = room_speed * 60;
                }
                
                if (!instance_exists(obj_cinematic))
                {
                    with (gml_Script_instance_create(x, y, obj_cinematic))
                    {
                        sequence = "finis phase 2";
                        alarm[0] = room_speed;
                    }
                }
            }
        }
    }
}

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2,
    Value_5 = 5,
    Value_10 = 10
}
