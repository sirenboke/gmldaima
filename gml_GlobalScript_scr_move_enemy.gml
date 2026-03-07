self.scr_move_enemy = function()
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
        
        if (target != -1 && distance_to_object(target) <= rng)
        {
            if (canAttack == true)
            {
                sprite_index = spr_attack;
                image_index = 0;
                image_speed = 0;
                state = UnknownEnum.Value_2;
            }
        }
        else if (place_meeting(x - 10, y, obj_enemy))
        {
            if (hasCollision == true)
            {
                state = UnknownEnum.Value_0;
            }
            else
            {
                x -= (moveSpeed * sign(image_xscale));
                
                if (sprite_index != spr_move)
                    sprite_index = spr_move;
            }
        }
        else
        {
            x -= (moveSpeed * sign(image_xscale));
            
            if (sprite_index != spr_move)
                sprite_index = spr_move;
        }
    }
    else
    {
        target = -1;
        
        if (type != "final")
        {
            x -= moveSpeed;
            
            if (sprite_index != spr_move)
                sprite_index = spr_move;
            
            if (x < -sprite_width)
                instance_destroy();
        }
        else
        {
            if (sprite_index != spr_move)
            {
                sprite_index = spr_move;
                image_xscale = -2;
                move_towards_point(room_width - sprite_width, y, 0.5 * global.roomSpeed);
            }
            
            if (x >= (room_width - 200))
            {
                speed = 0;
                image_xscale = 2;
                sprite_index = spr_idle;
                myStatInfo[1][3] = myStatInfo[1][2];
            }
        }
    }
};

enum UnknownEnum
{
    Value_0,
    Value_2 = 2
}
