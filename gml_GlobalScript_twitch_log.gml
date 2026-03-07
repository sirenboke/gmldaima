self.twitch_log = function(arg0)
{
    if (!global.Twitch_debuglog)
        return 0;
    
    show_debug_message(string(arg0));
};
