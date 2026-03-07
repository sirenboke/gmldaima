self.scr_clearData = function()
{
    directory_destroy(string(global.platformDir) + "Core Data");
    directory_destroy(string(global.platformDir) + "Player Data");
    directory_destroy(string(global.platformDir) + "Campaign Data");
};
