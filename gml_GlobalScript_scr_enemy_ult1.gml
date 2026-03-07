self.scr_enemy_ult1 = function()
{
    if (argument[1] <= 0)
        argument[1] = 1;
    
    if (gml_Script_scr_relicEffect(player, 0, 28) > 0 && argument[1] > 0)
        show_debug_message("Wise Hat effect (on " + string(name) + "'s " + string(myAbilityInfo[1]) + "): " + string(argument[1]) + "x.");
    
    extraDmg = myStatInfo[0][3] * (1.5 + (level / 15000)) * argument[1];
    skillTimer = 3 + (1 + (level / 2000));
    canAttack = true;
    
    if (skillTimer > 10)
        skillTimer = 10;
    
    if (tier >= 2)
    {
        extraCrit = 5 + (level / 1000);
        gml_Script_scr_statChange(extraCrit, undefined, 7, skillTimer, undefined);
    }
    
    skillTimer = round(skillTimer * abilityDurationBonus);
    
    if (alarm[2] == -1)
        alarm[2] = room_speed * skillTimer;
};
