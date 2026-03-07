self.scr_attack_ranged = function()
{
    allyInRange = true;
    meInRange = true;
    
    if (instance_exists(obj_enemy))
    {
        if (distance_to_object(target) > rng)
            meInRange = false;
        else
            meInRange = true;
        
        with (obj_warrior)
        {
            if (myRaidNumber == 0 && id != other.id)
            {
                if (distance_to_object(target) > rng)
                    allyInRange = false;
                else
                    allyInRange = true;
            }
        }
    }
    else
    {
        meInRange = true;
        allyInRange = true;
    }
    
    if (myRaidNumber == 0)
    {
        if (instance_exists(obj_enemy))
        {
            if (targetFixed == false)
                target = instance_nearest(x, y, obj_enemy);
            
            if (targetFixed == false)
            {
                for (var t = 0; t < instance_number(obj_enemy); t++)
                {
                    if (distance_to_object(instance_find(obj_enemy, t)) <= rng)
                    {
                        if (t == 0)
                            target = instance_find(obj_enemy, t);
                        else if (distance_to_object(instance_find(obj_enemy, t)) < distance_to_object(target))
                            target = instance_find(obj_enemy, t);
                    }
                }
            }
            
            if (instance_exists(target) && meInRange == true)
            {
                if (alarm[myAlarm] == -1)
                {
                    if (castingAbility == false)
                    {
                        if (canAttack == true)
                        {
                            if (sprite_index != spr_attack)
                                sprite_index = spr_attack;
                            
                            image_index = 0;
                            image_speed = (image_number / room_speed) * myStatInfo[1][3];
                            alarm[myAlarm] = room_speed / myStatInfo[1][3];
                        }
                        else
                        {
                            sprite_index = spr_idle;
                            image_speed = 0;
                            image_index = 0;
                        }
                    }
                    else
                    {
                        canAttack = false;
                    }
                }
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
            state = UnknownEnum.Value_9;
        }
        
        if (mana > maxmana)
            mana = maxmana;
    }
    else
    {
        sprite_index = spr_idle;
        state = UnknownEnum.Value_0;
    }
};

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_9 = 9
}
