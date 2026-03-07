self.scr_player_ascendCancel = function()
{
    gml_Script_twitch_chat_say("/me " + string(name) + " your " + string(global.cmdPrefix) + "!Ascension process has not been completed, you can try again when you are ready.");
    tryAscension = false;
};
