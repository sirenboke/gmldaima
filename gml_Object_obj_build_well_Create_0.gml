mp_grid_add_instances(global.gameGrid, self, 1);
event_inherited();
name = "Well";
ini_open(string(global.platformDir) + "Village Data/Data.ini");
global.wellGoldBonus = ini_read_real("Buildings", "Gold Bonus", 0.05);
level = ini_read_real("Buildings", name + " Level", 1);
cost = ini_read_real("Buildings", name + " Cost", 2500);
oCost = ini_read_real("Buildings", name + " Original Cost", 2500);
cost2 = ini_read_real("Buildings", name + " Cost 2", 0);
oCost2 = ini_read_real("Buildings", name + " Original Cost 2", 0);
ini_close();
costText = gml_Script_scr_bigNumber(cost);

with (obj_well)
    instance_destroy();
