if (gml_Script_live_call())
    return global.live_result;

if (!variable_instance_exists(self, "sector") || !variable_instance_exists(self, "level"))
    exit;

var currentRow = ((sector - 1) * 5) + (level - 1);
var corruptedRow = ((global.corruptedSector - 1) * 5) + (floor(global.corruptedLevel) - 1);

if (name == "Your World")
{
    if (layer_get_name(layer) != "Cleared")
        layer_add_instance(layer_get_id("Cleared"), self);
}

var c_handicaps = 16777215;
var c_votes = 65280;

if (y < (room_height - 300) || name == "Your World")
{
    if (instance_exists(obj_corruptedCard))
        exit;
    
    if (alarm[1] == -1)
        alarm[1] = room_speed;
    
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_font(f_special);
    image_index = clamp(icon, 1, image_number - 1);
    
    if (currentRow <= corruptedRow)
    {
        if (currentRow == corruptedRow || name == "Your World")
        {
            if (name != "Your World")
            {
                draw_set_font(f_mid);
                var _width = string_width(name);
                draw_sprite_ext(spr_black, 0, x - (_width / 2) - 10, y - 105, _width + 20, 50, 0, c_white, 0.5);
                draw_set_font(f_special);
                
                if (obj_corruptedControl.alarm[1] > -1)
                    gml_Script_scr_textoutline(x, y - 70, "(!island " + string(voteID) + ")");
                
                draw_set_valign(fa_middle);
                draw_set_font(f_mid);
                c_votes = 65280;
                
                for (var i = 0; i < instance_number(obj_corruptedIsland); i++)
                {
                    if (instance_find(obj_corruptedIsland, i).id != id && instance_find(obj_corruptedIsland, i).votes >= votes)
                        c_votes = 16777215;
                }
                
                if (votes == 0)
                    c_votes = 8421504;
                
                gml_Script_scr_textoutline(x, y, "Votes: " + string(votes), c_votes, undefined, undefined);
                draw_set_valign(fa_top);
                draw_set_font(f_mid);
                
                if (global.raiding == true)
                {
                    if (c_votes != 65280)
                    {
                        c_handicaps = 8421504;
                        c_votes = 8421504;
                    }
                    
                    draw_set_valign(fa_top);
                }
                else
                {
                    draw_set_valign(fa_middle);
                }
                
                gml_Script_scr_textgradient(x, y - 94, string(name), c_handicaps);
                draw_set_valign(fa_top);
                
                for (var i = 0; i < challengeAmount; i++)
                {
                    _width = string_width(challengeText[i]);
                    draw_sprite_ext(spr_black, 0, x - (_width / 2) - 10, (y + 60 + (i * 30)) - 2, _width + 20, 30, 0, c_white, 0.5);
                    gml_Script_scr_textgradient(x, y + 60 + (i * 30), challengeText[i], c_handicaps, c_handicaps, undefined, undefined, 480);
                }
            }
            else
            {
                draw_set_valign(fa_top);
                draw_set_font(f_big);
                var _width = string_width(name);
                draw_sprite_ext(spr_black, 0, x - (_width / 2) - 10, y, _width + 20, 40, 0, c_white, 0.5);
                gml_Script_scr_textgradient(x, y, string(name), 16777215);
            }
        }
    }
    else
    {
        if (layer_get_name(layer) != "Corrupted")
            layer_add_instance(layer_get_id("Corrupted"), self);
        
        draw_set_valign(fa_middle);
        gml_Script_scr_textoutline(x, y - 60, "?????");
        gml_Script_scr_textoutline(x, y + 60, "?????");
    }
    
    if (sector < global.corruptedSector || (sector == global.corruptedSector && level < global.corruptedLevel))
    {
        if (layer_get_name(layer) != "Cleared")
            layer_add_instance(layer_get_id("Cleared"), self);
    }
}
