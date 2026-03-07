randomize();
ini_open(string(global.platformDir) + "Core Data/Login.ini");
global.channelName = ini_read_string("Login", "User Name", "");
global.userName = "room_001";
global.userOAuth = "oauth:3m3g7bx7px1ib36w6ic9ye76xtpcj2";
ini_close();
alarm[0] = room_speed * 3600;
global.checkChat = 600;
chatReconnectMsg = 0;
alarm[2] = room_speed;
global.closing = false;

with (gml_Script_instance_create(x, y, obj_subControl))
{
    alarm[0] = 1;
    alarm[1] = room_speed;
}

if (global.isTwitch == 1)
{
    gml_Script_twitch_init("3nsrr6vwm5aj87n2h61miur0byinas");
    gml_Script_twitch_chat_connect(string(global.channelName), string(global.userName), string(global.userOAuth));
}

if (global.isKick == 1)
{
    if (!instance_exists(obj_kick))
        gml_Script_instance_create(x, y, obj_kick);
}
