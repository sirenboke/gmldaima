self.net_client_events = function()
{
    show_debug_message("Buffer received!");
    var data = argument[0];
    var event = buffer_read(data, buffer_u8);
    
    switch (event)
    {
        case 0:
            var listString = buffer_read(data, buffer_string);
            file_delete(string(global.platformDir) + "Core Data/List CLIENT.ini");
            ini_open(string(global.platformDir) + "Core Data/List CLIENT.ini");
            ini_write_string("Subscribers", "Names", listString);
            ini_close();
            show_debug_message("Subscriber List received: " + string(listString));
            
            if ((global.premiumChannel == 1 && global.channelName != "situ") || global.premiumChannel == 0)
            {
                ds_list_clear(global.subList);
                ds_list_read(global.subList, listString);
                file_delete(string(global.platformDir) + "Core Data/Subscriber List.ini");
            }
            
            show_debug_message(listString);
            ini_open(string(global.platformDir) + "Core Data/Subscriber List.ini");
            
            for (var i = 0; i < ds_list_size(global.subList); i++)
            {
                saveSubName[i] = ds_list_find_value(global.subList, i);
                show_debug_message(string(saveSubName[i]) + " is subbed");
                ini_write_real("Subscribers", string_lower(saveSubName[i]), 1);
            }
            
            ini_close();
            file_delete(string(global.platformDir) + "Core Data/Premium List CLIENT.ini");
            var premiumListString = buffer_read(data, buffer_string);
            ini_open(string(global.platformDir) + "Core Data/Premium List CLIENT.ini");
            ini_write_string("Premiums", "Names", premiumListString);
            ini_close();
            show_debug_message("Premium List received: " + string(premiumListString));
            ds_list_clear(global.premiumList);
            ds_list_read(global.premiumList, premiumListString);
            show_debug_message(premiumListString);
            file_delete(string(global.platformDir) + "Core Data/Premium List.ini");
            ini_open(string(global.platformDir) + "Core Data/Premium List.ini");
            
            for (var i = 0; i < ds_list_size(global.premiumList); i++)
            {
                savePremiumName[i] = ds_list_find_value(global.premiumList, i);
                ini_write_real("Premiums", string_lower(savePremiumName[i]), 1);
            }
            
            ini_close();
            
            if (ds_list_find_index(global.premiumList, string(global.channelName)) != -1)
            {
                show_debug_message(string(global.channelName) + " is premium");
                global.premiumChannel = 1;
            }
            else
            {
                show_debug_message(string(global.channelName) + " is not premium");
                global.premiumChannel = 0;
            }
            
            if (global.channelName == "room_001" || global.channelName == "erohzify")
                global.premiumChannel = 1;
            
            if (room == r_1)
            {
                with (obj_player)
                    gml_Script_scr_playerUnsubscribe(name);
                
                for (var i = 0; i < ds_list_size(global.subList); i++)
                {
                    saveSubName[i] = ds_list_find_value(global.subList, i);
                    
                    with (obj_player)
                    {
                        if (string_lower(other.saveSubName[i]) == string_lower(name))
                            gml_Script_scr_playerSubscribe(name);
                    }
                }
            }
            
            break;
        
        case 1:
            global.newVersion = buffer_read(data, buffer_u16);
            
            if (instance_exists(obj_continue))
            {
                if (global.gameVersion != global.newVersion)
                    instance_create_depth(obj_continue.x, obj_continue.y + 80, obj_continue.depth, obj_update);
            }
            
            break;
        
        case 2:
            break;
        
        case 3:
            var stringList = buffer_read(data, buffer_string);
            var playerAmount = buffer_read(data, buffer_u8);
            ini_open(string(global.platformDir) + "Core Data/Server Data/Full Client Data String.ini");
            ini_write_string("Data", "Full List String", stringList);
            ini_close();
            show_debug_message("STRING LIST RAW: " + string(stringList));
            show_debug_message("PLAYER AMOUNT: " + string(playerAmount));
            ds_list_read(global.playerListStrings, stringList);
            show_debug_message("Complete player data bellow:");
            
            for (var i = 0; i < playerAmount; i++)
            {
                var _player;
                _player[i] = string(ds_list_find_value(global.playerListStrings, i));
                var _playerJSON;
                _playerJSON[i] = base64_decode(_player[i]);
                show_debug_message("Player " + string(i) + ": " + _player[i]);
                show_debug_message("Player " + string(i) + ": " + _playerJSON[i]);
            }
            
            break;
    }
    
    if (buffer_exists(global.buffer))
        buffer_delete(global.buffer);
    
    var buffSize = 1;
    var buffType = 1;
    var buffAlign = 1;
    global.buffer = buffer_create(buffSize, buffType, buffAlign);
};
