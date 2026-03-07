if (global.raidCall == false && global.raiding == false && !instance_exists(obj_raidResults) && (global.stageType == "Forest" || global.stageType == "Grassland" || global.stageType == "Snow Trail") && !instance_exists(obj_raidTransition))
{
    global.raiding = true;
    global.enemyRaid = true;
    global.raidNumber = 0;
    global.enemyNumber = 0;
    enemies = 0;
    alarm[1] = room_speed * 10;
    alarm[11] = room_speed;
    
    if (global.stage < 251)
        global.stageTypeWorld = "Forest";
    
    if (global.stage >= 251)
        global.stageTypeWorld = "Grassland";
    
    if (global.stage >= 501)
        global.stageTypeWorld = "Snow Trail";
    
    if (global.stageType != global.stageTypeWorld)
    {
        global.stageType = global.stageTypeWorld;
        
        with (gml_Script_instance_create(x, y, obj_stageTransition))
        {
            c1 = 65535;
            text1 = global.stageTypeWorld;
            text2 = global.dungeonQuotes[irandom(global.dungeonMaxQuotes)];
        }
    }
    
    with (obj_player)
    {
        if (state == UnknownEnum.Value_7)
        {
            if (readyRaid == 0)
            {
                if (global.chatSpam == 0)
                    gml_Script_twitch_chat_say("/me " + string(name) + " is ready to defend!");
                
                readyRaid = 1;
                levelRaid = level;
                var _partyBonusSpecialized = specialized;
                
                if (_partyBonusSpecialized > 0)
                    _partyBonusSpecialized = 3;
                else
                    _partyBonusSpecialized = 1;
                
                if (class == "rogue")
                    global.rogueBonus += ((1 + myTier) * _partyBonusSpecialized);
                
                if (class == "warrior")
                    global.warriorBonus += ((1 + myTier) * _partyBonusSpecialized);
                
                if (class == "archer")
                    global.rangerBonus += ((1 + myTier) * _partyBonusSpecialized);
                
                if (class == "mage")
                    global.wizardBonus += ((1 + myTier) * _partyBonusSpecialized);
                
                global.raiders += 1;
                
                if (ds_list_find_index(raidList, string(levelRaid) + string(name)) == -1)
                {
                    if (ascended == true)
                    {
                        ds_list_add(raidList, string("Z" + string(raidPos) + string(levelRaid) + string(name)));
                    }
                    else
                    {
                        if (levelRaid < 10)
                            ds_list_add(raidList, string(string(raidPos) + "A" + string(levelRaid) + string(name)));
                        
                        if (levelRaid >= 10 && levelRaid <= 99)
                            ds_list_add(raidList, string(string(raidPos) + "B" + string(levelRaid) + string(name)));
                        
                        if (levelRaid >= 100 && levelRaid <= 999)
                            ds_list_add(raidList, string(string(raidPos) + "C" + string(levelRaid) + string(name)));
                        
                        if (levelRaid >= 1000 && levelRaid <= 9999)
                            ds_list_add(raidList, string(string(raidPos) + "D" + string(levelRaid) + string(name)));
                        
                        if (levelRaid >= 10000 && levelRaid <= 99999)
                            ds_list_add(raidList, string(string(raidPos) + "E" + string(levelRaid) + string(name)));
                        
                        if (levelRaid >= 100000)
                            ds_list_add(raidList, string(string(raidPos) + "F" + string(levelRaid) + string(name)));
                    }
                }
            }
        }
    }
    
    alarm[4] = room_speed * (irandom_range(1000, 1800) - (global.stage * 3));
    
    if (alarm[4] < (room_speed * 180))
        alarm[4] = room_speed * 180;
}
else
{
    alarm[4] = room_speed * 180;
}

enum UnknownEnum
{
    Value_7 = 7
}
