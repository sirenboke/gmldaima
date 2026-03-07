self.scr_twitch_reconnect_auto = function()
{
    gml_Script_twitch_chat_disconnect();
    gml_Script_twitch_free();
    alarm[3] = room_speed;
};
