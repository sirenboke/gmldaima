self.scr_player_reward = function(arg0, arg1, arg2 = 1)
{
    var _original = arg0;
    var _typetext = "";
    
    if (arg1 == 0)
    {
        var _multiplier = myMultiplier[2] * global.globalXPBonus;
        var _old = xp;
        _typetext = "xp";
        arg0 *= _multiplier;
        arg0 *= afkRewardPenalty;
        arg0 = ceil(arg0);
        
        if (ascended == true)
        {
            if (room == r_1)
                gml_Script_scr_townXP(arg0, 1);
            
            exit;
        }
        
        xp = gml_Script_scr_addValue(xp, arg0);
        
        if (is_nan(xp))
        {
            xp = _old;
            arg0 = 0;
        }
        
        global.creditsXP = gml_Script_scr_addValue(global.creditsXP, arg0);
        
        if (xp < 0)
            xp = 0;
        
        if (arg0 > 0 && afkdraw == false)
        {
            with (gml_Script_instance_create(x, y - (height / 2), obj_float))
            {
                type = 0;
                value = arg0;
                text = "+" + gml_Script_scr_bigNumber(value) + "xp";
                c1 = 16711935;
                c2 = 8388736;
                parent = other.id;
            }
        }
    }
    
    if (arg1 == 1)
    {
        var _multiplier = myMultiplier[4] * global.globalGoldBonus;
        var _old = mygold;
        _typetext = "gold";
        arg0 *= _multiplier;
        arg0 *= afkRewardPenalty;
        
        if (state == UnknownEnum.Value_4)
        {
            var _max = obj_build_mine.amount;
            
            if (arg0 > _max)
                arg0 = _max;
        }
        
        arg0 = ceil(arg0);
        
        if (ascended == true)
        {
            if (arg2 == 1)
                global.gold += arg0;
            
            exit;
        }
        
        mygold = gml_Script_scr_addValue(mygold, arg0);
        
        if (is_nan(mygold))
        {
            mygold = _old;
            arg0 = 0;
        }
        
        global.creditsGold = gml_Script_scr_addValue(global.creditsGold, arg0);
        
        if (mygold < 0)
            mygold = 0;
        
        if (arg0 > 0 && afkdraw == false)
        {
            with (gml_Script_instance_create(x, y - (height / 2), obj_float))
            {
                type = 1;
                value = arg0;
                text = "+" + gml_Script_scr_bigNumber(value);
                c1 = 65535;
                c2 = 4235519;
                parent = other.id;
            }
        }
    }
    
    if (arg1 == 2)
    {
        var _multiplier = myMultiplier[4] * global.globalFoodBonus;
        var _old = myfood;
        _typetext = "food";
        arg0 *= _multiplier;
        arg0 *= afkRewardPenalty;
        
        if (state == UnknownEnum.Value_3)
        {
            var _max = obj_build_farm.amount;
            
            if (arg0 > _max)
                arg0 = _max;
        }
        
        arg0 = ceil(arg0);
        
        if (ascended == true)
        {
            if (arg2 == 1)
                global.food += arg0;
            
            exit;
        }
        
        myfood = gml_Script_scr_addValue(myfood, arg0);
        
        if (is_nan(myfood))
        {
            myfood = _old;
            arg0 = 0;
        }
        
        global.creditsFood = gml_Script_scr_addValue(global.creditsFood, arg0);
        
        if (myfood < 0)
            myfood = 0;
        
        if (arg0 > 0 && afkdraw == false)
        {
            with (gml_Script_instance_create(x, y - (height / 2), obj_float))
            {
                type = 7;
                value = arg0;
                text = "+" + gml_Script_scr_bigNumber(value);
                c1 = 65280;
                c2 = 32768;
                parent = other.id;
            }
        }
    }
    
    return arg0;
};

enum UnknownEnum
{
    Value_3 = 3,
    Value_4
}
