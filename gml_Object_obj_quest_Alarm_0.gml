gml_Script_instance_create(x, y, obj_quest);
gml_Script_scr_playsound(s_questFailed, 0.9, 1.1, 1.5);

if (global.chatSpam == 0)
    gml_Script_twitch_chat_say("/me Quest expired...");

instance_destroy();
