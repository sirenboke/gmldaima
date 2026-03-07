self.scr_training = function()
{
    if (path_exists(actionPath))
    {
        if (distance_to_point(gotoX, gotoY) > 1)
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
        if (sprite_index != spr_training)
        {
            sprite_index = spr_training;
            image_speed = image_number / room_speed;
            image_index = 0;
        }
        
        energyUsed = 0.5;
        action = 5;
        xpvalue = obj_build_train.amount;
        xpvaluespecial = 1;
        goldvalue = 0;
        hpvalue = 0;
        foodvalue = 0;
        
        for (var _v = 1; _v < 5; _v++)
            actionPoints[_v] = 0;
        
        if (alarm[0] == -1)
        {
            image_index = 0;
            alarm[0] = room_speed;
            
            if (room == r_1)
                gml_Script_scr_playsound(s_xpOrb, 1.2, 2, 0.2);
            
            gml_Script_scr_player_abilityXP(id);
        }
    }
};
