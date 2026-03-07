gml_Script_scr_clearData();
ini_open("Global/Initialization.ini");
ini_write_real("Platform", "Twitch", global.isTwitch);
ini_write_real("Platform", "Kick", global.isKick);
ini_close();

if (global.isTwitch == 1)
    global.platformDir = "Twitch/";

if (global.isKick == 1)
    global.platformDir = "Kick/";

ini_open(string(global.platformDir) + "Core Data/Login.ini");
ini_write_string("Login", "User Name", string_lower(obj_username.msg));
var encoded = base64_encode("1");
var savefirsttime;

repeat (4)
    savefirsttime = base64_encode(encoded);

ini_write_string("Login", "Status", savefirsttime);
ini_close();

with (obj_username)
    instance_destroy();

room_goto(r_1);
gml_Script_twitch_chat_disconnect();
gml_Script_twitch_free();
exit;
