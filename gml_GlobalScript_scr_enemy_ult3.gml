self.scr_enemy_ult3 = function()
{
    if (argument[1] <= 0)
        argument[1] = 1;
    
    if (gml_Script_scr_relicEffect(player, 0, 28) > 0 && argument[1] > 0)
        show_debug_message("Wise Hat effect (on " + string(name) + "'s " + string(myAbilityInfo[1]) + "): " + string(argument[1]) + "x.");
    
    canAttack = true;
    var _lifeSteal = 10 * argument[1];
    gml_Script_scr_statChange(10, undefined, 5, 0, undefined);
    
    if (tier >= 2)
        aspdSteal = 0.001;
    
    skillBuff = round(4 + (level / 5000));
    skillBuff = round(skillBuff * abilityDurationBonus);
    
    if (skillBuff > 15)
        skillBuff = 15;
    
    buffed = skillBuff;
};
