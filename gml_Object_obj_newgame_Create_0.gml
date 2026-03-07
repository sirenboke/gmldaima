randomize();
text = "New Game";
fullscreen = false;
x = room_width / 2;
y = (room_height / 2) - 34;
gml_Script_scr_playsound(choose(s_menutheme, m_peaceful_1), 1, 1, 0.2);
global.ds_counter_total = 0;
global.ds_counter_list = 0;
global.ds_counter_map = 0;
global.ds_counter_grid = 0;
global.surface_counter_total = 0;
global.surface_registry = gml_Script_scr_ds_map_create();
ini_open("Global/Initialization.ini");
global.isTwitch = ini_read_real("Platform", "Twitch", 0);
global.isKick = ini_read_real("Platform", "Kick", 0);
global.platformDir = "";
ini_close();

if (global.isTwitch == 1)
{
    global.platformDir = "Twitch/";
    window_set_caption("Twitch Plays: Dungeon Raiders");
}

if (global.isKick == 1)
{
    global.platformDir = "Kick/";
    window_set_caption("Kick Plays: Dungeon Raiders");
}

ini_open(string(global.platformDir) + "Core Data/Login.ini");
global.channelName = ini_read_string("Login", "User Name", "");
global.cmdPrefix = "!";
ini_close();
ini_open(string(global.platformDir) + "Core Data/Permanent.ini");
global.townName = ini_read_string("Town", "Name", "Nameless Town");
ini_close();
global.roomSpeed = 200 / room_speed;
global.stageType = "Grassland";
global.newUnderworld = true;

if (global.newUnderworld == true)
    global.room_underworld = r_underworld_new;

if (global.newUnderworld == false)
    global.room_underworld = r_underworld;

global.dev = 0;

if (global.dev == 0)
{
    global.server_IP = "dungeonraiders.hopto.org";
    global.server_PORT = 50505;
}
else
{
    global.server_IP = "127.0.0.1";
    global.server_PORT = 50506;
}

global.subList = gml_Script_scr_ds_list_create();
global.premiumList = gml_Script_scr_ds_list_create();
global.patch = "4.8.25";
global.gameVersion = real(string_digits(global.patch));
global.newVersion = global.gameVersion;
network_set_config(network_config_use_non_blocking_socket, 0);
gml_Script_net_client_connect(global.server_IP, global.server_PORT);
alarm[1] = room_speed;
global.inFinalWar = false;
global.finalWar = false;
gml_Script_instance_create(x, y, obj_fog);
gml_Script_instance_create(x, y, obj_mountains);
gml_Script_instance_create(x, y, obj_ground);

repeat (100)
    gml_Script_instance_create(irandom(room_width * 2), room_height - 20, obj_trees);
