text = string(global.cmdPrefix) + "talent#";
name = "Academy";
mp_grid_add_instances(global.gameGrid, self, 1);
event_inherited();
ini_open(string(global.platformDir) + "Village Data/Data.ini");
level = ini_read_real("Buildings", name + " Level", 1);
cost = ini_read_real("Buildings", name + " Cost", 30000);
oCost = ini_read_real("Buildings", name + " Original Cost", 30000);
cost2 = ini_read_real("Buildings", name + " Cost 2", 0);
oCost2 = ini_read_real("Buildings", name + " Original Cost 2", 0);
global.academyXpBonus = ini_read_real("Buildings", "XP Bonus", 1.05);
ini_close();
costText = gml_Script_scr_bigNumber(cost);

with (obj_academy)
    instance_destroy();
