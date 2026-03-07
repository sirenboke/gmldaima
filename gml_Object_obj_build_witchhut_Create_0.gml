move_snap(2, 2);
text = string(global.cmdPrefix) + "give souls";
name = "Witch Hut";
image_speed = 0;
image_index = 1;
ini_open(string(global.platformDir) + "Village Data/Data.ini");
level = ini_read_real("Buildings", name + " Level", 1);
cost = ini_read_real("Buildings", name + " Cost", 10000);
oCost = ini_read_real("Buildings", name + " Original Cost", 10000);
cost2 = 0;
oCost2 = 0;
global.soulBonus = ini_read_real("Witch", "Souls Bonus", 1);
alarm[0] = ini_read_real("Witch", "Recipe Duration", -1);
ini_close();
costText = gml_Script_scr_bigNumber(cost);
global.gotWitch = true;
gemDisplay = 1;
displayTab = 0;
obj_gameControl.alarm[0] = room_speed;

if (global.souls == 0)
{
    gml_Script_twitch_chat_say("/color BlueViolet");
    gml_Script_twitch_chat_say_direct("/me You found the secret Witch hut! The !!witch was hoping for you to be strong enough to complete the mysterious Town Portal, and now that you've demonstrated your courage, she will grant you help if you are willing to liberate the mythical creatures that are being kept captive in the Underworld by an evil force.");
    gml_Script_twitch_chat_say_direct("/me You can now !!enchant Relics, use the !!Underworld Portal and capture demons' souls when defeating them.");
    gml_Script_twitch_chat_say("/color FireBrick");
}

event_inherited();
depth = -100;

with (obj_witchHut)
    instance_destroy();
