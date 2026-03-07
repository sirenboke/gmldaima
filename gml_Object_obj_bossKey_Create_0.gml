y = room_height - 320;
image_speed = 0;
image_index = 0;
depth = obj_gameControl.depth - 1;
xx = 250;
portalReady = false;
global.randAura = irandom_range(1, global.totalAuras);
spr_key = choose(spr_bossKey1, spr_bossKey2, spr_bossKey3, spr_bossKey4);
bossTimer = room_speed * 120;
ini_open(string(global.platformDir) + "Village Data/Data.ini");
global.portalID = 0;
global.portalPoints = ini_read_real("Stats", "Portal Points", 0);
global.portalPointsDisplay = global.portalPoints;
global.portalMaxPoints = 100000;
global.keyFrags = ini_read_real("Boss", "Key Fragments", 1);
global.keyLevel = ini_read_real("Boss", "Key Level", 1);
global.bossTier = ini_read_real("Boss", "Boss Tier", 0);
global.keyFragsTier = global.keyFrags - 1;
alarm[0] = ini_read_real("Underworld", "Portal Timer", -1);
ini_close();

if (global.keyFrags >= 6)
{
    global.bossStage = round(global.keyLevel / 5);
    global.keyLevel = 1;
    gml_Script_scr_playsound(s_keyComplete, 0.9, 1.1, 1);
}

for (var i = 0; i < clamp(global.keyFrags - 1, 0, 5); i += 1)
{
    with (gml_Script_instance_create(x, y, obj_keyFrag2))
        image_index = i + 1;
}

instance_create_depth(50, 600, -100, obj_townPortal);
