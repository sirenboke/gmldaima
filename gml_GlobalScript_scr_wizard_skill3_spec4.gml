self.scr_wizard_skill3_spec4 = function()
{
    if (argument[1] <= 0)
        argument[1] = 1;
    
    if (gml_Script_scr_relicEffect(player, 0, 28) > 0 && argument[1] > 0)
        show_debug_message("Wise Hat effect (on " + string(name) + "'s " + string(myAbilityInfo[1]) + "): " + string(argument[1]) + "x.");
    
    skillTimer = 3;
    skillTimer *= abilityDurationBonus;
    var _skillTimer = skillTimer;
    var _abilityDmg = myStatInfo[9][3] * (1 + (myStatInfo[9][3] / 60000));
    
    with (gml_Script_instance_create(x, y, obj_earthquake))
    {
        dmg = _abilityDmg;
        player = other.player;
        duration = 5;
        depth = other.depth - 1;
        alarm[0] = _skillTimer * room_speed;
    }
    
    if (alarm[2] == -1)
        alarm[2] = room_speed * _skillTimer;
};
