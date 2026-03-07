if (room != r_seasonEnd)
{
    global.bonanzaBonus = 1;
    gml_Script_scr_alarm_start(0, 2, gml_Script_scr_updateBuildings);
    gml_Script_scr_playsound(s_favorEnd, 1, 1.2, 1);
    gml_Script_scr_clearFavor();
}
