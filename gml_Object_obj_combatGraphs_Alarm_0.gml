with (obj_player)
{
    var _totalDamageDealt = 0;
    var _totalDamageMitigated = 0;
    
    for (var i = 0; i <= global.damageTypes; i++)
    {
        _totalDamageDealt += combatDamageDealt[i];
        _totalDamageMitigated += combatDamageMitigated[i];
    }
    
    if (_totalDamageDealt > 0)
        gml_Script_scr_addDiaryProgress(4, _totalDamageDealt);
    
    if (_totalDamageMitigated > 0)
        gml_Script_scr_addDiaryProgress(5, _totalDamageMitigated);
}
