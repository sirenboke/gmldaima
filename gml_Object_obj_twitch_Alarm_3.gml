gml_Script_twitch_init("3nsrr6vwm5aj87n2h61miur0byinas");
gml_Script_twitch_chat_connect(string(global.channelName), string(global.userName), string(global.userOAuth));

if (chatReconnectMsg == 0)
{
    gml_Script_twitch_chat_say("/color YellowGreen");
    gml_Script_twitch_chat_say_direct("/me Chat reconnected!");
    gml_Script_twitch_chat_say("/color FireBrick");
}

chatReconnectMsg = 300;
