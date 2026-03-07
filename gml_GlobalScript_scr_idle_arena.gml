self.scr_idle_arena = function()
{
    speed = 0;
    
    if (instance_exists(target))
    {
        if (distance_to_object(target) <= rng)
        {
            sprite_index = spr_attack;
            image_index = image_number / 2;
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
        if (sprite_index != spr_idle)
            sprite_index = spr_idle;
        
        image_speed = 0.01;
    }
};

enum UnknownEnum
{
    Value_1 = 1,
    Value_2
}
