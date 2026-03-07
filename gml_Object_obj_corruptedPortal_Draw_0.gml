if (gml_Script_live_call())
    return global.live_result;

size = 0.5;
draw_sprite_ext(spr_enemySpawner, image_index, x, y, size, size, 0, c_red, 0.8);
draw_sprite_ext(spr_enemySpawner, image_index, x, y, size * 0.7, -size / 4, 0, c_black, 0.4);

if (obj_portal.alarm[10] == -1)
{
    with (instance_place(x, y, obj_player))
    {
        if (toPortal == true && toRedPortal == true)
        {
            ini_open(string(global.platformDir) + string(myCharDir) + "Data.ini");
            state = UnknownEnum.Value_0;
            ini_write_real("Misc", "Last State", state);
            ini_write_real("Misc", "Last X", x);
            ini_write_real("Misc", "Last Y", y);
            alarm[10] = 1;
            toPortal = false;
            toRedPortal = false;
            other.count += 1;
            gml_Script_scr_playsound(s_portalClose, 0.9, 1.1, 0.5);
            ini_close();
        }
    }
}

if (obj_portal.alarm[10] == -1 && count > 0)
{
    if (count >= ds_list_size(global.raidListRedPortalName))
    {
        count = 0;
        
        if (obj_portal.alarm[11] == -1)
            obj_portal.alarm[11] = room_speed;
    }
}

enum UnknownEnum
{
    Value_0
}
