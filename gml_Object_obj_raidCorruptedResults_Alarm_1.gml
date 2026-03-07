var _choose = 0;
var _votes = 0;
var _amount = 0;

for (var i = 0; i < instance_number(obj_corruptedCard); i++)
{
    if (instance_find(obj_corruptedCard, i).votes > _votes)
    {
        _votes = instance_find(obj_corruptedCard, i).votes;
        _choose = instance_find(obj_corruptedCard, i).id;
        _amount = _choose.rewardAmount;
    }
}

if (_choose == 0)
{
    _choose = irandom(2);
    
    with (obj_corruptedCard)
    {
        if (myID == _choose)
        {
            votes = 1;
            _choose = id;
            _amount = rewardAmount;
        }
    }
}

for (var k = 0; k < _amount; k++)
{
    reward[k] = _choose.reward[k];
    rewardText[k] = _choose.rewardText[k];
    rewardValue[k] = _choose.rewardValue[k];
    var _mainReward = reward[k];
    
    with (obj_corruptedControl)
        corruptedReward[_mainReward][3] += 1;
    
    if (reward[k] == 10)
        global.bloodgems += 3;
    
    if (reward[k] == 11)
        global.gems += 500;
    
    show_debug_message("Aplicando corrupted modifiers " + string(k) + " | texto: " + rewardText[k] + " | value: " + string(rewardValue[k]));
}

gml_Script_scr_updateCorruptionShards();
var _rewardText = "";

for (var i = 0; i < _amount; i++)
    _rewardText += (string(rewardText[i]) + ",");

_rewardText = string_delete(_rewardText, string_last_pos(",", _rewardText), 1);
gml_Script_twitch_chat_say_direct("/me You consumed a " + string(_choose.name) + " and obtained its powers! (" + string(_rewardText) + ").");

with (obj_corruptedCard)
    alarm[2] = 1;

alarm[0] = room_speed;
