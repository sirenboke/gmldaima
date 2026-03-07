rewardedPlayers = 0;
var _relicsAmount = amount;
show_debug_message("Special Item Amount: " + string(_relicsAmount));
var _rewardText = string(name) + " obtained by: ";
var _rewardedPlayers = array_create(_relicsAmount, 0);
var _fullList = gml_Script_scr_ds_list_create();
ds_list_copy(_fullList, global.relicList);

for (var i = 0; i < _relicsAmount; i += 1)
{
    var listSize = ds_list_size(global.relicList);
    
    if (listSize > 0)
    {
        choosePlayer = ds_list_find_value(global.relicList, irandom(listSize - 1));
        
        with (obj_player)
        {
            if (name == other.choosePlayer)
            {
                show_debug_message("Relic Drop " + string(i) + " pre-earned by " + string(name) + " | List: " + string(listSize) + " (" + string(_relicsAmount - (i + 1)) + " left).");
                _rewardedPlayers[i] = id;
                ds_list_delete(global.relicList, ds_list_find_index(global.relicList, name));
                
                if (ds_list_size(global.relicList) <= 0)
                    ds_list_copy(global.relicList, _fullList);
            }
        }
    }
    else
    {
        listSize = ds_list_size(global.rewardList);
        choosePlayer = ds_list_find_value(global.rewardList, irandom(listSize - 1));
        
        with (obj_player)
        {
            if (name == other.choosePlayer)
            {
                show_debug_message("Relic Drop " + string(i) + " pre-earned by " + string(name) + " | List: " + string(listSize) + " (" + string(_relicsAmount - (i + 1)) + " left).");
                _rewardedPlayers[i] = id;
            }
        }
    }
}

with (obj_player)
    _amountPlayer = array_create(array_length(_rewardedPlayers), 0);

for (var ii = 0; ii < array_length(_rewardedPlayers); ii++)
{
    with (obj_player)
    {
        if (_rewardedPlayers[ii] == id)
        {
            _amountPlayer[ii] += 1;
            gotUniqueItem[other.itemID] += 1;
            ini_open(string(global.platformDir) + string(myCharDir) + "Data.ini");
            show_debug_message("Relic Drop " + string(ii) + " earned by " + string(name) + ".");
            achievement[13] += 1;
            ini_write_real("Relics", "Got Unique Item " + string(other.itemID), gotUniqueItem[other.itemID]);
            ini_close();
        }
    }
}

with (obj_player)
{
    var _myRewards = 0;
    
    for (var iii = 0; iii < array_length(_rewardedPlayers); iii++)
    {
        if (_amountPlayer[iii] > 0)
            _myRewards += 1;
    }
    
    if (_myRewards > 0)
    {
        var _slotsLeft = 5;
        _rewardText += (string(name) + " (" + string(_slotsLeft) + " spaces for Special Items left).");
        other.rewardedPlayers += 1;
    }
    
    _amountPlayer = 0;
}

gml_Script_twitch_chat_say("/color GoldenRod");
gml_Script_twitch_chat_say_direct("/me " + string(_rewardText));
gml_Script_twitch_chat_say("/color FireBrick");

if (room == r_1)
{
    with (obj_raidResults)
        alarm[0] = room_speed * 15;
    
    obj_raid.alarm[2] = room_speed * 30;
}

if (room == global.room_underworld)
{
    with (obj_raidPortalResults)
        alarm[0] = room_speed * 5;
}

ds_list_clear(global.relicList);
ds_list_clear(global.rewardList);
gml_Script_scr_ds_list_destroy(_fullList);
global.relicDrop = false;
alarm[3] = room_speed * 5;
