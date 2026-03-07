var _text = "";
var _amount = global.towerBuilding[3][1];
show_debug_message("Relic Enchanter activated, upgrading a random Relic for " + string(_amount) + " levels (prioritize equipped).");
_text = "/me Underworld's ?Tower 3 " + string(global.towerBuilding[3][0]) + " (lv." + string(global.towerBuilding[3][4]) + ") enchanted a random Relic " + string(global.towerBuilding[3][1]) + " times! (prioritizes equipped,";

with (obj_player)
{
    if (ascended == false)
    {
        var _gotRelics = 0;
        
        for (var i = 1; i < global.maxUniqueItems; i++)
        {
            if (gotUniqueItem[i] > 0)
            {
                _gotRelics = 1;
                break;
            }
        }
        
        if (_gotRelics == 0)
        {
            var _relic = irandom_range(1, global.maxUniqueItems);
            gotUniqueItem[_relic] += 1;
            uniqueItemLevel[_relic] += _amount;
            _text += (" " + string(name) + ": R" + string(_relic) + ",");
            show_debug_message(string(name) + " Had no relics, gave and upgraded Relic " + string(_relic) + " for " + string(_amount) + " levels.");
        }
        else
        {
            var _equippedRelics = 0;
            
            for (var i = 0; i < 5; i++)
            {
                if (uniqueSlot[i] != 0)
                {
                    _equippedRelics = 1;
                    break;
                }
                
                if (myPetID != 0)
                {
                    if (petRelicSlot[myPetID][i] != 0)
                    {
                        _equippedRelics = 1;
                        break;
                    }
                }
            }
            
            if (_equippedRelics == 0)
            {
                var _checkRelic = -1;
                
                do
                {
                    _checkRelic = irandom_range(1, global.maxUniqueItems);
                    show_debug_message(string(name) + " checking Relic " + string(_checkRelic) + " (has at least 1 Relic, checking one that is owned).");
                }
                until (gotUniqueItem[_checkRelic] > 0);
                
                uniqueItemLevel[_checkRelic] += _amount;
                _text += (" " + string(name) + ": R" + string(_checkRelic) + ",");
                show_debug_message(string(name) + " Successfully enchanted Relic " + string(_checkRelic) + " for " + string(_amount) + " levels.");
            }
            else
            {
                var _checkRelic = -1;
                
                if (myPetID == 0)
                {
                    do
                    {
                        _checkRelic = irandom_range(1, global.maxUniqueItems);
                        show_debug_message(string(name) + " checking Relic " + string(_checkRelic) + " (doesnt have a Pet equipped, checking one that is equipped).");
                    }
                    until (equippedUniqueItem[_checkRelic] == 1);
                    
                    uniqueItemLevel[_checkRelic] += _amount;
                    _text += (" " + string(name) + ": R" + string(_checkRelic) + ",");
                    show_debug_message(string(name) + " Successfully enchanted Relic " + string(_checkRelic) + " for " + string(_amount) + " levels.");
                }
                else
                {
                    do
                    {
                        _checkRelic = irandom_range(1, global.maxUniqueItems);
                        show_debug_message(string(name) + " checking Relic " + string(_checkRelic) + " (has a Pet equipped, checking one that is equipped or in Pet).");
                    }
                    until (equippedUniqueItem[_checkRelic] == 1 || myPetEquippedRelic[myPetID][_checkRelic] == 1);
                    
                    uniqueItemLevel[_checkRelic] += _amount;
                    _text += (" " + string(name) + ": R" + string(_checkRelic) + ",");
                    show_debug_message(string(name) + " Successfully enchanted Relic " + string(_checkRelic) + " for " + string(_amount) + " levels.");
                }
            }
        }
    }
}

_text = string_delete(_text, string_length(_text), 1);
_text += ").";
gml_Script_twitch_chat_say_direct(_text);
show_debug_message("Relic Enchanter activated.");
alarm[3] = global.towerBuilding[3][2] * room_speed;
