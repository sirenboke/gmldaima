self.textbox_is_visible = function()
{
    if (instance_exists(textbox))
    {
        if (textbox.textbox_visible == true)
            return true;
        else
            return false;
    }
};
