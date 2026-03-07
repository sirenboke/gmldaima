if (gml_Script_live_call())
    return global.live_result;

if (instance_exists(obj_corruptedCard))
{
    with (obj_corruptedCard)
        instance_destroy();
}

global.redPortalOpen = false;
var _choose = 0;
var _votes = 0;
var _amount = 0;

for (var i = 0; i < instance_number(obj_corruptedIsland); i++)
{
    if (instance_find(obj_corruptedIsland, i).votes > _votes)
    {
        _votes = instance_find(obj_corruptedIsland, i).votes;
        _choose = instance_find(obj_corruptedIsland, i).id;
        _amount = _choose.challengeAmount;
    }
}

if (_choose == 0)
{
    _choose = 1;
    
    with (obj_corruptedIsland)
    {
        if (sector == global.corruptedSector && level == global.corruptedLevel)
        {
            if (voteID == _choose)
            {
                votes = 1;
                _choose = id;
                _amount = challengeAmount;
            }
        }
    }
    
    _votes = 1;
}

if (_votes == 0)
{
    accepted = false;
    gml_Script_twitch_chat_say_direct("/me No destination chosen... The Red Portal remains active as you travel back to Town.");
    global.redPortalOpen = true;
    global.redPortalID += 1;
    ds_list_clear(global.raidListRedPortalName);
    ds_list_clear(global.raidListRedPortalClass);
    ini_open(string(global.platformDir) + "Village Data/Data.ini");
    ini_key_delete("Corrupted Dimension", "Red Portal List Names");
    ini_key_delete("Corrupted Dimension", "Red Portal List Classes");
    ini_close();
    alarm[2] = room_speed * 5;
}

if (_votes > 0)
{
    with (gml_Script_instance_create(x, y, obj_stageTransition))
    {
        c1 = 255;
        text1 = "Corrupted Dimension";
        text2 = "Sector " + string(global.corruptedSector) + ":" + string(global.corruptedLevel);
    }
    
    accepted = true;
    gml_Script_twitch_chat_say_direct("/me Traveling to the Corrupted Dimension, Sector " + string(global.corruptedSector) + ":" + string(global.corruptedLevel) + " - " + string(_choose.name) + " (Island " + string(_choose.voteID) + ").");
    
    with (obj_raidCorrupted)
    {
        challengeAmount = _amount;
        
        for (var i = 0; i < _amount; i++)
        {
            challenge[i] = _choose.challenge[i];
            global.globalChallengeValue[i] = _choose.challengeValue[i];
            show_debug_message("Handicaps (" + string(i + 1) + ") " + string(gml_Script_scr_updateChallengeString(challenge[i], global.globalChallengeValue[i])));
        }
        
        alarm[1] = room_speed * 3;
        alarm[11] = (room_speed * 3) - 1;
    }
    
    ds_list_clear(global.islandVoting);
}
