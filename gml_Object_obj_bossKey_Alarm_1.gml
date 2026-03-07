if (global.stageType == "Dungeon")
{
    if (instance_exists(obj_bigBoss1))
    {
        with (obj_bigBoss1)
            instance_destroy();
    }
    
    spr_key = choose(spr_bossKey1, spr_bossKey2, spr_bossKey3, spr_bossKey4);
    gml_Script_scr_playsound(s_bossQuit, 0.9, 1.1, 1);
    
    with (obj_keyFrag)
        instance_destroy();
    
    with (obj_keyFrag2)
        instance_destroy();
    
    global.keyFrags = 1;
    global.bossTier = 0;
    ini_open(string(global.platformDir) + "Village Data/Data.ini");
    ini_write_real("Boss", "Key Fragments", 1);
    ini_write_real("Boss", "Key Level", 0);
    ini_write_real("Boss", "Boss Tier", 0);
    ini_close();
    obj_raid.boss = false;
    
    with (gml_Script_instance_create(x, y, obj_stageTransition))
    {
        c1 = 32768;
        text1 = global.stageTypeWorld;
        text2 = "Stage " + string(global.ostage);
    }
}
