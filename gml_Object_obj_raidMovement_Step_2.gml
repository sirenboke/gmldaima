if (gml_Script_live_call())
    return global.live_result;

if (instance_exists(obj_warrior))
{
    var _highestSpeed;
    _highestSpeed[0] = 0;
    var _activeRaider;
    _activeRaider[0] = 0;
    global.raidSpeed = 0;
    
    for (var t = 0; t < instance_number(obj_warrior); t++)
        _activeRaider[t] = instance_find(obj_warrior, t);
    
    var _check = 0;
    
    for (var s = 0; s < array_length(_activeRaider); s++)
    {
        if (_activeRaider[s].myRaidNumber == 0)
        {
            _highestSpeed[_check] = _activeRaider[s].moveSpeed;
            _check += 1;
        }
    }
    
    for (var i = 0; i < array_length(_highestSpeed); i++)
    {
        if (_highestSpeed[i] > global.raidSpeed)
            global.raidSpeed = _highestSpeed[i];
    }
    
    global.raidMove = false;
    var _anyoneMove = 0;
    
    for (var m = 0; m < instance_number(obj_warrior); m++)
    {
        with (instance_find(obj_warrior, m))
        {
            if (myRaidNumber == 0)
            {
                if (alarm[0] == -1)
                {
                    if (meInRange == false && canMove && x >= maxPos)
                        _anyoneMove += 1;
                }
            }
        }
    }
    
    if (_anyoneMove > 0)
        global.raidMove = true;
}
else
{
    global.raidMove = false;
    global.raidSpeed = 1;
}

if (global.raiding == false || !instance_exists(obj_enemy) || !instance_exists(obj_warrior))
    global.raidMove = false;

if (global.raidMove == true)
{
    var _firstRaider = instance_nearest(room_width, room_height - 20, obj_warrior);
    var _rW = _firstRaider.sprite_width / 2;
    var _firstEnemy = instance_nearest(0, room_height - 20, obj_enemy);
    var _eW = _firstEnemy.sprite_width / 2;
    var _distance;
    
    if (_firstRaider.x < _firstEnemy.x)
        _distance = point_distance(_firstRaider.x + _rW, _firstRaider.y, _firstEnemy.x - _eW, _firstEnemy.y);
    else
        _distance = 0;
    
    if (_distance > 0)
    {
        if (_distance < global.raidSpeed)
            global.raidSpeed = _distance;
    }
    else
    {
        global.raidSpeed = 0;
        global.raidMove = false;
    }
    
    global.partBgPos -= (global.partBgSpd * global.raidSpeed);
    part_system_position(global.raidObject_partsys, global.partBgPos, 0);
    part_system_position(global.over_partsys, global.partBgPos, 0);
    
    with (obj_raidObject)
        x -= (bgSpd * global.raidSpeed);
    
    with (obj_raidBackground)
        x -= (bgSpd * global.raidSpeed);
    
    with (obj_showDamage)
        x -= (bgSpd * global.raidSpeed);
    
    with (obj_float)
    {
        if (y > (room_height - 300))
            x -= (bgSpd * global.raidSpeed);
    }
    
    with (obj_warrior)
    {
        if (myRaidNumber != 0)
            sprite_index = spr_move;
    }
}
