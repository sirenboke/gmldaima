self.scr_updatePlayerItems = function()
{
    ini_open(string(global.platformDir) + string(myCharDir) + "Data.ini");
    
    for (var i = 0; i <= 9; i++)
    {
        ini_write_real("Items", "Item " + string(i) + " Level", myItemInfo[i][0]);
        ini_write_real("Items", "Item " + string(i) + " Tier", myItemInfo[i][1]);
        myItemInfo[i][2] = string_repeat("I", myItemInfo[i][1]);
    }
    
    ini_close();
    gml_Script_scr_updateStats();
};
