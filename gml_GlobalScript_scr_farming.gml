self.scr_farming = function()
{
    if (path_exists(actionPath))
    {
        if (distance_to_point(gotoX, gotoY) > 5)
        {
            if (sprite_index != spr_move)
                sprite_index = spr_move;
            
            if (gotoX < x)
                image_xscale = -1;
            
            if (gotoX > x)
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
        if (sprite_index != spr_farming)
        {
            sprite_index = spr_farming;
            image_speed = image_number / room_speed;
            image_index = 0;
        }
        
        action = 2;
        energyUsed = 0.5;
        xpvalue = 0;
        goldvalue = 0;
        hpvalue = 0;
        foodvalue = 1 + ((obj_build_farm.amount / 50) + ((myVocationInfo[1][0] - 1) * 2));
        foodvalue *= power(1.1, myVocationInfo[1][0]);
        
        for (var _v = 1; _v < 5; _v++)
            actionPoints[_v] = 0;
        
        actionPoints[2] = 0.5 + global.farmingVP;
        
        if (class == "farmer")
        {
            foodvalue *= 1.5;
            actionPoints[2] = 2 + global.farmingVP;
            xpvalue = 2 + (level / 30);
        }
        
        if (alarm[0] == -1)
        {
            image_index = 0;
            alarm[0] = room_speed;
            audio_sound_pitch(s_farm1, random_range(0.9, 1.1));
            audio_play_sound(s_farm1, 0, 0);
        }
    }
};
