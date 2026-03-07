var _scale = scale;
var _dmg = dmg / 6;
var _player = player;
var _duration = duration;
var _range = range;
var _movespd = movespd / 6;
var _pull = pulling;
var _buff = buff / 6;
var _debuff = debuff / 6;

if (alarm[0] != -1)
{
    if (instance_exists(obj_enemy))
    {
        with (obj_enemy)
        {
            if (place_meeting(x, y, other))
            {
                gml_Script_scr_statChange(myStatInfo[1][3] * 0.1 * _debuff, undefined, 1, 3, undefined, 1);
                gml_Script_scr_statChange(myStatInfo[2][3] * 0.1 * _debuff, undefined, 2, 3, undefined, 1);
                gml_Script_scr_statChange(0.1 * _debuff, undefined, 10, 3, undefined, 1);
                gml_Script_scr_enemy_takeDamage(_dmg, 3, _player, undefined, undefined, undefined, 1);
                gml_Script_scr_knockup(2);
            }
        }
    }
    
    if (instance_exists(obj_warrior))
    {
        with (obj_warrior)
        {
            if (place_meeting(x, y, other))
            {
                gml_Script_scr_statChange(myStatInfo[1][3] * (0.05 + _buff), undefined, 1, 3, undefined, 1);
                gml_Script_scr_statChange(myStatInfo[2][3] * (0.05 + _buff), undefined, 2, 3, undefined, 1);
                speedBuff += (_movespd + _buff);
            }
        }
    }
    
    alarm[1] = room_speed / 5 / 6;
}
