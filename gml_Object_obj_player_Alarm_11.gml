obj_gameControl.alarm[5] = 1;
obj_gameControl.showPlayers = 0;
global.cardTurn = 1;
global.cardTurnNext = 2;
ds_list_delete(global.playerList, ds_list_find_index(global.playerList, name));
ds_list_delete(global.list_notafk, ds_list_find_index(global.list_notafk, name));
global.totalPlayers -= 1;
savedMaxPlayers = global.totalPlayers - 1;
ini_open(string(global.platformDir) + "Core Data/Active Players.ini");
ini_section_delete(saveNumber);
ini_write_real("Saved Players", "Last Save", savedMaxPlayers);
ini_close();

if (ds_list_find_index(obj_build_mine.mineList, id) != -1)
{
    var minePos = ds_list_find_index(obj_build_mine.mineList, id);
    ds_list_delete(obj_build_mine.mineList, minePos);
}

if (ds_list_find_index(obj_build_farm.farmList, id) != -1)
{
    var minePos = ds_list_find_index(obj_build_farm.farmList, id);
    ds_list_delete(obj_build_farm.farmList, minePos);
}

if (ds_list_find_index(obj_build_train.trainList, id) != -1)
{
    var minePos = ds_list_find_index(obj_build_train.trainList, id);
    ds_list_delete(obj_build_train.trainList, minePos);
}

with (myCard)
    instance_destroy();

with (obj_warrior)
{
    if (name == other.name)
        instance_destroy();
}

if (ds_list_find_index(global.raidListPortalName, name) == -1)
{
    if (global.chatSpam <= 2 && toPortal == false)
        gml_Script_twitch_chat_say("/me " + string(name) + " just left, see you soon!");
}

if (class == "farmer")
{
    global.farmerBonus -= (1 * (1 + myTier));
    
    if (global.farmerBonus < 0)
        global.farmerBonus = 0;
    
    global.farmerNumber -= 1;
}

if (class == "warrior")
    global.warriorNumber -= 1;

if (class == "rogue")
    global.rogueNumber -= 1;

if (class == "mage")
    global.wizardNumber -= 1;

if (class == "archer")
    global.rangerNumber -= 1;

with (gml_Script_instance_create(x, y - (height / 2), obj_smokeAnimation))
    sprite_index = spr_smokeBomb;

gml_Script_scr_playsound(s_quit, 0.9, 1.1, 1);
gml_Script_scr_updateBuildings();
instance_destroy();
ds_list_sort(global.playerList, true);
ini_open(string(global.platformDir) + "Core Data/Active Players.ini");

with (obj_player)
{
    myNumber = ds_list_find_index(global.playerList, name);
    saveNumber = ds_list_find_index(global.playerList, name);
    ini_write_string(saveNumber, "Name", name);
    ini_write_string(saveNumber, "Class", class);
}

ini_close();
