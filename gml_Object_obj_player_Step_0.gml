if ((room == global.room_underworld || room == r_corrupted) && readyRaid == 0)
{
    state = UnknownEnum.Value_0;
    x = 2500;
}

gml_Script_scr_alarm_step();

if (xp >= maxxp)
    gml_Script_scr_levelup();

if (hp > myStatInfo[8][3])
    hp = myStatInfo[8][3];

if (x >= 1420)
    visible = false;
else
    visible = true;

switch (state)
{
    case UnknownEnum.Value_0:
        gml_Script_scr_idleTown();
        break;
    
    case UnknownEnum.Value_1:
        gml_Script_scr_moveTown();
        break;
    
    case UnknownEnum.Value_4:
        gml_Script_scr_mining();
        break;
    
    case UnknownEnum.Value_3:
        gml_Script_scr_farming();
        break;
    
    case UnknownEnum.Value_5:
        gml_Script_scr_resting();
        break;
    
    case UnknownEnum.Value_7:
        gml_Script_scr_guard();
        break;
    
    case UnknownEnum.Value_6:
        gml_Script_scr_training();
        break;
    
    case UnknownEnum.Value_8:
        gml_Script_scr_raiding();
        break;
    
    case UnknownEnum.Value_12:
        gml_Script_scr_permadeath();
        break;
    
    case UnknownEnum.Value_13:
        gml_Script_scr_player_wait();
        break;
    
    case UnknownEnum.Value_14:
        gml_Script_scr_player_move();
        break;
    
    case UnknownEnum.Value_15:
        gml_Script_scr_player_afk();
        break;
}

if (state != UnknownEnum.Value_15 && afkdraw == true)
    gml_Script_scr_player_notafk();

if (state == UnknownEnum.Value_15)
{
    if (global.totalPlayers >= global.maxPlayers)
    {
        if (ascended == false)
        {
            if (alarm[10] > 1)
                alarm[10] = 1;
        }
    }
}

depth = -y / 10;

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_3 = 3,
    Value_4,
    Value_5,
    Value_6,
    Value_7,
    Value_8,
    Value_12 = 12,
    Value_13,
    Value_14,
    Value_15
}
