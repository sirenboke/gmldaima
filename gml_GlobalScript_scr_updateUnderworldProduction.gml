self.scr_updateUnderworldProduction = function()
{
    global.soulsProd = 0;
    global.underworldXPProd = 0;
    global.underworldGoldProd = 0;
    global.bossSoulsTotal = 0;
    
    for (var i = 0; i < 7; i += 1)
    {
        global.soulsProd += (global.bossSouls[i] * (i + 1));
        global.underworldXPProd += (global.bossSouls[i] * (i + 1) * 1000);
        global.underworldGoldProd += (global.bossSouls[i] * (i + 1) * 15000);
        global.bossSoulsTotal += global.bossSouls[i];
    }
    
    global.soulsProd *= global.underworldBonus;
    global.underworldXPProd *= global.underworldBonus;
    global.underworldGoldProd *= global.underworldBonus;
    ini_open(string(global.platformDir) + "Village Data/Data.ini");
    ini_write_real("Underworld", "Souls Production", global.soulsProd);
    ini_write_real("Underworld", "XP Production", global.underworldXPProd);
    ini_write_real("Underworld", "Gold Production", global.underworldGoldProd);
    
    for (var ss = 0; ss < 7; ss += 1)
        ini_write_real("Underworld", "Boss Soul " + string(ss), global.bossSouls[ss]);
    
    ini_close();
};
