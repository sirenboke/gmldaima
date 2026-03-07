self.scr_guard = function()
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
    
    action = 3;
    energyUsed = 0;
    xpvalue = 1 + (0.1 + (level / 100));
    goldvalue = 0;
    hpvalue = 0;
    foodvalue = 0;
    
    for (var _v = 1; _v < 5; _v++)
        actionPoints[_v] = 0;
    
    actionPoints[3] = 0.5 + (obj_build_inn.level / 10);
    
    if (alarm[0] == -1)
        alarm[0] = room_speed;
};
