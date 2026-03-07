if (!instance_exists(obj_continue))
{
    var _channelName = "-offline-";
    global.channelName = _channelName;
    ini_open(string(global.platformDir) + "Core Data/Login.ini");
    ini_write_string("Login", "Status", global.channelName);
    ini_write_string("Login", "OAuth", global.channelName);
    ini_write_string("Login", "User Name", global.channelName);
    ini_close();
    room_goto(r_1);
}
