self.scr_twitch_reconnect = function()
{
    gml_Script_twitch_chat_disconnect();
    gml_Script_twitch_free();
    alarm[1] = room_speed;
};
