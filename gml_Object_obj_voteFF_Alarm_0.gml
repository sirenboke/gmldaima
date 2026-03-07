var _raidList = 0;
var _type = type;
var _next = "";
var _player = -1;

if (_type == 0)
{
    with (obj_warrior)
    {
        if (raidList == global.raidList0 && myRaidNumber <= 0)
        {
            _player = id;
            _raidList = global.raidListMelee;
        }
    }
}

if (_type == 1)
{
    with (obj_warrior)
    {
        if (raidList == global.raidList1 && myRaidNumber <= 0)
        {
            _player = id;
            _raidList = global.raidListRanged;
        }
    }
}

votedPlayer = _player;

if (ds_list_size(_raidList) <= 1)
{
    gml_Script_twitch_chat_say("/me " + string(voteName) + " not enough players to vote switching!");
    instance_destroy();
    exit;
}

var _currentIndex = 0;

for (var i = 0; i < ds_list_size(_raidList); i++)
{
    var _entry = ds_list_find_value(_raidList, i);
    
    with (obj_warrior)
    {
        if (id == _player)
        {
            if (string_pos(name, _entry) > 0)
                _currentIndex = i;
        }
    }
}

var _nextIndex = (_currentIndex + 1) % ds_list_size(_raidList);
var _nextName = ds_list_find_value(_raidList, _nextIndex);
var _nextInstance = -4;

with (obj_warrior)
{
    if (id != _player)
    {
        var _sameType = (_type == 0 && raidList == global.raidList0) || (_type == 1 && raidList == global.raidList1);
        
        if (_sameType && string_pos(name, _nextName) > 0)
            _nextInstance = id;
    }
}

next = (_nextInstance != -4) ? _nextInstance.name : _nextName;
var _fullList = "";

for (var i = 0; i < (ds_list_size(_raidList) - 1); i++)
{
    _next[i] = ds_list_find_value(_raidList, i);
    _fullList += (", " + string(_next[i]));
}

show_debug_message("Vote switch name: " + string(_fullList));

if (_player != -1)
{
    gml_Script_scr_playsound(s_playerSpawn, 0.9, 1.1, 0.5);
    gml_Script_twitch_chat_say_direct("/me " + string(voteName) + " proposes to switch " + string(_player.name) + " with " + string(next) + ". Type " + string(global.cmdPrefix) + "y to accept or " + string(global.cmdPrefix) + "n to oppose (Need " + string(minVotes) + " votes to accept/cancel this action). [" + string(round(alarm[1] / room_speed)) + "s left]");
}
else
{
    gml_Script_scr_ds_list_destroy(voteList);
    instance_destroy();
}
