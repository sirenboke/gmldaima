if (room != r_seasonEnd)
{
    if (ds_list_size(global.list_notafk) > 0 && showTownStats == 0)
        showPlayers = 1;
    else
        showTownStats = 1;
    
    if (showPlayers == 1)
    {
        var _player = ds_list_find_value(global.list_notafk, global.cardTurn);
        global.cardTurn += 1;
        
        if (ds_list_find_index(global.list_notafk, _player) != -1)
        {
            with (obj_playerCard)
            {
                myTurn = false;
                
                if (player.name == _player)
                    myTurn = true;
            }
        }
    }
    
    global.cardTurnNext = string(ds_list_find_value(global.list_notafk, global.cardTurn + 1));
    
    if (global.cardTurnNext == "0")
        global.cardTurnNext = customDisplayTab[0];
    
    if (showPlayers == 1 && (global.cardTurn >= ds_list_size(global.list_notafk) || ds_list_size(global.list_notafk) == 0))
    {
        showPlayers = 0;
        showTownStats = 1;
        global.cardTurn = -1;
    }
    
    if (showTownStats == 1)
    {
        if (global.cardTurn < customTabs)
        {
            global.cardTurn += 1;
            
            if (global.cardTurn == customTabs)
            {
                if (ds_list_size(global.list_notafk) > 0)
                    global.cardTurnNext = string(ds_list_find_value(global.list_notafk, 0));
                else
                    global.cardTurnNext = customDisplayTab[0];
            }
            else
            {
                global.cardTurnNext = customDisplayTab[global.cardTurn + 1];
            }
        }
        else
        {
            global.cardTurn = 0;
            
            if (ds_list_size(global.list_notafk) > 0)
            {
                global.cardTurnNext = string(ds_list_find_value(global.list_notafk, 0));
                showPlayers = 1;
                showTownStats = 0;
            }
            else
            {
                global.cardTurnNext = customDisplayTab[0];
                showPlayers = 0;
                showTownStats = 1;
            }
        }
    }
    
    if (showTownStats == 0)
    {
        global.cardTurnNext = string(ds_list_find_value(global.list_notafk, global.cardTurn));
        
        if (global.cardTurnNext == "0")
            global.cardTurnNext = string(ds_list_find_value(global.list_notafk, 0));
    }
    
    if (showPlayers == 1 && string_length(global.cardTurnNext) > 8)
        global.cardTurnNext = string_delete(global.cardTurnNext, 7, 100) + "...";
    
    if (showTownStats == 1)
    {
        alarm[5] = room_speed * 20;
    }
    else
    {
        alarm[1] = (room_speed * 10) / 3;
        alarm[5] = room_speed * 20;
    }
}
