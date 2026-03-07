if (global.soulsProd > 0)
{
    global.souls += global.soulsProd;
    global.gold += (global.underworldGoldProd * global.globalGoldBonus);
    global.creditsGold += global.underworldGoldProd;
    
    if (room == r_1)
    {
        with (gml_Script_instance_create(370, 25, obj_float))
        {
            type = 1;
            value = global.underworldGoldProd * global.globalGoldBonus;
            text = "+" + gml_Script_scr_bigNumber(round(value));
            c1 = 65535;
            c2 = 4235519;
            parent = type;
            alarm[1] = 1;
        }
        
        with (gml_Script_instance_create(730, 55, obj_float))
        {
            type = 1;
            value = global.soulsProd;
            text = "+" + gml_Script_scr_bigNumber(round(value));
            c1 = 16776960;
            c2 = 8421376;
            parent = type;
            alarm[1] = 1;
        }
    }
    
    with (obj_warrior)
    {
        if (alarm[0] == -1)
        {
            myUnderworldXP = global.underworldXPProd * player.myMultiplier[2] * global.academyXpBonus;
            xp += myUnderworldXP;
        }
    }
    
    with (obj_player)
    {
        myUnderworldXP = global.underworldXPProd;
        gml_Script_scr_player_reward(myUnderworldXP, 0);
        
        with (gml_Script_instance_create(x, y - (height / 2), obj_float))
        {
            type = 0;
            value = other.myUnderworldXP;
            text = "+" + gml_Script_scr_bigNumber(round(value)) + "xp";
            c1 = 16711935;
            c2 = 8388736;
            parent = other.id;
            alarm[1] = 1;
        }
    }
}

alarm[0] = room_speed * 60;
