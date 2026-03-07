if (!global.closing)
{
    gml_Script_net_write_server(1, 0, 11, streamerName);
    alarm[2] = room_speed / 2;
}
else
{
    gml_Script_net_write_server(1, 2, 11, streamerName);
    obj_twitch.alarm[4] = room_speed / 2;
}

alarm[1] = room_speed * 600;
