self.scr_enemy_ult6 = function()
{
    if (argument[1] <= 0)
        argument[1] = 1;
    
    if (gml_Script_scr_relicEffect(player, 0, 28) > 0 && argument[1] > 0)
        show_debug_message("Wise Hat effect (on " + string(name) + "'s " + string(myAbilityInfo[1]) + "): " + string(argument[1]) + "x.");
    
    canAttack = true;
    x = room_width + 100 + (sprite_width * 2);
    moveSpeed = 0;
    var _spawnUnits = round(10 * abilityDurationBonus * argument[1]);
    
    with (gml_Script_instance_create(x - (sprite_width * 4), y, obj_enemySpawner))
    {
        summonMaxUnits = round(_spawnUnits);
        player = other.id;
    }
};
