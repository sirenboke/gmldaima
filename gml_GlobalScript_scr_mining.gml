self.scr_mining = function()
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
        if (sprite_index != spr_mining)
        {
            sprite_index = spr_mining;
            image_speed = image_number / room_speed;
            image_index = 0;
        }
        
        action = 1;
        energyUsed = 0.5;
        xpvalue = 0;
        goldvalue = 1 + ((obj_build_mine.amount / 50) + ((myVocationInfo[0][0] - 1) * 5));
        goldvalue *= power(1.1, myVocationInfo[0][0]);
        hpvalue = 0;
        foodvalue = 0;
        
        for (var _v = 1; _v < 5; _v++)
            actionPoints[_v] = 0;
        
        actionPoints[1] = 0.5 + global.miningVP;
        
        if (class == "farmer")
        {
            goldvalue *= 1.5;
            actionPoints[1] = 2 + global.miningVP;
        }
        
        if (alarm[0] == -1)
        {
            image_index = 0;
            alarm[0] = room_speed;
            gml_Script_scr_playsound(s_mining1, 0.9, 1.1, 0.1);
        }
    }
};
