self.scr_idle_enemy = function()
{
    speed = 0;
    
    if (sprite_index != spr_idle)
        sprite_index = spr_idle;
    
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
        
        if (target != -1 && distance_to_object(target) <= rng)
        {
            sprite_index = spr_attack;
            state = UnknownEnum.Value_2;
        }
        else
        {
            sprite_index = spr_move;
            state = UnknownEnum.Value_1;
        }
    }
    else
    {
        sprite_index = spr_move;
        state = UnknownEnum.Value_1;
        target = -1;
    }
    
    if (hasCollision == true)
    {
        if (place_meeting(x - 10, y, obj_enemy))
        {
            if (sprite_index != spr_idle)
                sprite_index = spr_idle;
        }
    }
};

enum UnknownEnum
{
    Value_1 = 1,
    Value_2
}
