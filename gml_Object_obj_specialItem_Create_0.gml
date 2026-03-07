alarm[0] = room_speed;
alarm[1] = 1;
alarm[2] = room_speed * 2;
alarm[4] = room_speed * 20;
grav = 1 * global.roomSpeed;
dir = random_range(-0.2, 0.2) * global.roomSpeed;
image_speed = 0;
gml_Script_scr_playsound(choose(s_drop1, s_drop2, s_drop3, s_drop4), 0.9, 1.1, 1);
gotoX = room_width / 2;

if (room == global.room_underworld)
    gotoX = (room_width / 2) - 210;

gotoY = room_height - 140;
ds_list_clear(global.relicList);
global.relicDrop = true;
rewardedPlayers = 0;
