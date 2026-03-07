if (file_exists(string(global.platformDir) + "Core Data/Permanent.ini"))
{
    if (show_question("Starting a new game will delete everything and go back to Campaign #1. Do you want to start a new game?"))
    {
        room_goto(r_newgame);
        gml_Script_scr_playsound(s_levelUp3, 1, 1, 1);
    }
}
else
{
    gml_Script_scr_clearData();
    room_goto(r_newgame);
    gml_Script_scr_playsound(s_levelUp3, 1, 1, 1);
}
