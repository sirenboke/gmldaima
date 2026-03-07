global.townFog = gml_Script_scr_surface_create(room_width, room_height, "townFog");
noTheme = false;
night = false;
timeSpeed = room_speed * 2;
light = 0;
lightColor = make_colour_hsv(0, 0, light);
finalLight = 0;
warColor = make_colour_hsv(80, finalLight, finalLight);

if (room != r_mainmenu)
    alarm[0] = timeSpeed;

depth = -room_height / 10;
gml_Script_instance_create(x, y, obj_fogRaid);
