global.checkChat -= 1;

if (chatReconnectMsg > 0)
    chatReconnectMsg -= 1;

if (global.checkChat <= 0)
{
    if (global.isTwitch == 1)
    {
        gml_Script_scr_twitch_reconnect_auto();
        global.checkChat = 10;
    }
    
    if (global.isKick == 1)
    {
        gml_Script_scr_kick_reconnect();
        global.checkChat = 600;
    }
}

alarm[2] = room_speed;
