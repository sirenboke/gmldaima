self.scr_w3s2_effect = function()
{
    var _r28 = -1;
    
    if (is_undefined(argument[0]))
    {
        show_debug_message("Argument0 undefined, set to default");
        _r28 = 0;
    }
    else
    {
        _r28 = argument[0];
        show_debug_message("Argument0 is defined as " + string(argument[0]));
    }
    
    if (_r28 <= 0)
        _r28 = 1;
    
    var _dmg = ((myStatInfo[0][3] * 7) + ((myStatInfo[9][3] / 5) * (1 + mySpecialBuff[4]))) * _r28;
    var _player = player;
    var _push = mySpecialBuff[3];
    var _distance = mySpecialBuff[1] * 150;
    var _strikingSpeed = 1 - mySpecialBuff[2];
    
    if (_strikingSpeed <= 0.02)
        _strikingSpeed = 0.02;
    
    canAttack = false;
    canMove = false;
    
    if (distance_to_object(instance_nearest(x, y, obj_enemy)) < 400)
    {
        if (buffed > 0)
        {
            with (instance_create_depth(x, y, depth - 2, obj_war3_2))
            {
                dmg = _dmg;
                player = _player;
                target = _player.myWarrior;
                depth = other.depth - 2;
                push = _push;
                distance = _distance;
                maxPos += _distance;
            }
            
            buffed -= 1;
            gml_Script_scr_alarm_start(1, _strikingSpeed * (2 * room_speed), gml_Script_scr_w3s2_effect, _r28);
        }
        else
        {
            canAttack = true;
            canMove = true;
            buffed = 0;
            skillBuff = 0;
        }
    }
    else
    {
        canAttack = true;
        canMove = true;
        buffed = 0;
        skillBuff = 0;
    }
    
    show_debug_message("strike wave damage: " + string(_dmg));
};
