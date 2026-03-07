self.scr_useAbility = function(arg0 = 0)
{
    if (arg0 > 0)
        show_debug_message("R28 (Wise Hat) should proc at " + string(arg0) + "x!");
    
    var _abilityName = myAbilityInfo[1];
    
    with (gml_Script_instance_create(x, y - height - 25, obj_float))
    {
        type = 20;
        value = string(_abilityName) + "!";
        text = value;
        c1 = 65535;
        c2 = 4235519;
        parent = other.id;
    }
    
    gml_Script_scr_playsound(s_skillReady, 0.9, 1.1, 0.02);
    mana = maxmana;
    
    if (class == "warrior")
    {
        if (specialized == 2)
        {
        }
        
        if (specialized == 3)
        {
        }
    }
    
    if (gml_Script_scr_relicEffect(player, 0, 28) > 0)
    {
        if (irandom(9) >= 8)
        {
            arg0 = gml_Script_scr_relicEffect(player, 0, 28);
            show_debug_message("R28 (Wise Hat) actually procced at " + string(arg0) + "x!");
            script_execute(myAbilityInfo[2], myAbilityInfo[4], arg0);
            gml_Script_scr_relicEffect_9();
            
            with (gml_Script_instance_create(x, y - (height / 2), obj_float))
            {
                type = 21;
                value = "Wise Hat proc! (" + gml_Script_scr_bigNumber(arg0 * 100) + "%)";
                text = value;
                c1 = 65535;
                c2 = 4235519;
                parent = other.id;
            }
        }
    }
    
    arg0 = 0;
    
    if (object_get_name(object_index) == "obj_warrior")
    {
        with (obj_warrior)
            alarm[11] = room_speed * 60;
    }
    
    if (equippedUniqueItem[4] != 1 && player.myPetEquippedRelic[myPetID][4] != 1)
    {
        maxmana += 0.1;
    }
    else
    {
        var _extramana = 0.1;
        _extramana /= (1 + gml_Script_scr_relicEffect(player, 1, 4));
        maxmana += _extramana;
    }
    
    mana = 0;
    castingAbility = false;
    canAttack = true;
    canMove = true;
    show_debug_message("Wise Hat effect (on pre-cast script): " + string(arg0) + "x.");
    script_execute(myAbilityInfo[2], myAbilityInfo[4], arg0);
    gml_Script_scr_relicEffect_9();
    
    if (type == "final")
    {
        show_debug_message("finis ability was " + string(skill));
        skill = 1 + irandom(global.enemyAbilityMax);
        show_debug_message("finis ability now set to skill " + string(skill));
        gml_Script_scr_setAbility(skill);
    }
};
