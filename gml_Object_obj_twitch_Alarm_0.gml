if (global.inFinalWar == false)
{
    ini_open(string(global.platformDir) + "Village Data/Data.ini");
    var _finisHP = ini_read_real("Underworld", "Final Boss HP", 0);
    
    if (_finisHP > 0)
    {
        _finisHP *= 1.1;
        ini_write_real("Underworld", "Final Boss HP", _finisHP);
    }
    
    ini_close();
    gml_Script_twitch_chat_say("/color YellowGreen");
    gml_Script_twitch_chat_say_direct("/me Saving progress... room00ZZZ");
    gml_Script_twitch_chat_say("/color FireBrick");
    
    with (obj_player)
    {
        if (ds_list_find_index(global.finalWarListName, name) == -1)
        {
            ds_list_add(global.finalWarListName, name);
            ds_list_add(global.finalWarListClass, class);
        }
    }
    
    gml_Script_scr_updateBuildings();
    gml_Script_scr_savegame();
}

alarm[0] = room_speed * 3600;
