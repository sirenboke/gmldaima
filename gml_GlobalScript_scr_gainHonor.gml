self.scr_gainHonor = function(arg0, arg1 = 0, arg2 = "")
{
    var _uname;
    
    if (arg2 == "")
    {
        _uname = name;
        arg0 = ceil(arg0);
        
        if (arg1 == 0)
            honor += arg0;
        
        honorPoints += arg0;
        
        if (honor >= maxHonor)
            gml_Script_scr_levelupHonor();
        
        global.creditsHonor += arg0;
        var _rank = -1;
        var h;
        
        for (h = 0; h < ds_grid_height(global.honorRanking); h++)
        {
            if (ds_grid_get(global.honorRanking, 0, h) == name)
            {
                _rank = h;
                break;
            }
        }
        
        ds_grid_set(global.honorRanking, 1, h, honor);
        ds_grid_sort(global.honorRanking, 1, 0);
        ini_open(string(global.platformDir) + string(myAccDir) + "Account Data.ini");
        ini_write_real("Honor", "Account Honor", honor);
        ini_write_real("Honor", "Honor Points", honorPoints);
        ini_write_real("Honor", "Account Level", honorLevel);
        ini_close();
        gml_Script_scr_addDiaryProgress(12, arg0);
    }
    else
    {
        _uname = arg2;
        var _myAccDir = "Player Data/" + string(arg2) + "/Account/";
        ini_open(string(global.platformDir) + string(_myAccDir) + "Account Data.ini");
        var _total = ini_read_real("Honor", "Honor Points", 0);
        ini_write_real("Honor", "Honor Points", _total + arg0);
        ini_close();
        show_debug_message(string(arg2) + " earned " + string(arg0) + " Honor Points and now has a total of " + string(_total + arg0));
        
        with (obj_player)
        {
            if (name == arg2)
            {
                honorPoints += arg0;
                gml_Script_scr_addDiaryProgress(12, arg0);
            }
        }
    }
    
    global.godsHonor += (global.godsHonorMax * 0.02 * arg0);
    gml_Script_twitch_chat_say("/me " + string(_uname) + " increased Gods Favor progress by " + string(arg0 * 2) + "%[+]!");
};
