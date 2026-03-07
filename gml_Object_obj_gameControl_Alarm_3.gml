ini_open(string(global.platformDir) + "Village Data/Data.ini");
ini_key_delete("Buildings", "Chest 1 Gold");
ini_key_delete("Buildings", "Chest 1 Gems");
ini_key_delete("Buildings", "Chest 2 XP");
ini_key_delete("Buildings", "Chest 2 TP");
ini_key_delete("Buildings", "Chest 3 Relic 1 Type");
ini_key_delete("Buildings", "Chest 3 Relics 1");
ini_key_delete("Buildings", "Chest 3 Relic 2 Type");
ini_key_delete("Buildings", "Chest 3 Relics 2");
ini_key_delete("Buildings", "Key List");
ini_close();
ds_map_clear(global.keyMap);
global.chestID[1] += 1;
global.chestID[2] += 1;
global.chestID[3] += 1;
global.globalRewardID += 1;
alarm[4] = chestTimer;

with (obj_player)
{
    ini_open(string(global.platformDir) + string(myAccDir) + "Character Data.ini");
    useChest = 0;
    ini_write_real("Chests", "Chest Uses", useChest);
    ini_write_real("Chests", "Chest 1 ID", -1);
    ini_write_real("Chests", "Chest 1 ID", -1);
    ini_write_real("Chests", "Chest 2 ID", -1);
    ini_write_real("Chests", "Chest 3 ID", -1);
    ini_close();
}

ini_open(string(global.platformDir) + "Village Data/Data.ini");
ini_write_real("Guilds", "Chest Reward ID", global.globalRewardID);
ini_write_real("Guilds", "Chest 1 ID", global.chestID[1]);
ini_write_real("Guilds", "Chest 2 ID", global.chestID[2]);
ini_write_real("Guilds", "Chest 3 ID", global.chestID[3]);
ini_close();
gml_Script_twitch_chat_say("/color GoldenRod");
gml_Script_twitch_chat_say_direct("/me Reward Chests closed!");
gml_Script_twitch_chat_say("/color FireBrick");
