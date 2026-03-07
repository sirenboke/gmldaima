text = "";
name = "Creature Keeper";
global.keeperBuilt = 1;
mp_grid_add_instances(global.gameGrid, self, 1);
event_inherited();

with (obj_townTree)
{
    if (distance_to_point(other.x, other.y) < 200)
        instance_destroy();
}

with (obj_townBush)
{
    if (distance_to_point(other.x, other.y) < 200)
        instance_destroy();
}

ini_open(string(global.platformDir) + "Village Data/Data.ini");
level = ini_read_real("Buildings", name + " Level", 1);
cost = ini_read_real("Buildings", name + " Cost", 2000000000);
oCost = ini_read_real("Buildings", name + " Original Cost", 2000000000);
cost2 = ini_read_real("Buildings", name + " Cost 2", 0);
oCost2 = ini_read_real("Buildings", name + " Original Cost 2", 0);
goldCost = ini_read_real("Buildings", name + " Gold Cost", 1000 * level);
foodCost = ini_read_real("Buildings", name + " Food Cost", 5000 * level);
costText = gml_Script_scr_bigNumber(cost);
eggchosen = ini_read_real("Buildings", name + " Egg", -1);
eggstage = ini_read_real("Buildings", name + " Egg Stage", -1);
hatchtimer = ini_read_real("Buildings", name + " Egg Timer", room_speed * 14400);
hatched = false;
petStat[0][0] = "Dragon";
petStat[1][0] = "Phoenix";
petStat[2][0] = "Golem";
ini_close();
eggAnimation = eggShake;
anpos = 0;
anspeed = 0.005;
eggText[0] = "The egg feels warm...";
eggText[1] = "The egg is wiggling...";
eggText[2] = "The egg is emitting sounds...";
eggText[3] = "The egg has some new cracks...";
eggTextAmount = array_length(eggText) - 1;
gml_Script_scr_alarm_initialize(2);
gml_Script_scr_alarm_start(0, room_speed, gml_Script_scr_creatureKeeper_train);

with (obj_creatureKeeper)
    instance_destroy();
