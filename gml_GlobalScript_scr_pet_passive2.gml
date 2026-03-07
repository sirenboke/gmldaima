self.scr_pet_passive2 = function(arg0)
{
    myTarget = player;
    bonusValue = 0.05 + (arg0 / 200);
    
    with (player)
    {
        if (instance_exists(target))
        {
            if (choose(0, 1) == 0)
            {
                other.buff = -((0.05 + (arg0 / 200)) / target.tierReduction);
                other.myTarget = target;
            }
            else
            {
                other.buff = 0.05 + (arg0 / 100);
                other.myTarget = player;
            }
            
            other.myTarget.myDamage[0] += other.buff;
        }
    }
    
    alarm[0] = room_speed * 3;
};
