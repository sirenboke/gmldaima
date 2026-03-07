if (!instance_exists(obj_transition_out))
{
    with (gml_Script_instance_create(0, 0, obj_transition_out))
        blank = false;
}

gml_Script_scr_savegame_final();
ini_open(string(global.platformDir) + "Village Data/Data.ini");
ini_write_real("Stats", "Food", global.food);
ini_write_real("Stats", "Gold", global.gold);
ini_close();
days = 0;
hours = 0;
minutes = 0;
seconds = 0;
global.creditsStage = gml_Script_scr_bigNumber(global.stage);
gml_Script_twitch_chat_say_direct("/me Campaign #" + string(global.season) + " has ended! You made it to stage " + gml_Script_scr_bigNumber(round(global.stage)) + " in The Final War. Congratulations!");
directory_create(string(global.platformDir) + "Campaign Data/Past Campaigns/Campaign #" + string(global.season));

with (obj_playerCard)
    instance_destroy();

with (obj_player)
    instance_destroy();

with (obj_warrior)
    instance_destroy();

file_delete(string(global.platformDir) + "Village Data/Data.ini");
alarm[2] = room_speed * 15;
