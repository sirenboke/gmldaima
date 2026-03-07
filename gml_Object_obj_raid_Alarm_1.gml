gml_Script_scr_clearDeathRain();

with (obj_raidPlayerCard)
{
    show = 0;
    alarm[0] = room_speed * 5;
}

gml_Script_twitch_chat_say("/color Red");

if (obj_bossKey.alarm[1] == -1)
{
    if (global.stage > 20)
        maxEnemies = round(30 + (global.stage / 10));
    else
        maxEnemies = 10 + global.stage;
    
    if (global.enemyRaid == false)
        gml_Script_twitch_chat_say_direct("/me " + string(raidAnnounceText) + " started!");
    else
        gml_Script_twitch_chat_say_direct("/me Enemies incoming! SMOrc");
}
else
{
    maxEnemies = round(6 + (global.stage / 50));
    gml_Script_twitch_chat_say_direct("/me Dungeon Boss raid " + gml_Script_scr_bigNumber(global.bossStage) + " started!");
}

gml_Script_twitch_chat_say("/color FireBrick");
gml_Script_scr_playsound(s_trumpet, 0.9, 1.1, 0.5);
global.extraRewardsTimerMax = 240 + (global.stage / 8);
global.extraRewardsTimer = 0;

with (obj_god)
{
    if (raidsLeft > 0)
        raidsLeft -= 1;
    
    if (raidsLeft <= 0)
    {
        raidsLeft = 0;
        
        if (alarm[3] > 0)
            alarm[3] = 1;
    }
}

ds_list_sort(global.raidList0, true);
ds_list_sort(global.raidList1, true);
alarm[8] = 1;
alarm[0] = room_speed;
var chest = choose(0, 1, 2);

if (chest == 0)
    gml_Script_instance_create(random_range(room_width + 100, room_width + 500), room_height - 20, obj_chest);

if (room == r_1)
{
    audio_sound_gain(obj_gameControl.theme, 0, 3000);
    
    if (boss == true || instance_exists(obj_bigBoss1))
    {
        boss = true;
        fightTheme = s_bossTheme1;
    }
    else
    {
        fightTheme = s_fight1;
    }
    
    audio_sound_gain(fightTheme, 0, 0);
    audio_sound_gain(fightTheme, 0.1, 10000);
    
    if (audio_is_paused(fightTheme))
        audio_resume_sound(fightTheme);
    else if (!audio_is_playing(fightTheme))
        audio_play_sound(fightTheme, 0, 1);
}
