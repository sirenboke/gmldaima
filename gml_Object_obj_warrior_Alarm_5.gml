if (myRaidNumber == 0 && !instance_exists(obj_cinematic))
{
    var lastHitHP = hp;
    gml_Script_scr_statChange(global.rainArmor, -1, 3, undefined, undefined);
    gml_Script_scr_statChange(0.005, -1, 40, undefined, undefined);
    gml_Script_scr_player_takeDamage(global.rainDmg, 4, -4, undefined, undefined, undefined, 1, 0, 0, 0);
}
