move_snap(2, 2);
text = string(global.cmdPrefix) + "rest";
name = "Inn";
image_xscale = -1;
depth = -100;
ini_open(string(global.platformDir) + "Village Data/Data.ini");
level = ini_read_real("Buildings", name + " Level", 1);
cost = ini_read_real("Buildings", name + " Cost", 2000);
oCost = ini_read_real("Buildings", name + " Original Cost", 2000);
cost2 = ini_read_real("Buildings", name + " Cost 2", 0);
oCost2 = ini_read_real("Buildings", name + " Original Cost 2", 0);
afks = 0;
afkicon = 0;
global.maxGold = ini_read_real("Stats", "Max Food", 2000);
global.maxFood = ini_read_real("Stats", "Max Gold", 2000);
ini_close();

if (global.maxGold < global.maxNumber)
    costText = gml_Script_scr_bigNumber(cost);
else
    costText = "Maximum Level";
