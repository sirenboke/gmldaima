self.scr_boss_move = function()
{
    if (instance_exists(obj_warrior))
    {
        target = instance_nearest(x, y, obj_warrior);
        
        if (distance_to_object(target) <= rng)
        {
            sprite_index = spr_attack;
            image_index = 0;
            image_speed = 0;
            state = UnknownEnum.Value_2;
        }
        else if (place_meeting(x - 20, y, obj_enemy))
        {
            state = UnknownEnum.Value_0;
        }
        else
        {
            x -= moveSpeed;
            
            if (sprite_index != spr_move)
                sprite_index = spr_move;
        }
    }
    else
    {
        state = UnknownEnum.Value_0;
    }
};

enum UnknownEnum
{
    Value_0,
    Value_2 = 2
}
