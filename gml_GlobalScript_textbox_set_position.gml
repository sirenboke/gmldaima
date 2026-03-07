self.textbox_set_position = function()
{
    with (textbox)
    {
        position_set = true;
        x1 = argument[0];
        y1 = argument[1];
        x2 = argument[2];
        y2 = argument[3];
        
        if (argument_count >= 5)
        {
            namex1 = argument[4];
            namey1 = argument[5];
            namex2 = argument[6];
            namey2 = argument[7];
        }
        
        if (argument_count >= 9)
        {
            sprite_position_set = true;
            spritex = argument[8];
            spritey = argument[9];
        }
        
        if (argument_count >= 11)
        {
            text_position_set = true;
            textx = argument[10];
            texty = argument[11];
        }
        
        if (argument_count >= 13)
        {
            name_text_position_set = true;
            nametextx = argument[12];
            nametexty = argument[13];
        }
        
        if (argument_count >= 15)
        {
            option1x = argument[14];
            option1y = argument[15];
        }
        
        if (argument_count >= 17)
        {
            option2x = argument[16];
            option2y = argument[17];
        }
        
        if (argument_count >= 19)
        {
            option3x = argument[18];
            option3y = argument[19];
        }
    }
};
