self.scr_resting = function()
{
    if (path_exists(actionPath))
    {
        if (distance_to_point(gotoX, gotoY) > 5)
        {
            if (sprite_index != spr_move)
                sprite_index = spr_move;
            
            if (gotoX <= round(x))
                image_xscale = -1;
            
            if (gotoX > round(x))
                image_xscale = 1;
            
            image_speed = (moveSpeed / 10) * global.roomSpeed;
        }
        else
        {
            path_delete(actionPath);
        }
    }
    else
    {
        if (sprite_index != spr_idle)
            sprite_index = spr_idle;
        
        image_speed = 0.002 * global.roomSpeed;
        action = 6;
        energyUsed = -4 - obj_build_inn.level;
        xpvalue = 0;
        goldvalue = 0;
        hpvalue = myStatInfo[8][3] / 10;
        foodvalue = ceil((level / 10) + (level * (1 + (level / 20))));
        foodvalue *= -1;
        
        if (hp >= myStatInfo[8][3])
        {
            hp = myStatInfo[8][3];
            hpvalue = 0;
            foodvalue = floor(foodvalue / 10);
        }
        
        if (global.food < 1)
        {
            global.food = 0;
            hpvalue = 0;
            foodvalue = 0;
        }
        
        if (energy < maxEnergy)
            energyUsed = -4 - obj_build_inn.level;
        
        if ((hp == myStatInfo[8][3] && energy == maxEnergy) || global.food < 1)
        {
            if (wasGuarding == true)
            {
                path_end();
                state = UnknownEnum.Value_7;
                target = obj_idleZone;
                actionPath = path_add();
                var w = 0;
                var h = 0;
                gotoX = random_range(target.x - w, target.x + w);
                gotoY = random_range(target.y - h, target.y + h);
                
                if (mp_grid_path(global.gameGrid, actionPath, x, y, gotoX, gotoY, 1))
                    path_start(actionPath, 0.5 * global.roomSpeed, path_action_stop, 0);
                
                wasGuarding = false;
            }
            else
            {
                state = UnknownEnum.Value_0;
                alarm[1] = 1;
            }
        }
        
        for (var _v = 1; _v < 5; _v++)
            actionPoints[_v] = 0;
        
        if (alarm[0] == -1)
            alarm[0] = room_speed;
    }
};

enum UnknownEnum
{
    Value_0,
    Value_7 = 7
}
