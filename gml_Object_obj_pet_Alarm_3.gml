myTarget = player;
bonusValue = 0.05 + (level / 200);

with (player)
{
    if (target != -1 && instance_exists(target))
    {
        if (choose(0, 1) == 0)
        {
            other.bonusValue /= target.tierReduction;
            other.buff = -other.bonusValue;
            other.myTarget = target;
        }
        else
        {
            other.buff = other.bonusValue;
            other.myTarget = id;
        }
        
        other.myTarget.myDamage[0] += other.buff;
    }
    else
    {
        other.buff = other.bonusValue;
        other.myTarget = id;
        other.myTarget.myDamage[0] += other.buff;
    }
}

show_debug_message("Pet random buff to " + string(myTarget));
alarm[0] = (room_speed * 2) + ((level / 30) * room_speed);
alarm[3] = random_range(room_speed * 7, room_speed * 10) - ((level / 15) * room_speed);
