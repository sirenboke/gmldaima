if (global.dev)
{
    draw_set_font(f_mid);
    draw_set_halign(fa_center);
    gml_Script_scr_textshadow(((room_width / 2) + 290) - (string_width("Moving: " + string(global.raidMove)) / 2), room_height - 224, "Moving: " + string(global.raidMove), 16777215, 0, 20, 1000);
    gml_Script_scr_textshadow(((room_width / 2) + 290) - (string_width("Speed: " + string(global.raidSpeed)) / 2), room_height - 204, "Speed: " + string(global.raidSpeed), 16777215, 0, 20, 1000);
}

part_system_drawit(global.raidObject_partsys);
part_system_drawit(global.over_partsys);
part_system_drawit(global.snow_partsys);
part_system_drawit(global.blizzard_partsys);
part_system_drawit(global.smokebomb_partsys);
