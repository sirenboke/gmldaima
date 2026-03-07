self.scr_enemy_ult7 = function()
{
    if (argument[1] <= 0)
        argument[1] = 1;
    
    if (gml_Script_scr_relicEffect(player, 0, 28) > 0 && argument[1] > 0)
        show_debug_message("Wise Hat effect (on " + string(name) + "'s " + string(myAbilityInfo[1]) + "): " + string(argument[1]) + "x.");
    
    canAttack = true;
    var armorDebuff = (0.1 + (level / 40000)) * argument[1];
    
    if (armorDebuff > 0.5)
        armorDebuff = 0.5;
    
    armorReduction += armorDebuff;
    skillBuff = round(5 + (level / 5000));
    skillBuff = round(skillBuff * abilityDurationBonus);
    
    if (skillBuff > 10)
        skillBuff = 10;
    
    buffed = skillBuff;
};
