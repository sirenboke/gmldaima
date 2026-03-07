forgeItem[1][0] = 0;
global.globalReforgeID += 1;

with (obj_player)
    forgedRelic = (obj_build_forge.level - 13) * 2;

ini_open(string(global.platformDir) + "Village Data/Data.ini");
ini_write_real("Buildings", "Reforge ID", global.globalReforgeID);
ini_close();
