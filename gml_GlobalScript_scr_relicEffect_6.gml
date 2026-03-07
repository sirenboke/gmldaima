self.scr_relicEffect_6 = function(arg0)
{
    if (myStatInfo[5][3] > 0)
    {
        var _healHit = arg0 * (myStatInfo[5][3] / 100);
        _healHit *= gml_Script_scr_relicEffect(player, 0, 6);
        
        if (object_get_name(object_index) == "obj_warrior")
            gml_Script_scr_player_heal(_healHit);
        
        if (object_get_name(object_get_parent(object_index)) == "obj_enemy")
            gml_Script_scr_enemy_heal(_healHit);
        
        show_debug_message("Relic 6 OG: " + string(_healHit) + " | Pet: " + string(_healHit));
    }
};
