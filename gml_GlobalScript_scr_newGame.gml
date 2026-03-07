self.scr_newGame = function()
{
    var _channelName = string_lower(obj_username.msg);
    
    if (string_length(_channelName) < 3)
        exit;
    
    if (global.isTwitch == 1)
        global.platformDir = "Twitch/";
    
    if (global.isKick == 1)
        global.platformDir = "Kick/";
    
    if (instance_exists(obj_username) && alarm[2] == -1)
    {
        if (!instance_exists(obj_retry))
            gml_Script_instance_create(x, y, obj_retry);
        
        global.channelName = _channelName;
        
        if (global.isTwitch == 1)
        {
            var _userName = "room_001";
            var _userOAuth = "oauth:3m3g7bx7px1ib36w6ic9ye76xtpcj2";
            gml_Script_twitch_init("3nsrr6vwm5aj87n2h61miur0byinas");
            gml_Script_twitch_chat_connect(string(_channelName), string(_userName), string(_userOAuth));
        }
        
        if (global.isKick == 1)
        {
            if (!instance_exists(obj_kick))
                gml_Script_instance_create(x, y, obj_kick);
        }
        
        alarm[0] = room_speed / 2;
        alarm[2] = room_speed * 60;
        file_delete(string(global.platformDir) + "Campaign Data/Credits.ini");
        file_delete(string(global.platformDir) + "Core Data/Active Players.ini");
        file_delete(string(global.platformDir) + "Village Data/Data.ini");
    }
    
    if (instance_exists(obj_oauth))
    {
        if (obj_oauth.message != "")
        {
            obj_oauth.userOAuth = obj_oauth.message;
        }
        else
        {
            obj_oauth.message = "Not a valid name";
            obj_oauth.userOAuth = obj_oauth.message;
        }
        
        ini_open(string(global.platformDir) + "Core Data/Login.ini");
        var encoded = base64_encode("1");
        var savefirsttime;
        
        repeat (4)
            savefirsttime = base64_encode(encoded);
        
        ini_write_string("Login", "Status", savefirsttime);
        ini_write_string("Login", "OAuth", string_lower(obj_oauth.message));
        ini_close();
        room_goto(r_1);
    }
};
