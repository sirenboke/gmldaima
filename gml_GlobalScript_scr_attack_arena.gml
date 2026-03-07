self.scr_attack_arena = function()
{
    if (instance_exists(target))
    {
        if (distance_to_object(target) <= rng)
        {
            speed = 0;
            
            if (alarm[1] == -1)
            {
                image_index = 0;
                image_speed = (image_number / room_speed) * myStatInfo[1][3];
                alarm[1] = room_speed / myStatInfo[1][3];
            }
        }
    }
    else
    {
        sprite_index = spr_idle;
        state = UnknownEnum.Value_0;
    }
    
    if (mana > maxmana)
        mana = maxmana;
};

enum UnknownEnum
{
    Value_0
}
