if (gml_Script_live_call())
    return global.live_result;

global.debug_timer++;

if (global.debug_timer >= global.debug_interval)
{
    global.debug_timer = 0;
    gml_Script_scr_debug_ds_report();
    gml_Script_scr_validate_surfaces();
}

gml_Script_scr_alarm_step();
global.farmerResourceBonus = global.farmerBonus / 20;
global.godResourceBonus = 1 + (global.godLevel / 50);
global.globalGoldBonus = (1 + (global.farmerResourceBonus + global.wellGoldBonus)) * global.bonanzaBonus * global.godResourceBonus;
global.globalXPBonus = global.academyXpBonus * (1 + (global.djinnInfo[0][2] / 100));
global.globalFoodBonus = (1 + global.farmerResourceBonus) * global.bonanzaBonus * global.godResourceBonus;

if (global.djinnInfo[0][0] == 1)
{
    global.globalFoodBonus *= (1 + (global.djinnInfo[0][2] / 100));
    global.globalGoldBonus *= (1 + (global.djinnInfo[0][2] / 100));
    global.globalXPBonus *= (1 + (global.djinnInfo[0][2] / 100));
}

if (room == r_1)
    global.globalDamageBonus = (global.bossSoulsBonuses / 50) + global.godsDmgBonus;

if (room == global.room_underworld)
    global.globalDamageBonus = global.bossSoulsBonuses / 50;

global.globalResistanceBonus = global.bossSoulsBonuses / 100;

if (global.stage < 251)
    global.stageTypeWorld = "Forest";

if (global.stage >= 251)
    global.stageTypeWorld = "Grassland";

if (global.stage >= 501)
    global.stageTypeWorld = "Snow Trail";

if (global.maxGold >= global.maxNumber)
    global.maxGold = global.maxNumber;

if (global.gold >= global.maxNumber)
    global.gold = global.maxNumber;

if (global.maxFood >= global.maxNumber)
    global.maxFood = global.maxNumber;

if (global.food >= global.maxNumber)
    global.food = global.maxNumber;
