mp_grid_add_instances(global.gameGrid, self, 1);
event_inherited();
name = "Forge";
ini_open(string(global.platformDir) + "Village Data/Data.ini");
level = ini_read_real("Buildings", "Forge Level", 1);
global.maxRelicCorruption = 1.5 + clamp((level - 20) / 10, 0, 10);
forgingLevel = level;
forgeItemAmount = clamp(round(level / 3), 1, 6);

if (level < 14)
    forgeRelicAmount = 0;
else
    forgeRelicAmount = (level - 13) * 2;

if (forgingLevel > 13)
    forgingLevel = 13;

forgeItem[0][0] = ini_read_real("Forge", "Forge Item Progress", 0);
forgeItem[0][1] = 50 + power(forgingLevel * 20, 2);
forgeItem[0][2] = 100 + round((power(forgingLevel, 6) + (forgingLevel * 30)) * power(1 + forgingLevel, 2));
forgeItem[1][0] = ini_read_real("Forge", "Forge Relic Progress", 0);
forgeItem[1][1] = 50;
forgeItem[1][2] = 2;

if (forgeItem[0][0] >= forgeItem[0][1])
    alarm[0] = ini_read_real("Forge", "Forge Item Duration", -1);

if (forgeItem[1][0] >= forgeItem[1][1])
    alarm[1] = ini_read_real("Forge", "Forge Relic Duration", -1);

forgeItemText[0][2] = string(gml_Script_scr_bigNumber(floor(forgeItem[0][2])) + "g");

if (forgeItem[0][2] >= 1000 && forgeItem[0][2] < 1000000)
{
    forgeItem[0][2] = floor(forgeItem[0][2] / 1000) * 1000;
    forgeItemText[0][2] = string(gml_Script_scr_bigNumber(floor(forgeItem[0][2] / 1000)) + "k");
}

if (forgeItem[0][2] >= 1000000)
{
    forgeItem[0][2] = floor(forgeItem[0][2] / 1000000) * 1000000;
    forgeItemText[0][2] = string(gml_Script_scr_bigNumber(floor(forgeItem[0][2] / 1000000)) + "M");
}

global.forgePitch = 0.5;
cost = ini_read_real("Buildings", name + " Cost", 15000);
oCost = ini_read_real("Buildings", name + " Original Cost", 15000);
cost2 = ini_read_real("Buildings", name + " Cost 2", 0);
oCost2 = ini_read_real("Buildings", name + " Original Cost 2", 0);
ini_close();
costText = gml_Script_scr_bigNumber(cost);
alarm[11] = room_speed * 60;
gml_Script_instance_create(x + 110, y + 40, obj_weaponStand);

with (obj_blacksmith)
    instance_destroy();
