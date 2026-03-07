if (room == r_corrupted)
{
    global.redPortalCost = 5;
    
    if (global.corruptedSector == 0)
    {
        global.corruptedSector = 1;
        ini_open(string(global.platformDir) + "Village Data/Data.ini");
        ini_write_real("Corrupted Dimension", "Sector", global.corruptedSector);
        ini_write_real("Corrupted Dimension", "Portal Ritual", global.redPortalCost);
        ini_close();
    }
    
    accepted = false;
    global.challenge_canSwitch = 1;
    global.challenge_canPot = 1;
    global.challenge_relicEffect = 1;
    global.challenge_petRelicEffect = 1;
    global.challenge_enemyCollision = 0;
    global.challenge_bossChance = 0;
    global.challenge_bloodRain = 1;
    global.challenge_enemyStamina = 1;
    global.challenge_allyStamina = 1;
    global.challenge_basicMiss = 0;
    global.challenge_trueReduction = 1;
    global.challenge_specialReduction = 1;
    global.challenge_enemyConst = 1;
    global.challenge_lessRewards = 1;
    global.challenge_blockPhysical = 0;
    global.challenge_interruption = 20;
    global.challenge_enemyRevive = 0;
    gml_Script_scr_loadCorruptedDimension();
    alarm[1] = room_speed * (60 + ((global.corruptedSector - 1) * 10));
    var _fxdistort2 = fx_create("_filter_heathaze");
    fx_set_single_layer(_fxdistort2, true);
    layer_set_fx(layer_get_id("Cards"), _fxdistort2);
    layer_add_instance(layer_get_id("Corrupted"), self);
    var _fxdistort = fx_create("_filter_heathaze");
    fx_set_single_layer(_fxdistort, false);
    layer_set_fx(layer_get_id("Corrupted"), _fxdistort);
    
    if (instance_exists(obj_corruptedCard))
    {
        with (obj_corruptedCard)
            instance_destroy();
    }
    
    with (obj_player)
    {
        state = UnknownEnum.Value_0;
        
        if (ds_list_find_index(global.raidListRedPortalName, string(name)) != -1)
        {
            readyRaid = 1;
            x = 2000;
            y = 450;
        }
    }
}

if (room == r_1)
{
    if (global.unlockCorrupted == 1 && !instance_exists(obj_corruptedPortal))
        instance_create_depth(x, y, depth - 1, obj_corruptedPortal);
}

enum UnknownEnum
{
    Value_0
}
