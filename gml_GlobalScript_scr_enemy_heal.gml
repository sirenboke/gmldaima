self.scr_enemy_heal = function(arg0)
{
    arg0 *= healReduction;
    hp += arg0;
    
    if (equippedUniqueItem[3] == 1)
    {
        if (hp > myStatInfo[8][3])
        {
            if (shield < maxshield)
            {
                var _extraHP = (hp - myStatInfo[8][3]) / 4;
                var _maxAddShield = maxshield - shield;
                
                if ((shield + _extraHP) > maxshield)
                    gml_Script_scr_shield(_maxAddShield);
                else
                    gml_Script_scr_shield(_extraHP);
            }
        }
    }
    
    if (hp > myStatInfo[8][3])
        hp = myStatInfo[8][3];
    
    with (gml_Script_instance_create(x, float_height - 20, obj_float))
    {
        type = 3;
        value = arg0;
        text = "+" + gml_Script_scr_bigNumber(value);
        c1 = 65280;
        c2 = 32768;
        parent = other.id;
        alarm[1] = 1;
    }
    
    return arg0;
};
