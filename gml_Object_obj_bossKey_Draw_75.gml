draw_set_font(f_mid);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_sprite_ext(spr_key, 0, x + xx, y + 4, 1, 1, 0, c_white, 1);

if (alarm[1] != -1)
{
    if (global.raiding == true || global.raidCall == true)
        alarm[1] += 1;
}

if ((alarm[0] != -1 && (global.raiding == true || global.raidCall == true || (obj_raid.alarm[9] != -1 && obj_raid.alarm[9] <= (room_speed * 120)))) || (obj_corruptedControl.alarm[0] > -1 && obj_corruptedControl.alarm[0] < (room_speed * 120)) || global.inFinalWar == true)
{
    if (alarm[0] <= (room_speed * 60))
        alarm[0] = room_speed * 60;
}

if (global.portalPoints >= global.portalMaxPoints)
{
    global.portalPoints = global.portalMaxPoints;
    
    if (portalReady == false)
    {
        if (global.unlockWitch == 0)
        {
            global.unlockWitch = 1;
            ini_open(string(global.platformDir) + "Village Data/Data.ini");
            ini_write_real("Underworld", "Unlock Witch", 1);
            ini_close();
            
            if (global.unlockWitch == 1 && global.witchBuilt == 0)
            {
                gml_Script_twitch_chat_say("/color BlueViolet");
                gml_Script_twitch_chat_say_direct("/me The mysterious Town portal is now complete... All of a sudden an odd presence can be felt in the Town, as if something or someone had been watching us all this time and had decided to let us know now... You can sense dark !magic being used nearby.");
                gml_Script_twitch_chat_say("/color FireBrick");
                
                with (obj_witchHut)
                    alarm[0] = room_speed * 600;
            }
        }
        else
        {
            gml_Script_twitch_chat_say("/color BlueViolet");
            gml_Script_twitch_chat_say_direct("/me The portal is now complete, type " + string(global.cmdPrefix) + "portal whenever you are ready.");
            gml_Script_twitch_chat_say("/color FireBrick");
        }
        
        gml_Script_scr_playsound(s_portalComplete, 0.9, 1.1, 0.5);
        
        if (!audio_is_playing(s_portalLoop))
        {
            audio_sound_gain(s_portalLoop, 0.05, 0);
            audio_play_sound(s_portalLoop, 0, 1);
        }
        
        portalReady = true;
    }
    
    image_speed = 0.1;
}
else
{
    image_index = floor((global.portalPoints / global.portalMaxPoints) * image_number);
}

draw_set_font(f_mid);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

if (alarm[0] == -1)
{
}
else
{
}

if (global.soulsProd > 0 && global.newUnderworld == false)
{
    xx = 375;
    draw_sprite_general(spr_bar, 1, 0, 0, 144, 8, room_width - 250, room_height - 258, 1, 1, 90, -1, -1, -1, -1, 1);
    draw_set_font(f_mid);
    gml_Script_scr_textoutline(x + 125, y - 65, "Underworld Souls Rewards:", 16777215, 0, 20, 500);
    draw_set_font(f_special);
    draw_sprite_ext(spr_bossSouls, 1, x + 125, y - 35, 1, 1, 0, c_white, 0.5);
    gml_Script_scr_textoutline(x + 125, y - 35, "Captured Souls: " + string(global.bossSoulsTotal), 16777215, 0, 20, 500);
    gml_Script_scr_textoutline(x + 125, y - 5, "+" + gml_Script_scr_bigNumber(round(global.underworldXPProd * global.globalXPBonus)) + " XP/min", 16777215, 0, 20, 500);
    gml_Script_scr_textoutline(x + 125, y + 10, "+" + gml_Script_scr_bigNumber(round(global.underworldGoldProd * global.globalGoldBonus)) + " gold/min", 65535, 0, 20, 500);
    gml_Script_scr_textoutline(x + 125, y + 25, "+" + gml_Script_scr_bigNumber(round(global.soulsProd)) + " souls/min", 16776960, 0, 20, 500);
    draw_sprite_ext(spr_black, 0, x + 25, y + 40, 205, 10, 0, c_white, 1);
    draw_sprite_ext(spr_bluebarsmall, 0, x + 27, y + 45, 201 - ((obj_gameControl.alarm[0] / room_speed / 60) * 201), 2, 0, c_white, 1);
}

with (obj_keyFrag)
    draw_self();

with (obj_keyFrag2)
    draw_self();

var _bossTier = global.bossTier;

if (global.bossStage > 500)
    _bossTier += 1;

if (global.bossStage > 1000)
    _bossTier += 1;

if (global.bossStage > 1500)
    _bossTier += 1;

if (global.bossStage > 2000)
    _bossTier += 1;

if (global.bossStage > 2500)
    _bossTier += 1;

if (_bossTier > 5)
    _bossTier = 5;

global.keyFragsTier = (global.keyFrags - 1) + _bossTier;
draw_set_font(f_mid);

if (global.keyFrags >= 6)
{
    draw_sprite_ext(spr_bossTier, _bossTier, x + xx + 150, y, 4, 4, 0, c_white, 1);
    gml_Script_scr_textoutline(x + xx, y - 45, string(global.cmdPrefix) + "boss", 16777215, 0, 20, 500);
    gml_Script_scr_textoutline(x + xx, y - 65, "Boss Difficulty: " + string(global.bossStage), 16777215, 0, 20, 500);
    
    if (_bossTier > 0)
        gml_Script_scr_textoutline(x + xx + 150, y - 65, "Tier: " + string(clamp(_bossTier, 0, 5)), 16777215, 0, 20, 500);
    
    if (alarm[1] == -1)
    {
        if (_bossTier < 5)
            gml_Script_scr_textoutline(x + xx, y + 40, "Collect more key fragments to increase Boss tier", 16777215, 0, 20, 500);
    }
    
    if (alarm[1] != -1)
    {
        draw_sprite_ext(spr_blackbar, 0, x + 8, room_height - 280, 484, 4, 0, c_white, 1);
        draw_sprite_ext(spr_enemyhpbarsmall, 0, x + 12, room_height - 280, (alarm[1] / bossTimer) * 476, 4, 0, c_white, 1);
        gml_Script_scr_textoutline(x + (sprite_width / 2), room_height - 280, "Boss leaving in...", 16777215, 0, 20, 500);
    }
}
else
{
    var _keyLevel;
    
    if (is_infinity(round(global.keyLevel / (global.keyFrags - 1))) || is_nan(round(global.keyLevel / (global.keyFrags - 1))))
        _keyLevel = "???";
    else
        _keyLevel = round(global.keyLevel / (global.keyFrags - 1));
    
    gml_Script_scr_textoutline(x + xx, y - 65, "Average Level: " + string(_keyLevel), 16777215, 0, 20, 500);
}
