forgeItem[0][0] = 0;
global.globalForgeID += 1;

with (obj_player)
    forgedItem = clamp(round(obj_build_forge.level / 3), 1, 6);

ini_open(string(global.platformDir) + "Village Data/Data.ini");
ini_write_real("Buildings", "Forge ID", global.globalForgeID);
ini_close();
