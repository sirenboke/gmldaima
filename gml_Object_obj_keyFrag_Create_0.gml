if (global.keyFragsTier >= 14)
{
    instance_destroy();
    exit;
}

sprite_index = obj_bossKey.spr_key;
depth = obj_bossKey.depth - 1;
image_speed = 0;
image_index = global.keyFrags;
global.keyFrags += 1;
ini_open(string(global.platformDir) + "Village Data/Data.ini");
ini_write_real("Boss", "Key Fragments", global.keyFrags);
alarm[0] = room_speed;
grav = 1 * global.roomSpeed;
dir = random_range(-0.2, 0.2) * global.roomSpeed;
locked = false;

if (global.keyFrags == 6)
{
    global.bossStage = round(global.keyLevel / 5);
    global.keyLevel = 1;
    gml_Script_scr_playsound(s_keyComplete, 0.9, 1.1, 1);
}

if (global.keyFrags > 6)
{
    sprite_index = spr_enemyTier;
    image_xscale = 2;
    image_yscale = 2;
    ini_write_real("Boss", "Boss Tier", clamp(global.bossTier + 1, 0, 5));
}
else if (global.keyFrags < 6)
{
    global.keyLevel += global.stage;
    ini_write_real("Boss", "Key Level", global.keyLevel);
}

ini_close();
audio_play_sound(s_levelUp, 0, 0);
