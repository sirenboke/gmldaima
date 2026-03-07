self.scr_boss_attack = function()
{
    if (instance_exists(obj_warrior))
    {
        target = instance_nearest(x, y, obj_warrior);
        
        if (instance_exists(target))
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
        state = UnknownEnum.Value_0;
    }
};

enum UnknownEnum
{
    Value_0,
    Value_1
}
