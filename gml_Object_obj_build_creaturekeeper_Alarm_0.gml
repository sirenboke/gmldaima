if (hatched == false && eggchosen != -1)
{
    if (eggstage < 5)
    {
        eggstage += 1;
        anspeed = 0.005 + (eggstage / 1000);
        gml_Script_twitch_chat_say("/me " + string(eggText[irandom_range(0, eggTextAmount)]));
        alarm[1] = irandom_range(6, 600) * room_speed;
        alarm[0] = room_speed * 14400;
        ini_open(string(global.platformDir) + "Village Data/Data.ini");
        ini_write_real("Buildings", "Keeper Egg Stage", eggstage);
        ini_write_real("Buildings", "Keeper Egg Timer", room_speed * 14400);
        ini_close();
    }
    else
    {
        hatched = true;
        gml_Script_twitch_chat_say_direct("/me The egg finally hatched! What is that? A... " + string(petStat[eggchosen][0]) + "? Amazing!");
    }
}
