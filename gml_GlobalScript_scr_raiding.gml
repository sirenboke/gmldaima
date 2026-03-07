self.scr_raiding = function()
{
    if (round(x) < targetX)
    {
        if (sprite_index != spr_move)
            sprite_index = spr_move;
        
        image_speed = (moveSpeed / 10) * global.roomSpeed;
        
        if (x < targetX)
            image_xscale = 1;
        
        if (x > targetX)
            image_xscale = -1;
    }
    else
    {
        if (sprite_index != spr_idle)
            sprite_index = spr_idle;
        
        image_speed = 0.002 * global.roomSpeed;
    }
    
    action = 4;
    
    with (obj_warrior)
    {
        if (name == other.name)
            other.raidAction = raidAction;
    }
    
    energyUsed = 0;
    xpvalue = 0;
    goldvalue = 0;
    hpvalue = 0;
    foodvalue = 0;
    
    for (var _v = 1; _v < 5; _v++)
        actionPoints[_v] = 0;
    
    if (global.enemyRaid == true)
    {
        actionPoints[3] = 0.5 + (obj_build_inn.level / 10);
        action = 3;
    }
    
    actionPoints[4] = 0.5 + global.raidingVP;
    
    if (alarm[0] == -1)
        alarm[0] = room_speed;
};
