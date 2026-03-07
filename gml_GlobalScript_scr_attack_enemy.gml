self.scr_attack_enemy = function()
{
    if (instance_exists(obj_warrior))
    {
        var _target = -1;
        var _targetX = -1;
        
        for (var i = 0; i < instance_number(obj_warrior); i++)
        {
            var _check;
            _check[i] = instance_find(obj_warrior, i);
            
            if (_check[i].x > _targetX)
            {
                _target = _check[i];
                _targetX = _target.x;
            }
        }
        
        if (_target == -1)
            _target = instance_nearest(x, y, obj_warrior);
        
        target = _target;
        
        if (target != -1 && instance_exists(target))
        {
            if (distance_to_object(target) <= rng)
            {
                if (target.enteredCombat == true)
                {
                    if (alarm[1] == -1)
                    {
                        if (canAttack == true)
                        {
                            if (sprite_index != spr_attack)
                                sprite_index = spr_attack;
                            
                            image_index = 0;
                            image_speed = (image_number / room_speed) * myStatInfo[1][3];
                            alarm[1] = room_speed / myStatInfo[1][3];
                        }
                        else
                        {
                            sprite_index = spr_idle;
                            image_speed = 0;
                            image_index = 0;
                        }
                    }
                }
            }
            else
            {
                sprite_index = spr_move;
                state = UnknownEnum.Value_1;
                image_speed = 0.05 * global.roomSpeed;
            }
        }
    }
    else
    {
        target = -1;
        state = UnknownEnum.Value_1;
        sprite_index = spr_move;
    }
};

enum UnknownEnum
{
    Value_1 = 1
}
