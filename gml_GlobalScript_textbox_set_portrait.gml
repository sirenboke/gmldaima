self.textbox_set_portrait = function()
{
    with (textbox)
    {
        if (argument_count == 1)
        {
            sprite = argument[0];
        }
        else
        {
            var al = array_length(msg);
            
            if (argument_count >= al)
            {
                for (var i = 0; i < al; i++)
                    portrait[i] = argument[i];
            }
            else
            {
                for (var i = 0; i < argument_count; i++)
                    portrait[i] = argument[i];
                
                var empty_slots = al - (al - argument_count);
                
                for (var i = empty_slots; i < al; i++)
                    portrait[i] = argument[0];
            }
        }
    }
};
