if (sound == s_enchant1)
    gml_Script_scr_playsound(s_enchant2, 0.8, 1.2, 1);

if (sound == "buy")
{
    gml_Script_scr_playsound(choose(s_equip1, s_equip2, s_equip3, s_equip4), 0.9, 1.1, 1);
    gml_Script_scr_playsound(choose(s_buy1, s_buy2, s_buy3), 0.9, 1.1, 1);
}
else
{
    gml_Script_scr_playsound(sound, 0.8, 1.2, 1);
}

times += 1;

if (times > maxTimes)
    instance_destroy();

alarm[0] = room_speed / 1.5;
