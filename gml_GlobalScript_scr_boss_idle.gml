self.scr_boss_idle = function()
{
    if (instance_exists(obj_warrior))
    {
        speed = 0;
        
        if (sprite_index != spr_idle)
            sprite_index = spr_idle;
        
        if (distance_to_object(instance_nearest(x, y, obj_warrior)) <= rng)
        {
            sprite_index = spr_attack;
            state = UnknownEnum.Value_2;
        }
        else if (global.newUnderworld == false)
        {
            sprite_index = spr_move;
            state = UnknownEnum.Value_1;
        }
        else if (!instance_exists(obj_portalBoss1) && !instance_exists(obj_cinematic))
        {
            sprite_index = spr_move;
            state = UnknownEnum.Value_1;
        }
        else
        {
            x = room_width + 1000;
        }
    }
    
    if (place_meeting(x - 20, y, obj_enemy))
    {
        if (sprite_index != spr_idle)
            sprite_index = spr_idle;
    }
};

enum UnknownEnum
{
    Value_1 = 1,
    Value_2
}
