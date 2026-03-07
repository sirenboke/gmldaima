if (gml_Script_live_call())
    return global.live_result;

if (instance_exists(obj_corruptedPortal))
{
    x = 40;
    y = 490;
}

draw_set_font(f_mid);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

if (global.unlockWitch == 1)
{
    if (global.portalPoints > 0)
        gml_Script_scr_textoutline(x, y - 70, string(floor((global.portalPoints / global.portalMaxPoints) * 100)) + "%", 16777215, 0, 20, 500);
}

if (global.portalPoints >= global.portalMaxPoints)
{
    if (global.gotWitch == 1)
    {
        gml_Script_scr_textoutline(x, y - 145, string(global.cmdPrefix) + "portal", 16777215, 0, 20, 500);
        gml_Script_scr_textoutline(x + 15, y - 120, string(ds_list_size(global.raidListPortalName)), 16777215, 0, 20, 500);
        draw_sprite_ext(spr_classIcons, 3, x - 20, y - 120, 1, 1, 0, c_white, 1);
    }
}

if (obj_bossKey.alarm[0] > -1)
{
    if (obj_bossKey.alarm[0] > (room_speed * 60))
        gml_Script_scr_textoutline(obj_townPortal.x, obj_townPortal.y, "(" + string(round(obj_bossKey.alarm[0] / room_speed / 60)) + "m)", 16777215, 0, 20, 500);
    else
        gml_Script_scr_textoutline(obj_townPortal.x, obj_townPortal.y, "(" + string(round(obj_bossKey.alarm[0] / room_speed)) + "s)", 16777215, 0, 20, 500);
}
