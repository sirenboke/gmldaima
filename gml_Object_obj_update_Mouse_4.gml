if (global.newVersion != global.gameVersion)
{
    if (show_question("There is an update available, go to the download page? (game will close)"))
    {
        url_open("https://erohz.itch.io/tpdr");
        game_end();
    }
}
