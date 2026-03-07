self.scr_w3s1_effect = function()
{
    canAttack = true;
    
    if (focusHpRegen > 0)
        gml_Script_scr_statChange(focusHpRegen, -1, 6, undefined, undefined);
    
    focusHpRegen = 0;
};
