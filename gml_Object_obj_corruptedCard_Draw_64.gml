if (gml_Script_live_call())
    return global.live_result;

if (_alpha == 0)
{
    if (alarm[2] != -1 || c_votes == 65280)
    {
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        draw_set_font(f_midbig);
        gml_Script_scr_textgradient(x, y - 110, name, 16777215, 16776960, undefined, 30, 250);
        
        for (var i = 0; i < rewardAmount; i++)
        {
            var _width = string_width(rewardText[i]);
            draw_sprite_ext(spr_black, 0, x - (_width / 2) - 10, ((y - 30) + (i * 30)) - 2, _width + 20, 70, 0, c_white, 0.5);
            gml_Script_scr_textgradient(x, y + (i * 30), rewardText[i], 16777215, 16777215, undefined, 30, 300);
        }
        
        c_votes = 65280;
        
        for (var i = 0; i < instance_number(obj_corruptedCard); i++)
        {
            if (instance_find(obj_corruptedCard, i).id != id && instance_find(obj_corruptedCard, i).votes >= votes)
                c_votes = 8421504;
        }
        
        if (instance_number(obj_corruptedCard) > 1)
        {
            draw_set_font(f_mid);
            gml_Script_scr_textoutline(x, y + 130, "(!vote" + string(myID + 1) + ")");
            gml_Script_scr_textoutline(x, y + 100, "Votes: " + string(votes), c_votes);
        }
    }
}
