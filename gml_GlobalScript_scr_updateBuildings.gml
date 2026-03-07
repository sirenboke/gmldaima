self.scr_updateBuildings = function()
{
    show_debug_message("updating buildings");
    global.farmerResourceBonus = global.farmerBonus / 20;
    global.godResourceBonus = 1 + (global.godLevel / 50);
    global.globalGoldBonus = (1 + (global.farmerResourceBonus + global.wellGoldBonus)) * global.bonanzaBonus * global.godResourceBonus;
    global.globalXPBonus = global.academyXpBonus * (1 + (global.djinnInfo[0][2] / 100));
    global.globalFoodBonus = (1 + global.farmerResourceBonus) * global.bonanzaBonus * global.godResourceBonus;
    
    if (global.djinnInfo[0][0] == 1)
    {
        global.globalFoodBonus *= (1 + (global.djinnInfo[0][2] / 100));
        global.globalGoldBonus *= (1 + (global.djinnInfo[0][2] / 100));
        global.globalXPBonus *= (1 + (global.djinnInfo[0][2] / 100));
        show_debug_message("XP and resource gain multiplied by Djinn");
    }
    
    with (obj_build_mine)
    {
        amount = 5 + round((2 + level) * (level / 10) * power(5, 1 + (level / 14)));
        oamount = amount * global.mineBonusValue * ((1 + (global.farmerResourceBonus + global.wellGoldBonus)) * global.godResourceBonus * (1 + (global.djinnInfo[0][2] / 100)));
        show_debug_message("Mine Value: " + string(amount));
        amount *= (global.mineBonusValue * global.globalGoldBonus);
        amount *= (1 + global.corruptionShardEffect[3]);
        amount = ceil(amount);
        gemChance = 5000 - (global.godLevel * 50) - (level * 20);
        
        if (instance_exists(obj_build_guildhall))
        {
            gemChance *= (1 - (global.minerGuildLevel / 100));
            gemChance *= (1 - global.corruptionShardEffect[8]);
        }
        
        if (obj_god.alarm[2] != -1)
            obj_build_mine.gemChance /= 2;
    }
    
    with (obj_build_farm)
    {
        amount = 8 + round((2 + level) * (level / 18) * power(2, 1 + (level / 38)));
        oamount = amount * global.farmBonusValue * ((1 + global.farmerResourceBonus) * global.godResourceBonus * (1 + (global.djinnInfo[0][2] / 100)));
        amount *= (global.farmBonusValue * global.globalFoodBonus);
        amount *= (1 + global.corruptionShardEffect[2]);
        amount = ceil(amount);
    }
};
