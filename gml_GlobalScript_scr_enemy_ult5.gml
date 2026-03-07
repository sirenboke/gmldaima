self.scr_enemy_ult5 = function()
{
    if (argument[1] <= 0)
        argument[1] = 1;
    
    if (gml_Script_scr_relicEffect(player, 0, 28) > 0 && argument[1] > 0)
        show_debug_message("Wise Hat effect (on " + string(name) + "'s " + string(myAbilityInfo[1]) + "): " + string(argument[1]) + "x.");
    
    with (obj_warrior)
    {
        if (myRaidNumber == 0)
            gml_Script_scr_stun(1.5 * abilityDurationBonus);
    }
    
    canAttack = false;
    var _abilityDmg = myStatInfo[0][3] * argument[1];
    var _target = target;
    
    with (gml_Script_instance_create(x, clamp(y - (height / 2), room_height - 200, room_height - 20), obj_bigRay))
    {
        dmg = _abilityDmg;
        player = other.id;
        target = _target;
        alarm[1] = room_speed * 3 * other.abilityDurationBonus;
    }
};
