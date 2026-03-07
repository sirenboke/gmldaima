self.scr_castAbility = function()
{
    if (object_get_name(object_index) == "obj_warrior")
    {
        with (obj_warrior)
            alarm[11] = room_speed * 60;
    }
    
    if (castingAbility == false)
    {
        castingAbility = true;
        canAttack = false;
        canMove = false;
        gml_Script_scr_playsound(s_skillReady, 0.9, 1.1, 0.02);
        mana = maxmana;
        gml_Script_scr_alarm_start(0, abilityCastTime, gml_Script_scr_useAbility);
        show_debug_message("Cast Time: OG: " + string(myAbilityInfo[9]) + " | Final: " + string(abilityCastTime));
    }
};
