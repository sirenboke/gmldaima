if (gml_Script_live_call())
    return global.live_result;

draw_set_font(f_mid);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

if (global.portalTower >= 5)
{
    gml_Script_scr_textoutline(x, y - 145, string(global.cmdPrefix) + "redportal", 16777215, 0, 20, 500);
    gml_Script_scr_textoutline(x + 15, y - 120, string(ds_list_size(global.raidListRedPortalName)), 16777215, 0, 20, 500);
    
    if (global.redPortalOpen == false)
    {
        var c_cost = 16777215;
        
        if (global.bloodgems < global.redPortalCost)
            c_cost = 4235519;
        
        gml_Script_scr_textoutline(x - 10, y - 70, string(global.redPortalCost), c_cost, 0, 20, 500);
        draw_sprite_ext(spr_underworldIcons, 1, x + 10, y - 70, 1, 1, 0, c_white, 1);
    }
    else if (obj_corruptedControl.alarm[0] > -1)
    {
        gml_Script_scr_textoutline(x, y, "(" + gml_Script_scr_formatTimer(obj_corruptedControl.alarm[0]) + ")", 16777215, 0, 20, 500);
    }
    
    draw_sprite_ext(spr_classIcons, 3, x - 20, y - 120, 1, 1, 0, c_white, 1);
}
