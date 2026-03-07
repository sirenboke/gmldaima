self.textbox_show_backlog = function()
{
    with (textbox)
    {
        if (argument[0] == true)
        {
            backlog_visible = true;
            backlog_position = 0;
        }
        else
        {
            backlog_visible = false;
        }
        
        if (argument_count >= 2)
            scroll_speed = argument[1];
    }
};
