var _player = player;
var _pierce = false;
var _dmg = dmg;
var _gloRed = gloRed;
var _physRed = physRed;
var _speRed = speRed;
var _staRed = staRed;
var _duration = duration;
var _armorRed = armorRed;

with (other)
{
    gml_Script_scr_statChange(myStatInfo[3][3] * (_armorRed / 100), -1, 3);
    
    if (_physRed > 0)
        gml_Script_scr_statChange(_physRed, 1, 12, _duration);
    
    if (_speRed > 0)
        gml_Script_scr_statChange(_speRed, 1, 13, _duration);
    
    if (_staRed > 0)
        gml_Script_scr_statChange(_staRed, 1, 14, _duration);
    
    if (_gloRed > 0)
        gml_Script_scr_statChange(_gloRed, 1, 11, _duration);
    
    if (gml_Script_scr_enemy_takeDamage(_dmg, 4, _player, 1, 1, 0, undefined, undefined, undefined, undefined, 1, 1, 1) <= 0)
    {
        if (instance_exists(obj_enemy))
        {
            with (instance_nearest(x + 20, y, obj_enemy))
                gml_Script_scr_enemy_takeDamage(_dmg, 1, _player, undefined, 1, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
        }
    }
}

if (_pierce == false)
{
    with (other)
        gml_Script_scr_interrupt();
    
    instance_destroy();
}
