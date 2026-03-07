if (room != r_seasonEnd)
{
    global.godsDmgBonus = 0;
    raidsLeft = 0;
    
    with (obj_player)
        gml_Script_scr_alarm_start(6, 1, gml_Script_scr_updateStats);
    
    gml_Script_scr_playsound(s_favorEnd, 1, 1.2, 1);
    gml_Script_scr_clearFavor();
    alarm[0] = 1;
}
