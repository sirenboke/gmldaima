self.scr_pet_skill3 = function(arg0)
{
    var _rand = irandom_range(0, room_width);
    var _target = 0;
    
    if (instance_exists(obj_enemy))
    {
        _target = instance_nearest(_rand, room_height, obj_enemy);
        
        if (instance_exists(_target))
        {
            if (_target.x < room_width)
            {
                _target.myResistance[0][0] += ((0.05 + (arg0 / 100)) / _target.tierReduction);
                
                with (instance_create_depth(_target.x, _target.y, _target.depth - 1, obj_targetMarked))
                    player = _target;
            }
        }
    }
};
