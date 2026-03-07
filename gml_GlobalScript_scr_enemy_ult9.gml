self.scr_enemy_ult9 = function()
{
    if (argument[1] <= 0)
        argument[1] = 1;
    
    if (gml_Script_scr_relicEffect(player, 0, 28) > 0 && argument[1] > 0)
        show_debug_message("Wise Hat effect (on " + string(name) + "'s " + string(myAbilityInfo[1]) + "): " + string(argument[1]) + "x.");
    
    var _dmgReflection = (0.02 + (level / 20000)) * argument[1];
    skillTimer = 2 + (1 + (level / 10000));
    gml_Script_scr_statChange(_dmgReflection, undefined, 42, skillTimer);
    canAttack = true;
    skillTimer = round(skillTimer * abilityDurationBonus);
    
    if (skillTimer > 6)
        skillTimer = 6;
    
    if (tier >= 2)
        gml_Script_scr_statChange(level, undefined, 6, skillTimer, undefined, undefined, 0);
    
    if (alarm[2] == -1)
        alarm[2] = room_speed * skillTimer;
};
