self.scr_idle = function()
{
    if (x < xx)
    {
        x += (0.5 * global.roomSpeed * moveSpeed);
        
        if (sprite_index != spr_move)
            sprite_index = spr_move;
        
        image_speed = 0.024 * global.roomSpeed * (moveSpeed - speedBuff);
    }
    else
    {
        if (sprite_index != spr_idle)
            sprite_index = spr_idle;
        
        image_speed = 0.01;
    }
    
    if (global.raiding == true)
    {
        if (instance_exists(obj_enemy))
        {
            if (targetFixed == false)
                target = instance_nearest(x, y, obj_enemy);
            
            if (myRaidNumber == 0)
            {
                sprite_index = spr_move;
                state = UnknownEnum.Value_1;
                
                if (image_xscale != 2)
                    image_xscale = 2;
            }
            else if (x > xx)
            {
                image_xscale = -2;
                
                if (sprite_index != spr_move)
                    sprite_index = spr_move;
                
                image_speed = 0.024 * global.roomSpeed * moveSpeed;
                x -= (moveSpeed * 2);
                
                if (x <= xx)
                    x = xx;
            }
            else
            {
                image_xscale = 2;
                
                if (global.raidMove == true)
                {
                    if (sprite_index != spr_move)
                        sprite_index = spr_move;
                    
                    image_speed = 0.024 * global.roomSpeed * (moveSpeed - speedBuff);
                }
                else
                {
                    if (sprite_index != spr_idle)
                        sprite_index = spr_idle;
                    
                    image_speed = 0.01;
                }
            }
        }
    }
    else
    {
        if (sprite_index != spr_idle)
            sprite_index = spr_idle;
        
        image_speed = 0.01;
    }
};

enum UnknownEnum
{
    Value_1 = 1
}
