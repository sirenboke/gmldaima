if (room != r_seasonEnd)
{
    if (global.cardTurn > (ds_list_size(global.list_notafk) + customTabs))
        global.cardTurn = 0;
    
    if (ds_list_size(global.list_notafk) > 0 && global.cardTurn < ds_list_size(global.list_notafk))
    {
        showPlayers = 1;
    }
    else
    {
        showPlayers = 0;
        
        with (obj_camera)
            focusPlayer = -1;
    }
    
    if (showPlayers == 1)
    {
        var _player = ds_list_find_value(global.list_notafk, global.cardTurn);
        
        if (ds_list_find_index(global.list_notafk, _player) != -1)
        {
            with (obj_playerCard)
            {
                myTurn = false;
                
                if (player.name == _player)
                    myTurn = true;
                
                with (obj_camera)
                    focusPlayer = _player;
            }
        }
    }
    
    global.cardTurnNext = string(ds_list_find_value(global.list_notafk, global.cardTurn + 1));
    
    if (global.cardTurnNext == "undefined")
        global.cardTurnNext = customDisplayTab[0];
    else if (string_length(global.cardTurnNext) > 8)
        global.cardTurnNext = string_delete(global.cardTurnNext, 7, 100) + "...";
    
    if (showPlayers == 0)
    {
        if (global.cardTurn >= (ds_list_size(global.list_notafk) + customTabs))
        {
            if (ds_list_size(global.list_notafk) > 0)
            {
                global.cardTurnNext = string(ds_list_find_value(global.list_notafk, 0));
                
                if (string_length(global.cardTurnNext) > 8)
                    global.cardTurnNext = string_delete(global.cardTurnNext, 7, 100) + "...";
            }
            else
            {
                global.cardTurnNext = customDisplayTab[0];
            }
        }
        else
        {
            global.cardTurnNext = customDisplayTab[(global.cardTurn - ds_list_size(global.list_notafk)) + 1];
        }
    }
    
    global.cardTurn += 1;
    
    if (showPlayers == 0)
    {
        alarm[5] = room_speed * 20;
    }
    else
    {
        alarm[1] = (room_speed * 10) / 3;
        alarm[5] = room_speed * 20;
    }
}
