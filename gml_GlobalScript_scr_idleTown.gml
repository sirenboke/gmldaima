self.scr_idleTown = function()
{
    if (alarm[1] == -1)
    {
        alarm[1] = random_range(room_speed * 5, room_speed * 15);
    }
    else if (path_position == 1)
    {
        if (sprite_index != spr_idle)
            sprite_index = spr_idle;
        
        image_speed = 0.002 * global.roomSpeed;
    }
    else
    {
        if (sprite_index != spr_move)
            sprite_index = spr_move;
        
        image_speed = 0.02 * global.roomSpeed;
        
        if (x < gotoX)
            image_xscale = 1;
        
        if (x > gotoX)
            image_xscale = -1;
    }
    
    action = 0;
    energyUsed = -1;
    xpvalue = 0;
    goldvalue = 0;
    hpvalue = 0;
    foodvalue = 0;
    
    for (var _v = 1; _v < 5; _v++)
        actionPoints[_v] = 0;
    
    if (alarm[0] == -1)
    {
        if (energy < maxEnergy)
        {
            with (gml_Script_instance_create(x, y - (height * 1.5), obj_float))
            {
                type = 5;
                value = real(string_digits(other.energyUsed));
                text = "+" + string(value) + " energy";
                c1 = 65535;
                c2 = 4235519;
                parent = other.id;
            }
        }
        
        alarm[0] = room_speed * 2;
    }
};
