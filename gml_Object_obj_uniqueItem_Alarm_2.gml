var _x = 0;
var _autoLootText = "";

for (var i = 0; i < ds_list_size(global.rewardList); i++)
{
    var _checkAutoLoot;
    _checkAutoLoot[i] = ds_list_find_value(global.rewardList, i);
    
    with (obj_player)
    {
        if (name == _checkAutoLoot[i])
        {
            if (ascended == false && autoLoot == true)
            {
                if (favoriteRelics[other.itemID] == 1)
                {
                    var _getAutoLoot;
                    _getAutoLoot[_x] = id;
                    _x += 1;
                    _autoLootText += (" " + string(name) + ",");
                    
                    if (ds_list_find_index(global.relicList, name) == -1)
                        ds_list_add(global.relicList, name);
                }
            }
        }
    }
}

if (_autoLootText != "")
{
    _autoLootText = string_insert(" (Automatically participating:", _autoLootText, 1);
    _autoLootText = string_delete(_autoLootText, -1, 1) + ")";
}

gml_Script_twitch_chat_say("/color GoldenRod");
gml_Script_twitch_chat_say_direct("/me You found " + string(amount) + "x " + string(name) + "! (Relic " + string(itemID) + ") Type " + string(global.cmdPrefix) + "loot to have a chance to get it" + string(_autoLootText) + ".");
gml_Script_twitch_chat_say("/color FireBrick");
