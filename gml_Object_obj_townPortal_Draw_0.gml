if (gml_Script_live_call())
    return global.live_result;

if (global.portalPoints > 0)
    global.portalPointsDisplay = global.portalPoints;

size = (global.portalPointsDisplay / global.portalMaxPoints) * 0.5;
draw_sprite_ext(spr_enemySpawner, image_index, x, y, -size, size, 0, c_fuchsia, 0.8);
draw_sprite_ext(spr_enemySpawner, image_index, x, y, size * 0.7, -size / 4, 0, c_black, 0.4);

if (obj_bossKey.alarm[0] == -1)
{
    with (instance_place(x, y, obj_player))
    {
        if (toPortal == true && toRedPortal == false)
        {
            ini_open(string(global.platformDir) + string(myCharDir) + "Data.ini");
            state = UnknownEnum.Value_0;
            ini_write_real("Misc", "Last State", state);
            ini_write_real("Misc", "Last X", x);
            ini_write_real("Misc", "Last Y", y);
            alarm[10] = 1;
            toPortal = false;
            other.count += 1;
            gml_Script_scr_playsound(s_portalClose, 0.9, 1.1, 0.5);
            ini_close();
        }
    }
}

if (obj_bossKey.alarm[0] == -1 && count > 0)
{
    if (count >= ds_list_size(global.raidListPortalName))
    {
        count = 0;
        
        if (obj_bossKey.alarm[11] == -1)
            obj_bossKey.alarm[11] = room_speed;
    }
}

enum UnknownEnum
{
    Value_0
}
