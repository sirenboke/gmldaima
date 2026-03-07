self.textbox_set_speed = function()
{
    with (textbox)
    {
        var maxmessages = array_length(msg);
        
        for (var i = 0; i < maxmessages; i++)
        {
            if (argument_count > i)
                message_speed[i] = argument[i];
            else
                message_speed[i] = 0.5;
        }
        
        speed_set = true;
    }
};
