ini_open(string(global.platformDir) + "Core Data/Login.ini");
var decoded = ini_read_string("Login", "Status", "0");

repeat (4)
    firsttime = base64_decode(decoded);

var firsttime = real(base64_decode(firsttime));

if (firsttime == 1)
{
    global.userOAuth = string_lower(ini_read_string("Login", "OAuth", ""));
    ini_close();
    room_goto(r_1);
    instance_destroy();
}
else
{
    ini_close();
    url_open("https://twitchapps.com/tmi/");
    global.userOAuth = "";
    showmessage = false;
    checkname = "";
    x = room_width / 2;
    y = room_height / 2;
    message = "";
    limit = 100;
}
