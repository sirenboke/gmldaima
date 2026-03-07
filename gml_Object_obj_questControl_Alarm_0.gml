if (legendary != "")
{
    if (questCompleteText != "")
    {
        gml_Script_twitch_chat_say("/me " + string(questCompleteText) + " | New " + string(legendary) + "Quest: " + string(questText));
        show_debug_message("/me " + string(questCompleteText) + " | New " + string(legendary) + "Quest: " + string(questText));
    }
    else
    {
        gml_Script_twitch_chat_say("/me New " + string(legendary) + "Quest: " + string(questText));
        show_debug_message("/me New " + string(legendary) + "Quest: " + string(questText));
    }
}
else if (global.chatSpam == 0)
{
    if (questCompleteText != "")
    {
        gml_Script_twitch_chat_say("/me " + string(questCompleteText) + " | New " + string(legendary) + "Quest: " + string(questText));
        show_debug_message("/me " + string(questCompleteText) + " | New " + string(legendary) + "Quest: " + string(questText));
    }
    else
    {
        gml_Script_twitch_chat_say("/me New " + string(legendary) + "Quest: " + string(questText));
        show_debug_message("/me New " + string(legendary) + "Quest: " + string(questText));
    }
}

questCompleteText = "";
