self.scr_player_ascend = function()
{
    var _className = "";
    
    if (specialized == 0)
        _className = class;
    else
        _className = global.skillSpecialization[classType][specialized - 1];
    
    gml_Script_twitch_chat_say_direct("/me " + string(name) + " has Ascended as a " + string(_className) + "! This character is now in the !!Eternal Realm, please !join the Town again to create a new character.");
    gml_Script_scr_playsound(s_questDone, 0.9, 1.1, 0.6);
    gml_Script_scr_playsound(s_questNew, 0.9, 1.1, 0.6);
    gml_Script_scr_playsound(s_ascend1, 0.9, 1.1, 1);
    gml_Script_scr_playsound(s_ascend2, 0.9, 1.1, 1);
    gml_Script_scr_playsound(s_ascend3, 0.9, 1.1, 1);
    
    with (gml_Script_instance_create(x, y, obj_displayText))
    {
        text1 = "Character Ascension!";
        text2 = string(other.name) + " has Ascended as a " + string(_className) + " (+1 Ascension Level)!";
        text3 = "Best of luck in your new journey.";
        c1 = 4235519;
        alarm[0] = room_speed * 5;
    }
    
    ascended = true;
    tryAscension = false;
    custom_alarm[8][0] = -1;
    ascensionLevel += 1;
    global.totalAscensionLevel += 1;
    ini_open(string(global.platformDir) + "Village Data/Data.ini");
    ini_write_real("Stats", "Total Ascension Level", global.totalAscensionLevel);
    ini_close();
    global.gold += mygold;
    donated += mygold;
    mygold = 0;
    global.gems += myGems;
    donated_gems += myGems;
    myGems = 0;
    global.food += myfood;
    donated_food += myfood;
    myfood = 0;
    honorPoints = 0;
    global.godsFavorStacks += 1;
    
    with (obj_god)
    {
        if (alarm[1] == -1 && alarm[2] == -1 && alarm[3] == -1)
            alarm[0] = room_speed * 120;
    }
    
    ini_open(string(global.platformDir) + string(myAccDir) + "Character Data.ini");
    ini_write_real("Ascensions", "Class " + string(classType) + " Specialization " + string(specialized), 1);
    ini_write_real("Ascensions", "Level", ascensionLevel);
    subClassName = _className;
    ascension[classType][specialized] = 1;
    ini_close();
    ds_list_delete(global.playerList, ds_list_find_index(global.playerList, name));
    ds_list_delete(global.list_notafk, ds_list_find_index(global.list_notafk, name));
    ini_open(string(global.platformDir) + "Core Data/Active Players.ini");
    ini_section_delete(saveNumber);
    ini_write_real("Saved Players", "Last Save", savedMaxPlayers);
    ini_close();
    
    with (obj_warrior)
    {
        if (name == other.name)
            instance_destroy();
    }
    
    directory_destroy(string(global.platformDir) + string(myCharDir));
    ini_open(string(global.platformDir) + string(myAccDir) + "Character Data.ini");
    ini_section_delete("Resources");
    ini_section_delete("Relics");
    ini_section_delete("Portal");
    ini_section_delete("Shop");
    ini_section_delete("Forge");
    ini_section_delete("Red Portal");
    ini_section_delete("Chests");
    ini_close();
    ini_open(string(global.platformDir) + string(myCharDir) + "Data.ini");
    ini_write_real("Misc", "Sub", sub);
    ini_write_real("Misc", "Auto Potion", autoPot);
    ini_write_real("Misc", "Auto Ability", autoAbility);
    ini_write_real("Misc", "Auto Switch", autoSwitch);
    ini_write_real("Misc", "Auto Loot", autoLoot);
    ini_write_real("Misc", "Auto Buy", autoBuy);
    
    for (var i = 0; i < 4; i += 1)
        ini_write_real("Misc", "Auto " + string(i), autoAction[i]);
    
    ini_write_real("Stats", "Honor", honor);
    ini_close();
    var _wasPortal = ds_list_find_index(global.raidListPortalName, string(name));
    var _wasRedPortal = ds_list_find_index(global.raidListRedPortalName, string(name));
    
    if (_wasPortal != -1)
    {
        show_debug_message(string(name) + " was in Portal (pos " + string(_wasPortal) + "), removing from list.");
        ds_list_delete(global.raidListPortalName, _wasPortal);
        ds_list_delete(global.raidListPortalClass, ds_list_find_index(global.raidListPortalClass, string(class)));
    }
    
    if (_wasRedPortal != -1)
    {
        show_debug_message(string(name) + " was in Red Portal (pos " + string(_wasRedPortal) + "), removing from list.");
        ds_list_delete(global.raidListRedPortalName, _wasRedPortal);
        ds_list_delete(global.raidListRedPortalClass, ds_list_find_index(global.raidListRedPortalClass, string(class)));
    }
    
    name = "ascended " + string(name) + " " + string_lower(subClassName);
    displayName = name;
    
    if (string_length(displayName) > 8)
    {
        if (string_pos("ascended ", name) == 1)
        {
            var _oldName = string_delete(displayName, 1, 9);
            displayName = "# " + string_delete(_oldName, 7, 100) + "...";
        }
        else
        {
            displayName = string_delete(displayName, 7, 100) + "...";
        }
    }
    
    myCharDir = "Player Data/" + string(name) + "/Classes/" + string(class) + "/";
    myAccDir = "Player Data/" + string(name) + "/Account/";
    ascensionLevel -= 1;
    
    if (_wasPortal != -1)
    {
        show_debug_message(string(name) + " was in Portal before ascending (pos " + string(_wasPortal) + "), adding to list.");
        ds_list_add(global.raidListPortalName, string(name));
        ds_list_add(global.raidListPortalClass, string(class));
    }
    
    if (_wasRedPortal != -1)
    {
        show_debug_message(string(name) + " was in Red Portal before ascending (pos " + string(_wasRedPortal) + "), adding to list.");
        ds_list_add(global.raidListRedPortalName, string(name));
        ds_list_add(global.raidListRedPortalClass, string(class));
    }
    
    show_debug_message(global.raidListPortalName);
    show_debug_message(global.raidListRedPortalName);
    ini_open(string(global.platformDir) + string(myCharDir) + "Data.ini");
    ini_write_real("Ascension", "Ascended", 1);
    ini_key_delete("Misc", "Auto Loot");
    ini_key_delete("Misc", "Auto Buy");
    autoLoot = false;
    autoBuy = false;
    ini_close();
    ini_open(string(global.platformDir) + string(myAccDir) + "Character Data.ini");
    ini_write_real("Ascensions", "Level", ascensionLevel);
    ini_close();
    ini_open(string(global.platformDir) + "Core Data/Active Players.ini");
    ds_list_add(global.playerList, name);
    ds_list_add(global.list_notafk, name);
    ds_list_sort(global.playerList, true);
    ds_list_sort(global.list_notafk, true);
    
    with (obj_player)
    {
        myNumber = ds_list_find_index(global.playerList, name);
        saveNumber = ds_list_find_index(global.playerList, name);
        ini_write_string(saveNumber, "Name", name);
        ini_write_string(saveNumber, "Class", class);
    }
    
    ini_close();
    gml_Script_scr_savePlayer();
};
