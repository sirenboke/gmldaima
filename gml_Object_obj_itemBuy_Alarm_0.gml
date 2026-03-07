var _amount = amount;
var _cost = cost;
var _image_index = image_index;
var _number = number;

if (itemType == 1)
{
    with (obj_player)
    {
        if (autoBuy == true && afkdraw == false)
        {
            if (favoriteRelics[_image_index] == 1)
            {
                if (boughtItem[_number] > 0)
                {
                    if (class == "farmer")
                        _cost = 1;
                    
                    if (myGems > (_cost * _amount))
                    {
                        show_debug_message(string(name) + " autobought an item.");
                        myGems -= (_cost * _amount);
                        boughtItem[_number] -= _amount;
                        gotUniqueItem[_image_index] += _amount;
                        gml_Script_scr_townXP(round(2 * _amount) * 1000000);
                        ini_open(string(global.platformDir) + string(myAccDir) + "Character Data.ini");
                        ini_write_real("Resources", "Gems", myGems);
                        ini_write_real("Shop", "Bought Item " + string(_number), boughtItem[_number]);
                        ini_close();
                        ini_open(string(global.platformDir) + string(myCharDir) + "Data.ini");
                        ini_write_real("Relics", "Got Unique Item " + string(_image_index), gotUniqueItem[_image_index]);
                        ini_close();
                        
                        with (gml_Script_instance_create(x, y, obj_playSound))
                        {
                            maxTimes = _amount;
                            sound = "buy";
                        }
                        
                        if (global.chatSpam <= 1)
                            gml_Script_twitch_chat_say("/me " + string(name) + " has automatically bought (" + string(_amount) + "x) Relic " + string(_image_index) + " (" + string(global.uniqueItem[_image_index][0]) + ") for " + string(_cost * _amount) + " room00Gem from the Town Shop! (Got " + string(gotUniqueItem[_image_index]) + " units and " + gml_Script_scr_bigNumber(myGems) + " room00Gem left).");
                    }
                }
            }
        }
    }
}
