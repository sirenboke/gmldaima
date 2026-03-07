ini_open(string(global.platformDir) + "Core Data/Permanent.ini");
global.godLevel = ini_read_real("God", "Level", 1);

if (global.godLevel > 50)
    global.godLevel = 50;

global.godResourceBonus = 1 + (global.godLevel / 50);
global.bonanzaBonus = 1;
global.godsDmgBonus = 0;
global.godMaxXP = global.godLevel * 500000000000;
global.godXP = ini_read_real("God", "XP", 0);
global.godsHonor = ini_read_real("God", "Favor Progress", 0);
global.godsHonorMax = ini_read_real("God", "Favor Max", 50);
global.godsHonorMax -= (global.godLevel / 10);

if (global.godsHonor >= global.godsHonorMax)
    global.godsHonor = 0;

global.godsFavorStacks = ini_read_real("God", "Favor Stacks", 0);
ini_close();
timer = room_speed * (random_range(5000, 10000) - (global.godLevel * 10));

if (timer < (120 * room_speed))
    timer = room_speed * random_range(120, 300);

raidsLeft = 0;
gml_Script_scr_alarm_initialize(2);
