self.scr_commands = function(arg0, arg1, arg2 = 0)
{
    uname = arg0;
    udata = arg1;
    var _cmd = string_lower(string_replace_all(udata, " ", ""));
    show_debug_message("Trimmed CMD from " + string(uname) + ": " + string(_cmd));
    global.checkChat = 300;
    
    if (global.isKick == 1)
        global.checkChat = 600;
    
    if (global.dev == true && (uname != "erohzify" && uname != "room_001"))
        exit;
    
    if (room == r_1)
    {
        with (obj_player)
        {
            if (name == other.uname)
            {
                gml_Script_scr_player_notafk();
                alarm[5] = afkTimer * room_speed;
                afksemi = 0;
            }
        }
    }
    
    if (string_pos("tipped", _cmd) != 0 || string_pos("cheered", _cmd) != 0)
    {
        if ((uname == "erohzify" || uname == "room_001") || (global.premiumChannel == 1 && uname == global.channelName))
        {
            var _length = 0;
            var _secureName = string_insert("@", _cmd, 7);
            var _readHonorPos = 0;
            var _ratio = 1;
            var _value = 10;
            
            if (string_pos("tipped", _cmd) != 0)
            {
                _readHonorPos = string_pos("tipped", _cmd);
                _ratio = 1;
            }
            else if (string_pos("cheered", _cmd) != 0)
            {
                _readHonorPos = string_pos("cheered", _cmd);
                _ratio = 100;
            }
            
            var nameLength = real(string_pos("*", _cmd)) - 1 - 7;
            var _player = string_copy(_cmd, 8, nameLength);
            
            if (nameLength < 4 || string_length(_player) < 4)
                _player = "";
            
            show_debug_message(string(_player) + " tipped and got position is " + string(_readHonorPos));
            var _readHonor = string_digits(string_copy(_cmd, _readHonorPos + 6, 6));
            
            if (_readHonor != "")
            {
                _readHonor = real(_readHonor);
                _readHonor = floor(_readHonor / _ratio) * _value;
                
                if (_readHonor > 0 && _player != "")
                    gml_Script_scr_gainHonor(_readHonor, 1, _player);
            }
            
            show_debug_message(string(_player) + " received " + string(_readHonor) + " honor points!");
        }
        else
        {
            gml_Script_twitch_chat_say("/me You need to become a !!Premium Channel to do this!");
        }
        
        exit;
    }
    
    if (string_pos(global.cmdPrefix, _cmd) == 1)
    {
        var multi = string_count(",", _cmd);
        
        if (multi > 0)
        {
            var cmdFull = _cmd;
            arg2 = 1;
            show_debug_message("MultiCMD (" + string(multi) + "): '" + string(cmdFull) + "'");
            cmdFull += ",";
            
            for (var i = 0; i <= multi; i++)
            {
                var c = string_pos(",", cmdFull);
                var cmd = string_delete(cmdFull, c, string_length(cmdFull));
                cmdFull = string_delete(cmdFull, 1, c);
                show_debug_message("Next CMD: '" + string(cmd) + "' Left: '" + string(cmdFull) + "'");
                
                if (string_pos("room00", cmd) == 0)
                {
                    if (string_pos(string(global.cmdPrefix), cmd) != 1)
                        cmd = string_insert(global.cmdPrefix, cmd, 1);
                }
                
                gml_Script_scr_commands(uname, cmd, 1);
            }
            
            exit;
        }
    }
    
    var _prefix = global.cmdPrefix;
    
    if (_prefix == "!")
    {
        if (string_pos("?", _cmd) != 1 && string_pos("room00", _cmd) != 1)
        {
            if (string_pos(_prefix, _cmd) == 1)
            {
                if (string_pos("?", _cmd) != 0)
                    _cmd = string_lower(string_replace(_cmd, _prefix, ""));
                else
                    _cmd = "!" + string_lower(string_replace(_cmd, _prefix, ""));
            }
            else
            {
                show_debug_message("Chat _cmd (not cmd): " + string(_cmd));
                exit;
            }
            
            show_debug_message("Command from " + string(uname) + ": " + string(_prefix) + " - " + string(_cmd));
        }
    }
    else if (string_pos("room00", _cmd) != 1)
    {
        if (string_pos(_prefix, _cmd) == 1)
        {
            if (string_pos("?", _cmd) != 0)
                _cmd = string_lower(string_replace(_cmd, _prefix, ""));
            else
                _cmd = "!" + string_lower(string_replace(_cmd, _prefix, ""));
        }
        else
        {
            show_debug_message("Chat _cmd (not cmd): " + string(_cmd));
            exit;
        }
        
        show_debug_message("Command from " + string(uname) + ": " + string(_prefix) + " - " + string(_cmd));
    }
    
    if (string_pos("?prefix", _cmd) == 1)
    {
        show_debug_message("Current prefix: " + string(global.cmdPrefix));
        
        if (arg2 == 0)
            gml_Script_twitch_chat_say("/me TP: Dungeon Raiders command prefix on this channel: " + string(global.cmdPrefix));
    }
    
    if (room == r_newgame)
    {
        if (string_pos("!confirm", _cmd) == 1)
        {
            if (uname == "erohzify" || uname == "room_001" || string_lower(uname) == string_lower(global.channelName))
            {
                if (instance_exists(obj_confirm))
                    obj_confirm.alarm[1] = 1;
            }
            
            exit;
        }
        
        if (string_pos("!cancel", _cmd) == 1)
        {
            if (uname == "erohzify" || uname == "room_001" || uname == global.channelName)
            {
                if (instance_exists(obj_confirm))
                    obj_confirm.alarm[2] = 1;
            }
            
            exit;
        }
    }
    else
    {
        if (string_pos("!leak", _cmd) == 1)
        {
            if (uname == "erohzify" || uname == "room_001" || uname == global.channelName)
                global.avoidLeak = !global.avoidLeak;
            
            exit;
        }
        
        if (string_pos("!light", _cmd) == 1)
        {
            if (uname == "erohzify" || uname == "room_001" || uname == global.channelName)
                obj_fog.light += 107;
            
            exit;
        }
        
        if (string_pos("!startwar", _cmd) == 1)
        {
            if (uname == "erohzify" || uname == "room_001" || uname == global.channelName)
            {
                if (global.totalCorruption == 100)
                {
                    obj_raid.alarm[9] = room_speed;
                }
                else
                {
                    if (global.totalCorruption != 100)
                        global.totalCorruption = 100;
                    
                    obj_seasonControl.alarm[3] = room_speed;
                }
            }
            
            exit;
        }
        
        if (global.dev == true)
        {
            if (string_pos("!timeadd", _cmd) == 1)
            {
                if (uname == "erohzify" || uname == "room_001" || uname == global.channelName)
                {
                    var amount = real(string_digits(_cmd));
                    amount *= 60;
                    global.seasonTime += amount;
                    obj_seasonControl.totalSeconds += amount;
                    gml_Script_scr_updateTime();
                }
                
                exit;
            }
            
            if (string_pos("!timesub", _cmd) == 1)
            {
                if (uname == "erohzify" || uname == "room_001" || uname == global.channelName)
                {
                    var amount = real(string_digits(_cmd));
                    amount *= 60;
                    global.seasonTime -= amount;
                    obj_seasonControl.totalSeconds -= amount;
                    gml_Script_scr_updateTime();
                }
                
                exit;
            }
            
            if (string_pos("!timeset", _cmd) == 1)
            {
                if (uname == "erohzify" || uname == "room_001" || uname == global.channelName)
                {
                    var amount = real(string_digits(_cmd));
                    amount *= 60;
                    global.seasonTime = amount;
                    obj_seasonControl.totalSeconds = amount;
                    gml_Script_scr_updateTime();
                }
                
                exit;
            }
        }
        
        if (string_pos("!dev", _cmd) == 1)
        {
            if (uname == "erohzify" || uname == "room_001")
                global.dev = !global.dev;
            
            exit;
        }
        
        if (string_pos("!debug", _cmd) == 1)
        {
            if (uname == "erohzify" || uname == "room_001")
                obj_gameControl.debug = !obj_gameControl.debug;
            
            exit;
        }
        
        if (global.dev == 1 && string_pos("!voc", _cmd) == 1)
        {
            with (obj_player)
            {
                myVocationInfo[irandom(3)][0] += 1;
                gml_Script_scr_updateStats();
            }
        }
        
        if (string_pos("!testsp", _cmd) == 1)
        {
            if (uname == "erohzify" || uname == "room_001")
            {
                with (obj_player)
                {
                    xpvaluespecial = myAbilityInfo[8];
                    gml_Script_scr_player_abilityXP(id);
                }
            }
        }
        
        if (string_pos("!testpet", _cmd) == 1)
        {
            if (uname == "erohzify" || uname == "room_001")
            {
                with (obj_player)
                {
                    if (gotPet[1] == 0)
                    {
                        gotPet[1] = 1;
                        myfood += 50000000;
                        mygold += 50000000;
                        ini_open(string(global.platformDir) + string(myCharDir) + "Data.ini");
                        ini_write_real("Pets", "Got Pet 1", 1);
                        ini_write_real("Pets", "My Pet 1 Level", 1);
                        ini_write_real("Pets", "My Pet 1 XP", 0);
                        ini_close();
                    }
                    else
                    {
                    }
                }
            }
        }
        
        if (string_pos("!hack", _cmd) == 1)
        {
            if (uname == "erohzify" || uname == "room_001")
            {
                with (obj_player)
                {
                    for (var s = 0; s <= 9; s++)
                    {
                        myItemInfo[s][0] = 14;
                        myItemInfo[s][1] = 3;
                        myItemInfo[s][2] = string_repeat("I", myItemInfo[s][1]);
                        baseStat[s][0] = baseStat[s][1];
                    }
                    
                    gml_Script_scr_updateStats();
                    autoAction[1] = 1;
                    autoAction[2] = 1;
                    autoAction[3] = 1;
                    autoAction[4] = 1;
                    mygold += 10000000000;
                    myfood += 10000000000;
                    myGems += 10000;
                    skillPoints += 100000;
                    totalSkillPoints += 100000;
                    
                    if (specialized != 0)
                    {
                        specialPoints[myAbilityInfo[0]] += 100;
                        totalSpecialPoints[myAbilityInfo[0]] += 100;
                    }
                    
                    if (myAbilityInfo[5] < 2)
                        myAbilityInfo[5] = 2;
                    else if (myAbilityInfo[5] < 3)
                        myAbilityInfo[5] = 3;
                    else if (myAbilityInfo[5] == 3)
                        myAbilityInfo[5] = 1;
                    
                    myAbilityInfo[4] = 21 * myAbilityInfo[5];
                    ini_open(string(global.platformDir) + string(myCharDir) + "Data.ini");
                    
                    for (var i = 1; i <= global.maxUniqueItems; i++)
                    {
                        gotUniqueItem[i] += 3;
                        uniqueItemLevel[i] = 100;
                        ini_write_real("Relics", "Got Unique Item " + string(i), gotUniqueItem[i]);
                    }
                    
                    for (var i = 1; i <= global.totalAuras; i++)
                    {
                        gotAura[i] = 1;
                        auraBonus[i] = 50000;
                        gotPet[i] = 1;
                        myPetInfo[i][4] = 30;
                    }
                    
                    ini_close();
                }
                
                gml_Script_scr_savegame();
            }
            
            exit;
        }
        
        if (string_pos("!startraid", _cmd) == 1)
        {
            if (uname == "erohzify" || uname == "room_001")
            {
                if (obj_raid.alarm[1] > -1)
                {
                    obj_raid.alarm[1] = room_speed * 2;
                    obj_raid.alarm[11] = (room_speed * 2) - 1;
                }
            }
            
            exit;
        }
        
        if (string_pos("!savegame", _cmd) == 1)
        {
            if (ds_list_find_index(global.playerList, uname) != -1)
            {
                if (global.inFinalWar == false && global.finalWar == false && room == r_1)
                {
                    if (obj_twitch.alarm[0] <= (room_speed * 2400))
                        obj_twitch.alarm[0] = 1;
                    else
                        gml_Script_twitch_chat_say_direct("/me " + string(uname) + " Last save is too recent! But don't worry, the game automatically saves every hour.");
                }
            }
            else if (arg2 == 0)
            {
                gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
            }
            
            exit;
        }
        
        if (string_pos("!fixraid", _cmd) == 1)
        {
            if (uname == "erohzify" || uname == "room_001" || uname == "sawode" || uname == "razzor1" || uname == "byfd7" || uname == global.channelName || uname == "fxpeanut" || uname == "ethiniel" || uname == "fatninja145")
                global.portalPointsDisplay = global.portalPoints;
            
            exit;
        }
        
        if (string_pos("!setmaxplayers", _cmd) == 1)
        {
            if (uname == "erohzify" || uname == "room_001" || uname == global.channelName)
            {
                var _maxPlayers = string_digits(_cmd);
                
                if (_maxPlayers == "")
                {
                    _maxPlayers = global.maxPlayers;
                }
                else
                {
                    _maxPlayers = real(_maxPlayers);
                    _maxPlayers = clamp(_maxPlayers, 5, 99);
                }
                
                global.maxPlayers = _maxPlayers;
                gml_Script_twitch_chat_say_direct("/me Maximum Players set to " + string(global.maxPlayers) + ".");
            }
        }
        
        if (string_pos("!fixmaxraid", _cmd) == 1)
        {
            if (uname == "erohzify" || uname == "room_001" || uname == "sawode" || uname == "razzor1" || uname == "byfd7" || uname == "lawtribal" || uname == global.channelName)
            {
                if (global.canRaid == true)
                {
                    var raidStage = string_digits(_cmd);
                    
                    if (raidStage == "")
                        raidStage = global.stage;
                    else
                        raidStage = real(raidStage);
                    
                    with (obj_raid)
                    {
                        ini_open(string(global.platformDir) + "Village Data/Data.ini");
                        
                        for (var i = 0; i <= floor(raidStage / 50); i++)
                        {
                            if (ini_read_real("Minibosses", "Miniboss " + string(i) + " Relic 1", 0) == 0)
                            {
                                specialRaid[i][0] = 1;
                                
                                if (i <= 1)
                                {
                                    var _relic1 = irandom_range(1, global.maxUniqueItems);
                                    var _relic2;
                                    
                                    do
                                        _relic2 = irandom_range(1, global.maxUniqueItems);
                                    until (_relic2 != _relic1);
                                    
                                    var _relic3;
                                    
                                    do
                                        _relic3 = irandom_range(1, global.maxUniqueItems);
                                    until (_relic3 != _relic1 && _relic3 != _relic2);
                                    
                                    specialRaid[floor(i)][1] = ini_read_real("Minibosses", "Miniboss " + string(floor(i)) + " Relic 1", _relic1);
                                    specialRaid[floor(i)][2] = ini_read_real("Minibosses", "Miniboss " + string(floor(i)) + " Relic 2", _relic2);
                                    specialRaid[floor(i)][3] = ini_read_real("Minibosses", "Miniboss " + string(floor(i)) + " Relic 3", _relic3);
                                }
                                else
                                {
                                    var _relic1;
                                    
                                    do
                                        _relic1 = irandom_range(1, global.maxUniqueItems);
                                    until (_relic1 != specialRaid[floor(i - 1)][1] && _relic1 != specialRaid[floor(i - 1)][2] && _relic1 != specialRaid[floor(i - 1)][3]);
                                    
                                    var _relic2;
                                    
                                    do
                                        _relic2 = irandom_range(1, global.maxUniqueItems);
                                    until (_relic2 != _relic1 && _relic2 != specialRaid[floor(i - 1)][1] && _relic2 != specialRaid[floor(i - 1)][2] && _relic2 != specialRaid[floor(i - 1)][3]);
                                    
                                    var _relic3;
                                    
                                    do
                                        _relic3 = irandom_range(1, global.maxUniqueItems);
                                    until (_relic3 != _relic1 && _relic3 != _relic2 && _relic3 != specialRaid[floor(i - 1)][1] && _relic3 != specialRaid[floor(i - 1)][2] && _relic3 != specialRaid[floor(i - 1)][3]);
                                    
                                    specialRaid[floor(i)][1] = ini_read_real("Minibosses", "Miniboss " + string(floor(i)) + " Relic 1", _relic1);
                                    specialRaid[floor(i)][2] = ini_read_real("Minibosses", "Miniboss " + string(floor(i)) + " Relic 2", _relic2);
                                    specialRaid[floor(i)][3] = ini_read_real("Minibosses", "Miniboss " + string(floor(i)) + " Relic 3", _relic3);
                                }
                                
                                specialRaid[i][4] = ini_read_real("Minibosses", "Miniboss " + string(i) + " Type", irandom(2));
                                ini_write_real("Minibosses", "Miniboss " + string(i) + " Respawn Time", -1);
                                ini_write_real("Minibosses", "Miniboss " + string(i) + " Relic 1", specialRaid[i][1]);
                                ini_write_real("Minibosses", "Miniboss " + string(i) + " Relic 2", specialRaid[i][2]);
                                ini_write_real("Minibosses", "Miniboss " + string(i) + " Relic 3", specialRaid[i][3]);
                                ini_write_real("Minibosses", "Miniboss " + string(i) + " Type", specialRaid[i][4]);
                                custom_alarm[50 + i][0] = specialRaid[i][0];
                                show_debug_message("Territory Boss " + string(i) + " unlocked for the first time! R1: " + string(specialRaid[i][1]) + ", total array length: " + string(array_length(specialRaid)));
                            }
                            else
                            {
                                specialRaid[i][0] = ini_read_real("Minibosses", "Miniboss " + string(i) + " Respawn Time", -1);
                                specialRaid[i][1] = ini_read_real("Minibosses", "Miniboss " + string(i) + " Relic 1", 1 + irandom(global.maxUniqueItems - 1));
                                specialRaid[i][2] = ini_read_real("Minibosses", "Miniboss " + string(i) + " Relic 2", 1 + irandom(global.maxUniqueItems - 1));
                                specialRaid[i][3] = ini_read_real("Minibosses", "Miniboss " + string(i) + " Relic 3", 1 + irandom(global.maxUniqueItems - 1));
                                specialRaid[i][4] = ini_read_real("Minibosses", "Miniboss " + string(i) + " Type", irandom(2));
                                custom_alarm[50 + i][0] = specialRaid[i][0];
                                
                                if (custom_alarm[50 + i][0] != -1)
                                {
                                    gml_Script_scr_alarm_start(50 + i, specialRaid[i][0], gml_Script_scr_territoryBoss_spawn(i));
                                    show_debug_message("Territory Boss " + string(i) + " spawning in " + string(custom_alarm[50 + i][0]));
                                }
                                else
                                {
                                    show_debug_message("Territory Boss " + string(i) + " spawning available");
                                }
                            }
                        }
                        
                        ini_close();
                    }
                    
                    global.ostage = raidStage;
                    global.stage = global.ostage;
                }
                else if (arg2 == 0)
                {
                    gml_Script_twitch_chat_say_direct("/me " + string(uname) + " Please wait until " + string(global.cmdPrefix) + "raid is available to execute this command.");
                }
            }
            
            exit;
        }
        
        if (string_pos("!chatspam", _cmd) == 1)
        {
            if (uname == "erohzify" || uname == "room_001" || uname == "sawode" || uname == "razzor1" || uname == "byfd7" || uname == "lawtribal" || uname == global.channelName)
            {
                var _chatSpam = string_digits(_cmd);
                
                if (_chatSpam == "")
                {
                    _chatSpam = "?";
                }
                else
                {
                    _chatSpam = real(_chatSpam);
                    
                    if (_chatSpam < 0)
                        _chatSpam = 0;
                    
                    if (_chatSpam > 3)
                        _chatSpam = 3;
                }
                
                if (_chatSpam != "?")
                    global.chatSpam = _chatSpam;
                
                if (arg2 == 0)
                    gml_Script_twitch_chat_say_direct("/me Chat spam prevention level set to " + string(global.chatSpam) + " (0 to 3, weaker to stronger spam filter).");
                
                ini_open(string(global.platformDir) + "Core Data/Permanent.ini");
                ini_write_real("Settings", "Chat Spam", global.chatSpam);
                ini_close();
            }
            
            exit;
        }
        
        if (string_pos("?chatspam", _cmd) == 1)
        {
            if (arg2 == 0)
                gml_Script_twitch_chat_say_direct("/me Chat spam prevention level set to " + string(global.chatSpam) + " (0 to 3, weaker to stronger spam filter).");
            
            exit;
        }
        
        if (string_pos("!startportal", _cmd) == 1)
        {
            if (uname == "erohzify" || uname == "room_001")
            {
                if (obj_bossKey.alarm[0] != -1)
                    obj_bossKey.alarm[0] = room_speed * 3;
            }
            
            exit;
        }
        
        if (string_pos("!startredportal", _cmd) == 1)
        {
            if (uname == "erohzify" || uname == "room_001")
            {
                if (obj_corruptedControl.alarm[0] != -1)
                    obj_corruptedControl.alarm[0] = room_speed * 3;
            }
            
            exit;
        }
        
        if (string_pos("!fixportal", _cmd) == 1)
        {
            if (uname == "erohzify" || uname == "room_001")
            {
                setTimer = real(string_digits(_cmd));
                
                if (obj_bossKey.alarm[0] != -1)
                    obj_bossKey.alarm[0] = setTimer * room_speed * 60;
            }
            
            exit;
        }
        
        if (string_pos("!forceguard", _cmd) == 1)
        {
            if (uname == "erohzify" || uname == "room_001")
            {
                choosePlayer = string_delete(_cmd, 1, 12);
                
                with (obj_player)
                {
                    if (name == string_lettersdigits(other.choosePlayer))
                        state = UnknownEnum.Value_7;
                }
            }
            
            exit;
        }
        
        if (string_pos("!allguard", _cmd) == 1)
        {
            if (uname == "erohzify" || uname == "room_001" || uname == global.channelName)
            {
                with (obj_player)
                {
                    if (state == UnknownEnum.Value_0)
                        state = UnknownEnum.Value_7;
                }
            }
            
            exit;
        }
        
        if (string_pos("!forceportal", _cmd) == 1)
        {
            if (uname == "erohzify" || uname == "room_001")
            {
                choosePlayer = string_delete(_cmd, 1, 13);
                
                with (obj_player)
                {
                    if (name == string_lettersdigits(other.choosePlayer))
                    {
                        usePortal = global.portalID;
                        alarm[8] += room_speed * 3600;
                        alarm[9] += room_speed * 3600;
                        gml_Script_scr_updateStats();
                        
                        if (obj_bossKey.alarm[0] == -1)
                        {
                            obj_bossKey.alarm[0] = room_speed * 3600;
                            
                            if (arg2 == 0)
                                gml_Script_twitch_chat_say("/color BlueViolet");
                            
                            if (arg2 == 0)
                                gml_Script_twitch_chat_say_direct("/me " + string(name) + " has opened the portal. Type " + string(global.cmdPrefix) + "portal to claim your reward...");
                            
                            if (arg2 == 0)
                                gml_Script_twitch_chat_say("/color FireBrick");
                        }
                        
                        if (ds_list_find_index(global.raidListPortalName, string(name)) == -1)
                        {
                            ds_list_add(global.raidListPortalName, string(name));
                            ds_list_add(global.raidListPortalClass, string(class));
                        }
                    }
                }
            }
            
            exit;
        }
        
        if (string_pos("!allportal", _cmd) == 1)
        {
            if (uname == "erohzify" || uname == "room_001")
            {
                if (obj_bossKey.alarm[0] == -1)
                    obj_bossKey.alarm[0] = room_speed * 3600;
                
                with (obj_player)
                {
                    usePortal = global.portalID;
                    alarm[8] += room_speed * 3600;
                    alarm[9] += room_speed * 3600;
                    gml_Script_scr_updateStats();
                    
                    if (ds_list_find_index(global.raidListPortalName, string(name)) == -1)
                    {
                        ds_list_add(global.raidListPortalName, string(name));
                        ds_list_add(global.raidListPortalClass, string(class));
                    }
                }
            }
            
            exit;
        }
        
        if (string_pos("!allredportal", _cmd) == 1)
        {
            if (uname == "erohzify" || uname == "room_001")
            {
                if (obj_corruptedControl.alarm[0] == -1)
                    obj_corruptedControl.alarm[0] = room_speed * 3600;
                
                with (obj_player)
                {
                    useRedPortal = global.redPortalID;
                    gml_Script_scr_updateStats();
                    
                    if (ds_list_find_index(global.raidListRedPortalName, string(name)) == -1)
                    {
                        ds_list_add(global.raidListRedPortalName, string(name));
                        ds_list_add(global.raidListRedPortalClass, string(class));
                    }
                }
            }
            
            exit;
        }
        
        if (string_pos("!bunny", _cmd) == 1)
        {
            if (arg2 == 0)
                gml_Script_twitch_chat_say_direct("/me Golden Bunnies found this Campaign: " + string(global.creditsBunnies) + "/" + string(global.totalBunnies) + ".");
            
            exit;
        }
        
        if (string_pos("!goldenbunny", _cmd) == 1)
        {
            if (uname == "erohzify" || uname == "room_001")
            {
                gml_Script_instance_create(choose(-20, room_width + 20), room_height - 15, obj_goldenBunny);
            }
            else if (uname == global.channelName)
            {
                if (global.creditsBunnies < global.totalBunnies)
                    gml_Script_instance_create(choose(-20, room_width + 20), room_height - 15, obj_goldenBunny);
            }
            
            exit;
        }
        
        if (string_pos("!showbuff", _cmd) == 1)
        {
            if (uname == "erohzify" || uname == "room_001")
            {
                global.showStatChange = !global.showStatChange;
                gml_Script_twitch_chat_say("/me Raid buffs/debuffs display: " + string(global.showStatChange));
            }
            
            exit;
        }
        
        if (string_pos("!cameramove", _cmd) == 1)
        {
            if (uname == "erohzify" || uname == "room_001")
            {
                if (global.cameraMove == false)
                    global.cameraMove = true;
                else
                    global.cameraMove = false;
            }
            
            exit;
        }
        
        if (string_pos("!clear", _cmd) == 1)
        {
            if (uname == "room_001" || uname == "erohzify")
            {
                var _clear = string_delete(_cmd, 1, 7);
                
                with (obj_player)
                {
                    if (name == _clear)
                    {
                        ini_open(string(global.platformDir) + string(myCharDir) + "Data.ini");
                        ini_write_real("Honor", "Account Honor", honor);
                        ini_write_real("Honor", "Account Level", honorLevel);
                        ini_key_delete("Honor", "Honor Points");
                        honorPoints = honorLevel * 100;
                        
                        for (var ui = 1; ui < (global.maxUniqueItems + 1); ui += 1)
                        {
                            ini_key_delete("Relics", "Got Unique Item " + string(ui));
                            ini_key_delete("Relics", "Unique Item " + string(ui) + " Level");
                        }
                        
                        ini_key_delete("Relics", "Equipped Unique Item");
                        ini_key_delete("Resources", "Gems");
                        myGems = 1;
                        ini_close();
                    }
                }
            }
            
            exit;
        }
        
        if (global.inFinalWar == false)
        {
            if (room == r_corrupted)
            {
                if (string_pos("!island", _cmd) == 1)
                {
                    var _island = string_digits(_cmd);
                    
                    if (_island != "")
                        _island = real(_island);
                    else
                        _island = "";
                    
                    if (_island == "")
                    {
                        gml_Script_twitch_chat_say("/me " + string(name) + " please enter a valid Island ID!");
                        exit;
                    }
                    
                    if (obj_corruptedControl.alarm[1] != -1)
                    {
                        with (obj_player)
                        {
                            if (name == other.uname)
                            {
                                var _name = name;
                                
                                if (ds_list_find_index(global.islandVoting, name) == -1)
                                {
                                    if (instance_exists(obj_corruptedIsland))
                                    {
                                        with (obj_corruptedIsland)
                                        {
                                            if (sector == global.corruptedSector && level == global.corruptedLevel)
                                            {
                                                if (voteID == _island)
                                                {
                                                    votes += 1;
                                                    ds_list_add(global.islandVoting, other.name);
                                                    
                                                    if (ds_list_size(global.islandVoting) >= ds_list_size(global.raidListRedPortalName))
                                                        obj_corruptedControl.alarm[1] = room_speed;
                                                    
                                                    gml_Script_twitch_chat_say_direct("/me " + string(_name) + " voted for Island #" + string(_island) + " (" + string(name) + ").");
                                                }
                                            }
                                        }
                                    }
                                    else
                                    {
                                    }
                                }
                                else
                                {
                                    gml_Script_twitch_chat_say("/me " + string(name) + " you have already participated.");
                                }
                            }
                        }
                    }
                }
                
                if (string_pos("!vote", _cmd) == 1 && string_pos("!voteswitch", _cmd) != 1)
                {
                    var _card = string_digits(_cmd);
                    
                    if (_card != "")
                        _card = real(_card);
                    else
                        _card = "";
                    
                    if (_card == "")
                    {
                        gml_Script_twitch_chat_say("/me " + string(name) + " please enter a valid Corrupted Modifier ID!");
                        exit;
                    }
                    
                    with (obj_player)
                    {
                        if (name == other.uname)
                        {
                            var _name = name;
                            
                            if (ds_list_find_index(global.corruptedCardVoting, name) == -1)
                            {
                                if (instance_exists(obj_corruptedCard))
                                {
                                    if (instance_exists(obj_raidCorruptedResults))
                                    {
                                        if (obj_raidCorruptedResults.alarm[1] > -1)
                                        {
                                            with (obj_corruptedCard)
                                            {
                                                if ((myID + 1) == _card)
                                                {
                                                    votes += 1;
                                                    ds_list_add(global.corruptedCardVoting, other.name);
                                                    
                                                    if (ds_list_size(global.corruptedCardVoting) >= ds_list_size(global.raidListRedPortalName))
                                                        obj_raidCorruptedResults.alarm[1] = room_speed;
                                                    
                                                    gml_Script_twitch_chat_say_direct("/me " + string(_name) + " voted for Corruption Shard #" + string(_card) + " (" + string(name) + ").");
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            else
                            {
                                gml_Script_twitch_chat_say("/me " + string(name) + " you have already participated.");
                            }
                        }
                    }
                }
            }
            
            if (string_pos("!spawn", _cmd) == 1)
            {
                if (uname == "erohzify" || uname == "room_001")
                {
                    var nameLength = real(string_pos("*", _cmd)) - 7;
                    spawnName = string_copy(_cmd, 7, nameLength);
                    spawnClass = string_letters(string_delete(_cmd, 1, nameLength + 7));
                    spawnFull = string(string(spawnName) + string(spawnClass));
                    
                    if (arg2 == 0)
                        gml_Script_twitch_chat_say("/me " + string(spawnName) + " - " + string(spawnClass) + " - " + string(spawnFull) + " You are already in!");
                    
                    if (ds_list_find_index(global.playerList, spawnName) == -1)
                        gml_Script_scr_spawnCharacter(spawnName, spawnClass, spawnFull);
                }
                
                exit;
            }
            
            if (instance_exists(obj_goldenBunny))
            {
                if (string_pos("!" + string(obj_goldenBunny.word), _cmd) != 0)
                {
                    with (obj_goldenBunny)
                        hp -= 1;
                    
                    exit;
                }
            }
            
            if (string_pos("!tame", _cmd) == 1)
            {
                var petName = string_letters(string_delete(_cmd, 1, 5));
                
                if (instance_exists(obj_wildPet))
                {
                    with (obj_player)
                    {
                        if (name == other.uname)
                        {
                            show_debug_message("step 1/3");
                            
                            if (name == obj_wildPet._playerName)
                            {
                                show_debug_message("step 2/3");
                                
                                if (obj_wildPet.name == petName)
                                {
                                    show_debug_message("step 3/3");
                                    obj_wildPet.hp -= 1;
                                }
                            }
                        }
                    }
                }
                
                exit;
            }
            
            if (string_pos("!attack", _cmd) == 1)
            {
                if (uname == "erohzify" || uname == global.channelName)
                    obj_raid.alarm[4] = room_speed * 10;
                
                exit;
            }
            
            if (string_pos("!fill", _cmd) == 1)
            {
                if (uname == "erohzify" || uname == "room_001")
                {
                    global.gold = global.maxGold;
                    global.food = global.maxFood;
                    global.souls = 100000000;
                }
                else if (arg2 == 0)
                {
                    gml_Script_twitch_chat_say("Kappa");
                }
                
                exit;
            }
            
            if (string_pos("!resetgold", _cmd) == 1)
            {
                if (uname == "erohzify" || uname == "room_001" || uname == global.channelName)
                {
                    global.gold = 0;
                }
                else
                {
                }
                
                exit;
            }
            
            if (string_pos("!favor", _cmd) == 1)
            {
                if (uname == "erohzify" || uname == "room_001")
                {
                    global.godsHonor += (global.godsHonorMax - global.godsHonor);
                    
                    with (obj_god)
                    {
                        alarm[1] = 1;
                        alarm[2] = 1;
                        alarm[3] = 1;
                    }
                }
                else if (arg2 == 0)
                {
                    gml_Script_twitch_chat_say("LUL");
                }
                
                exit;
            }
            
            if (string_pos("!voteswitch", _cmd) == 1)
            {
                var _fftype = string_digits(_cmd);
                
                if (_fftype == "")
                    _fftype = 0;
                
                if (_fftype != "")
                    _fftype = real(_fftype);
                
                var _name = "";
                
                if (global.challenge_canSwitch == 0)
                {
                    gml_Script_twitch_chat_say_direct("/me Switching is currently disabled!");
                    exit;
                }
                
                if (ds_list_find_index(global.playerList, uname) != -1)
                {
                    if (instance_exists(obj_warrior) && global.raiding == true)
                    {
                        with (obj_warrior)
                        {
                            if (name == other.uname)
                                _name = name;
                        }
                        
                        if (_name == "")
                            exit;
                        
                        if (!instance_exists(obj_voteFF))
                        {
                            with (gml_Script_instance_create(x, y, obj_voteFF))
                            {
                                type = _fftype;
                                voteName = _name;
                                next = "";
                                minVotes = ceil(instance_number(obj_warrior) / 2);
                                votes = 0;
                                alarm[0] = 1;
                                alarm[1] = room_speed * 15;
                            }
                        }
                        else if (arg2 == 0)
                        {
                            gml_Script_twitch_chat_say("/me A poll is currently being made, please wait until the decision is made to start a new one.");
                        }
                    }
                }
                else if (arg2 == 0)
                {
                    gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
                }
                
                exit;
            }
            
            if (string_pos("!voteyes", _cmd) == 1 || string_pos("voteyea", _cmd) == 1 || string_pos("!y", _cmd) == 1)
            {
                if (ds_list_find_index(global.playerList, uname) != -1)
                {
                    if (instance_exists(obj_voteFF))
                    {
                        with (obj_player)
                        {
                            if (name == other.uname)
                            {
                                if (ds_list_find_index(obj_voteFF.voteList, name) == -1)
                                {
                                    with (obj_voteFF)
                                        yesVotes += 1;
                                    
                                    with (obj_voteFF)
                                        votes += 1;
                                    
                                    ds_list_add(obj_voteFF.voteList, name);
                                    
                                    if (arg2 == 0)
                                        gml_Script_twitch_chat_say_direct("/me " + string(obj_voteFF.votes) + " votes. " + string(obj_voteFF.minVotes - obj_voteFF.votes) + " left to decide. [Yes: " + string(obj_voteFF.yesVotes) + " | No: " + string(obj_voteFF.noVotes) + " ]");
                                    
                                    if (obj_voteFF.votes >= obj_voteFF.minVotes)
                                        obj_voteFF.alarm[1] = 1;
                                }
                                else if (arg2 == 0)
                                {
                                    gml_Script_twitch_chat_say("/me " + string(name) + " You have already voted.");
                                }
                            }
                        }
                    }
                    
                    if (instance_exists(obj_votePoll_new))
                    {
                        if (obj_votePoll_new.alarm[2] == -1)
                        {
                            with (obj_player)
                            {
                                if (name == other.uname)
                                {
                                    if (ds_list_find_index(obj_votePoll_new.voteList, name) == -1)
                                    {
                                        with (obj_votePoll_new)
                                            yesVotes += (1 + other.sub);
                                        
                                        with (obj_votePoll_new)
                                            votes += (1 + other.sub);
                                        
                                        ds_list_add(obj_votePoll_new.voteList, name);
                                        
                                        if (arg2 == 0)
                                            gml_Script_twitch_chat_say_direct("/me " + string(obj_votePoll_new.votes) + " votes. " + string(obj_votePoll_new.minVotes - obj_votePoll_new.votes) + " left to decide. [Yes: " + string(obj_votePoll_new.yesVotes) + " | No: " + string(obj_votePoll_new.noVotes) + " ]");
                                        
                                        if (obj_votePoll_new.votes >= obj_votePoll_new.minVotes)
                                            obj_votePoll_new.alarm[1] = 1;
                                    }
                                    else if (arg2 == 0)
                                    {
                                        gml_Script_twitch_chat_say("/me " + string(name) + " You have already voted.");
                                    }
                                }
                            }
                        }
                    }
                }
                else if (arg2 == 0)
                {
                    gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
                }
                
                exit;
            }
            
            if (string_pos("!voteno", _cmd) == 1 || string_pos("votenay", _cmd) == 1 || string_pos("!n", _cmd) == 1)
            {
                if (ds_list_find_index(global.playerList, uname) != -1)
                {
                    if (instance_exists(obj_voteFF))
                    {
                        with (obj_player)
                        {
                            if (name == other.uname)
                            {
                                if (ds_list_find_index(obj_voteFF.voteList, name) == -1)
                                {
                                    with (obj_voteFF)
                                        noVotes += 1;
                                    
                                    with (obj_voteFF)
                                        votes += 1;
                                    
                                    ds_list_add(obj_voteFF.voteList, name);
                                    
                                    if (arg2 == 0)
                                        gml_Script_twitch_chat_say_direct("/me " + string(obj_voteFF.votes) + " votes. " + string(obj_voteFF.minVotes - obj_voteFF.votes) + " left to decide. [Yes: " + string(obj_voteFF.yesVotes) + " | No: " + string(obj_voteFF.noVotes) + " ]");
                                    
                                    if (obj_voteFF.votes >= obj_voteFF.minVotes)
                                        obj_voteFF.alarm[1] = 1;
                                }
                                else if (arg2 == 0)
                                {
                                    gml_Script_twitch_chat_say("/me " + string(name) + " You have already voted.");
                                }
                            }
                        }
                    }
                    
                    if (instance_exists(obj_votePoll_new))
                    {
                        with (obj_player)
                        {
                            if (name == other.uname)
                            {
                                if (ds_list_find_index(obj_votePoll_new.voteList, name) == -1)
                                {
                                    with (obj_votePoll_new)
                                        noVotes += (1 + other.sub);
                                    
                                    with (obj_votePoll_new)
                                        votes += (1 + other.sub);
                                    
                                    ds_list_add(obj_votePoll_new.voteList, name);
                                    
                                    if (arg2 == 0)
                                        gml_Script_twitch_chat_say_direct("/me " + string(obj_votePoll_new.votes) + " votes. " + string(obj_votePoll_new.minVotes - obj_votePoll_new.votes) + " left to decide. [Yes: " + string(obj_votePoll_new.yesVotes) + " | No: " + string(obj_votePoll_new.noVotes) + " ]");
                                    
                                    if (obj_votePoll_new.votes >= obj_votePoll_new.minVotes)
                                        obj_votePoll_new.alarm[1] = 1;
                                }
                                else if (arg2 == 0)
                                {
                                    gml_Script_twitch_chat_say("/me " + string(name) + " You have already voted.");
                                }
                            }
                        }
                    }
                }
                else if (arg2 == 0)
                {
                    gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
                }
                
                exit;
            }
            
            if (room == global.room_underworld)
            {
                if (string_pos("!join", _cmd) == 1 || string_pos("join", _cmd) == 1)
                {
                    if (ds_list_find_index(global.playerList, uname) == -1)
                    {
                        if (arg2 == 0)
                            gml_Script_twitch_chat_say("/me " + string(uname) + " Raiders have travelled to the Underworld, please wait until they get back!");
                    }
                    
                    exit;
                }
                
                if (string_pos("!loot", _cmd) == 1)
                {
                    if (global.relicDrop == true)
                    {
                        if (ds_list_find_index(global.rewardList, uname) != -1)
                        {
                            if (ds_list_find_index(global.relicList, uname) == -1)
                            {
                                ds_list_add(global.relicList, uname);
                                
                                if (global.chatSpam <= 2)
                                {
                                    if (arg2 == 0)
                                        gml_Script_twitch_chat_say_direct("/me " + string(uname) + " is taking part on the Relic drop!");
                                }
                            }
                        }
                        else if (global.chatSpam <= 2)
                        {
                            if (arg2 == 0)
                                gml_Script_twitch_chat_say_direct("/me " + string(uname) + " you are not eligible to loot this Relic!");
                        }
                    }
                    
                    exit;
                }
            }
            
            if (room == r_1)
            {
                if (string_pos("!loot", _cmd) == 1)
                {
                    if (global.relicDrop == true)
                    {
                        if (ds_list_find_index(global.rewardList, uname) != -1)
                        {
                            if (ds_list_find_index(global.relicList, uname) == -1)
                            {
                                ds_list_add(global.relicList, uname);
                                
                                if (global.chatSpam <= 2)
                                {
                                    if (arg2 == 0)
                                        gml_Script_twitch_chat_say_direct("/me " + string(uname) + " is taking part on the Relic drop!");
                                }
                            }
                        }
                        else if (global.chatSpam <= 2)
                        {
                            if (arg2 == 0)
                                gml_Script_twitch_chat_say_direct("/me " + string(uname) + " you are not eligible to loot this Relic!");
                        }
                    }
                    
                    exit;
                }
                
                if (string_pos("!chest", _cmd) == 1)
                {
                    if (ds_list_find_index(global.playerList, uname) != -1)
                    {
                        var _index, _amount;
                        
                        if (string_pos("*", _cmd) != 0)
                        {
                            var _length = real(string_pos("*", _cmd));
                            _index = string_digits(string_copy(_cmd, 1, _length));
                            
                            if (_index != "")
                                _index = real(_index);
                            else
                                exit;
                            
                            _amount = string_digits(string_delete(_cmd, 1, _length));
                            
                            if (_amount != "")
                                _amount = real(_amount);
                            else
                                _amount = 1;
                            
                            show_debug_message("Chest: slot " + string(_index) + " - " + string(_amount) + "x");
                        }
                        else
                        {
                            _index = string_digits(_cmd);
                            
                            if (_index != "")
                                _index = real(_index);
                            else
                                _index = 0;
                            
                            _amount = 1;
                        }
                        
                        var rewardID = _index;
                        var chooseAmount = _amount;
                        
                        if (rewardID >= 1 && rewardID <= 3)
                        {
                            if (instance_exists(obj_build_guildhall))
                            {
                                if (global.maxChestUses > 0)
                                {
                                    if (obj_gameControl.alarm[4] == -1)
                                    {
                                        var _value = ds_map_find_value(global.keyMap, string(uname));
                                        
                                        if (is_undefined(_value))
                                        {
                                            ds_map_add(global.keyMap, string(uname), 0);
                                            _value = 0;
                                        }
                                        
                                        if (chooseAmount > (global.maxChestUses - _value))
                                            chooseAmount = global.maxChestUses - _value;
                                        
                                        if (_value < global.maxChestUses)
                                        {
                                            with (obj_player)
                                            {
                                                if (name == other.uname)
                                                {
                                                    var _chatText = "/me " + string(name) + " Opened (" + string(chooseAmount) + "x) Reward Chest #" + string(rewardID) + "!";
                                                    
                                                    if (rewardID == 1)
                                                        _chatText += (" [+" + gml_Script_scr_bigNumber(global.chestReward[1][2] * chooseAmount) + " gems and +" + gml_Script_scr_bigNumber(global.chestReward[1][1] * myMultiplier[4] * global.globalGoldBonus * chooseAmount) + " gold!]");
                                                    
                                                    if (rewardID == 2)
                                                        _chatText += (" [+" + gml_Script_scr_bigNumber(global.chestReward[2][2] * chooseAmount) + " talent points and +" + gml_Script_scr_bigNumber(global.chestReward[2][1] * myMultiplier[2] * global.globalXPBonus * chooseAmount) + " XP!]");
                                                    
                                                    if (rewardID == 3)
                                                        _chatText += (" [+" + string(global.chestReward[3][3] * chooseAmount) + " Relic " + string(global.chestReward[3][1]) + ", +" + string(global.chestReward[3][4] * chooseAmount) + " Relic " + string(global.chestReward[3][2]) + "]");
                                                    
                                                    for (var _x = 0; _x < chooseAmount; _x++)
                                                    {
                                                        ds_map_replace(global.keyMap, string(name), ds_map_find_value(global.keyMap, string(name)) + 1);
                                                        _value = ds_map_find_value(global.keyMap, string(name));
                                                        ini_open(string(global.platformDir) + string(myAccDir) + "Character Data.ini");
                                                        
                                                        if (rewardID == 1)
                                                        {
                                                            myGems += global.chestReward[1][2];
                                                            gml_Script_scr_player_reward(global.chestReward[1][1], 1);
                                                            achievement[25] += global.chestReward[1][2];
                                                            ini_write_real("Resources", "Gems", myGems);
                                                        }
                                                        
                                                        if (rewardID == 2)
                                                        {
                                                            skillPoints += global.chestReward[2][2];
                                                            totalSkillPoints += global.chestReward[2][2];
                                                            gml_Script_scr_player_reward(global.chestReward[2][1], 0);
                                                        }
                                                        
                                                        if (rewardID == 3)
                                                        {
                                                            ini_close();
                                                            ini_open(string(global.platformDir) + string(myCharDir) + "Data.ini");
                                                            gotUniqueItem[global.chestReward[3][1]] += global.chestReward[3][3];
                                                            gotUniqueItem[global.chestReward[3][2]] += global.chestReward[3][4];
                                                            achievement[13] += global.chestReward[3][3] + global.chestReward[3][4];
                                                            ini_write_real("Relics", "Got Unique Item " + string(global.chestReward[3][1]), gotUniqueItem[global.chestReward[3][1]]);
                                                            ini_write_real("Relics", "Got Unique Item " + string(global.chestReward[3][2]), gotUniqueItem[global.chestReward[3][2]]);
                                                            ini_close();
                                                            ini_open(string(global.platformDir) + string(myAccDir) + "Character Data.ini");
                                                        }
                                                        
                                                        useChest += 1;
                                                        myRewardID = global.globalRewardID;
                                                        ini_write_real("Chests", "Chest Uses", useChest);
                                                        ini_write_real("Chests", "Chest " + string(rewardID) + " ID", global.chestID[rewardID]);
                                                        ini_write_real("Chests", "My Reward ID", global.globalRewardID);
                                                        ini_close();
                                                        gml_Script_scr_playsound(s_favorTrigger, 1.2, 1.3, 0.5);
                                                        achievement[22] += 1;
                                                        var keyList = ds_map_write(global.keyMap);
                                                        ini_open(string(global.platformDir) + "Village Data/Data.ini");
                                                        ini_write_string("Buildings", "Key List", keyList);
                                                        ini_close();
                                                    }
                                                    
                                                    _chatText += (" (" + string(global.maxChestUses - _value) + " keys left.)");
                                                    
                                                    if (global.chatSpam <= 2 && arg2 == 0)
                                                        gml_Script_twitch_chat_say_direct(_chatText);
                                                }
                                            }
                                        }
                                        else if (arg2 == 0)
                                        {
                                            gml_Script_twitch_chat_say("/me " + string(uname) + " You can not open more chests! To be able to do that, you must upgrade the Guild Hall.");
                                        }
                                    }
                                    else if (arg2 == 0)
                                    {
                                        gml_Script_twitch_chat_say("/me " + string(uname) + " There is still work to do before that! Contribute in quests to increase the Reward Chests value [" + string(round(obj_gameControl.alarm[4] / room_speed / 60)) + " minutes left to open].");
                                    }
                                }
                                else if (arg2 == 0)
                                {
                                    gml_Script_twitch_chat_say("/me " + string(uname) + " You must upgrade the Guild Hall to level 10 to open Reward Chests.");
                                }
                            }
                            else if (arg2 == 0)
                            {
                                gml_Script_twitch_chat_say("/me " + string(uname) + " You must build the Guild Hall and upgrade it to level 10 to unlock Reward Chests.");
                            }
                        }
                        else if (arg2 == 0)
                        {
                            gml_Script_twitch_chat_say("/me " + string(uname) + " This Reward Chest does not exist.");
                        }
                    }
                    else if (arg2 == 0)
                    {
                        gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
                    }
                    
                    exit;
                }
                
                if (string_pos("!afk", _cmd) == 1)
                {
                    if (uname == "erohzify" || uname == "room_001")
                    {
                        with (obj_player)
                        {
                            if (afk == false)
                            {
                                path_end();
                                state = UnknownEnum.Value_0;
                                alarm[3] = 1;
                            }
                        }
                    }
                    else if (arg2 == 0)
                    {
                        gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
                    }
                    
                    exit;
                }
                
                if (string_pos("!farm", _cmd) == 1 || string_pos("farm", _cmd) == 1 || string_pos("room00farm", _cmd) == 1)
                {
                    if (ds_list_find_index(global.playerList, uname) != -1)
                    {
                        with (obj_player)
                        {
                            if (name == other.uname)
                            {
                                if (state != UnknownEnum.Value_8 && state != UnknownEnum.Value_12 && toPortal == false)
                                {
                                    if (obj_build_farm.currentSlots < global.maxFarm)
                                    {
                                        path_end();
                                        
                                        if (farmAura != 0)
                                        {
                                            myAura = farmAura;
                                            auraIcon = oauraIcon[myAura];
                                            spr_aura = auraIcon;
                                            gml_Script_scr_updateStats();
                                        }
                                        
                                        state = UnknownEnum.Value_3;
                                        target = obj_build_farm;
                                        actionPath = path_add();
                                        var w = 100;
                                        var h = 40;
                                        gotoX = random_range(target.x - w, target.x + w);
                                        gotoY = random_range(target.y - h, target.y + h);
                                        
                                        if (mp_grid_path(global.gameGrid, actionPath, x, y, gotoX, gotoY, 1))
                                            path_start(actionPath, moveSpeed * global.roomSpeed, path_action_stop, 0);
                                    }
                                    else if (arg2 == 0)
                                    {
                                        gml_Script_twitch_chat_say("/me " + string(name) + " Farm is full, upgrade it to get more space!");
                                    }
                                }
                            }
                        }
                    }
                    else if (arg2 == 0)
                    {
                        gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
                    }
                    
                    exit;
                }
                
                if (string_pos("!guard", _cmd) == 1 || string_pos("guard", _cmd) == 1 || string_pos("!defend", _cmd) == 1 || string_pos("defend", _cmd) == 1 || string_pos("room00guard", _cmd) == 1)
                {
                    if (ds_list_find_index(global.playerList, uname) != -1)
                    {
                        with (obj_player)
                        {
                            if (name == other.uname)
                            {
                                if (state != UnknownEnum.Value_8 && toPortal == false)
                                {
                                    path_end();
                                    state = UnknownEnum.Value_7;
                                    alarm[1] = 1;
                                }
                            }
                        }
                    }
                    else if (arg2 == 0)
                    {
                        gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
                    }
                    
                    exit;
                }
                
                if (string_pos("!mine", _cmd) == 1 || string_pos("mine", _cmd) == 1 || string_pos("room00mine", _cmd) == 1)
                {
                    if (ds_list_find_index(global.playerList, uname) != -1)
                    {
                        with (obj_player)
                        {
                            if (name == other.uname)
                            {
                                if (state != UnknownEnum.Value_8 && state != UnknownEnum.Value_12 && toPortal == false)
                                {
                                    if (obj_build_mine.currentSlots < global.maxMine)
                                    {
                                        path_end();
                                        
                                        if (mineAura != 0)
                                        {
                                            myAura = mineAura;
                                            auraIcon = oauraIcon[myAura];
                                            spr_aura = auraIcon;
                                            gml_Script_scr_updateStats();
                                        }
                                        
                                        state = UnknownEnum.Value_4;
                                        target = obj_build_mine;
                                        var w = 25;
                                        var h = 10;
                                        gotoX = irandom_range(target.x - w, target.x + w);
                                        gotoY = irandom_range(target.y - h, target.y);
                                        actionPath = path_add();
                                        
                                        if (mp_grid_path(global.gameGrid, actionPath, x, y, gotoX, gotoY, 1))
                                            path_start(actionPath, moveSpeed * global.roomSpeed, path_action_stop, 0);
                                    }
                                    else if (arg2 == 0)
                                    {
                                        gml_Script_twitch_chat_say("/me " + string(name) + " Mine is full, upgrade it to get more space!");
                                    }
                                }
                            }
                        }
                    }
                    else if (arg2 == 0)
                    {
                        gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
                    }
                    
                    exit;
                }
                
                if (string_pos("!trainpet", _cmd) == 1 || string_pos("trainpet", _cmd) == 1)
                {
                    if (ds_list_find_index(global.playerList, uname) != -1)
                    {
                        if (global.keeperBuilt == 1)
                        {
                            var _pet = string_digits(_cmd);
                            
                            if (_pet == "")
                                _pet = 0;
                            else
                                _pet = real(_pet);
                            
                            if (_pet > global.maxPets)
                                _pet = 0;
                            
                            with (obj_player)
                            {
                                if (name == other.uname)
                                {
                                    if (state != UnknownEnum.Value_8)
                                    {
                                        if (gotPet[_pet] >= 1)
                                        {
                                            if (myPetInfo[_pet][4] < (obj_build_creaturekeeper.level + 4))
                                            {
                                                if (petTraining == 0)
                                                {
                                                    ini_open(string(global.platformDir) + string(myCharDir) + "Data.ini");
                                                    ini_write_real("Pets", "My Pet " + string(myPetID) + " Level", myPetInfo[myPetID][4]);
                                                    ini_write_real("Pets", "My Pet " + string(myPetID) + " XP", myPetInfo[myPetID][5]);
                                                    ini_write_real("Pets", "My Pet ID", 0);
                                                    
                                                    if (myPetID == _pet)
                                                    {
                                                        ini_write_real("Pets", "My Pet ID", 0);
                                                        
                                                        if (myPlayerPet != 0)
                                                        {
                                                            with (myPlayerPet)
                                                                instance_destroy();
                                                            
                                                            myPlayerPet = 0;
                                                        }
                                                        
                                                        myPetID = 0;
                                                    }
                                                    
                                                    petTraining = _pet;
                                                    ini_write_real("Pets", "My Pet Training", petTraining);
                                                    ini_close();
                                                    
                                                    if (arg2 == 0)
                                                        gml_Script_twitch_chat_say("/me " + string(name) + " Pet #" + string(_pet) + " (" + string(myPetInfo[_pet][1]) + ") is now being trained by the Creature Keeper! You will get notified when the training ends.");
                                                }
                                                else if (arg2 == 0)
                                                {
                                                    gml_Script_twitch_chat_say("/me " + string(name) + " The Creature Keeper is busy training your Pet #" + string(petTraining) + " (" + string(myPetInfo[petTraining][1]) + ")! You can stop that training to start another one.");
                                                }
                                            }
                                            else if (arg2 == 0)
                                            {
                                                gml_Script_twitch_chat_say("/me " + string(name) + " You must upgrade the Creature Keeper building to train Pet #" + string(_pet) + "!");
                                            }
                                        }
                                        else if (arg2 == 0)
                                        {
                                            gml_Script_twitch_chat_say("/me " + string(name) + " You do not own Pet #" + string(_pet) + "!");
                                        }
                                    }
                                    else if (arg2 == 0)
                                    {
                                        gml_Script_twitch_chat_say("/me " + string(name) + " You can't train your pets while raiding!");
                                    }
                                }
                            }
                        }
                        else if (arg2 == 0)
                        {
                            gml_Script_twitch_chat_say("/me " + string(uname) + " You must build the Creature Keeper building to do this.");
                        }
                    }
                    else if (arg2 == 0)
                    {
                        gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
                    }
                    
                    exit;
                }
                
                if (string_pos("!stoptrainpet", _cmd) == 1 || string_pos("stoptrainpet", _cmd) == 1)
                {
                    if (ds_list_find_index(global.playerList, uname) != -1)
                    {
                        if (global.keeperBuilt == 1)
                        {
                            with (obj_player)
                            {
                                if (name == other.uname)
                                {
                                    var _petText = "";
                                    
                                    if (petTraining != 0)
                                    {
                                        ini_open(string(global.platformDir) + string(myCharDir) + "Data.ini");
                                        ini_write_real("Pets", "My Pet " + string(petTraining) + " Level", myPetInfo[petTraining][4]);
                                        ini_write_real("Pets", "My Pet " + string(petTraining) + " XP", myPetInfo[petTraining][5]);
                                        ini_write_real("Pets", "My Pet Training", 0);
                                        ini_close();
                                        
                                        if (myPetID == 0)
                                        {
                                            myPetID = petTraining;
                                            _petText = " Pet #" + string(myPetID) + " (" + string(myPetInfo[myPetID][1]) + " - lv." + string(myPetInfo[myPetID][4]) + ") is now your companion.";
                                            
                                            if (myPlayerPet != 0)
                                            {
                                                with (myPlayerPet)
                                                    instance_destroy();
                                            }
                                            
                                            myPlayerPet = instance_create_depth(x, y, depth - 1, obj_petPlayer);
                                            
                                            with (myPlayerPet)
                                            {
                                                player = other.id;
                                                type = other.myPetID;
                                            }
                                        }
                                        
                                        if (arg2 == 0)
                                            gml_Script_twitch_chat_say("/me " + string(name) + " Pet #" + string(petTraining) + " (" + string(myPetInfo[petTraining][1]) + ") is no longer training and is now ready for combat." + string(_petText));
                                        
                                        petTraining = 0;
                                    }
                                    else if (arg2 == 0)
                                    {
                                        gml_Script_twitch_chat_say("/me " + string(name) + " The Creature Keeper is not training any of your Pets at this moment.");
                                    }
                                }
                            }
                        }
                        else if (arg2 == 0)
                        {
                            gml_Script_twitch_chat_say("/me " + string(uname) + " You must built the Creature Keeper building to do this.");
                        }
                    }
                    else if (arg2 == 0)
                    {
                        gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
                    }
                    
                    exit;
                }
                
                if (string_pos("!train", _cmd) == 1 || string_pos("train", _cmd) == 1 || string_pos("room00train", _cmd) == 1)
                {
                    if (ds_list_find_index(global.playerList, uname) != -1)
                    {
                        with (obj_player)
                        {
                            if (name == other.uname)
                            {
                                if (state != UnknownEnum.Value_8 && state != UnknownEnum.Value_12 && toPortal == false)
                                {
                                    if (obj_build_train.currentSlots < global.maxTrain)
                                    {
                                        path_end();
                                        
                                        if (trainAura != 0)
                                        {
                                            myAura = trainAura;
                                            auraIcon = oauraIcon[myAura];
                                            spr_aura = auraIcon;
                                            gml_Script_scr_updateStats();
                                        }
                                        
                                        state = UnknownEnum.Value_6;
                                        target = obj_build_train;
                                        actionPath = path_add();
                                        var w = 30;
                                        var h = 50;
                                        gotoX = irandom_range(target.x - w, target.x + w);
                                        gotoY = irandom_range(target.y - h, target.y + h);
                                        
                                        if (mp_grid_path(global.gameGrid, actionPath, x, y, gotoX, gotoY, 1))
                                            path_start(actionPath, moveSpeed * global.roomSpeed, path_action_stop, 0);
                                    }
                                    else if (arg2 == 0)
                                    {
                                        gml_Script_twitch_chat_say("/me " + string(name) + " Training camp is full, upgrade it to get more space!");
                                    }
                                }
                            }
                        }
                    }
                    else if (arg2 == 0)
                    {
                        gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
                    }
                    
                    exit;
                }
                
                if (string_pos("!rest", _cmd) == 1 || string_pos("rest", _cmd) == 1 || string_pos("room00zzz", _cmd) == 1)
                {
                    if (ds_list_find_index(global.playerList, uname) != -1)
                    {
                        with (obj_player)
                        {
                            if (name == other.uname)
                            {
                                if (state != UnknownEnum.Value_8 && state != UnknownEnum.Value_12 && toPortal == false)
                                {
                                    path_end();
                                    state = UnknownEnum.Value_5;
                                    target = obj_build_inn;
                                    actionPath = path_add();
                                    var w = 20;
                                    var h = 15;
                                    gotoX = irandom_range(target.x - w, target.x + w);
                                    gotoY = target.y;
                                    
                                    if (mp_grid_path(global.gameGrid, actionPath, x, y, gotoX, gotoY, 1))
                                        path_start(actionPath, moveSpeed * global.roomSpeed, path_action_stop, 0);
                                }
                            }
                        }
                    }
                    else if (arg2 == 0)
                    {
                        gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
                    }
                    
                    exit;
                }
                
                if (string_pos("!stop", _cmd) == 1 || string_pos("stop", _cmd) == 1 || string_pos("!idle", _cmd) == 1 || string_pos("idle", _cmd) == 1)
                {
                    if (ds_list_find_index(global.playerList, uname) != -1)
                    {
                        with (obj_player)
                        {
                            if (name == other.uname)
                            {
                                if (state != UnknownEnum.Value_8 && toPortal == false)
                                {
                                    path_end();
                                    state = UnknownEnum.Value_0;
                                    alarm[1] = 1;
                                }
                            }
                        }
                    }
                    else if (arg2 == 0)
                    {
                        gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
                    }
                    
                    exit;
                }
                
                if (string_pos("!ascend", _cmd) == 1)
                {
                    if (ds_list_find_index(global.playerList, uname) != -1)
                    {
                        if (global.unlockCorrupted == 1 || global.dev == 1)
                        {
                            with (obj_player)
                            {
                                if (name == other.uname)
                                {
                                    if (state != UnknownEnum.Value_8)
                                    {
                                        if (tryAscension == false)
                                        {
                                            if ((specialized == 0 && myAbilityInfo[4] >= global.maxAbilityLevel) || (specialized != 0 && myAbilityInfo[4] >= 15) || global.dev == true)
                                            {
                                                var _eligible = false;
                                                
                                                if (global.dev == true)
                                                    _eligible = true;
                                                
                                                if (_eligible == false)
                                                {
                                                    var _voc = 0;
                                                    
                                                    for (var i = 0; i < 4; i += 1)
                                                    {
                                                        if (myVocationInfo[i][0] >= maxVocationLevel)
                                                            _voc = 1;
                                                    }
                                                    
                                                    if (_voc == 0)
                                                    {
                                                        gml_Script_twitch_chat_say("/me " + string(name) + " You must max at least 1 vocation before " + string(global.cmdPrefix) + "!Ascending.");
                                                        exit;
                                                    }
                                                    
                                                    if (level < 2500)
                                                    {
                                                        gml_Script_twitch_chat_say("/me " + string(name) + " You must reach level 2,500 before " + string(global.cmdPrefix) + "!Ascending.");
                                                        exit;
                                                    }
                                                    
                                                    if (ascension[classType][specialized] == 1)
                                                    {
                                                        gml_Script_twitch_chat_say("/me " + string(name) + " You can not " + string(global.cmdPrefix) + "!Ascend multiple times as the same Specialized sub-class.");
                                                        exit;
                                                    }
                                                    
                                                    if (_voc == 1 && level >= 2500 && ascension[classType][specialized] == 0)
                                                        _eligible = true;
                                                }
                                                
                                                if (_eligible == true)
                                                {
                                                    tryAscension = true;
                                                    gml_Script_scr_playsound(s_ascend2, 0.9, 1.1, 1);
                                                    gml_Script_twitch_chat_say("/me " + string(name) + " It looks like you are finally ready to " + string(global.cmdPrefix) + "!Ascend, please make sure your build setup is correct (Pet, Relics, Ability, Talents, Special Points, Auras, Auto-actions...) and type !confirm ascension when you are fully prepared (5 minutes left).");
                                                    gml_Script_scr_alarm_start(8, room_speed * 300, gml_Script_scr_player_ascendCancel);
                                                }
                                            }
                                            else if (arg2 == 0)
                                            {
                                                gml_Script_twitch_chat_say("/me " + string(name) + " you must max your current ability before " + string(global.cmdPrefix) + "!Ascending.");
                                            }
                                        }
                                        else
                                        {
                                            gml_Script_twitch_chat_say("/me " + string(name) + " you are in the middle of the " + string(global.cmdPrefix) + "!Ascension process, please make sure your build setup is correct (Pet, Relics, Ability, Talents, Special Points, Auras, Auto-actions...) and type !confirm ascension when you are fully prepared.");
                                        }
                                    }
                                }
                            }
                        }
                        else if (arg2 == 0)
                        {
                            gml_Script_twitch_chat_say("/me " + string(uname) + " tried to " + string(global.cmdPrefix) + "!Ascend but... nothing happened. It's not your time yet, try again in the future, when you reach your limits...");
                        }
                    }
                    else if (arg2 == 0)
                    {
                        gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
                    }
                    
                    exit;
                }
                
                if (string_pos("!confirmascension", _cmd) == 1)
                {
                    if (ds_list_find_index(global.playerList, uname) != -1)
                    {
                        if (global.unlockCorrupted == 1 || global.dev == true)
                        {
                            with (obj_player)
                            {
                                if (name == other.uname)
                                {
                                    if (state != UnknownEnum.Value_8)
                                    {
                                        if (tryAscension == true)
                                            gml_Script_scr_player_ascend();
                                    }
                                }
                            }
                        }
                    }
                }
                
                if (string_pos("!specialize", _cmd) == 1)
                {
                    if (ds_list_find_index(global.playerList, uname) != -1)
                    {
                        with (obj_player)
                        {
                            if (name == other.uname)
                            {
                                if (state != UnknownEnum.Value_8)
                                {
                                    if ((specialized == 0 && myAbilityInfo[4] >= global.maxAbilityLevel && instance_exists(obj_build_academy) && obj_build_academy.level >= 30) || (name == "erohzify" && specialized == 0))
                                    {
                                        if (class == "warrior" || class == "mage" || class == "archer" || (name == "erohzify" && specialized == 0))
                                        {
                                            if (arg2 == 0)
                                                gml_Script_twitch_chat_say("/me " + string(name) + " has " + string(global.cmdPrefix) + "!specialized as a " + string(global.skillSpecialization[classType][myAbilityInfo[0]]) + " (+1 !!Special Point)! You may want to change your ability with " + string(global.cmdPrefix) + "setskill# (1 to 3).");
                                            
                                            subClassName = string(global.skillSpecialization[classType][myAbilityInfo[0]]);
                                            gml_Script_scr_playsound(s_magical_1, 0.9, 1.1, 0.6);
                                            gml_Script_scr_playsound(s_questDone, 0.9, 1.1, 0.6);
                                            gml_Script_scr_playsound(s_questNew, 0.9, 1.1, 0.6);
                                            classSpecialization[myAbilityInfo[0]] = 1;
                                            specialized = myAbilityInfo[0] + 1;
                                            ini_open(string(global.platformDir) + string(myCharDir) + "Data.ini");
                                            ini_write_real("Build", "Ability " + string(myAbilityInfo[0]) + " Specialization", 1);
                                            ini_write_real("Build", "Specialized", specialized);
                                            ini_write_real("Build", "Ability " + string(myAbilityInfo[0]) + " Tier", 3);
                                            
                                            for (var i = 0; i < 3; i++)
                                            {
                                                specialPoints[i] = clamp(ini_read_real("Specialization", "Special Points Spec " + string(specialized - 1) + " Ability " + string(i), -1), -1, global.maxSpecAbilityLevel);
                                                totalSpecialPoints[i] = clamp(ini_read_real("Specialization", "Total Special Points Spec " + string(specialized - 1) + " Ability " + string(i), 1), 1, global.maxSpecAbilityLevel);
                                                
                                                if (specialPoints[i] == -1 && totalSpecialPoints[i] == 1)
                                                {
                                                    specialPoints[i] = totalSpecialPoints[i];
                                                    ini_write_real("Specialization", "Total Special Points Spec " + string(specialized - 1) + " Ability " + string(i), totalSpecialPoints[i]);
                                                    ini_write_real("Specialization", "Special Points Spec " + string(specialized - 1) + " Ability " + string(i), specialPoints[i]);
                                                }
                                            }
                                            
                                            ini_close();
                                            gml_Script_scr_updateSkin();
                                            gml_Script_scr_player_setAbility(1, 1);
                                            skillTier[myAbilityInfo[0]] = 1;
                                            skillTierText[myAbilityInfo[0]] = string_repeat("I", skillTier[myAbilityInfo[0]]);
                                        }
                                        else if (arg2 == 0)
                                        {
                                            gml_Script_twitch_chat_say("/me " + string(name) + " This feature is on early testing stages and it is only available for warriors, mages and archers at the moment.");
                                        }
                                    }
                                    else if (arg2 == 0)
                                    {
                                        gml_Script_twitch_chat_say("/me " + string(name) + " you don't meet the requirements to " + string(global.cmdPrefix) + "!speciailze.");
                                    }
                                }
                            }
                        }
                    }
                    else if (arg2 == 0)
                    {
                        gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
                    }
                    
                    exit;
                }
                
                if (string_pos("!unspecialize", _cmd) == 1)
                {
                    if (ds_list_find_index(global.playerList, uname) != -1)
                    {
                        with (obj_player)
                        {
                            if (name == other.uname)
                            {
                                if (state != UnknownEnum.Value_8)
                                {
                                    if (specialized != 0)
                                    {
                                        if (arg2 == 0)
                                            gml_Script_twitch_chat_say("/me " + string(name) + " is no longer specialized as a " + string(global.skillSpecialization[classType][specialized - 1]) + "!");
                                        
                                        subClassName = "";
                                        gml_Script_scr_playsound(s_questFailed, 0.9, 1.1, 0.6);
                                        gml_Script_scr_playsound(s_favorEnd, 0.5, 0.7, 0.6);
                                        var _lastAbility = specialized;
                                        specialized = 0;
                                        gml_Script_scr_player_setAbility(_lastAbility, 1);
                                        classSpecialization[_lastAbility - 1] = 0;
                                        ini_open(string(global.platformDir) + string(myCharDir) + "Data.ini");
                                        ini_key_delete("Build", "Ability " + string(_lastAbility - 1) + " Specialization");
                                        ini_key_delete("Build", "Specialized");
                                        skillTier[_lastAbility - 1] = 2;
                                        skillTierText[_lastAbility - 1] = string_repeat("I", skillTier[_lastAbility - 1]);
                                        ini_write_real("Build", "Ability " + string(_lastAbility - 1) + " Tier", 2);
                                        ini_close();
                                        gml_Script_scr_updateSkin();
                                    }
                                    else if (arg2 == 0)
                                    {
                                        gml_Script_twitch_chat_say("/me " + string(name) + " you must be " + string(global.cmdPrefix) + "!specialized to do this.");
                                    }
                                }
                            }
                        }
                    }
                    else if (arg2 == 0)
                    {
                        gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
                    }
                    
                    exit;
                }
                
                if (string_pos("!retreat", _cmd) == 1)
                {
                    if (ds_list_find_index(global.playerList, uname) != -1)
                    {
                        if (global.raidCall == true && global.raiding == false)
                        {
                            with (obj_player)
                            {
                                if (name == other.uname)
                                {
                                    if (readyRaid == 1)
                                    {
                                        var _partyBonusSpecialized = specialized;
                                        
                                        if (_partyBonusSpecialized > 0)
                                            _partyBonusSpecialized = 3;
                                        else
                                            _partyBonusSpecialized = 1;
                                        
                                        if (class == "rogue")
                                            global.rogueBonus -= (1 + _partyBonusSpecialized);
                                        
                                        if (class == "warrior")
                                            global.warriorBonus -= (1 + _partyBonusSpecialized);
                                        
                                        if (class == "archer")
                                            global.rangerBonus -= (1 + _partyBonusSpecialized);
                                        
                                        if (class == "mage")
                                            global.wizardBonus -= (1 + _partyBonusSpecialized);
                                        
                                        if (global.rogueBonus < 0)
                                            global.rogueBonus = 0;
                                        
                                        if (global.warriorBonus < 0)
                                            global.warriorBonus = 0;
                                        
                                        if (global.rangerBonus < 0)
                                            global.rangerBonus = 0;
                                        
                                        if (global.wizardBonus < 0)
                                            global.wizardBonus = 0;
                                        
                                        global.raiders -= 1;
                                        energy += 20;
                                        readyRaid = 0;
                                        ds_list_delete(global.rewardList, ds_list_find_index(global.rewardList, string(name)));
                                        
                                        if (levelRaid < 10)
                                            ds_list_delete(raidList, ds_list_find_index(raidList, string(string(raidPos) + "A" + string(levelRaid) + string(name))));
                                        
                                        if (levelRaid >= 10 && levelRaid <= 99)
                                            ds_list_delete(raidList, ds_list_find_index(raidList, string(string(raidPos) + "B" + string(levelRaid) + string(name))));
                                        
                                        if (levelRaid >= 100 && levelRaid <= 999)
                                            ds_list_delete(raidList, ds_list_find_index(raidList, string(string(raidPos) + "C" + string(levelRaid) + string(name))));
                                        
                                        if (levelRaid >= 1000 && levelRaid <= 9999)
                                            ds_list_delete(raidList, ds_list_find_index(raidList, string(string(raidPos) + "D" + string(levelRaid) + string(name))));
                                        
                                        if (levelRaid >= 10000 && levelRaid <= 99999)
                                            ds_list_delete(raidList, ds_list_find_index(raidList, string(string(raidPos) + "F" + string(levelRaid) + string(name))));
                                        
                                        if (levelRaid >= 100000)
                                            ds_list_delete(raidList, ds_list_find_index(raidList, string(string(raidPos) + "G" + string(levelRaid) + string(name))));
                                        
                                        if (global.chatSpam <= 2)
                                        {
                                            if (arg2 == 0)
                                                gml_Script_twitch_chat_say("/me " + string(name) + " has retreated from the raid! [Ranged: " + string(ds_list_size(global.raidList1)) + " | Melee: " + string(ds_list_size(global.raidList0)) + "] room00Raid");
                                        }
                                    }
                                    else if (global.chatSpam <= 2)
                                    {
                                        if (arg2 == 0)
                                            gml_Script_twitch_chat_say("/me " + string(name) + " you are not in for this raid.");
                                    }
                                    
                                    if (global.raiders <= 0)
                                    {
                                        global.raidCall = false;
                                        
                                        if (obj_bossKey.alarm[1] == -1)
                                            global.stage = global.ostage;
                                        else
                                            global.stage = global.bossStage;
                                        
                                        obj_raid.alarm[1] = -1;
                                        obj_raid.alarm[11] = -1;
                                        obj_raid.raidType = 0;
                                    }
                                }
                            }
                        }
                        else if (arg2 == 0)
                        {
                            gml_Script_twitch_chat_say("/me " + string(uname) + " you can not retreat at this moment...");
                        }
                    }
                    else if (arg2 == 0)
                    {
                        gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
                    }
                    
                    exit;
                }
                
                if ((string_pos("!raid", _cmd) == 1 || string_pos("room00raid", _cmd) == 1 || string_pos("!push", _cmd) == 1 || string_pos("!maxraid", _cmd) == 1) && string_pos("!raidp", _cmd) != 1)
                {
                    if (global.canRaid == true)
                    {
                        with (obj_player)
                        {
                            if (name == other.uname)
                            {
                                if (global.dev == false && energy < 20)
                                {
                                    if (global.chatSpam <= 1)
                                        gml_Script_twitch_chat_say("/me " + string(name) + " You need to have at least 20 energy to raid. Energy: " + string(floor(energy)) + "/" + string(round(maxEnergy)) + ". room00ZZZ");
                                    
                                    exit;
                                }
                                
                                if (readyRaid != 0)
                                {
                                    if (global.chatSpam <= 1)
                                        gml_Script_twitch_chat_say("/me " + string(name) + " You must wait to arrive from the raid to do that.");
                                    
                                    exit;
                                }
                            }
                        }
                        
                        if (ds_list_find_index(global.playerList, uname) != -1)
                        {
                            if (global.raidCall == false)
                            {
                                var raidStage;
                                
                                if (obj_bossKey.alarm[1] == -1)
                                {
                                    raidStage = string_digits(_cmd);
                                    
                                    if (string_pos("!push", _cmd) == 1 || string_pos("!maxraid", _cmd) == 1)
                                    {
                                        raidStage = global.ostage;
                                    }
                                    else if (raidStage == "" || raidStage == "00")
                                    {
                                        raidStage = global.ostage - 1;
                                    }
                                    else
                                    {
                                        raidStage = real(raidStage);
                                        
                                        if (raidStage > global.ostage)
                                            raidStage = global.ostage;
                                    }
                                    
                                    if (raidStage < 1)
                                        raidStage = 1;
                                    
                                    if (raidStage != 0 && raidStage < global.ostage)
                                        global.raidCost = 0;
                                    
                                    if (raidStage > global.ostage)
                                        raidStage = global.ostage;
                                    
                                    global.stage = raidStage;
                                    
                                    if (global.stage <= 10)
                                        global.raidCost = 0;
                                }
                                else
                                {
                                    global.stage = global.bossStage;
                                    global.raidCost = 0;
                                }
                                
                                if (global.gold >= global.raidCost)
                                {
                                    global.gold -= global.raidCost;
                                    global.raidCall = true;
                                    
                                    with (obj_raid)
                                    {
                                        if (boss == false)
                                        {
                                            raidType = 0;
                                            raidAnnounceText = "Raid " + gml_Script_scr_bigNumber(global.stage);
                                            
                                            if ((raidStage % 50) == 0 && gml_Script_scr_alarm_get(50 + (global.stage / 50)) == -1)
                                            {
                                                raidType = 1;
                                                raidAnnounceText = "Territory Boss " + string(global.stage / 50);
                                            }
                                            
                                            if ((raidStage % 250) == 0 && gml_Script_scr_alarm_get(50 + (global.stage / 50)) == -1)
                                            {
                                                raidType = 2;
                                                raidAnnounceText = "Biome Boss " + string(global.stage / 250);
                                            }
                                            
                                            if ((raidStage % 1000) == 0 && gml_Script_scr_alarm_get(50 + (global.stage / 50)) == -1)
                                            {
                                                raidType = 3;
                                                raidAnnounceText = "Legendary Boss " + string(global.stage / 1000);
                                            }
                                            
                                            gml_Script_scr_playsound(s_trumpet, 0.9, 1.1, 0.5);
                                        }
                                        else
                                        {
                                            raidType = 1;
                                            raidAnnounceText = "Dungeon Boss " + string(global.stage);
                                        }
                                    }
                                    
                                    obj_raid.alarm[4] += room_speed * 60;
                                    
                                    if (global.raidCost > 0)
                                    {
                                        with (gml_Script_instance_create(400, 75, obj_float))
                                        {
                                            type = 8;
                                            value = global.raidCost;
                                            text = "-" + gml_Script_scr_bigNumber(value) + "g";
                                            c1 = 255;
                                            c2 = 128;
                                            parent = type;
                                        }
                                    }
                                    
                                    var _raidTimer = room_speed * 30;
                                    
                                    if (global.dev)
                                        _raidTimer = room_speed;
                                    
                                    obj_raid.alarm[1] = _raidTimer;
                                    obj_raid.alarm[11] = _raidTimer - 1;
                                    
                                    if (arg2 == 0)
                                        gml_Script_twitch_chat_say("/color Red");
                                    
                                    if (global.chatSpam <= 1)
                                    {
                                        if (obj_bossKey.alarm[1] == -1)
                                        {
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
                                            
                                            gml_Script_twitch_chat_say_direct("/me " + string(uname) + " has started " + string(obj_raid.raidAnnounceText) + " for " + gml_Script_scr_bigNumber(global.raidCost) + "g! Type " + string(global.cmdPrefix) + "raid to join (30s) room00Raid");
                                        }
                                        else
                                        {
                                            gml_Script_twitch_chat_say_direct("/me " + string(uname) + " is attacking the Dungeon Boss again! Type " + string(global.cmdPrefix) + "raid to join (30s) room00Raid");
                                        }
                                    }
                                }
                                else
                                {
                                    gml_Script_twitch_chat_say("/me You need " + gml_Script_scr_bigNumber(global.raidCost) + " gold to start raid " + gml_Script_scr_bigNumber(global.stage) + "! (" + gml_Script_scr_bigNumber(round(global.raidCost - global.gold)) + "g left).");
                                    global.stage = global.ostage;
                                }
                                
                                if (arg2 == 0)
                                    gml_Script_twitch_chat_say("/color FireBrick");
                            }
                            
                            if (ds_list_find_index(global.playerList, uname) != -1 && global.raidCall == true)
                            {
                                with (obj_player)
                                {
                                    if (name == other.uname || (autoAction[3] == 1 && (obj_raid.boss == true || obj_raid.raidType > 0 || global.stage == global.ostage)) || global.dev == 1)
                                    {
                                        if (readyRaid == 0)
                                        {
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
                                            
                                            tempNumber = global.raiders;
                                            global.raiders += 1;
                                            energy -= 20;
                                            readyRaid = 1;
                                            levelRaid = level;
                                            ds_list_add(global.rewardList, string(name));
                                            
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
                                            
                                            if (global.chatSpam <= 1)
                                                gml_Script_twitch_chat_say("/me " + string(name) + " is ready to raid! [Ranged: " + string(ds_list_size(global.raidList1)) + " | Melee: " + string(ds_list_size(global.raidList0)) + "] room00Raid");
                                        }
                                        else if (autoAction[3] == 0 && global.chatSpam <= 1)
                                        {
                                            gml_Script_twitch_chat_say("/me " + string(name) + " you are already in for this raid.");
                                        }
                                    }
                                }
                            }
                        }
                        else if (arg2 == 0)
                        {
                            gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
                        }
                        
                        exit;
                    }
                    else
                    {
                        if (arg2 == 0)
                            gml_Script_twitch_chat_say("/me " + string(uname) + " Some other event with higher priority is blocking your command (current raid, enemy attack, portal, final war...).");
                        
                        exit;
                    }
                }
                
                if (string_pos("!boss", _cmd) == 1)
                {
                    if (global.keyFrags > 5 && global.canRaid == true)
                    {
                        with (obj_player)
                        {
                            if (name == other.uname)
                            {
                                if (energy < 20)
                                {
                                    if (global.chatSpam <= 1)
                                        gml_Script_twitch_chat_say("/me " + string(name) + " You need to have at least 20 energy to raid. Energy: " + string(floor(energy)) + "/" + string(round(maxEnergy)) + ". room00ZZZ");
                                    
                                    exit;
                                }
                                
                                if (readyRaid != 0)
                                {
                                    if (global.chatSpam <= 1)
                                        gml_Script_twitch_chat_say("/me " + string(name) + " You must wait to arrive from the raid to do that.");
                                    
                                    exit;
                                }
                            }
                        }
                        
                        if (ds_list_find_index(global.playerList, uname) != -1)
                        {
                            if (global.raidCall == false)
                            {
                                global.raidCost = 0;
                                global.raidCall = true;
                                gml_Script_scr_playsound(s_horn, 0.9, 1.1, 0.7);
                                
                                if (obj_bossKey.alarm[1] == -1)
                                {
                                    global.stage = global.bossStage;
                                    var _tier = global.bossTier;
                                    
                                    if (global.bossStage > 500)
                                        _tier += 1;
                                    
                                    if (global.bossStage > 1000)
                                        _tier += 1;
                                    
                                    if (global.bossStage > 1500)
                                        _tier += 1;
                                    
                                    if (global.bossStage > 2000)
                                        _tier += 1;
                                    
                                    if (global.bossStage > 2500)
                                        _tier += 1;
                                    
                                    _tier = clamp(_tier, 0, 5);
                                    
                                    if (_tier > 0)
                                        _tier = " (Tier " + string(_tier) + ")";
                                    else
                                        _tier = "";
                                    
                                    gml_Script_twitch_chat_say("/color Red");
                                    gml_Script_twitch_chat_say_direct("/me " + string(uname) + " has summoned a level " + gml_Script_scr_bigNumber(global.bossStage) + " Dungeon Boss" + string(_tier) + "! Defeat it before it leaves and earn tons of rewards! Type " + string(global.cmdPrefix) + "raid to join (60s) room00Raid");
                                    gml_Script_twitch_chat_say("/color FireBrick");
                                    gml_Script_scr_playsound(s_bossStart, 0.9, 1.1, 1);
                                    obj_raid.alarm[1] = room_speed * 60;
                                    obj_raid.alarm[11] = (room_speed * 60) - 1;
                                    obj_bossKey.alarm[1] = obj_bossKey.bossTimer;
                                    obj_raid.boss = true;
                                    
                                    with (gml_Script_instance_create(x, y, obj_stageTransition))
                                    {
                                        c1 = 128;
                                        text1 = "Dungeons";
                                        text2 = global.dungeonQuotes[irandom(global.dungeonMaxQuotes)];
                                    }
                                }
                                else
                                {
                                    if (arg2 == 0)
                                        gml_Script_twitch_chat_say("/color Red");
                                    
                                    gml_Script_twitch_chat_say_direct("/me " + string(uname) + " is attacking the Dungeon Boss again! Type " + string(global.cmdPrefix) + "raid to join (30s) room00Raid");
                                    
                                    if (arg2 == 0)
                                        gml_Script_twitch_chat_say("/color FireBrick");
                                    
                                    obj_raid.alarm[1] = room_speed * 30;
                                    obj_raid.alarm[11] = (room_speed * 30) - 1;
                                    obj_raid.raidAnnounceText = "Dungeon Boss (" + string(global.bossStage) + ")";
                                    obj_raid.alarm[4] += room_speed * 300;
                                    obj_raid.boss = true;
                                    obj_raid.raidType = 1;
                                }
                            }
                            
                            if (ds_list_find_index(global.playerList, uname) != -1 && global.raidCall == true)
                            {
                                with (obj_player)
                                {
                                    if (name == other.uname || (autoAction[3] == 1 && (obj_raid.boss == true || obj_raid.raidType > 0 || global.stage == global.ostage)) || global.dev == 1)
                                    {
                                        if (readyRaid == 0)
                                        {
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
                                            
                                            tempNumber = global.raiders;
                                            global.raiders += 1;
                                            energy -= 20;
                                            readyRaid = 1;
                                            levelRaid = level;
                                            ds_list_add(global.rewardList, string(name));
                                            
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
                                            
                                            if (global.chatSpam <= 1)
                                                gml_Script_twitch_chat_say("/me " + string(name) + " is ready to raid! [Ranged: " + string(ds_list_size(global.raidList1)) + " | Melee: " + string(ds_list_size(global.raidList0)) + "] room00Raid");
                                        }
                                        else if (autoAction[3] == 0 && global.chatSpam <= 1)
                                        {
                                            gml_Script_twitch_chat_say("/me " + string(name) + " you are already in for this raid.");
                                        }
                                    }
                                }
                            }
                        }
                        else if (arg2 == 0)
                        {
                            gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
                        }
                        
                        exit;
                    }
                    else
                    {
                        if (arg2 == 0)
                            gml_Script_twitch_chat_say("/me " + string(uname) + " Some other event with higher priority is blocking your command (current raid, enemy attack, portal, final war...).");
                        
                        exit;
                    }
                }
                
                if (string_pos("!donate", _cmd) == 1)
                {
                    if (ds_list_find_index(global.playerList, uname) != -1)
                    {
                        var _suffix = string_letters(string_char_at(_cmd, string_length(_cmd)));
                        show_debug_message("Donate suffix: " + string(_suffix));
                        var _amount = string_digits(_cmd);
                        
                        if (_amount == "")
                        {
                            if (string_pos("all", _cmd) != 0)
                                _suffix = "all";
                            else
                                exit;
                        }
                        else
                        {
                            _amount = real(_amount);
                        }
                        
                        show_debug_message("Donated " + string(_amount) + string(_suffix));
                        
                        if (_suffix == "k")
                            _amount *= 1000;
                        
                        if (_suffix == "m")
                            _amount *= 1000000;
                        
                        if (_suffix == "b")
                            _amount *= 1000000000;
                        
                        if (_suffix == "t")
                            _amount *= 1000000000000;
                        
                        var _donationType = "";
                        var _donationResource = -1;
                        var _type = 0;
                        var _xpos = 370;
                        var _ypos = 25;
                        var _donated = 0;
                        var _left = 0;
                        var c_1 = 16777215;
                        var c_2 = 16777215;
                        
                        if (string_pos("!donategold", _cmd) == 1)
                        {
                            _donationType = "gold";
                        }
                        else if (string_pos("!donatefood", _cmd) == 1)
                        {
                            _donationType = "food";
                        }
                        else if (string_pos("!donategem", _cmd) == 1)
                        {
                            _donationType = "room00Gem";
                        }
                        else
                        {
                            if (_amount == "")
                                _amount = 10;
                            
                            gml_Script_twitch_chat_say("/me " + string(uname) + " you must specify the resource you want to donate (!donate gold/food/gems " + gml_Script_scr_bigNumber(_amount) + ")");
                            exit;
                        }
                        
                        with (obj_player)
                        {
                            if (name == other.uname)
                            {
                                var _donation = _amount;
                                
                                if (_donationType == "gold")
                                {
                                    if (_suffix == "all")
                                        _donation = mygold;
                                    
                                    if (_donation > (global.maxGold - global.gold))
                                        _donation = global.maxGold - global.gold;
                                    
                                    if (mygold >= _donation)
                                    {
                                        mygold -= _donation;
                                        global.gold += _donation;
                                    }
                                    else
                                    {
                                        _donation = mygold;
                                        mygold -= _donation;
                                        global.gold += _donation;
                                    }
                                    
                                    donated += _donation;
                                    _type = 1;
                                    _donated = donated;
                                    _left = mygold;
                                    c_1 = 65535;
                                    c_2 = 4235519;
                                }
                                
                                if (_donationType == "food")
                                {
                                    if (_suffix == "all")
                                        _donation = myfood;
                                    
                                    if (_donation > (global.maxFood - global.food))
                                        _donation = global.maxFood - global.food;
                                    
                                    if (myfood >= _donation)
                                    {
                                        myfood -= _donation;
                                        global.food += _donation;
                                    }
                                    else
                                    {
                                        _donation = myfood;
                                        myfood -= _donation;
                                        global.food += _donation;
                                    }
                                    
                                    donated_food += _donation;
                                    _type = 7;
                                    _xpos += 150;
                                    _donated = donated_food;
                                    _left = myfood;
                                    c_1 = 65280;
                                    c_2 = 32768;
                                }
                                
                                if (_donationType == "room00Gem")
                                {
                                    if (_suffix == "all")
                                        _donation = myGems;
                                    
                                    if (myGems >= _donation)
                                    {
                                        myGems -= _donation;
                                        global.gems += _donation;
                                    }
                                    else
                                    {
                                        _donation = myGems;
                                        myGems -= _donation;
                                        global.gems += _donation;
                                    }
                                    
                                    donated_gems += _donation;
                                    _type = 13;
                                    _ypos = 55;
                                    _donated = donated_gems;
                                    _left = myGems;
                                    c_1 = 65280;
                                    c_2 = 16776960;
                                }
                                
                                with (gml_Script_instance_create(_xpos, _ypos, obj_float))
                                {
                                    type = _type;
                                    value = round(_donation);
                                    text = "+" + gml_Script_scr_bigNumber(value);
                                    c1 = c_1;
                                    c2 = c_2;
                                    parent = type;
                                    alarm[1] = 1;
                                }
                                
                                gml_Script_scr_playsound(choose(s_donate1, s_donate2, s_donate3), 0.9, 1.1, 0.4);
                                
                                if (arg2 == 0)
                                    gml_Script_twitch_chat_say("/me " + string(name) + " donated " + gml_Script_scr_bigNumber(round(_donation)) + " " + string(_donationType) + " (" + gml_Script_scr_bigNumber(round(_donated)) + " in total, " + gml_Script_scr_bigNumber(round(_left)) + " " + string(_donationType) + " left).");
                            }
                        }
                    }
                    else if (arg2 == 0)
                    {
                        gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
                    }
                    
                    exit;
                }
                
                if (string_pos("!raidpos", _cmd) == 1 || string_pos("!raidpref", _cmd) == 1)
                {
                    if (string_pos(":", _cmd) == -1)
                    {
                        gml_Script_twitch_chat_say("/me " + string(uname) + " wrong command format. Example: '" + string(global.cmdPrefix) + "raidpos: f' to set your preferred position to 'first'. Available positions: 0/f = first, 1/d = no preference (default), 2/l = last.");
                        exit;
                    }
                    
                    var _pos = string_copy(_cmd, string_pos(":", _cmd) + 1, 1);
                    
                    if (string_digits(_pos) != "")
                    {
                        if (_pos == "0" || _pos == "1" || _pos == "2")
                        {
                            if (_pos == "0")
                                _pos = "f";
                            
                            if (_pos == "1")
                                _pos = "d";
                            
                            if (_pos == "2")
                                _pos = "l";
                        }
                        else
                        {
                            gml_Script_twitch_chat_say("/me " + string(uname) + " invalid command argument. Example: '" + string(global.cmdPrefix) + "raidpos: f' to set your preferred position to 'first'. Available positions: 0/f = first, 1/d = no preference (default), 2/l = last.");
                            exit;
                        }
                    }
                    else if (_pos == "f" || _pos == "d" || _pos == "l")
                    {
                    }
                    else
                    {
                        gml_Script_twitch_chat_say("/me " + string(uname) + " invalid command argument. Example: '" + string(global.cmdPrefix) + "raidpos: f' to set your preferred position to 'first'. Available positions: 0/f = first, 1/d = no preference (default), 2/l = last.");
                        exit;
                    }
                    
                    if (ds_list_find_index(global.playerList, uname) != -1)
                    {
                        with (obj_player)
                        {
                            if (name == other.uname)
                            {
                                if (state != UnknownEnum.Value_8 && readyRaid == 0)
                                {
                                    var _posText = "";
                                    
                                    if (_pos == "f")
                                    {
                                        _posText = "first";
                                        _pos = "A";
                                    }
                                    
                                    if (_pos == "d")
                                    {
                                        _posText = "default";
                                        _pos = "";
                                    }
                                    
                                    if (_pos == "l")
                                    {
                                        _posText = "last";
                                        _pos = "Y";
                                    }
                                    
                                    raidPos = _pos;
                                    gml_Script_twitch_chat_say("/me " + string(name) + " raid position preference updated successfully to '" + string(_posText) + "'.");
                                    ini_open(string(global.platformDir) + string(myCharDir) + "Data.ini");
                                    ini_write_string("Misc", "Raid Position", raidPos);
                                    ini_close();
                                }
                                else if (arg2 == 0)
                                {
                                    gml_Script_twitch_chat_say("/me " + string(name) + " You must be in Town and not ready to raid to change your raid position preference.");
                                }
                            }
                        }
                    }
                    else if (arg2 == 0)
                    {
                        gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
                    }
                    
                    exit;
                }
                
                if (string_pos("!setautopot", _cmd) == 1)
                {
                    if (ds_list_find_index(global.playerList, uname) != -1)
                    {
                        var amount = string_digits(_cmd);
                        
                        if (amount == "")
                            amount = 30;
                        else
                            amount = real(amount);
                        
                        if (amount <= 0)
                            amount = 30;
                        
                        if (amount > 100)
                            amount = 100;
                        
                        amount /= 100;
                        
                        with (obj_player)
                        {
                            if (name == other.uname)
                            {
                                if (myTier > 0)
                                {
                                    autoPotHP = amount;
                                    ini_open(string(global.platformDir) + string(myCharDir) + "Data.ini");
                                    ini_write_real("Misc", "Auto Potion HP", autoPotHP);
                                    ini_close();
                                    
                                    if (arg2 == 0)
                                        gml_Script_twitch_chat_say("/me " + string(name) + " set their automatic potion at " + string(amount * 100) + "% HP.");
                                }
                                else if (arg2 == 0)
                                {
                                    gml_Script_twitch_chat_say("/me " + string(name) + " you don't have access to this command. You need to reach " + string(global.cmdPrefix) + "!Hero status to unlock it.");
                                }
                            }
                        }
                    }
                    else if (arg2 == 0)
                    {
                        gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
                    }
                    
                    exit;
                }
                
                if (string_pos("!autopot", _cmd) == 1 || string_pos("!auto-pot", _cmd) == 1)
                {
                    if (ds_list_find_index(global.playerList, uname) != -1)
                    {
                        with (obj_player)
                        {
                            if (name == other.uname)
                            {
                                if (myTier > 0)
                                {
                                    if (autoPot == 0)
                                    {
                                        autoPot = 1;
                                        
                                        if (arg2 == 0)
                                            gml_Script_twitch_chat_say("/me " + string(name) + " activated automatic potion.");
                                    }
                                    else
                                    {
                                        autoPot = 0;
                                        
                                        if (arg2 == 0)
                                            gml_Script_twitch_chat_say("/me " + string(name) + " deactivated automatic potion.");
                                    }
                                    
                                    ini_open(string(global.platformDir) + string(myCharDir) + "Data.ini");
                                    ini_write_real("Misc", "Auto Potion", autoPot);
                                    ini_close();
                                }
                                else if (arg2 == 0)
                                {
                                    gml_Script_twitch_chat_say("/me " + string(name) + " you don't have access to this command. You need to reach " + string(global.cmdPrefix) + "!Hero status to unlock it.");
                                }
                            }
                        }
                    }
                    else if (arg2 == 0)
                    {
                        gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
                    }
                    
                    exit;
                }
                
                if (string_pos("!autom", _cmd) == 1 || string_pos("!auto-m", _cmd) == 1 || string_pos("!autof", _cmd) == 1 || string_pos("!auto-f", _cmd) == 1 || string_pos("!autog", _cmd) == 1 || string_pos("!auto-g", _cmd) == 1 || string_pos("!autor", _cmd) == 1 || string_pos("!auto-r", _cmd) == 1)
                {
                    if (ds_list_find_index(global.playerList, uname) != -1)
                    {
                        var _actionType = 0;
                        
                        if (string_pos("!autom", _cmd) == 1 || string_pos("!auto-m", _cmd) == 1)
                            _actionType = 1;
                        
                        if (string_pos("!autof", _cmd) == 1 || string_pos("!auto-f", _cmd) == 1)
                            _actionType = 2;
                        
                        if (string_pos("!autog", _cmd) == 1 || string_pos("!auto-g", _cmd) == 1)
                            _actionType = 3;
                        
                        if (string_pos("!autor", _cmd) == 1 || string_pos("!auto-r", _cmd) == 1)
                            _actionType = 4;
                        
                        if (_actionType == 0)
                            exit;
                        
                        with (obj_player)
                        {
                            if (name == other.uname)
                            {
                                if (canAutoAction[_actionType - 1] == 1)
                                {
                                    if (autoAction[_actionType - 1] == 0)
                                    {
                                        autoAction[_actionType - 1] = 1;
                                        
                                        if (arg2 == 0)
                                            gml_Script_twitch_chat_say("/me " + string(name) + " activated automatic " + string(global.actionText[_actionType]) + ".");
                                    }
                                    else
                                    {
                                        autoAction[_actionType - 1] = 0;
                                        
                                        if (arg2 == 0)
                                            gml_Script_twitch_chat_say("/me " + string(name) + " deactivated automatic " + string(global.actionText[_actionType]) + ".");
                                    }
                                    
                                    ini_open(string(global.platformDir) + string(myCharDir) + "Data.ini");
                                    ini_write_real("Misc", "Auto " + string(_actionType - 1), autoAction[_actionType - 1]);
                                    ini_close();
                                }
                                else if (arg2 == 0)
                                {
                                    gml_Script_twitch_chat_say("/me " + string(name) + " you don't have access to this command. You need to unlock it by maxing " + string(global.actionText[_actionType]) + " vocation or by redeeming it at the Honor Shop.");
                                }
                            }
                        }
                    }
                    else if (arg2 == 0)
                    {
                        gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
                    }
                    
                    exit;
                }
                
                if (string_pos("!autosk", _cmd) == 1 || string_pos("!auto-sk", _cmd) == 1 || string_pos("!auto-ab", _cmd) == 1 || string_pos("!autoab", _cmd) == 1)
                {
                    if (ds_list_find_index(global.playerList, uname) != -1)
                    {
                        with (obj_player)
                        {
                            if (name == other.uname)
                            {
                                if (myTier > 0 || sub == 1)
                                {
                                    if (autoAbility == 0)
                                    {
                                        autoAbility = 1;
                                        
                                        if (arg2 == 0)
                                            gml_Script_twitch_chat_say("/me " + string(name) + " activated automatic ability.");
                                    }
                                    else
                                    {
                                        autoAbility = 0;
                                        
                                        if (arg2 == 0)
                                            gml_Script_twitch_chat_say("/me " + string(name) + " deactivated automatic ability.");
                                    }
                                    
                                    ini_open(string(global.platformDir) + string(myCharDir) + "Data.ini");
                                    ini_write_real("Misc", "Auto Ability", autoAbility);
                                    ini_close();
                                }
                                else if (arg2 == 0)
                                {
                                    gml_Script_twitch_chat_say("/me " + string(name) + " you don't have access to this command. You need to reach " + string(global.cmdPrefix) + "!Legend status or subscribe to @Room_001 to unlock it.");
                                }
                            }
                        }
                    }
                    else if (arg2 == 0)
                    {
                        gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
                    }
                    
                    exit;
                }
                
                if (string_pos("!autosw", _cmd) == 1 || string_pos("!auto-sw", _cmd) == 1)
                {
                    if (ds_list_find_index(global.playerList, uname) != -1)
                    {
                        with (obj_player)
                        {
                            if (name == other.uname)
                            {
                                if (sub == 1)
                                {
                                    if (autoSwitch == 0)
                                    {
                                        autoSwitch = 1;
                                        
                                        if (arg2 == 0)
                                            gml_Script_twitch_chat_say("/me " + string(name) + " activated automatic switch.");
                                    }
                                    else
                                    {
                                        autoSwitch = 0;
                                        
                                        if (arg2 == 0)
                                            gml_Script_twitch_chat_say("/me " + string(name) + " deactivated automatic switch.");
                                    }
                                    
                                    ini_open(string(global.platformDir) + string(myCharDir) + "Data.ini");
                                    ini_write_real("Misc", "Auto Switch", autoSwitch);
                                    ini_close();
                                }
                                else if (arg2 == 0)
                                {
                                    gml_Script_twitch_chat_say("/me " + string(name) + " this command is only available to @Room_001 subscribers.");
                                }
                            }
                        }
                    }
                    else if (arg2 == 0)
                    {
                        gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
                    }
                    
                    exit;
                }
                
                if (string_pos("!autolo", _cmd) == 1 || string_pos("!auto-lo", _cmd) == 1)
                {
                    if (ds_list_find_index(global.playerList, uname) != -1)
                    {
                        with (obj_player)
                        {
                            if (name == other.uname)
                            {
                                if (sub == 1)
                                {
                                    if (autoLoot == 0)
                                    {
                                        autoLoot = 1;
                                        
                                        if (arg2 == 0)
                                            gml_Script_twitch_chat_say("/me " + string(name) + " activated automatic favorite Relic looting.");
                                    }
                                    else
                                    {
                                        autoLoot = 0;
                                        
                                        if (arg2 == 0)
                                            gml_Script_twitch_chat_say("/me " + string(name) + " deactivated automatic favorite Relic looting.");
                                    }
                                    
                                    ini_open(string(global.platformDir) + string(myCharDir) + "Data.ini");
                                    ini_write_real("Misc", "Auto Loot", autoLoot);
                                    ini_close();
                                }
                                else if (arg2 == 0)
                                {
                                    gml_Script_twitch_chat_say("/me " + string(name) + " this feature is only available to @Room_001 subscribers.");
                                }
                            }
                        }
                    }
                    else if (arg2 == 0)
                    {
                        gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
                    }
                    
                    exit;
                }
                
                if (string_pos("!autobu", _cmd) == 1 || string_pos("!auto-bu", _cmd) == 1)
                {
                    if (ds_list_find_index(global.playerList, uname) != -1)
                    {
                        with (obj_player)
                        {
                            if (name == other.uname)
                            {
                                if (sub == 1)
                                {
                                    if (autoBuy == 0)
                                    {
                                        autoBuy = 1;
                                        
                                        if (arg2 == 0)
                                            gml_Script_twitch_chat_say("/me " + string(name) + " activated automatic favorite Relic purchasing.");
                                    }
                                    else
                                    {
                                        autoBuy = 0;
                                        
                                        if (arg2 == 0)
                                            gml_Script_twitch_chat_say("/me " + string(name) + " deactivated automatic favorite Relic purchasing.");
                                    }
                                    
                                    ini_open(string(global.platformDir) + string(myCharDir) + "Data.ini");
                                    ini_write_real("Misc", "Auto Buy", autoBuy);
                                    ini_close();
                                }
                                else if (arg2 == 0)
                                {
                                    gml_Script_twitch_chat_say("/me " + string(name) + " this feature is only available to @Room_001 subscribers.");
                                }
                            }
                        }
                    }
                    else if (arg2 == 0)
                    {
                        gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
                    }
                    
                    exit;
                }
                
                if (string_pos("!magic", _cmd) == 1 || string_pos("!witch", _cmd) == 1)
                {
                    if (ds_list_find_index(global.playerList, uname) != -1)
                    {
                        if (global.witchBuilt == 0 && global.unlockWitch == 1)
                        {
                            if (global.gold >= obj_witchHut.witchCost)
                            {
                                global.witchBuilt = 1;
                                global.townMaxHP += 25;
                                global.townHP += 25;
                                global.gold -= obj_witchHut.witchCost;
                                gml_Script_scr_playsound(choose(s_buy1, s_buy2, s_buy3), 0.9, 1.1, 1);
                                
                                if (arg2 == 0)
                                    gml_Script_twitch_chat_say("/color BlueViolet");
                                
                                gml_Script_twitch_chat_say_direct("/me Searching where the black magic is coming from...");
                                
                                if (arg2 == 0)
                                    gml_Script_twitch_chat_say("/color FireBrick");
                                
                                with (gml_Script_instance_create(obj_witchHut.x, obj_witchHut.y, obj_buildingTimer))
                                {
                                    visible = false;
                                    ini_open(string(global.platformDir) + "Village Data/Data.ini");
                                    ini_write_real("Buildings", "Witch Build", 1);
                                    ini_close();
                                    build = obj_build_witchhut;
                                    timer = 120;
                                    alarm[0] = room_speed * 10;
                                    
                                    with (gml_Script_instance_create(400, 75, obj_float))
                                    {
                                        type = 8;
                                        value = obj_witchHut.witchCost;
                                        text = "-" + gml_Script_scr_bigNumber(value) + "g";
                                        c1 = 255;
                                        c2 = 128;
                                        parent = type;
                                    }
                                }
                                
                                with (obj_witchHut)
                                    instance_destroy();
                            }
                            else
                            {
                                gml_Script_twitch_chat_say_direct("/me " + string(uname) + " Searching where the magic is coming will cost the Town " + string(gml_Script_scr_bigNumber(obj_witchHut.witchCost)) + " gold.");
                            }
                        }
                    }
                    else if (arg2 == 0)
                    {
                        gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
                    }
                    
                    exit;
                }
                
                if (string_pos("!guildhall", _cmd) == 1)
                {
                    if (ds_list_find_index(global.playerList, uname) != -1)
                    {
                        if (global.guildsBuilt == 0 && global.gold >= obj_guilds.guildsCost)
                        {
                            if (global.townLevel >= obj_guilds.levelCost)
                            {
                                if (global.tutorialStep == 4)
                                {
                                    if (instance_exists(obj_tutorial))
                                    {
                                        if (obj_tutorial.alarm[1] > room_speed)
                                            obj_tutorial.alarm[1] = room_speed;
                                    }
                                }
                                
                                global.guildsBuilt = 1;
                                gml_Script_scr_townXP(obj_guilds.guildsCost);
                                global.gold -= obj_guilds.guildsCost;
                                gml_Script_scr_playsound(choose(s_buy1, s_buy2, s_buy3), 0.9, 1.1, 1);
                                
                                if (arg2 == 0)
                                    gml_Script_twitch_chat_say_direct("/me Building Guild Hall! You complete quests, guilds reward you!");
                                
                                with (gml_Script_instance_create(obj_guilds.x, obj_guilds.y, obj_buildingTimer))
                                {
                                    ini_open(string(global.platformDir) + "Village Data/Data.ini");
                                    ini_write_real("Buildings", "Guild Hall", 1);
                                    ini_close();
                                    build = obj_build_guildhall;
                                    timer = 300;
                                    alarm[0] = room_speed * timer;
                                    
                                    with (gml_Script_instance_create(400, 75, obj_float))
                                    {
                                        type = 8;
                                        value = obj_guilds.guildsCost;
                                        text = "-" + gml_Script_scr_bigNumber(value) + "g";
                                        c1 = 255;
                                        c2 = 128;
                                        parent = type;
                                    }
                                }
                                
                                with (obj_guilds)
                                    instance_destroy();
                            }
                        }
                    }
                    else if (arg2 == 0)
                    {
                        gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
                    }
                    
                    exit;
                }
                
                if (string_pos("!academy", _cmd) == 1)
                {
                    if (ds_list_find_index(global.playerList, uname) != -1)
                    {
                        if (global.academyBuilt == 0 && global.gold >= obj_academy.academyCost)
                        {
                            if (global.townLevel >= obj_academy.levelCost)
                            {
                                if (global.tutorialStep == 3)
                                {
                                    if (instance_exists(obj_tutorial))
                                    {
                                        if (obj_tutorial.alarm[1] > room_speed)
                                            obj_tutorial.alarm[1] = room_speed;
                                    }
                                }
                                
                                global.academyBuilt = 1;
                                gml_Script_scr_townXP(obj_academy.academyCost);
                                global.gold -= obj_academy.academyCost;
                                gml_Script_scr_playsound(choose(s_buy1, s_buy2, s_buy3), 0.9, 1.1, 1);
                                
                                if (arg2 == 0)
                                    gml_Script_twitch_chat_say_direct("/me Building academy! Knowledge for everyone!...");
                                
                                with (gml_Script_instance_create(obj_academy.x, obj_academy.y, obj_buildingTimer))
                                {
                                    ini_open(string(global.platformDir) + "Village Data/Data.ini");
                                    ini_write_real("Buildings", "Academy", 1);
                                    ini_close();
                                    build = obj_build_academy;
                                    timer = 300;
                                    alarm[0] = room_speed * timer;
                                    
                                    with (gml_Script_instance_create(400, 75, obj_float))
                                    {
                                        type = 8;
                                        value = obj_academy.academyCost;
                                        text = "-" + gml_Script_scr_bigNumber(value) + "g";
                                        c1 = 255;
                                        c2 = 128;
                                        parent = type;
                                    }
                                }
                                
                                with (obj_academy)
                                    instance_destroy();
                            }
                        }
                    }
                    else if (arg2 == 0)
                    {
                        gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
                    }
                    
                    exit;
                }
                
                if (string_pos("!creaturekeeper", _cmd) == 1)
                {
                    if (ds_list_find_index(global.playerList, uname) != -1)
                    {
                        if (global.keeperBuilt == 0 && global.gold >= obj_creatureKeeper.cost)
                        {
                            if (global.townLevel >= obj_creatureKeeper.levelCost)
                            {
                                global.keeperBuilt = 1;
                                gml_Script_scr_townXP(obj_creatureKeeper.cost);
                                global.gold -= obj_creatureKeeper.cost;
                                gml_Script_scr_playsound(choose(s_buy1, s_buy2, s_buy3), 0.9, 1.1, 1);
                                
                                if (arg2 == 0)
                                    gml_Script_twitch_chat_say_direct("/me Building Creature Keeper! A new friend is coming to town!...");
                                
                                with (gml_Script_instance_create(obj_creatureKeeper.x, obj_creatureKeeper.y, obj_buildingTimer))
                                {
                                    ini_open(string(global.platformDir) + "Village Data/Data.ini");
                                    ini_write_real("Buildings", "Creature Keeper", 1);
                                    ini_close();
                                    build = obj_build_creaturekeeper;
                                    timer = 3;
                                    alarm[0] = room_speed * timer;
                                    
                                    with (gml_Script_instance_create(400, 75, obj_float))
                                    {
                                        type = 8;
                                        value = obj_creatureKeeper.cost;
                                        text = "-" + gml_Script_scr_bigNumber(value) + "g";
                                        c1 = 255;
                                        c2 = 128;
                                        parent = type;
                                    }
                                }
                                
                                with (obj_creatureKeeper)
                                    instance_destroy();
                            }
                        }
                    }
                    else if (arg2 == 0)
                    {
                        gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
                    }
                    
                    exit;
                }
                
                if (string_pos("!egg", _cmd) == 1)
                {
                    if (ds_list_find_index(global.playerList, uname) != -1)
                    {
                        if (instance_exists(obj_build_creaturekeeper))
                        {
                            if (obj_build_creaturekeeper.eggchosen == -1)
                            {
                                var chooseEgg = string_digits(_cmd);
                                
                                if (chooseEgg == "")
                                    chooseEgg = -1;
                                else
                                    chooseEgg = real(string_digits(chooseEgg));
                                
                                if (chooseEgg >= 1 && chooseEgg <= 3)
                                {
                                    with (obj_build_creaturekeeper)
                                    {
                                        eggchosen = chooseEgg - 1;
                                        eggstage = 0;
                                        alarm[0] = hatchtimer;
                                    }
                                    
                                    gml_Script_scr_playsound(choose(s_buy1, s_buy2, s_buy3), 0.9, 1.1, 1);
                                    
                                    if (arg2 == 0)
                                        gml_Script_twitch_chat_say_direct("/me You chose egg " + string(chooseEgg) + "! It is now starting to hatch!");
                                }
                                else if (arg2 == 0)
                                {
                                    gml_Script_twitch_chat_say("/me You can only choose between 3 eggs!");
                                }
                            }
                        }
                    }
                    else if (arg2 == 0)
                    {
                        gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
                    }
                    
                    exit;
                }
                
                if (string_pos("!shop", _cmd) == 1)
                {
                    if (ds_list_find_index(global.playerList, uname) != -1)
                    {
                        if (global.shopBuilt == 0 && global.gold >= obj_shop.shopCost && global.townLevel >= obj_shop.levelCost)
                        {
                            global.shopBuilt = 1;
                            gml_Script_scr_townXP(obj_shop.shopCost);
                            global.gold -= obj_shop.shopCost;
                            gml_Script_scr_playsound(choose(s_buy1, s_buy2, s_buy3), 0.9, 1.1, 1);
                            
                            if (arg2 == 0)
                                gml_Script_twitch_chat_say_direct("/me Building shop! A mysterious silhouette is approaching the town...");
                            
                            with (gml_Script_instance_create(obj_shop.x, obj_shop.y, obj_buildingTimer))
                            {
                                ini_open(string(global.platformDir) + "Village Data/Data.ini");
                                ini_write_real("Buildings", "Shop", 1);
                                ini_close();
                                build = obj_build_shop;
                                timer = 300;
                                alarm[0] = room_speed * timer;
                                
                                with (gml_Script_instance_create(400, 75, obj_float))
                                {
                                    type = 8;
                                    value = obj_shop.shopCost;
                                    text = "-" + gml_Script_scr_bigNumber(value) + "g";
                                    c1 = 255;
                                    c2 = 128;
                                    parent = type;
                                }
                            }
                            
                            with (obj_shop)
                                instance_destroy();
                        }
                    }
                    else if (arg2 == 0)
                    {
                        gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
                    }
                    
                    exit;
                }
                
                if (string_pos("!spend", _cmd) == 1)
                {
                    if (ds_list_find_index(global.playerList, uname) != -1)
                    {
                        if (string_pos("*", _cmd) == 0)
                            exit;
                        
                        var _length = real(string_pos("*", _cmd));
                        var _index = "obj_build_" + string_copy(_cmd, 11, _length - 11);
                        
                        if (_index == "obj_build_witchhut")
                            exit;
                        
                        var _spendType = string_copy(_cmd, 7, 4);
                        
                        if (_spendType != "gold" && _spendType != "gems")
                        {
                            _index = "obj_build_" + string_copy(_cmd, 7, _length - 7);
                            
                            if (_index == "obj_build_witchhut")
                                exit;
                        }
                        
                        var _suffix = string_letters(string_char_at(_cmd, string_length(_cmd)));
                        show_debug_message("Spend suffix: " + string(_suffix));
                        var _amount = string_digits(_cmd);
                        
                        if (_amount == "")
                        {
                            if (string_pos("all", _cmd) != 0)
                                _suffix = "all";
                            else
                                exit;
                        }
                        else
                        {
                            _amount = real(_amount);
                        }
                        
                        if (_suffix == "k")
                            _amount *= 1000;
                        
                        if (_suffix == "m")
                            _amount *= 1000000;
                        
                        if (_suffix == "b")
                            _amount *= 1000000000;
                        
                        if (_suffix == "t")
                            _amount *= 1000000000000;
                        
                        var _cost = 0;
                        var _building;
                        
                        if (asset_get_index(string(_index)) != -1)
                        {
                            if (instance_exists(asset_get_index(string(_index))))
                            {
                                _building = asset_get_index(string(_index));
                                _cost = _building.cost;
                            }
                            else
                            {
                                gml_Script_twitch_chat_say_direct("/me " + string(uname) + " This building has not been constructed yet!");
                                show_debug_message("Building '" + string(_index) + "' is not available.");
                                exit;
                            }
                        }
                        else
                        {
                            show_debug_message("Building '" + string(_index) + "' does not exist.");
                            exit;
                        }
                        
                        var _type = 0;
                        var _player = -1;
                        var _playerValue = 0;
                        
                        with (obj_player)
                        {
                            if (name == other.uname)
                                _player = id;
                        }
                        
                        if (_spendType == "gold")
                        {
                            _type = 0;
                            _cost = _building.cost;
                            _playerValue = _player.mygold;
                        }
                        else if (_spendType == "gems")
                        {
                            _type = 1;
                            _cost = _building.cost2;
                            
                            if (_cost == 0)
                            {
                                if (arg2 == 0)
                                    gml_Script_twitch_chat_say("/me " + string(uname) + " the " + string(_building.name) + " doesn't require gems to upgrade.");
                                
                                exit;
                            }
                            
                            _playerValue = _player.myGems;
                        }
                        else if (_building.cost2 == 0)
                        {
                            _spendType = "gold";
                            _type = 0;
                            _cost = _building.cost;
                            _playerValue = _player.mygold;
                        }
                        else
                        {
                            if (_amount == "")
                                _amount = 10;
                            
                            if (arg2 == 0)
                                gml_Script_twitch_chat_say("/me " + string(uname) + " you must specify if you want to spend gold or gems on upgrading the " + string(_building.name) + " (!spend gems " + string(_building.name) + " * " + gml_Script_scr_bigNumber(_amount) + ").");
                            
                            exit;
                        }
                        
                        if (_cost <= 0 || _building.costText == "Maximum Level")
                        {
                            show_debug_message("Cant spend more " + string(_spendType) + " on " + string(_building.name) + " building");
                            exit;
                        }
                        
                        show_debug_message("Spend " + string(_amount) + " " + string(_spendType) + " on " + string(_building.name) + " building");
                        
                        if (asset_get_index(string(_index)) == -1)
                        {
                            show_debug_message("Building '" + string(_index) + "' does not exist.");
                            exit;
                        }
                        else
                        {
                            show_debug_message("Building '" + string(_index) + "' exists.");
                            
                            if (instance_exists(asset_get_index(string(_index))))
                            {
                                show_debug_message("Building '" + string(_index) + "' is available.");
                                _building = asset_get_index(string(_index));
                                var chooseAmount = _amount;
                                
                                with (obj_player)
                                {
                                    if (name == other.uname)
                                    {
                                        var _spend = 0;
                                        var _xpText = "";
                                        
                                        if (_suffix == "all")
                                            _amount = round(_playerValue);
                                        
                                        if (state == UnknownEnum.Value_8)
                                        {
                                            if (arg2 == 0)
                                                gml_Script_twitch_chat_say("/me " + string(name) + " you must be in town to spend gold on buildings.");
                                            
                                            exit;
                                        }
                                        else
                                        {
                                            if (_playerValue >= _amount)
                                                _spend = _amount;
                                            else
                                                _spend = round(_playerValue);
                                            
                                            if (_spend > 0)
                                            {
                                                if (_cost > 0 && _building.costText != "Maximum Level")
                                                {
                                                    var _oldCost = _cost;
                                                    var _xpGain = 0;
                                                    
                                                    if (_type == 0)
                                                    {
                                                        if (_spend > _building.cost)
                                                            _spend = _building.cost;
                                                        
                                                        _building.cost -= _spend;
                                                    }
                                                    
                                                    if (_type == 1)
                                                    {
                                                        if (_spend > _building.cost2)
                                                            _spend = _building.cost2;
                                                        
                                                        _building.cost2 -= _spend;
                                                    }
                                                    
                                                    if (_building.cost <= 0 && ((_building.oCost2 > 0 && _building.cost2 <= 0) || _building.oCost2 <= 0))
                                                    {
                                                        _spend = _oldCost;
                                                        _xpGain = _spend;
                                                        
                                                        if (_type == 1)
                                                            _xpGain = (_building.oCost / _building.oCost2) * _spend;
                                                        
                                                        _xpText = " The Town obtained " + gml_Script_scr_bigNumber(_xpGain) + " XP!";
                                                        show_debug_message("You spent " + gml_Script_scr_bigNumber(_spend) + " " + string(_spendType) + " on '" + string(_building.name) + " and leveled it up!");
                                                        gml_Script_twitch_chat_say("/me " + string(name) + " spent " + gml_Script_scr_bigNumber(_spend) + " of their personal " + string(_spendType) + " on the " + string(_building.name) + " and leveled it up!" + string(_xpText));
                                                        gml_Script_scr_upgBuilding(_building, 0);
                                                    }
                                                    else
                                                    {
                                                        _xpGain = _spend;
                                                        
                                                        if (_type == 1)
                                                            _xpGain = 0;
                                                        
                                                        if (_xpGain > 0)
                                                            _xpText = " The Town obtained " + gml_Script_scr_bigNumber(_xpGain) + " XP!";
                                                        
                                                        _building.costText = gml_Script_scr_bigNumber(_building.cost);
                                                        ini_open(string(global.platformDir) + "Village Data/Data.ini");
                                                        ini_write_real("Buildings", string(_building.name) + " Cost", _building.cost);
                                                        ini_write_real("Buildings", string(_building.name) + " Cost 2", _building.cost2);
                                                        ini_close();
                                                        
                                                        if (_type == 0)
                                                            _cost = _building.cost;
                                                        
                                                        if (_type == 1)
                                                            _cost = _building.cost2;
                                                        
                                                        show_debug_message("You spent " + gml_Script_scr_bigNumber(_spend) + " " + string(_spendType) + " on '" + string(_building.name) + ". Building " + string(_spendType) + " cost is now " + gml_Script_scr_bigNumber(_cost) + ".");
                                                        gml_Script_twitch_chat_say("/me " + string(name) + " spent " + gml_Script_scr_bigNumber(_spend) + " of their personal " + string(_spendType) + " on the " + string(_building.name) + " and reduced its " + string(_spendType) + " upgrade cost to " + gml_Script_scr_bigNumber(_cost) + "!" + string(_xpText));
                                                    }
                                                    
                                                    if (_type == 0)
                                                    {
                                                        mygold -= _spend;
                                                        donated += _spend;
                                                    }
                                                    
                                                    if (_type == 1)
                                                    {
                                                        myGems -= _spend;
                                                        donated_gems += _spend;
                                                    }
                                                    
                                                    gml_Script_scr_townXP(_xpGain);
                                                }
                                                else
                                                {
                                                    gml_Script_twitch_chat_say("/me " + string(name) + " " + string(_building.name) + " reached its maximum level and cannot be upgraded any further!");
                                                    show_debug_message("Can not reduce '" + string(_index) + "' cost.");
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            else
                            {
                                gml_Script_twitch_chat_say("/me " + string(uname) + " This building has not been constructed yet!");
                                show_debug_message("Building '" + string(_index) + "' is not available.");
                            }
                        }
                    }
                    else if (arg2 == 0)
                    {
                        gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
                    }
                }
                
                if (string_pos("!forge", _cmd) == 1)
                {
                    if (ds_list_find_index(global.playerList, uname) != -1)
                    {
                        if (global.blacksmithBuilt == 0 && global.gold >= obj_blacksmith.blacksmithCost && global.townLevel >= obj_blacksmith.levelCost)
                        {
                            global.blacksmithBuilt = 1;
                            gml_Script_scr_townXP(obj_blacksmith.blacksmithCost);
                            global.gold -= obj_blacksmith.blacksmithCost;
                            gml_Script_scr_playsound(choose(s_buy1, s_buy2, s_buy3), 0.9, 1.1, 1);
                            
                            if (arg2 == 0)
                                gml_Script_twitch_chat_say_direct("/me Building forge! The blacksmith will be able to upgrade some of your items!");
                            
                            with (gml_Script_instance_create(obj_blacksmith.x, obj_blacksmith.y, obj_buildingTimer))
                            {
                                ini_open(string(global.platformDir) + "Village Data/Data.ini");
                                ini_write_real("Buildings", "Forge", 1);
                                ini_close();
                                build = obj_build_forge;
                                timer = 300;
                                alarm[0] = room_speed * timer;
                                
                                with (gml_Script_instance_create(400, 75, obj_float))
                                {
                                    type = 8;
                                    value = obj_blacksmith.blacksmithCost;
                                    text = "-" + gml_Script_scr_bigNumber(value) + "g";
                                    c1 = 255;
                                    c2 = 128;
                                    parent = type;
                                }
                            }
                            
                            with (obj_blacksmith)
                                instance_destroy();
                        }
                    }
                    else if (arg2 == 0)
                    {
                        gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
                    }
                }
                
                if (string_pos("!well", _cmd) == 1)
                {
                    if (ds_list_find_index(global.playerList, uname) != -1)
                    {
                        if (global.wellBuilt == 0 && global.gold >= obj_well.wellCost)
                        {
                            global.wellBuilt = 1;
                            gml_Script_scr_townXP(obj_well.wellCost);
                            global.gold -= obj_well.wellCost;
                            gml_Script_scr_playsound(choose(s_buy1, s_buy2, s_buy3), 0.9, 1.1, 1);
                            
                            if (arg2 == 0)
                                gml_Script_twitch_chat_say_direct("/me Building well! I guess throwing coins in it will do something...");
                            
                            with (gml_Script_instance_create(obj_well.x, obj_well.y, obj_buildingTimer))
                            {
                                ini_open(string(global.platformDir) + "Village Data/Data.ini");
                                ini_write_real("Buildings", "Well", 1);
                                ini_close();
                                build = obj_build_well;
                                timer = 150;
                                sprite_index = spr_blank;
                                alarm[0] = room_speed * timer;
                                
                                with (gml_Script_instance_create(400, 75, obj_float))
                                {
                                    type = 8;
                                    value = obj_well.wellCost;
                                    text = "-" + gml_Script_scr_bigNumber(value) + "g";
                                    c1 = 255;
                                    c2 = 128;
                                    parent = type;
                                }
                            }
                            
                            with (obj_well)
                                instance_destroy();
                        }
                    }
                    else if (arg2 == 0)
                    {
                        gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
                    }
                    
                    exit;
                }
                
                if (string_pos("!upgwitch", _cmd) == 1)
                {
                    if (ds_list_find_index(global.playerList, uname) != -1)
                    {
                        if (instance_exists(obj_build_witchhut))
                        {
                            if (global.souls >= obj_build_witchhut.cost && obj_build_witchhut.cost < global.maxNumber)
                            {
                                if (!instance_exists(obj_votePoll_new))
                                {
                                    with (gml_Script_instance_create(x, y, obj_votePoll_new))
                                    {
                                        name = other.uname;
                                        buildObj = obj_build_witchhut;
                                        buildName = "Witch Hut";
                                        cost1 = obj_build_witchhut.cost;
                                        cost1type = "souls";
                                        votes = 0;
                                        alarm[0] = 1;
                                        alarm[1] = room_speed * 60;
                                    }
                                }
                                else if (arg2 == 0)
                                {
                                    gml_Script_twitch_chat_say("/me A poll is currently being made, please wait until the decision is made to start a new one.");
                                }
                            }
                            else if (arg2 == 0)
                            {
                                gml_Script_twitch_chat_say("/me Either you need more souls to upgrade the Witch Hut or it has reached its maximum level.");
                            }
                        }
                    }
                    else if (arg2 == 0)
                    {
                        gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
                    }
                    
                    exit;
                }
                
                if (string_pos("!portal", _cmd) == 1 || string_pos("room00portal", _cmd) == 1)
                {
                    if (ds_list_find_index(global.playerList, uname) != -1)
                    {
                        if (global.portalPoints >= global.portalMaxPoints)
                        {
                            if (global.gotWitch == 1 || global.dev == 1)
                            {
                                with (obj_player)
                                {
                                    if (name == other.uname)
                                    {
                                        if (ds_list_find_index(global.raidListPortalName, string(name)) == -1)
                                        {
                                            ini_open(string(global.platformDir) + string(myAccDir) + "Character Data.ini");
                                            ini_write_real("Portal", "Portal ID", global.portalID);
                                            ini_close();
                                            usePortal = global.portalID;
                                            gml_Script_scr_playsound(s_portalClose2, 0.9, 1.1, 0.3);
                                            alarm[8] += room_speed * 3600;
                                            gml_Script_scr_alarm_start(0, gml_Script_scr_alarm_get(0) + (room_speed * 3600), gml_Script_scr_updateStats);
                                            alarm[9] += room_speed * 3600;
                                            gml_Script_scr_alarm_start(1, gml_Script_scr_alarm_get(1) + (room_speed * 3600), gml_Script_scr_updateStats);
                                            gml_Script_scr_updateStats();
                                            
                                            if (obj_bossKey.alarm[0] == -1)
                                            {
                                                obj_bossKey.alarm[0] = room_speed * 3600;
                                                gml_Script_twitch_chat_say("/color BlueViolet");
                                                gml_Script_twitch_chat_say_direct("/me " + string(name) + " has opened the Underworld Portal room00Portal . Type " + string(global.cmdPrefix) + "portal to enter...");
                                                gml_Script_twitch_chat_say("/color FireBrick");
                                            }
                                            
                                            ds_list_add(global.raidListPortalName, string(name));
                                            ds_list_add(global.raidListPortalClass, string(class));
                                            achievement[20] += 1;
                                            
                                            if (diaryQuest[42][0] < 50)
                                                gml_Script_scr_addDiaryProgress(9, 1);
                                            
                                            with (obj_player)
                                            {
                                                if (ascended == true)
                                                {
                                                    if (ds_list_find_index(global.raidListPortalName, string(name)) == -1)
                                                    {
                                                        usePortal = global.portalID;
                                                        alarm[8] += room_speed * 3600;
                                                        alarm[9] += room_speed * 3600;
                                                        gml_Script_scr_updateStats();
                                                        ds_list_add(global.raidListPortalName, string(name));
                                                        ds_list_add(global.raidListPortalClass, string(class));
                                                        gml_Script_twitch_chat_say("/me " + string(name) + " is ready to go into the Underworld Portal! room00Raid room00Portal");
                                                    }
                                                }
                                            }
                                            
                                            if (arg2 == 0)
                                                gml_Script_twitch_chat_say("/color BlueViolet");
                                            
                                            gml_Script_twitch_chat_say("/me " + string(name) + " is ready to go into the Underworld Portal! room00Raid room00Portal");
                                            
                                            if (arg2 == 0)
                                                gml_Script_twitch_chat_say("/color FireBrick");
                                        }
                                        else
                                        {
                                            gml_Script_twitch_chat_say("/me You already used this Underworld Portal, doing it again would disintegrate you...");
                                        }
                                    }
                                }
                            }
                            else
                            {
                                gml_Script_twitch_chat_say("/me " + string(uname) + " we should find where the odd presence is coming from before entering this mysterious portal... You can sense dark !magic being used nearby.");
                            }
                        }
                    }
                    else if (arg2 == 0)
                    {
                        gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
                    }
                    
                    exit;
                }
                
                if (string_pos("!redportal", _cmd) == 1)
                {
                    if (ds_list_find_index(global.playerList, uname) != -1)
                    {
                        if (global.portalTower >= 5 || global.dev == 1)
                        {
                            with (obj_player)
                            {
                                if (name == other.uname)
                                {
                                    if (global.redPortalOpen == false)
                                    {
                                        if (global.bloodgems >= global.redPortalCost || global.dev == true)
                                        {
                                            gml_Script_twitch_chat_say_direct("/me You completed the ritual to open the Red Portal, you can now enter the Corrupted Dimension.");
                                            global.bloodgems -= global.redPortalCost;
                                            global.redPortalOpen = true;
                                        }
                                        else
                                        {
                                            gml_Script_twitch_chat_say("/me You are missing " + string(global.redPortalCost - global.bloodgems) + " Blood Gems to complete the Red Portal ritual.");
                                            exit;
                                        }
                                    }
                                    
                                    if (ds_list_find_index(global.raidListRedPortalName, string(name)) == -1)
                                    {
                                        ini_open(string(global.platformDir) + string(myAccDir) + "Character Data.ini");
                                        ini_write_real("Red Portal", "Red Portal ID", global.redPortalID);
                                        ini_close();
                                        useRedPortal = global.redPortalID;
                                        gml_Script_scr_playsound(s_portalClose2, 0.9, 1.1, 0.3);
                                        
                                        if (obj_corruptedControl.alarm[0] == -1)
                                        {
                                            obj_corruptedControl.alarm[0] = room_speed * 86400;
                                            gml_Script_twitch_chat_say("/color BlueViolet");
                                            gml_Script_twitch_chat_say_direct("/me " + string(name) + " has opened the Red Portal room00Portal . Type " + string(global.cmdPrefix) + "redportal to enter...");
                                            gml_Script_twitch_chat_say("/color FireBrick");
                                        }
                                        
                                        ds_list_add(global.raidListRedPortalName, string(name));
                                        ds_list_add(global.raidListRedPortalClass, string(class));
                                        
                                        with (obj_player)
                                        {
                                            if (ascended == true)
                                            {
                                                if (ds_list_find_index(global.raidListRedPortalName, string(name)) == -1)
                                                {
                                                    useRedPortal = global.redPortalID;
                                                    ds_list_add(global.raidListRedPortalName, string(name));
                                                    ds_list_add(global.raidListRedPortalClass, string(class));
                                                    gml_Script_twitch_chat_say("/me " + string(name) + " is ready to go into the Red Portal! room00Raid room00Portal");
                                                }
                                            }
                                        }
                                        
                                        if (arg2 == 0)
                                            gml_Script_twitch_chat_say("/color BlueViolet");
                                        
                                        gml_Script_twitch_chat_say("/me " + string(name) + " is ready to go into the Red Portal! room00Raid room00Portal");
                                        
                                        if (arg2 == 0)
                                            gml_Script_twitch_chat_say("/color FireBrick");
                                    }
                                    else
                                    {
                                        gml_Script_twitch_chat_say("/me You already used this Red Portal, doing it again would... you already know.");
                                    }
                                }
                            }
                        }
                        else
                        {
                            gml_Script_twitch_chat_say("/me " + string(uname) + " Red Portal? You have not found any... yet.");
                        }
                    }
                    else if (arg2 == 0)
                    {
                        gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
                    }
                    
                    exit;
                }
                
                if (string_pos("!talent", _cmd) == 1 || string_pos("room00talent", _cmd) == 1)
                {
                    if (ds_list_find_index(global.playerList, uname) != -1)
                    {
                        if (instance_exists(obj_build_academy))
                        {
                            var _index, _amount;
                            
                            if (string_pos("*", _cmd) == 0)
                            {
                                _index = string_digits(_cmd);
                                _amount = 999999999999;
                            }
                            else
                            {
                                var _length = real(string_pos("*", _cmd));
                                _index = string_digits(string_copy(_cmd, 1, _length));
                                
                                if (_index != "")
                                    _index = real(_index);
                                else
                                    exit;
                                
                                _amount = string_digits(string_delete(_cmd, 1, _length));
                                
                                if (_amount != "")
                                    _amount = real(_amount);
                                else
                                    _amount = 999999999999;
                            }
                            
                            show_debug_message("Talent: " + string(_index) + " - " + string(_amount) + "x");
                            var learnAmount = _amount;
                            var setLearn = 99;
                            
                            if (string_digits(_index) != "")
                                _index -= 1;
                            
                            if (_index == 0)
                                setLearn = 3;
                            
                            if (_index == 1)
                                setLearn = 8;
                            
                            if (_index == 2)
                                setLearn = 6;
                            
                            if (_index == 3)
                                setLearn = 7;
                            
                            if (_index == 4)
                                setLearn = 0;
                            
                            if (_index == 5)
                                setLearn = 5;
                            
                            if (_index == 6)
                                setLearn = 4;
                            
                            if (_index == 7)
                                setLearn = 1;
                            
                            if (_index == 8)
                                setLearn = 2;
                            
                            if (_index == 9)
                                setLearn = 9;
                            
                            setLearn += 1;
                            
                            if (setLearn > 0 && setLearn <= 10)
                            {
                                with (obj_player)
                                {
                                    if (name == other.uname)
                                    {
                                        if (skillPoints > 0)
                                        {
                                            if (state == UnknownEnum.Value_8)
                                            {
                                                if (arg2 == 0)
                                                    gml_Script_twitch_chat_say("/me " + string(name) + " You must be in town to spend talent points.");
                                                
                                                exit;
                                            }
                                            
                                            var finalAmount;
                                            
                                            if (learnAmount >= skillPoints)
                                            {
                                                finalAmount = skillPoints;
                                            }
                                            else
                                            {
                                                finalAmount = learnAmount;
                                                
                                                if (learnAmount == 0)
                                                    finalAmount = 1;
                                            }
                                            
                                            setLearn -= 1;
                                            var _pointsSpent = 0;
                                            var _pointsLeft = 0;
                                            baseStat[setLearn][0] += finalAmount;
                                            skillPoints -= finalAmount;
                                            var _result = gml_Script_scr_updateStats(finalAmount, setLearn);
                                            _pointsSpent = _result;
                                            var capped = false;
                                            
                                            if (myStatInfo[setLearn][3] >= myStatInfo[setLearn][4])
                                                capped = true;
                                            
                                            show_debug_message("Actually spent " + string(_pointsSpent) + " TPs");
                                            show_debug_message("Stat " + string(setLearn) + " = " + string(global.baseStatText[setLearn]) + ".");
                                            gml_Script_scr_playsound(choose(s_talent1, s_talent2, s_talent3, s_talent4, s_talent5), 0.9, 1.1, 1);
                                            
                                            if (capped == false)
                                            {
                                                if (global.chatSpam <= 2)
                                                {
                                                    if (arg2 == 0)
                                                        gml_Script_twitch_chat_say("/me " + string(name) + " got +" + gml_Script_scr_bigNumber(_pointsSpent / global.talentValue[setLearn]) + " " + string(global.baseStatText[setLearn]) + " for " + gml_Script_scr_bigNumber(_pointsSpent) + " room00Talent ! (Total spent on " + string(global.baseStatText[setLearn]) + ": " + gml_Script_scr_bigNumber(baseStat[setLearn][0]) + " | " + gml_Script_scr_bigNumber(skillPoints) + " room00Talent left).");
                                                }
                                            }
                                            else if (global.chatSpam <= 2)
                                            {
                                                if (arg2 == 0)
                                                    gml_Script_twitch_chat_say("/me " + string(name) + " got +" + gml_Script_scr_bigNumber(_pointsSpent / global.talentValue[setLearn]) + " " + string(global.baseStatText[setLearn]) + " for " + gml_Script_scr_bigNumber(_pointsSpent) + " room00Talent and maxed this stat! (Total spent on " + string(global.baseStatText[setLearn]) + ": " + gml_Script_scr_bigNumber(baseStat[setLearn][0]) + " | " + gml_Script_scr_bigNumber(skillPoints) + " room00Talent left).");
                                            }
                                        }
                                        else if (global.chatSpam <= 2)
                                        {
                                            if (arg2 == 0)
                                                gml_Script_twitch_chat_say("/me " + string(name) + " You don't have any room00Talent available.");
                                        }
                                    }
                                }
                            }
                            else if (global.chatSpam <= 2)
                            {
                                if (arg2 == 0)
                                    gml_Script_twitch_chat_say("/me " + string(uname) + " That talent does not exist or the command format is incorrect (!talent #*#).");
                            }
                        }
                        else if (arg2 == 0)
                        {
                            gml_Script_twitch_chat_say("/me " + string(uname) + " You must build the academy in order to spend talent points!");
                        }
                    }
                    else if (arg2 == 0)
                    {
                        gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
                    }
                    
                    exit;
                }
                
                if (string_pos("!respec", _cmd) == 1)
                {
                    if (ds_list_find_index(global.playerList, uname) != -1)
                    {
                        if (instance_exists(obj_build_academy))
                        {
                            var _index, _amount;
                            
                            if (string_pos("*", _cmd) == 0)
                            {
                                _index = string_digits(_cmd);
                                _amount = 999999999999;
                            }
                            else
                            {
                                var _length = real(string_pos("*", _cmd));
                                _index = string_digits(string_copy(_cmd, 1, _length));
                                
                                if (_index != "")
                                    _index = real(_index);
                                else
                                    exit;
                                
                                _amount = string_digits(string_delete(_cmd, 1, _length));
                                
                                if (_amount != "")
                                    _amount = real(_amount);
                                else
                                    _amount = 999999999999;
                            }
                            
                            show_debug_message("Respec: " + string(_index) + " - " + string(_amount) + "x");
                            var learnAmount = _amount;
                            var setLearn = 99;
                            
                            if (string_digits(_index) != "")
                                _index -= 1;
                            
                            if (_index == 0)
                                setLearn = 3;
                            
                            if (_index == 1)
                                setLearn = 8;
                            
                            if (_index == 2)
                                setLearn = 6;
                            
                            if (_index == 3)
                                setLearn = 7;
                            
                            if (_index == 4)
                                setLearn = 0;
                            
                            if (_index == 5)
                                setLearn = 5;
                            
                            if (_index == 6)
                                setLearn = 4;
                            
                            if (_index == 7)
                                setLearn = 1;
                            
                            if (_index == 8)
                                setLearn = 2;
                            
                            if (_index == 9)
                                setLearn = 9;
                            
                            setLearn += 1;
                            
                            if (setLearn > 0 && setLearn <= 10)
                            {
                                with (obj_player)
                                {
                                    if (name == other.uname)
                                    {
                                        setLearn -= 1;
                                        
                                        if (baseStat[setLearn][0] > 0)
                                        {
                                            if (state == UnknownEnum.Value_8)
                                            {
                                                if (arg2 == 0)
                                                    gml_Script_twitch_chat_say("/me " + string(name) + " You must be in town to remove talent points.");
                                                
                                                exit;
                                            }
                                            
                                            var finalAmount;
                                            
                                            if (learnAmount >= baseStat[setLearn][0])
                                            {
                                                finalAmount = baseStat[setLearn][0];
                                            }
                                            else
                                            {
                                                finalAmount = learnAmount;
                                                
                                                if (learnAmount == 0)
                                                    finalAmount = 1;
                                            }
                                            
                                            respecCost = 0;
                                            
                                            if (sub == 1 || myTier >= 2)
                                                respecCost = 0;
                                            
                                            if (respecCost <= mygold)
                                            {
                                                baseStat[setLearn][0] -= finalAmount;
                                                skillPoints += finalAmount;
                                                mygold -= respecCost;
                                                gml_Script_scr_playsound(choose(s_talent1, s_talent2, s_talent3, s_talent4, s_talent5), 0.9, 1.1, 1);
                                                ini_open(string(global.platformDir) + string(myCharDir) + "Data.ini");
                                                ini_write_real("Stats", "Base Stat " + string(setLearn), baseStat[setLearn][0]);
                                                ini_write_real("Stats", "Skill Points", skillPoints);
                                                gml_Script_scr_updateStats();
                                                ini_close();
                                                
                                                if (global.chatSpam <= 2)
                                                {
                                                    if (arg2 == 0)
                                                        gml_Script_twitch_chat_say("/me " + string(name) + " removed " + gml_Script_scr_bigNumber(finalAmount / global.talentValue[setLearn]) + " " + string(global.baseStatText[setLearn]) + " and got " + gml_Script_scr_bigNumber(finalAmount) + " room00Talent back! (Total " + string(global.baseStatText[setLearn]) + ": " + gml_Script_scr_bigNumber(baseStat[setLearn][0]) + " | " + gml_Script_scr_bigNumber(skillPoints) + " room00Talent left, costed " + gml_Script_scr_bigNumber(respecCost) + "g)");
                                                }
                                            }
                                            else if (global.chatSpam <= 2)
                                            {
                                                if (arg2 == 0)
                                                    gml_Script_twitch_chat_say("/me " + string(name) + " You need " + string(respecCost - mygold) + " more gold to do that...");
                                            }
                                        }
                                        else if (global.chatSpam <= 2)
                                        {
                                            if (arg2 == 0)
                                                gml_Script_twitch_chat_say("/me " + string(name) + " You don't have any room00Talent spent on " + string(global.baseStatText[setLearn]) + "...");
                                        }
                                    }
                                }
                            }
                            else
                            {
                                gml_Script_twitch_chat_say("/me " + string(uname) + " Available talent slots: 1 to 10");
                            }
                        }
                        else if (arg2 == 0)
                        {
                            gml_Script_twitch_chat_say("/me " + string(uname) + " You must build the academy in order to remove talent points!");
                        }
                    }
                    else if (arg2 == 0)
                    {
                        gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
                    }
                    
                    exit;
                }
                
                if (string_pos("!fullrespec", _cmd) == 1)
                {
                    if (ds_list_find_index(global.playerList, uname) != -1)
                    {
                        if (instance_exists(obj_build_academy))
                        {
                            with (obj_player)
                            {
                                if (name == other.uname)
                                {
                                    ini_open(string(global.platformDir) + string(myCharDir) + "Data.ini");
                                    respecCost = 0;
                                    
                                    for (var i = 1; i < 10; i += 1)
                                        respecCost += ini_read_real("Stats", "Base Stat " + string(i), 0);
                                    
                                    ini_close();
                                    respecCost *= 10;
                                    respecCost = 0;
                                    
                                    if (sub == 1 || myTier >= 2)
                                        respecCost = 0;
                                    
                                    if (mygold >= respecCost)
                                    {
                                        if (state == UnknownEnum.Value_8)
                                        {
                                            if (arg2 == 0)
                                                gml_Script_twitch_chat_say("/me " + string(name) + " You must be in town to reset your talents.");
                                            
                                            exit;
                                        }
                                        
                                        ini_open(string(global.platformDir) + string(myCharDir) + "Data.ini");
                                        
                                        for (var i = 0; i < 10; i += 1)
                                        {
                                            ini_key_delete("Stats", "Base Stat " + string(i));
                                            baseStat[i][0] = 0;
                                        }
                                        
                                        gml_Script_scr_playsound(s_respec, 0.9, 1.1, 1);
                                        mygold -= respecCost;
                                        ini_write_real("Stats", "Total Skill Points", totalSkillPoints);
                                        skillPoints = ini_read_real("Stats", "Total Skill Points", level - 1);
                                        ini_write_real("Stats", "Skill Points", skillPoints);
                                        gml_Script_scr_updateStats();
                                        ini_close();
                                        
                                        if (arg2 == 0)
                                            gml_Script_twitch_chat_say("/me " + string(name) + " forgot their learnings successfully! (" + gml_Script_scr_bigNumber(skillPoints) + " room00Talent available, costed " + gml_Script_scr_bigNumber(respecCost) + "g)");
                                    }
                                    else if (arg2 == 0)
                                    {
                                        gml_Script_twitch_chat_say("/me " + string(name) + " you need " + string(respecCost - mygold) + " more gold to fully respec...");
                                    }
                                }
                            }
                        }
                        else if (arg2 == 0)
                        {
                            gml_Script_twitch_chat_say("/me " + string(uname) + " You must build the academy first!");
                        }
                    }
                    else if (arg2 == 0)
                    {
                        gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
                    }
                    
                    exit;
                }
                
                if (string_pos("!spec", _cmd) == 1 || string_pos("room00special", _cmd) == 1)
                {
                    if (ds_list_find_index(global.playerList, uname) != -1)
                    {
                        if (instance_exists(obj_build_academy) && obj_build_academy.level >= 30)
                        {
                            var _index, _amount;
                            
                            if (string_pos("*", _cmd) == 0)
                            {
                                _index = string_digits(_cmd);
                                _amount = 999999999999;
                            }
                            else
                            {
                                var _length = real(string_pos("*", _cmd));
                                _index = string_digits(string_copy(_cmd, 1, _length));
                                
                                if (_index != "")
                                    _index = real(_index);
                                else
                                    exit;
                                
                                _amount = string_digits(string_delete(_cmd, 1, _length));
                                
                                if (_amount != "")
                                    _amount = real(_amount);
                                else
                                    _amount = 999999999999;
                            }
                            
                            show_debug_message("Talent: " + string(_index) + " - " + string(_amount) + "x");
                            var setLearn = _index;
                            var learnAmount = _amount;
                            
                            if (string_digits(setLearn) == "")
                                exit;
                            
                            if (setLearn > 0 && setLearn <= global.globalSpecialBranches)
                            {
                                with (obj_player)
                                {
                                    if (name == other.uname)
                                    {
                                        if (specialized > 0)
                                        {
                                            if (specialPoints[myAbilityInfo[0]] > 0)
                                            {
                                                if (state == UnknownEnum.Value_8)
                                                {
                                                    if (arg2 == 0)
                                                        gml_Script_twitch_chat_say("/me " + string(name) + " You must be in town to spend special points.");
                                                    
                                                    exit;
                                                }
                                                
                                                if ((class == "warrior" || class == "mage" || class == "archer" || name == "erohzify") && specialized != 0)
                                                {
                                                    var finalAmount;
                                                    
                                                    if (learnAmount >= specialPoints[myAbilityInfo[0]])
                                                    {
                                                        finalAmount = specialPoints[myAbilityInfo[0]];
                                                    }
                                                    else
                                                    {
                                                        finalAmount = learnAmount;
                                                        
                                                        if (learnAmount == 0)
                                                            finalAmount = 1;
                                                    }
                                                    
                                                    setLearn -= 1;
                                                    var _pointsSpent = 0;
                                                    var _pointsLeft = 0;
                                                    var capped;
                                                    
                                                    for (var tp = 0; tp < finalAmount; tp++)
                                                    {
                                                        if (mySpecialInfo[classType][specialized - 1][myAbilityInfo[0]][setLearn] < global.globalSpecialInfo[classType][specialized - 1][myAbilityInfo[0]][setLearn][3] || global.globalSpecialInfo[classType][specialized - 1][myAbilityInfo[0]][setLearn][3] == -1)
                                                        {
                                                            mySpecialInfo[classType][specialized - 1][myAbilityInfo[0]][setLearn] += 1;
                                                            specialPoints[myAbilityInfo[0]] -= 1;
                                                            _pointsSpent += 1;
                                                            capped = false;
                                                        }
                                                        else
                                                        {
                                                            _pointsLeft = finalAmount - _pointsSpent;
                                                            capped = true;
                                                            break;
                                                        }
                                                    }
                                                    
                                                    ini_open(string(global.platformDir) + string(myCharDir) + "Data.ini");
                                                    gml_Script_scr_player_updateSpecialPoints();
                                                    ini_close();
                                                    gml_Script_scr_playsound(choose(s_talent1, s_talent2, s_talent3, s_talent4, s_talent5), 0.9, 1.1, 1);
                                                    
                                                    if (capped == false)
                                                    {
                                                        if (global.chatSpam <= 2)
                                                        {
                                                            if (arg2 == 0)
                                                                gml_Script_twitch_chat_say("/me " + string(name) + " upgraded " + string(myAbilityInfo[1]) + "'s " + string(global.globalSpecialInfo[classType][specialized - 1][myAbilityInfo[0]][setLearn][1]) + " by " + gml_Script_scr_bigNumber(global.globalSpecialInfo[classType][specialized - 1][myAbilityInfo[0]][setLearn][2] * finalAmount) + " (" + gml_Script_scr_bigNumber(_pointsSpent) + " special points used, total spent on Branch " + string(setLearn + 1) + ": " + gml_Script_scr_bigNumber(mySpecialInfo[classType][specialized - 1][myAbilityInfo[0]][setLearn]) + " | " + gml_Script_scr_bigNumber(specialPoints[myAbilityInfo[0]]) + " special points left).");
                                                        }
                                                    }
                                                    else if (global.chatSpam <= 2)
                                                    {
                                                        if (arg2 == 0)
                                                            gml_Script_twitch_chat_say("/me " + string(name) + " upgraded " + string(myAbilityInfo[1]) + "'s " + string(global.globalSpecialInfo[classType][specialized - 1][myAbilityInfo[0]][setLearn][1]) + " by " + gml_Script_scr_bigNumber(global.globalSpecialInfo[classType][specialized - 1][myAbilityInfo[0]][setLearn][2] * finalAmount) + " and maxed this branch! (" + gml_Script_scr_bigNumber(_pointsSpent) + " special points used, total spent on Branch " + string(setLearn + 1) + ": " + gml_Script_scr_bigNumber(mySpecialInfo[classType][specialized - 1][myAbilityInfo[0]][setLearn]) + " | " + gml_Script_scr_bigNumber(specialPoints[myAbilityInfo[0]]) + " special points left).");
                                                    }
                                                }
                                                else if (global.chatSpam <= 2)
                                                {
                                                    if (arg2 == 0)
                                                        gml_Script_twitch_chat_say("/me " + string(name) + " This class can not spend special points.");
                                                }
                                            }
                                            else if (global.chatSpam <= 2)
                                            {
                                                if (arg2 == 0)
                                                    gml_Script_twitch_chat_say("/me " + string(name) + " You don't have any special points available.");
                                            }
                                        }
                                        else if (global.chatSpam <= 2)
                                        {
                                            if (arg2 == 0)
                                                gml_Script_twitch_chat_say("/me " + string(name) + " You must " + string(global.cmdPrefix) + "specialize in order to obtain and use special points.");
                                        }
                                    }
                                }
                            }
                            else if (global.chatSpam <= 2)
                            {
                                if (arg2 == 0)
                                    gml_Script_twitch_chat_say("/me " + string(uname) + " That special upgrade does not exist or the command format is incorrect (" + string(global.cmdPrefix) + "spec #*#).");
                            }
                        }
                        else if (arg2 == 0)
                        {
                            gml_Script_twitch_chat_say("/me " + string(uname) + " You must have a level 30+ academy in order to spend special points!");
                        }
                    }
                    else if (arg2 == 0)
                    {
                        gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
                    }
                    
                    exit;
                }
                
                if (string_pos("!unspec", _cmd) == 1)
                {
                    if (ds_list_find_index(global.playerList, uname) != -1)
                    {
                        if (instance_exists(obj_build_academy))
                        {
                            var _index, _amount;
                            
                            if (string_pos("*", _cmd) == 0)
                            {
                                _index = string_digits(_cmd);
                                _amount = 999999999999;
                            }
                            else
                            {
                                var _length = real(string_pos("*", _cmd));
                                _index = string_digits(string_copy(_cmd, 1, _length));
                                
                                if (_index != "")
                                    _index = real(_index);
                                else
                                    exit;
                                
                                _amount = string_digits(string_delete(_cmd, 1, _length));
                                
                                if (_amount != "")
                                    _amount = real(_amount);
                                else
                                    _amount = 999999999999;
                            }
                            
                            show_debug_message("Unspec: " + string(_index) + " - " + string(_amount) + "x");
                            var setLearn = _index;
                            var learnAmount = _amount;
                            
                            if (string_digits(setLearn) == "")
                                exit;
                            
                            if (setLearn > 0 && setLearn <= global.globalSpecialBranches)
                            {
                                with (obj_player)
                                {
                                    if (name == other.uname)
                                    {
                                        if (specialized > 0)
                                        {
                                            setLearn -= 1;
                                            
                                            if (mySpecialInfo[classType][specialized - 1][myAbilityInfo[0]][setLearn] > 0)
                                            {
                                                if (state == UnknownEnum.Value_8)
                                                {
                                                    if (arg2 == 0)
                                                        gml_Script_twitch_chat_say("/me " + string(name) + " You must be in town to remove special points.");
                                                    
                                                    exit;
                                                }
                                                
                                                var finalAmount;
                                                
                                                if (learnAmount >= mySpecialInfo[classType][specialized - 1][myAbilityInfo[0]][setLearn])
                                                {
                                                    finalAmount = mySpecialInfo[classType][specialized - 1][myAbilityInfo[0]][setLearn];
                                                }
                                                else
                                                {
                                                    finalAmount = learnAmount;
                                                    
                                                    if (learnAmount == 0)
                                                        finalAmount = 1;
                                                }
                                                
                                                unspecCost = 0;
                                                
                                                if (sub == 1 || myTier >= 2)
                                                    respecCost = 0;
                                                
                                                if (unspecCost <= myGems)
                                                {
                                                    mySpecialInfo[classType][specialized - 1][myAbilityInfo[0]][setLearn] -= finalAmount;
                                                    specialPoints[myAbilityInfo[0]] += finalAmount;
                                                    myGems -= unspecCost;
                                                    gml_Script_scr_playsound(choose(s_talent1, s_talent2, s_talent3, s_talent4, s_talent5), 0.9, 1.1, 1);
                                                    ini_open(string(global.platformDir) + string(myCharDir) + "Data.ini");
                                                    ini_write_real("Build", "Spec " + string(specialized - 1) + " Ability " + string(myAbilityInfo[0]) + " Points " + string(setLearn), mySpecialInfo[classType][specialized - 1][myAbilityInfo[0]][setLearn]);
                                                    ini_write_real("Specialization", "Special Points Spec " + string(specialized - 1) + " Ability " + string(myAbilityInfo[0]), specialPoints[myAbilityInfo[0]]);
                                                    gml_Script_scr_player_updateSpecialPoints();
                                                    ini_close();
                                                    
                                                    if (global.chatSpam <= 2)
                                                    {
                                                        if (arg2 == 0)
                                                            gml_Script_twitch_chat_say("/me " + string(name) + " removed " + gml_Script_scr_bigNumber(finalAmount) + " points from branch " + string(setLearn + 1) + " (" + string(global.globalSpecialInfo[classType][specialized - 1][myAbilityInfo[0]][setLearn][1]) + ") and got " + gml_Script_scr_bigNumber(finalAmount) + " special points back! (" + gml_Script_scr_bigNumber(specialPoints[myAbilityInfo[0]]) + " special points left, costed " + gml_Script_scr_bigNumber(unspecCost) + " gems)");
                                                    }
                                                }
                                                else if (global.chatSpam <= 2)
                                                {
                                                    if (arg2 == 0)
                                                        gml_Script_twitch_chat_say("/me " + string(name) + " You need " + string(unspecCost - myGems) + " more gems to do that...");
                                                }
                                            }
                                            else if (global.chatSpam <= 2)
                                            {
                                                if (arg2 == 0)
                                                    gml_Script_twitch_chat_say("/me " + string(name) + " You don't have any special points spent on branch " + string(setLearn + 1) + "...");
                                            }
                                        }
                                    }
                                }
                            }
                            else
                            {
                                gml_Script_twitch_chat_say("/me " + string(uname) + " Available special points branches: 1 to 5");
                            }
                        }
                        else if (arg2 == 0)
                        {
                            gml_Script_twitch_chat_say("/me " + string(uname) + " You must build the academy in order to remove talent points!");
                        }
                    }
                    else if (arg2 == 0)
                    {
                        gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
                    }
                    
                    exit;
                }
                
                if (string_pos("!fixspec", _cmd) == 1)
                {
                    if (ds_list_find_index(global.playerList, uname) != -1)
                    {
                        with (obj_player)
                        {
                            if (name == other.uname)
                            {
                                if (specialized > 0)
                                {
                                    ini_open(string(global.platformDir) + string(myCharDir) + "Data.ini");
                                    
                                    if (myAbilityInfo[4] > global.maxSpecAbilityLevel)
                                        myAbilityInfo[4] = global.maxSpecAbilityLevel;
                                    
                                    for (var i = 0; i < global.globalSpecialBranches; i += 1)
                                        mySpecialInfo[classType][specialized - 1][myAbilityInfo[0]][i] = 0;
                                    
                                    totalSpecialPoints[myAbilityInfo[0]] = myAbilityInfo[4];
                                    specialPoints[myAbilityInfo[0]] = myAbilityInfo[4];
                                    gml_Script_scr_player_updateSpecialPoints();
                                    ini_close();
                                }
                            }
                        }
                    }
                }
                
                if (string_pos("!fullunspec", _cmd) == 1)
                {
                    if (ds_list_find_index(global.playerList, uname) != -1)
                    {
                        if (instance_exists(obj_build_academy))
                        {
                            with (obj_player)
                            {
                                if (name == other.uname)
                                {
                                    if (specialized > 0)
                                    {
                                        ini_open(string(global.platformDir) + string(myCharDir) + "Data.ini");
                                        unspecCost = 0;
                                        
                                        for (var i = 1; i < 10; i += 1)
                                            unspecCost += ini_read_real("Stats", "Base Stat " + string(i), 0);
                                        
                                        ini_close();
                                        unspecCost *= 10;
                                        unspecCost = 0;
                                        
                                        if (sub == 1 || myTier >= 2)
                                            unspecCost = 0;
                                        
                                        if (myGems >= unspecCost)
                                        {
                                            if (state == UnknownEnum.Value_8)
                                            {
                                                if (arg2 == 0)
                                                    gml_Script_twitch_chat_say("/me " + string(name) + " You must be in town to reset your special points.");
                                                
                                                exit;
                                            }
                                            
                                            ini_open(string(global.platformDir) + string(myCharDir) + "Data.ini");
                                            
                                            for (var i = 0; i < global.globalSpecialBranches; i += 1)
                                            {
                                                ini_key_delete("Build", "Spec " + string(specialized - 1) + " Ability " + string(myAbilityInfo[0]) + " Points " + string(i));
                                                mySpecialInfo[classType][specialized - 1][myAbilityInfo[0]][i] = 0;
                                            }
                                            
                                            gml_Script_scr_playsound(s_respec, 0.9, 1.1, 1);
                                            myGems -= unspecCost;
                                            specialPoints[myAbilityInfo[0]] = ini_read_real("Specialization", "Total Special Points Spec " + string(specialized - 1) + " Ability " + string(myAbilityInfo[0]), 0);
                                            ini_write_real("Specialization", "Special Points Spec " + string(specialized - 1) + " Ability " + string(myAbilityInfo[0]), specialPoints[myAbilityInfo[0]]);
                                            gml_Script_scr_player_updateSpecialPoints();
                                            ini_close();
                                            
                                            if (arg2 == 0)
                                                gml_Script_twitch_chat_say("/me " + string(name) + " forgot their special learnings successfully! (" + gml_Script_scr_bigNumber(specialPoints[myAbilityInfo[0]]) + " special points available, costed " + gml_Script_scr_bigNumber(unspecCost) + " gems)");
                                        }
                                        else if (arg2 == 0)
                                        {
                                            gml_Script_twitch_chat_say("/me " + string(name) + " you need " + string(unspecCost - myGems) + " more gems to fully unspec...");
                                        }
                                    }
                                }
                            }
                        }
                        else if (arg2 == 0)
                        {
                            gml_Script_twitch_chat_say("/me " + string(uname) + " You must build the academy first!");
                        }
                    }
                    else if (arg2 == 0)
                    {
                        gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
                    }
                    
                    exit;
                }
                
                if (string_pos("!setskill", _cmd) == 1 || string_pos("setskill", _cmd) == 1)
                {
                    if (ds_list_find_index(global.playerList, uname) != -1)
                    {
                        var setSkill = string_digits(_cmd);
                        
                        if (setSkill == "")
                            setSkill = 0;
                        else
                            setSkill = real(setSkill);
                        
                        if (setSkill > 0 && setSkill < 4)
                        {
                            with (obj_player)
                            {
                                if (name == other.uname)
                                {
                                    if (state == UnknownEnum.Value_8)
                                    {
                                        if (arg2 == 0)
                                            gml_Script_twitch_chat_say("/me " + string(name) + " You must be in town to change your ability.");
                                        
                                        exit;
                                    }
                                    
                                    gml_Script_scr_player_setAbility(setSkill);
                                }
                            }
                        }
                        else
                        {
                            gml_Script_twitch_chat_say("/me " + string(uname) + " Ability " + string(setSkill) + " does not exist. Available abilities: 3.");
                        }
                    }
                    else if (arg2 == 0)
                    {
                        gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
                    }
                    
                    exit;
                }
                
                if (string_pos("!setpetrelic", _cmd) == 1 || string_pos("setpetrelic", _cmd) == 1)
                {
                    if (ds_list_find_index(global.playerList, uname) != -1)
                    {
                        if (string_pos(":", _cmd) == 0)
                            exit;
                        
                        var _length = real(string_pos(":", _cmd));
                        var _index = string_digits(string_copy(_cmd, 1, _length));
                        
                        if (_index != "")
                            _index = real(_index);
                        else
                            exit;
                        
                        var _amount = string_digits(string_delete(_cmd, 1, _length));
                        
                        if (_amount != "")
                            _amount = real(_amount);
                        else
                            exit;
                        
                        show_debug_message("Relic: slot " + string(_index) + " - id " + string(_amount));
                        var setRelicSlot = _index;
                        var setRelic = _amount;
                        
                        with (obj_player)
                        {
                            if (name == other.uname)
                            {
                                if (myPetID > 0 && myPetInfo[myPetID][4] >= 10)
                                {
                                    if (setRelicSlot > 0 && setRelicSlot <= floor(myPetInfo[myPetID][4] / 10))
                                    {
                                        if (setRelic <= global.maxUniqueItems && setRelic != 0)
                                        {
                                            if (equippedUniqueItem[setRelic] == 0 && myPetEquippedRelic[myPetID][setRelic] == 0)
                                            {
                                                if (gotUniqueItem[setRelic] > 0)
                                                {
                                                    if (string_lower(global.uniqueItem[setRelic][3]) == class || global.uniqueItem[setRelic][3] == "All Classes")
                                                    {
                                                        if (state == UnknownEnum.Value_8)
                                                        {
                                                            if (arg2 == 0)
                                                                gml_Script_twitch_chat_say("/me " + string(name) + " You must be in town to change your Relic.");
                                                            
                                                            exit;
                                                        }
                                                        
                                                        var _oldRelic = petRelicSlot[myPetID][setRelicSlot];
                                                        ini_open(string(global.platformDir) + string(myCharDir) + "Data.ini");
                                                        myPetEquippedRelic[myPetID][_oldRelic] = 0;
                                                        petRelicSlot[myPetID][setRelicSlot] = setRelic;
                                                        myPetEquippedRelic[myPetID][setRelic] = 1;
                                                        ini_key_delete("Pets", "My Pet " + string(myPetID) + " Equipped Relic " + string(_oldRelic));
                                                        ini_write_real("Pets", "My Pet " + string(myPetID) + " Relic Slot " + string(setRelicSlot), setRelic);
                                                        ini_write_real("Pets", "My Pet " + string(myPetID) + " Equipped Relic " + string(setRelic), 1);
                                                        uniqueItemLevel[setRelic] = ini_read_real("Relics", "Unique Item " + string(setRelic) + " Level", 1);
                                                        ini_close();
                                                        
                                                        if (arg2 == 0)
                                                            gml_Script_twitch_chat_say("/me " + string(name) + " Relic " + string(setRelic) + " (" + string(global.uniqueItem[setRelic][0]) + " - lv." + string(uniqueItemLevel[setRelic]) + ") equipped successfully on " + myPetInfo[myPetID][1] + "'s Relic Slot " + string(setRelicSlot) + " (" + string(round(myPetRelicSlotEffect[myPetID][setRelicSlot] * 100)) + "% effect).");
                                                    }
                                                    else if (arg2 == 0)
                                                    {
                                                        gml_Script_twitch_chat_say("/me " + string(name) + " Relic " + string(setRelic) + " is exclusive for " + string(global.uniqueItem[setRelic][3]) + "s only.");
                                                    }
                                                }
                                                else if (arg2 == 0)
                                                {
                                                    gml_Script_twitch_chat_say("/me " + string(name) + " You don't own Relic " + string(setRelic) + ".");
                                                }
                                            }
                                            else
                                            {
                                                if (petRelicSlot[myPetID][setRelicSlot] == setRelic)
                                                {
                                                    if (arg2 == 0)
                                                        gml_Script_twitch_chat_say("/me " + string(name) + " You are already using Relic " + string(setRelic) + " on slot " + string(setRelicSlot) + ".");
                                                }
                                                
                                                if (petRelicSlot[myPetID][setRelicSlot] != setRelic)
                                                {
                                                    var _swapRelic = petRelicSlot[myPetID][setRelicSlot];
                                                    var _swapRelicTo = setRelicSlot;
                                                    var _swapRelicFrom = 0;
                                                    var _fromPlayer = 0;
                                                    var _wearer = "";
                                                    
                                                    for (var s = 1; s <= 5; s++)
                                                    {
                                                        if (uniqueSlot[s] == setRelic)
                                                        {
                                                            _swapRelicFrom = s;
                                                            _fromPlayer = 1;
                                                            _wearer = "personal ";
                                                            break;
                                                        }
                                                        
                                                        if (petRelicSlot[myPetID][s] == setRelic)
                                                        {
                                                            _swapRelicFrom = s;
                                                            _fromPlayer = 0;
                                                            _wearer = "pet ";
                                                            break;
                                                        }
                                                    }
                                                    
                                                    petRelicSlot[myPetID][setRelicSlot] = setRelic;
                                                    myPetEquippedRelic[myPetID][setRelic] = 1;
                                                    myPetEquippedRelic[myPetID][_swapRelic] = 0;
                                                    
                                                    if (_fromPlayer == 1)
                                                    {
                                                        uniqueSlot[_swapRelicFrom] = _swapRelic;
                                                        equippedUniqueItem[_swapRelic] = 1;
                                                        equippedUniqueItem[setRelic] = 0;
                                                    }
                                                    else
                                                    {
                                                        petRelicSlot[myPetID][_swapRelicFrom] = _swapRelic;
                                                        myPetEquippedRelic[myPetID][_swapRelic] = 1;
                                                    }
                                                    
                                                    if (_swapRelic != 0)
                                                    {
                                                        if (arg2 == 0)
                                                            gml_Script_twitch_chat_say("/me " + string(name) + " Relic " + string(setRelic) + " (" + string(global.uniqueItem[setRelic][0]) + ") swapped succesfully with Relic " + string(_swapRelic) + " (" + string(global.uniqueItem[_swapRelic][0]) + ") from " + string(_wearer) + "slot " + string(_swapRelicFrom) + " to pet slot " + string(setRelicSlot) + " (" + string(round(myPetRelicSlotEffect[myPetID][setRelicSlot] * 100)) + "% effect).");
                                                    }
                                                    else if (arg2 == 0)
                                                    {
                                                        gml_Script_twitch_chat_say("/me " + string(name) + " Relic " + string(setRelic) + " (" + string(global.uniqueItem[setRelic][0]) + ") moved successfully from " + string(_wearer) + "slot " + string(_swapRelicFrom) + " to pet slot " + string(setRelicSlot) + " (" + string(round(myPetRelicSlotEffect[myPetID][setRelicSlot] * 100)) + "% effect).");
                                                    }
                                                }
                                            }
                                        }
                                        else if (setRelic == 0)
                                        {
                                            var _oldRelic = petRelicSlot[myPetID][setRelicSlot];
                                            ini_open(string(global.platformDir) + string(myCharDir) + "Data.ini");
                                            ini_key_delete("Pets", "My Pet " + string(myPetID) + " Equipped Relic " + string(_oldRelic));
                                            myPetEquippedRelic[myPetID][petRelicSlot[myPetID][setRelicSlot]] = 0;
                                            petRelicSlot[myPetID][setRelicSlot] = setRelic;
                                            myPetEquippedRelic[myPetID][setRelic] = 0;
                                            ini_write_real("Pets", "My Pet " + string(myPetID) + " Relic Slot " + string(setRelicSlot), setRelic);
                                            ini_close();
                                            
                                            if (_oldRelic > 0)
                                            {
                                                if (arg2 == 0)
                                                    gml_Script_twitch_chat_say("/me " + string(name) + " you unequipped Relic " + string(_oldRelic) + " (" + string(global.uniqueItem[_oldRelic][0]) + ") from your " + string(myPetInfo[myPetID][1]) + "'s Relic slot " + string(setRelicSlot) + ".");
                                            }
                                            else if (arg2 == 0)
                                            {
                                                gml_Script_twitch_chat_say("/me " + string(name) + " there is no Relic equipped on your " + string(myPetInfo[myPetID][1]) + "'s Relic slot " + string(setRelicSlot) + ".");
                                            }
                                        }
                                        else if (arg2 == 0)
                                        {
                                            gml_Script_twitch_chat_say("/me " + string(name) + " Relic " + string(setRelic) + " does not exist.");
                                        }
                                    }
                                    else if (arg2 == 0)
                                    {
                                        gml_Script_twitch_chat_say("/me " + string(name) + " your " + string(myPetInfo[myPetID][1]) + " pet does not have this Relic slot unlocked.");
                                    }
                                }
                                else if (arg2 == 0)
                                {
                                    gml_Script_twitch_chat_say("/me " + string(name) + " you must own a level 10+ pet to make them use your Relics.");
                                }
                            }
                        }
                    }
                    else if (arg2 == 0)
                    {
                        gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
                    }
                    
                    exit;
                }
                
                if (string_pos("!setpet", _cmd) == 1 || string_pos("setpet", _cmd) == 1)
                {
                    if (ds_list_find_index(global.playerList, uname) != -1)
                    {
                        var setPet = string_digits(_cmd);
                        
                        if (setPet == "")
                            setPet = 0;
                        else
                            setPet = real(setPet);
                        
                        if (setPet > 0 && setPet <= global.maxPets)
                        {
                            with (obj_player)
                            {
                                if (name == other.uname)
                                {
                                    if (state == UnknownEnum.Value_8)
                                    {
                                        if (arg2 == 0)
                                            gml_Script_twitch_chat_say("/me " + string(name) + " You must be in town to change your pet.");
                                        
                                        exit;
                                    }
                                    
                                    if (gotPet[setPet] != 0)
                                    {
                                        if (myPetID != setPet)
                                        {
                                            if (petTraining != setPet)
                                            {
                                                ini_open(string(global.platformDir) + string(myCharDir) + "Data.ini");
                                                ini_write_real("Pets", "My Pet " + string(myPetID) + " Level", myPetInfo[myPetID][4]);
                                                ini_write_real("Pets", "My Pet " + string(myPetID) + " XP", myPetInfo[myPetID][5]);
                                                myPetID = setPet;
                                                myPetInfo[myPetID][1] = global.globalPetInfo[myPetID][1];
                                                myPetInfo[myPetID][2] = global.globalPetInfo[myPetID][2];
                                                myPetInfo[myPetID][3] = global.globalPetInfo[myPetID][3];
                                                myPetInfo[myPetID][4] = ini_read_real("Pets", "My Pet " + string(myPetID) + " Level", 1);
                                                myPetInfo[myPetID][5] = ini_read_real("Pets", "My Pet " + string(myPetID) + " XP", 0);
                                                myPetInfo[myPetID][6] = myPetInfo[myPetID][4] * 1000 * myPetInfo[myPetID][4];
                                                ini_write_real("Pets", "My Pet ID", myPetID);
                                                show_debug_message("Pet: " + string(myPetID));
                                                
                                                for (var pr = 0; pr <= global.maxUniqueItems; pr++)
                                                {
                                                    myPetEquippedRelic[myPetID][pr] = ini_read_real("Pets", "My Pet " + string(myPetID) + " Equipped Relic " + string(pr), 0);
                                                    
                                                    if (equippedUniqueItem[pr] == 1 && myPetEquippedRelic[myPetID][pr] == 1)
                                                        equippedUniqueItem[pr] = 0;
                                                }
                                                
                                                for (var re = 1; re <= 5; re++)
                                                {
                                                    petRelicSlot[myPetID][re] = ini_read_real("Pets", "My Pet " + string(myPetID) + " Relic Slot " + string(re), 0);
                                                    
                                                    if (gotUniqueItem[petRelicSlot[myPetID][re]] > 0)
                                                        myPetEquippedRelic[myPetID][petRelicSlot[myPetID][re]] = 1;
                                                    else
                                                        myPetEquippedRelic[myPetID][petRelicSlot[myPetID][re]] = 0;
                                                    
                                                    myPetRelicSlotEffect[myPetID][re] = (0.1 + (0.05 * myPetInfo[myPetID][4])) - (re * 0.5);
                                                    
                                                    if (myPetRelicSlotEffect[myPetID][re] < 0)
                                                        myPetRelicSlotEffect[myPetID][re] = 0;
                                                    
                                                    show_debug_message("Relic Slot " + string(re) + " = Relic " + string(petRelicSlot[myPetID][re]) + " (" + string(myPetRelicSlotEffect[myPetID][re]) + " effect)");
                                                    
                                                    for (var cr = 1; cr <= 5; cr += 1)
                                                    {
                                                        if (uniqueSlot[re] == petRelicSlot[myPetID][cr])
                                                            uniqueSlot[re] = 0;
                                                    }
                                                    
                                                    if (uniqueSlot[re] == 0)
                                                        equippedUniqueItem[uniqueSlot[re]] = 0;
                                                }
                                                
                                                if (myPlayerPet != 0)
                                                {
                                                    with (myPlayerPet)
                                                        instance_destroy();
                                                }
                                                
                                                myPlayerPet = instance_create_depth(x, y, depth - 1, obj_petPlayer);
                                                
                                                with (myPlayerPet)
                                                {
                                                    player = other.id;
                                                    type = other.myPetID;
                                                }
                                                
                                                ini_close();
                                                
                                                if (arg2 == 0)
                                                    gml_Script_twitch_chat_say("/me " + string(name) + " Pet #" + string(myPetID) + " (" + string(myPetInfo[myPetID][1]) + " - lv." + string(myPetInfo[myPetID][4]) + ") is now your companion.");
                                            }
                                            else if (arg2 == 0)
                                            {
                                                gml_Script_twitch_chat_say("/me " + string(name) + " This pet is currently training, type " + string(global.cmdPrefix) + "stoptrainpet to retrieve it.");
                                            }
                                        }
                                        else if (arg2 == 0)
                                        {
                                            gml_Script_twitch_chat_say("/me " + string(name) + " This pet is already on use.");
                                        }
                                    }
                                    else if (arg2 == 0)
                                    {
                                        gml_Script_twitch_chat_say("/me " + string(name) + " You don't own Pet #" + string(setPet) + " (" + string(global.globalPetInfo[setPet][1]) + ").");
                                    }
                                }
                            }
                        }
                        else if (setPet == 0)
                        {
                            with (obj_player)
                            {
                                if (name == other.uname)
                                {
                                    ini_open(string(global.platformDir) + string(myCharDir) + "Data.ini");
                                    ini_write_real("Pets", "My Pet " + string(myPetID) + " Level", myPetInfo[myPetID][4]);
                                    ini_write_real("Pets", "My Pet " + string(myPetID) + " XP", myPetInfo[myPetID][5]);
                                    ini_write_real("Pets", "My Pet ID", 0);
                                    ini_close();
                                    myPetID = 0;
                                    show_debug_message("Player Pet ID: " + string(myPetID));
                                    
                                    if (myPlayerPet != 0)
                                    {
                                        with (myPlayerPet)
                                            instance_destroy();
                                        
                                        myPlayerPet = 0;
                                    }
                                    
                                    if (arg2 == 0)
                                        gml_Script_twitch_chat_say("/me " + string(name) + " you are no longer using a pet.");
                                }
                            }
                            
                            exit;
                        }
                        else if (arg2 == 0)
                        {
                            gml_Script_twitch_chat_say("/me " + string(uname) + " Pet #" + string(setPet) + " does not exist. Available pets: 4.");
                        }
                    }
                    else if (arg2 == 0)
                    {
                        gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
                    }
                    
                    exit;
                }
                
                if (string_pos("!forge", _cmd) == 1 && instance_exists(obj_build_forge))
                {
                    if (ds_list_find_index(global.playerList, uname) != -1)
                    {
                        var chooseAmount = 1;
                        var buyItem;
                        
                        if (string_pos("*", _cmd) != 0)
                        {
                            var _length = real(string_pos("*", _cmd));
                            var _index = string_digits(string_copy(_cmd, 1, _length));
                            
                            if (_index != "")
                                _index = real(_index);
                            else
                                exit;
                            
                            var _amount = string_digits(string_delete(_cmd, 1, _length));
                            
                            if (_amount != "")
                                _amount = real(_amount);
                            else
                                exit;
                            
                            show_debug_message("Buy: slot " + string(_index) + " - " + string(_amount) + "x");
                            buyItem = _index;
                            chooseAmount = _amount;
                            
                            if (string_digits(buyItem) == "")
                                buyItem = 0;
                            else
                                buyItem = real(string_digits(buyItem));
                            
                            if (string_digits(chooseAmount) == "")
                                chooseAmount = 1;
                            else
                                chooseAmount = real(string_digits(chooseAmount));
                        }
                        else if (string_digits(_cmd) == "")
                        {
                            buyItem = 0;
                            chooseAmount = 1;
                        }
                        else
                        {
                            buyItem = real(string_digits(_cmd));
                            chooseAmount = 1;
                        }
                        
                        var setForge = 99;
                        buyItem -= 1;
                        
                        if (buyItem == 0)
                            setForge = 3;
                        
                        if (buyItem == 1)
                            setForge = 8;
                        
                        if (buyItem == 2)
                            setForge = 6;
                        
                        if (buyItem == 3)
                            setForge = 7;
                        
                        if (buyItem == 4)
                            setForge = 0;
                        
                        if (buyItem == 5)
                            setForge = 5;
                        
                        if (buyItem == 6)
                            setForge = 4;
                        
                        if (buyItem == 7)
                            setForge = 1;
                        
                        if (buyItem == 8)
                            setForge = 2;
                        
                        if (buyItem == 9)
                            setForge = 9;
                        
                        setForge += 1;
                        show_debug_message("Forge: slot " + string(setForge) + " - " + string(chooseAmount) + "x");
                        
                        with (obj_player)
                        {
                            if (name == other.uname)
                            {
                                if (state != UnknownEnum.Value_8)
                                {
                                    if (myForgeID != global.globalForgeID)
                                    {
                                        myForgeID = global.globalForgeID;
                                        forgedItem = clamp(round(obj_build_forge.level / 3), 1, 6);
                                    }
                                    
                                    if (forgedItem > 0)
                                    {
                                        if (chooseAmount > forgedItem)
                                            chooseAmount = forgedItem;
                                        
                                        setForge -= 1;
                                        
                                        if (setForge >= 0 && setForge <= 9)
                                        {
                                            if (obj_build_forge.forgingLevel >= 13 && myItemInfo[setForge][0] > obj_build_forge.forgingLevel)
                                            {
                                                if (arg2 == 0)
                                                    gml_Script_twitch_chat_say("/me " + string(name) + " You can not forge this item anymore, it has reached its maximum potential.");
                                                
                                                exit;
                                            }
                                            
                                            if (obj_build_forge.forgeItem[0][0] >= obj_build_forge.forgeItem[0][1])
                                            {
                                                if (myItemInfo[setForge][0] == 0)
                                                    gml_Script_twitch_chat_say("/me " + string(name) + " You don't have any piece of equipment on this slot. You can get items from the Town Shop or by participating in raids.");
                                                
                                                if (myItemInfo[setForge][0] > 0 && myItemInfo[setForge][0] <= obj_build_forge.forgingLevel)
                                                {
                                                    var forgeCost = obj_build_forge.forgeItem[0][2] * costReduction;
                                                    
                                                    if (myItemInfo[setForge][0] < obj_build_forge.forgingLevel)
                                                    {
                                                        forgeCost = 100 + round((power(myItemInfo[setForge][0], 6) + (myItemInfo[setForge][0] * 30)) * power(1 + myItemInfo[setForge][0], 2));
                                                        forgeCost /= 2;
                                                    }
                                                    
                                                    if (mygold < forgeCost)
                                                    {
                                                        if (arg2 == 0)
                                                            gml_Script_twitch_chat_say("/me " + string(name) + " You need " + gml_Script_scr_bigNumber(round(forgeCost - mygold)) + " more gold to upgrade your " + string(myItemInfo[setForge][4]) + ".");
                                                        
                                                        exit;
                                                    }
                                                    
                                                    var totalCost = 0;
                                                    var _amount;
                                                    
                                                    for (_amount = 0; _amount < chooseAmount; _amount++)
                                                    {
                                                        forgeCost = obj_build_forge.forgeItem[0][2] * costReduction;
                                                        
                                                        if (myItemInfo[setForge][0] < obj_build_forge.forgingLevel)
                                                        {
                                                            forgeCost = 100 + round((power(myItemInfo[setForge][0], 6) + (myItemInfo[setForge][0] * 30)) * power(1 + myItemInfo[setForge][0], 2));
                                                            forgeCost /= 2;
                                                        }
                                                        
                                                        if (myItemInfo[setForge][0] <= obj_build_forge.forgingLevel)
                                                        {
                                                            if (mygold >= forgeCost)
                                                            {
                                                                ini_open(string(global.platformDir) + string(myAccDir) + "Character Data.ini");
                                                                myForgeID = global.globalForgeID;
                                                                forgedItem -= 1;
                                                                ini_write_real("Forge", "Forged Item", forgedItem);
                                                                ini_write_real("Forge", "My Forge ID", myForgeID);
                                                                ini_write_real("Forge", "My Reforge ID", myReforgeID);
                                                                ini_write_real("Forge", "Forged Relic", forgedRelic);
                                                                ini_close();
                                                                ini_open(string(global.platformDir) + "Village Data/Data.ini");
                                                                
                                                                with (obj_build_forge)
                                                                {
                                                                    ini_write_real("Forge", "Forge Item Progress", forgeItem[0][0]);
                                                                    ini_write_real("Forge", "Forge Item Duration", alarm[0]);
                                                                    ini_write_real("Forge", "Forge Relic Progress", forgeItem[1][0]);
                                                                    ini_write_real("Forge", "Forge Relic Duration", alarm[1]);
                                                                    ini_write_real("Buildings", "Forge ID", global.globalForgeID);
                                                                    ini_write_real("Buildings", "Reforge ID", global.globalReforgeID);
                                                                }
                                                                
                                                                ini_close();
                                                                mygold -= forgeCost;
                                                                gml_Script_scr_townXP(round(forgeCost / costReduction));
                                                                totalCost += forgeCost;
                                                                myItemInfo[setForge][1] += 1;
                                                                
                                                                if (myItemInfo[setForge][1] > 3)
                                                                {
                                                                    myItemInfo[setForge][1] = 1;
                                                                    myItemInfo[setForge][0] += 1;
                                                                }
                                                                
                                                                gml_Script_scr_updatePlayerItems();
                                                            }
                                                            else
                                                            {
                                                                break;
                                                            }
                                                        }
                                                        else
                                                        {
                                                            break;
                                                        }
                                                    }
                                                    
                                                    if (global.chatSpam <= 2)
                                                    {
                                                        if (arg2 == 0)
                                                            gml_Script_twitch_chat_say("/me " + string(name) + " Upgraded their " + string(myItemInfo[setForge][4]) + " (x" + string(_amount) + ") in the forge to tier " + string(myItemInfo[setForge][0]) + " [" + string(myItemInfo[setForge][2]) + "] for " + gml_Script_scr_bigNumber(totalCost) + "g! (" + string(forgedItem) + " forge uses and " + gml_Script_scr_bigNumber(mygold) + " gold left).");
                                                    }
                                                    
                                                    with (gml_Script_instance_create(x, y, obj_playSound))
                                                    {
                                                        maxTimes = _amount;
                                                        sound = s_upgradeItem;
                                                    }
                                                }
                                                else if (arg2 == 0)
                                                {
                                                    gml_Script_twitch_chat_say("/me " + string(name) + " The blacksmith can not forge this tier yet! Upgrade the forge to unlock higher forging materials.");
                                                }
                                            }
                                            else if (arg2 == 0)
                                            {
                                                gml_Script_twitch_chat_say("/me " + string(name) + " The blacksmith needs more materials. Raid to recycle unused items and obtain forging materials.");
                                            }
                                        }
                                        else if (arg2 == 0)
                                        {
                                            gml_Script_twitch_chat_say("/me " + string(name) + " That " + string(global.cmdPrefix) + "!item does not exist or the command format is incorrect (" + string(global.cmdPrefix) + "forge #*#).");
                                        }
                                    }
                                    else if (arg2 == 0)
                                    {
                                        gml_Script_twitch_chat_say("/me " + string(name) + " Each player can only " + string(global.cmdPrefix) + "!forge " + string(clamp(round(obj_build_forge.level / 3), 1, 6)) + " items, upgrade the forge to increase that amount!");
                                    }
                                }
                                else if (arg2 == 0)
                                {
                                    gml_Script_twitch_chat_say("/me " + string(name) + " You must be in town to use the forge.");
                                }
                            }
                        }
                    }
                    else if (arg2 == 0)
                    {
                        gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
                    }
                    
                    exit;
                }
                
                if (string_pos("!reforge", _cmd) == 1 && instance_exists(obj_build_forge))
                {
                    if (ds_list_find_index(global.playerList, uname) != -1)
                    {
                        var chooseAmount = 1;
                        var buyItem;
                        
                        if (string_pos("*", _cmd) != 0)
                        {
                            var _length = real(string_pos("*", _cmd));
                            var _index = string_digits(string_copy(_cmd, 1, _length));
                            
                            if (_index != "")
                                _index = real(_index);
                            else
                                exit;
                            
                            var _amount = string_digits(string_delete(_cmd, 1, _length));
                            
                            if (_amount != "")
                                _amount = real(_amount);
                            else
                                exit;
                            
                            show_debug_message("Buy: slot " + string(_index) + " - " + string(_amount) + "x");
                            buyItem = _index;
                            chooseAmount = _amount;
                            
                            if (string_digits(buyItem) == "")
                                buyItem = 0;
                            else
                                buyItem = real(string_digits(buyItem));
                            
                            if (string_digits(chooseAmount) == "")
                                chooseAmount = 1;
                            else
                                chooseAmount = real(string_digits(chooseAmount));
                        }
                        else if (string_digits(_cmd) == "")
                        {
                            buyItem = 0;
                            chooseAmount = 1;
                        }
                        else
                        {
                            buyItem = real(string_digits(_cmd));
                            chooseAmount = 1;
                        }
                        
                        var setForge = buyItem;
                        
                        with (obj_player)
                        {
                            if (name == other.uname)
                            {
                                if (state != UnknownEnum.Value_8)
                                {
                                    if (setForge > 0 && setForge <= global.maxUniqueItems)
                                    {
                                        if (obj_build_forge.level >= 14)
                                        {
                                            if (myReforgeID != global.globalReforgeID)
                                            {
                                                myReforgeID = global.globalReforgeID;
                                                forgedRelic = (obj_build_forge.level - 13) * 2;
                                            }
                                            
                                            if (forgedRelic > 0)
                                            {
                                                if (chooseAmount > forgedRelic)
                                                    chooseAmount = forgedRelic;
                                                
                                                if (obj_build_forge.forgeItem[1][0] >= obj_build_forge.forgeItem[1][1])
                                                {
                                                    var forgeCost = obj_build_forge.forgeItem[1][2] * chooseAmount;
                                                    
                                                    if (myGems >= forgeCost)
                                                    {
                                                        myGems -= forgeCost;
                                                        gml_Script_scr_townXP(round(forgeCost * 1000000));
                                                        gotUniqueItem[setForge] += chooseAmount;
                                                        ini_open(string(global.platformDir) + string(myAccDir) + "Character Data.ini");
                                                        myReforgeID = global.globalReforgeID;
                                                        forgedRelic -= chooseAmount;
                                                        ini_write_real("Forge", "Forged Relic", forgedRelic);
                                                        ini_write_real("Forge", "My Forge ID", myForgeID);
                                                        ini_write_real("Forge", "My Reforge ID", myReforgeID);
                                                        ini_write_real("Forge", "Forged Item", forgedItem);
                                                        ini_close();
                                                        ini_open(string(global.platformDir) + string(myCharDir) + "Data.ini");
                                                        ini_write_real("Relics", "Got Unique Item " + string(setForge), gotUniqueItem[setForge]);
                                                        ini_close();
                                                        ini_open(string(global.platformDir) + "Village Data/Data.ini");
                                                        
                                                        with (obj_build_forge)
                                                        {
                                                            ini_write_real("Forge", "Forge Item Progress", forgeItem[0][0]);
                                                            ini_write_real("Forge", "Forge Item Duration", alarm[0]);
                                                            ini_write_real("Forge", "Forge Relic Progress", forgeItem[1][0]);
                                                            ini_write_real("Forge", "Forge Relic Duration", alarm[1]);
                                                            ini_write_real("Buildings", "Forge ID", global.globalForgeID);
                                                            ini_write_real("Buildings", "Reforge ID", global.globalReforgeID);
                                                        }
                                                        
                                                        ini_close();
                                                        
                                                        if (global.chatSpam <= 2)
                                                        {
                                                            if (arg2 == 0)
                                                                gml_Script_twitch_chat_say("/me " + string(name) + " Forged (x" + string(chooseAmount) + ") Relic " + string(setForge) + " for " + gml_Script_scr_bigNumber(forgeCost) + " room00Gem ! (" + string(forgedRelic) + " reforge uses and " + gml_Script_scr_bigNumber(myGems) + " room00Gem left).");
                                                        }
                                                        
                                                        with (gml_Script_instance_create(x, y, obj_playSound))
                                                        {
                                                            maxTimes = chooseAmount;
                                                            sound = s_upgradeItem;
                                                        }
                                                    }
                                                    else if (arg2 == 0)
                                                    {
                                                        gml_Script_twitch_chat_say("/me " + string(name) + " You need " + gml_Script_scr_bigNumber(round(obj_build_forge.forgeItem[1][2] - myGems)) + " more room00Gem to forge a Relic.");
                                                    }
                                                }
                                                else if (arg2 == 0)
                                                {
                                                    gml_Script_twitch_chat_say("/me " + string(name) + " The blacksmith needs more materials. Raid to recycle unused items and obtain forging materials.");
                                                }
                                            }
                                            else if (arg2 == 0)
                                            {
                                                gml_Script_twitch_chat_say("/me " + string(name) + " Each player can only " + string(global.cmdPrefix) + "!reforge " + string((obj_build_forge.level - 13) * 2) + " Relics, upgrade the forge to increase that amount!");
                                            }
                                        }
                                        else if (arg2 == 0)
                                        {
                                            gml_Script_twitch_chat_say("/me " + string(name) + " The blacksmith can not forge Relics yet! Upgrade the forge to level 14 to unlock forging Relics.");
                                        }
                                    }
                                    else if (arg2 == 0)
                                    {
                                        gml_Script_twitch_chat_say("/me " + string(name) + " The Relic you are trying to forge does not exist or the command format is incorrect (" + string(global.cmdPrefix) + "reforge #*#).");
                                    }
                                    
                                    gml_Script_scr_updatePlayerItems();
                                }
                                else if (arg2 == 0)
                                {
                                    gml_Script_twitch_chat_say("/me " + string(name) + " You must be in town to use the forge.");
                                }
                            }
                        }
                    }
                    else if (arg2 == 0)
                    {
                        gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
                    }
                    
                    exit;
                }
                
                if (string_pos("!renamebuild", _cmd) == 1 || string_pos("!rb", _cmd) == 1)
                {
                    if (ds_list_find_index(global.playerList, uname) != -1)
                    {
                        var setBuild = string_digits(_cmd);
                        
                        if (setBuild == "")
                            setBuild = 0;
                        else
                            setBuild = real(setBuild);
                        
                        var _buildName;
                        
                        if (string_pos("!renamebuild", _cmd) == 1)
                            _buildName = string_letters(string_copy(string_delete(_cmd, 1, 13), 1, 20));
                        
                        if (string_pos("!rb", _cmd) == 1)
                            _buildName = string_letters(string_copy(string_delete(_cmd, 1, 4), 1, 20));
                        
                        show_debug_message("Rename Build " + string(setBuild) + " to " + _buildName);
                        
                        with (obj_player)
                        {
                            if (name == other.uname)
                            {
                                if (setBuild > 0 && setBuild <= myBuildSlots)
                                {
                                    ini_open(string(global.platformDir) + string(myCharDir) + "Builds.ini");
                                    var _oldName = ini_read_string("Build " + string(setBuild), "Name", "!renamebuild" + string(setBuild));
                                    ini_write_string("Build " + string(setBuild), "Name", string(_buildName));
                                    ini_close();
                                    
                                    if (arg2 == 0)
                                        gml_Script_twitch_chat_say("/me " + string(name) + " renamed Build " + string(setBuild) + " (" + string(_oldName) + ") to '" + string(_buildName) + "'.");
                                    
                                    ini_open(string(global.platformDir) + string(myCharDir) + "Data.ini");
                                    ini_write_string("Build", "Build " + string(setBuild) + " Name", _buildName);
                                    ini_close();
                                    
                                    if (build == setBuild)
                                        buildName = _buildName;
                                }
                                else if (arg2 == 0)
                                {
                                    gml_Script_twitch_chat_say("/me " + string(name) + " This Build slot is locked.");
                                }
                            }
                        }
                    }
                    else if (arg2 == 0)
                    {
                        gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
                    }
                }
                
                if (string_pos("!savebuild", _cmd) == 1 || string_pos("!sb", _cmd) == 1)
                {
                    if (ds_list_find_index(global.playerList, uname) != -1)
                    {
                        var setBuild = string_digits(_cmd);
                        var setBuildName = "";
                        
                        if (setBuild == "")
                        {
                            setBuild = 0;
                            
                            if (string_pos("!savebuild", _cmd) == 1)
                                setBuildName = string_letters(string_delete(_cmd, 1, 10));
                            
                            if (string_pos("!sb", _cmd) == 1)
                                setBuildName = string_letters(string_delete(_cmd, 1, 3));
                        }
                        else
                        {
                            setBuild = real(setBuild);
                        }
                        
                        with (obj_player)
                        {
                            if (name == other.uname)
                            {
                                if (state == UnknownEnum.Value_8)
                                {
                                    if (arg2 == 0)
                                        gml_Script_twitch_chat_say("/me " + string(name) + " You must be in town to change your build.");
                                    
                                    exit;
                                }
                                
                                ini_open(string(global.platformDir) + string(myCharDir) + "Builds.ini");
                                
                                for (var i = 1; i <= myBuildSlots; i++)
                                {
                                    show_debug_message("Trying to match Build " + string(i) + " with name " + string(setBuildName));
                                    
                                    if (ini_read_string("Build " + string(i), "Name", "!renamebuild" + string(i)) == setBuildName)
                                    {
                                        setBuild = i;
                                        show_debug_message("Matched Build " + string(setBuild) + " with name " + string(setBuildName));
                                        break;
                                    }
                                }
                                
                                ini_close();
                                
                                if (setBuild > 0 && setBuild <= myBuildSlots)
                                {
                                    gml_Script_scr_savePlayer();
                                    ini_open(string(global.platformDir) + string(myCharDir) + "Data.ini");
                                    var _buildName = ini_read_string("Build", "Build " + string(setBuild) + " Name", "!renamebuild" + string(setBuild));
                                    ini_close();
                                    ini_open(string(global.platformDir) + string(myCharDir) + "Builds.ini");
                                    
                                    for (var s = 0; s <= 9; s += 1)
                                    {
                                        ini_write_real("Build " + string(setBuild), "Base Stat " + string(s), baseStat[s][0]);
                                        show_debug_message("Talent Points on " + string(global.baseStatText[s]) + ": " + string(baseStat[s][0]));
                                    }
                                    
                                    ini_write_real("Build " + string(setBuild), "My Ability", myAbilityInfo[0]);
                                    ini_write_real("Build " + string(setBuild), "Specialized", specialized);
                                    ini_write_real("Build " + string(setBuild), "Auto Ability", autoAbility);
                                    ini_write_real("Build " + string(setBuild), "My Aura", myAura);
                                    ini_write_real("Build " + string(setBuild), "Mine Aura", mineAura);
                                    ini_write_real("Build " + string(setBuild), "Farm Aura", farmAura);
                                    ini_write_real("Build " + string(setBuild), "Train Aura", trainAura);
                                    ini_write_real("Build " + string(setBuild), "Raid Aura", raidAura);
                                    ini_write_real("Build " + string(setBuild), "Portal Aura", portalAura);
                                    
                                    for (var sr = 1; sr <= 5; sr += 1)
                                    {
                                        ini_write_real("Build " + string(setBuild), "Relic Slot " + string(sr), uniqueSlot[sr]);
                                        
                                        if (myPetID != 0)
                                            ini_write_real("Build " + string(setBuild), "Pet " + string(myPetID) + " Relic Slot " + string(sr), petRelicSlot[myPetID][sr]);
                                    }
                                    
                                    ini_write_real("Build " + string(setBuild), "My Pet ID", myPetID);
                                    
                                    for (var g = 0; g <= 9; g++)
                                    {
                                        ini_key_delete("Build " + string(setBuild), "Item " + string(g) + " Gemstone Type");
                                        ini_key_delete("Build " + string(setBuild), "Item " + string(g) + " Gemstone Size");
                                        
                                        if (myItemInfo[g][6] != 0)
                                        {
                                            ini_write_real("Build " + string(setBuild), "Item " + string(g) + " Gemstone Type", myItemInfo[g][6]);
                                            ini_write_real("Build " + string(setBuild), "Item " + string(g) + " Gemstone Size", myItemInfo[g][7]);
                                        }
                                    }
                                    
                                    ini_write_string("Build " + string(setBuild), "Raid Position", raidPos);
                                    ini_write_real("Build " + string(setBuild), "Raid Type", raidType);
                                    ini_close();
                                    
                                    if (arg2 == 0)
                                        gml_Script_twitch_chat_say("/me " + string(name) + " Build " + string(setBuild) + " (" + string(_buildName) + ") saved successfully, type " + string(global.cmdPrefix) + "loadbuild" + string(setBuild) + " to equip it.");
                                }
                                else if (arg2 == 0)
                                {
                                    gml_Script_twitch_chat_say("/me " + string(name) + " You can only save " + string(myBuildSlots) + " builds.");
                                }
                            }
                        }
                    }
                    else if (arg2 == 0)
                    {
                        gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
                    }
                    
                    exit;
                }
                
                if (string_pos("!loadbuild", _cmd) == 1 || string_pos("!lb", _cmd) == 1)
                {
                    if (ds_list_find_index(global.playerList, uname) != -1)
                    {
                        var setBuild = string_digits(_cmd);
                        var setBuildName = "";
                        
                        if (setBuild == "")
                        {
                            setBuild = 0;
                            
                            if (string_pos("!loadbuild", _cmd) == 1)
                                setBuildName = string_letters(string_delete(_cmd, 1, 10));
                            
                            if (string_pos("!lb", _cmd) == 1)
                                setBuildName = string_letters(string_delete(_cmd, 1, 3));
                        }
                        else
                        {
                            setBuild = real(setBuild);
                        }
                        
                        with (obj_player)
                        {
                            if (name == other.uname)
                            {
                                if (state == UnknownEnum.Value_8)
                                {
                                    if (arg2 == 0)
                                        gml_Script_twitch_chat_say("/me " + string(name) + " You must be in town to change your build.");
                                    
                                    exit;
                                }
                                
                                gml_Script_scr_player_loadbuild(setBuild, setBuildName, arg2);
                            }
                        }
                    }
                    else if (arg2 == 0)
                    {
                        gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
                    }
                    
                    exit;
                }
                
                if (string_pos("!setmineaura", _cmd) == 1)
                {
                    if (ds_list_find_index(global.playerList, uname) != -1)
                    {
                        setAura = string_digits(_cmd);
                        
                        if (setAura == "")
                            setAura = 0;
                        else
                            setAura = real(setAura);
                        
                        with (obj_player)
                        {
                            if (name == other.uname)
                            {
                                if (myTier > 1 || sub == 1)
                                {
                                    if (other.setAura <= maxAuras)
                                    {
                                        if (gotAura[other.setAura] == 1)
                                        {
                                            if (state == UnknownEnum.Value_8)
                                            {
                                                if (arg2 == 0)
                                                    gml_Script_twitch_chat_say("/me " + string(name) + " You must be in town to set your Auras.");
                                                
                                                exit;
                                            }
                                            
                                            ini_open(string(global.platformDir) + string(myCharDir) + "Data.ini");
                                            ini_write_real("Build", "Mine Aura", other.setAura);
                                            ini_close();
                                            mineAura = other.setAura;
                                            
                                            if (other.setAura > 0)
                                            {
                                                if (arg2 == 0)
                                                    gml_Script_twitch_chat_say("/me " + string(name) + " Aura " + string(other.setAura) + " (" + string(global.auraInfo[other.setAura][0]) + " | " + gml_Script_scr_bigNumber(auraBonus[other.setAura]) + "%) set for mining.");
                                            }
                                            else if (arg2 == 0)
                                            {
                                                gml_Script_twitch_chat_say("/me " + string(name) + " No Aura set for mining.");
                                            }
                                        }
                                        else if (arg2 == 0)
                                        {
                                            gml_Script_twitch_chat_say("/me " + string(name) + " You don't own Aura " + string(other.setAura) + ".");
                                        }
                                    }
                                    else if (arg2 == 0)
                                    {
                                        gml_Script_twitch_chat_say("/me " + string(name) + " Aura " + string(other.setAura) + " does not exist.");
                                    }
                                }
                                else if (arg2 == 0)
                                {
                                    gml_Script_twitch_chat_say("/me " + string(name) + " Automatic Auras are only available to " + string(global.cmdPrefix) + "!Legends+. Reach level 500 or subscribe to @Room_001 to unlock this command!");
                                }
                            }
                        }
                    }
                    else if (arg2 == 0)
                    {
                        gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
                    }
                    
                    exit;
                }
                
                if (string_pos("!setfarmaura", _cmd) == 1)
                {
                    if (ds_list_find_index(global.playerList, uname) != -1)
                    {
                        setAura = string_digits(_cmd);
                        
                        if (setAura == "")
                            setAura = 0;
                        else
                            setAura = real(setAura);
                        
                        with (obj_player)
                        {
                            if (name == other.uname)
                            {
                                if (myTier > 1 || sub == 1)
                                {
                                    if (other.setAura <= maxAuras)
                                    {
                                        if (gotAura[other.setAura] == 1)
                                        {
                                            if (state == UnknownEnum.Value_8)
                                            {
                                                if (arg2 == 0)
                                                    gml_Script_twitch_chat_say("/me " + string(name) + " You must be in town to set your Auras.");
                                                
                                                exit;
                                            }
                                            
                                            ini_open(string(global.platformDir) + string(myCharDir) + "Data.ini");
                                            ini_write_real("Build", "Farm Aura", other.setAura);
                                            ini_close();
                                            farmAura = other.setAura;
                                            
                                            if (other.setAura > 0)
                                            {
                                                if (arg2 == 0)
                                                    gml_Script_twitch_chat_say("/me " + string(name) + " Aura " + string(other.setAura) + " (" + string(global.auraInfo[other.setAura][0]) + " | " + gml_Script_scr_bigNumber(auraBonus[other.setAura]) + "%) set for farming.");
                                            }
                                            else if (arg2 == 0)
                                            {
                                                gml_Script_twitch_chat_say("/me " + string(name) + " No Aura set for farming.");
                                            }
                                        }
                                        else if (arg2 == 0)
                                        {
                                            gml_Script_twitch_chat_say("/me " + string(name) + " You don't own Aura " + string(other.setAura) + ".");
                                        }
                                    }
                                    else if (arg2 == 0)
                                    {
                                        gml_Script_twitch_chat_say("/me " + string(name) + " Aura " + string(other.setAura) + " does not exist.");
                                    }
                                }
                                else if (arg2 == 0)
                                {
                                    gml_Script_twitch_chat_say("/me " + string(name) + " Automatic Auras are only available to " + string(global.cmdPrefix) + "!Legends+. Reach level 500 or subscribe to @Room_001 to unlock this command!");
                                }
                            }
                        }
                    }
                    else if (arg2 == 0)
                    {
                        gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
                    }
                    
                    exit;
                }
                
                if (string_pos("!setraidaura", _cmd) == 1)
                {
                    if (ds_list_find_index(global.playerList, uname) != -1)
                    {
                        setAura = string_digits(_cmd);
                        
                        if (setAura == "")
                            setAura = 0;
                        else
                            setAura = real(setAura);
                        
                        with (obj_player)
                        {
                            if (name == other.uname)
                            {
                                if (myTier > 1 || sub == 1)
                                {
                                    if (other.setAura <= maxAuras)
                                    {
                                        if (gotAura[other.setAura] == 1)
                                        {
                                            if (state == UnknownEnum.Value_8)
                                            {
                                                if (arg2 == 0)
                                                    gml_Script_twitch_chat_say("/me " + string(name) + " You must be in town to set your Auras.");
                                                
                                                exit;
                                            }
                                            
                                            ini_open(string(global.platformDir) + string(myCharDir) + "Data.ini");
                                            ini_write_real("Build", "Raid Aura", other.setAura);
                                            ini_close();
                                            raidAura = other.setAura;
                                            
                                            if (other.setAura > 0)
                                            {
                                                if (arg2 == 0)
                                                    gml_Script_twitch_chat_say("/me " + string(name) + " Aura " + string(other.setAura) + " (" + string(global.auraInfo[other.setAura][0]) + " | " + gml_Script_scr_bigNumber(auraBonus[other.setAura]) + "%) set for raiding.");
                                            }
                                            else if (arg2 == 0)
                                            {
                                                gml_Script_twitch_chat_say("/me " + string(name) + " No Aura set for raiding.");
                                            }
                                        }
                                        else if (arg2 == 0)
                                        {
                                            gml_Script_twitch_chat_say("/me " + string(name) + " You don't own Aura " + string(other.setAura) + ".");
                                        }
                                    }
                                    else if (arg2 == 0)
                                    {
                                        gml_Script_twitch_chat_say("/me " + string(name) + " Aura " + string(other.setAura) + " does not exist.");
                                    }
                                }
                                else if (arg2 == 0)
                                {
                                    gml_Script_twitch_chat_say("/me " + string(name) + " Automatic Auras are only available to " + string(global.cmdPrefix) + "!Legends+. Reach level 500 or subscribe to @Room_001 to unlock this command!");
                                }
                            }
                        }
                    }
                    else if (arg2 == 0)
                    {
                        gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
                    }
                    
                    exit;
                }
                
                if (string_pos("!setportalaura", _cmd) == 1)
                {
                    if (ds_list_find_index(global.playerList, uname) != -1)
                    {
                        setAura = string_digits(_cmd);
                        
                        if (setAura == "")
                            setAura = 0;
                        else
                            setAura = real(setAura);
                        
                        with (obj_player)
                        {
                            if (name == other.uname)
                            {
                                if (myTier > 1 || sub == 1)
                                {
                                    if (other.setAura <= maxAuras)
                                    {
                                        if (gotAura[other.setAura] == 1)
                                        {
                                            if (state == UnknownEnum.Value_8)
                                            {
                                                if (arg2 == 0)
                                                    gml_Script_twitch_chat_say("/me " + string(name) + " You must be in town to set your Auras.");
                                                
                                                exit;
                                            }
                                            
                                            ini_open(string(global.platformDir) + string(myCharDir) + "Data.ini");
                                            ini_write_real("Build", "Portal Aura", other.setAura);
                                            ini_close();
                                            portalAura = other.setAura;
                                            
                                            if (other.setAura > 0)
                                            {
                                                if (arg2 == 0)
                                                    gml_Script_twitch_chat_say("/me " + string(name) + " Aura " + string(other.setAura) + " (" + string(global.auraInfo[other.setAura][0]) + " | " + gml_Script_scr_bigNumber(auraBonus[other.setAura]) + "%) set for portal.");
                                            }
                                            else if (arg2 == 0)
                                            {
                                                gml_Script_twitch_chat_say("/me " + string(name) + " No Aura set for portal.");
                                            }
                                        }
                                        else if (arg2 == 0)
                                        {
                                            gml_Script_twitch_chat_say("/me " + string(name) + " You don't own Aura " + string(other.setAura) + ".");
                                        }
                                    }
                                    else if (arg2 == 0)
                                    {
                                        gml_Script_twitch_chat_say("/me " + string(name) + " Aura " + string(other.setAura) + " does not exist.");
                                    }
                                }
                                else if (arg2 == 0)
                                {
                                    gml_Script_twitch_chat_say("/me " + string(name) + " Automatic Auras are only available to " + string(global.cmdPrefix) + "!Legends+. Reach level 500 or subscribe to @Room_001 to unlock this command!");
                                }
                            }
                        }
                    }
                    else if (arg2 == 0)
                    {
                        gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
                    }
                    
                    exit;
                }
                
                if (string_pos("!settrainaura", _cmd) == 1)
                {
                    if (ds_list_find_index(global.playerList, uname) != -1)
                    {
                        setAura = string_digits(_cmd);
                        
                        if (setAura == "")
                            setAura = 0;
                        else
                            setAura = real(setAura);
                        
                        with (obj_player)
                        {
                            if (name == other.uname)
                            {
                                if (myTier > 1 || sub == 1)
                                {
                                    if (other.setAura <= maxAuras)
                                    {
                                        if (gotAura[other.setAura] == 1)
                                        {
                                            if (state == UnknownEnum.Value_8)
                                            {
                                                if (arg2 == 0)
                                                    gml_Script_twitch_chat_say("/me " + string(name) + " You must be in town to set your Auras.");
                                                
                                                exit;
                                            }
                                            
                                            ini_open(string(global.platformDir) + string(myCharDir) + "Data.ini");
                                            ini_write_real("Build", "Train Aura", other.setAura);
                                            ini_close();
                                            trainAura = other.setAura;
                                            
                                            if (other.setAura > 0)
                                            {
                                                if (arg2 == 0)
                                                    gml_Script_twitch_chat_say("/me " + string(name) + " Aura " + string(other.setAura) + " (" + string(global.auraInfo[other.setAura][0]) + " | " + gml_Script_scr_bigNumber(auraBonus[other.setAura]) + "%) set for training.");
                                            }
                                            else if (arg2 == 0)
                                            {
                                                gml_Script_twitch_chat_say("/me " + string(name) + " No Aura set for training.");
                                            }
                                        }
                                        else if (arg2 == 0)
                                        {
                                            gml_Script_twitch_chat_say("/me " + string(name) + " You don't own Aura " + string(other.setAura) + ".");
                                        }
                                    }
                                    else if (arg2 == 0)
                                    {
                                        gml_Script_twitch_chat_say("/me " + string(name) + " Aura " + string(other.setAura) + " does not exist.");
                                    }
                                }
                                else if (arg2 == 0)
                                {
                                    gml_Script_twitch_chat_say("/me " + string(name) + " Automatic Auras are only available to " + string(global.cmdPrefix) + "!Legends+. Reach level 500 or subscribe to @Room_001 to unlock this command!");
                                }
                            }
                        }
                    }
                    else if (arg2 == 0)
                    {
                        gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
                    }
                    
                    exit;
                }
                
                if (string_pos("!setaura", _cmd) == 1 || string_pos("setaura", _cmd) == 1)
                {
                    if (ds_list_find_index(global.playerList, uname) != -1)
                    {
                        setAura = string_digits(_cmd);
                        
                        if (setAura == "")
                            setAura = 0;
                        else
                            setAura = real(setAura);
                        
                        with (obj_player)
                        {
                            if (name == other.uname)
                            {
                                if (other.setAura <= maxAuras)
                                {
                                    if (gotAura[other.setAura] == 1)
                                    {
                                        if (state == UnknownEnum.Value_8)
                                        {
                                            if (arg2 == 0)
                                                gml_Script_twitch_chat_say("/me " + string(name) + " You must be in town to change your Aura.");
                                            
                                            exit;
                                        }
                                        
                                        ini_open(string(global.platformDir) + string(myCharDir) + "Data.ini");
                                        ini_write_real("Build", "Aura " + string(myAura) + " Bonus", auraBonus[myAura]);
                                        myMultiplier[myAura] /= 1 + (auraBonus[myAura] / 100);
                                        myAura = other.setAura;
                                        auraIcon = oauraIcon[myAura];
                                        spr_aura = auraIcon;
                                        gml_Script_scr_updateStats();
                                        ini_write_real("Build", "Aura", myAura);
                                        ini_write_string("Build", "Aura Icon", auraIcon);
                                        ini_close();
                                        
                                        if (myAura > 0)
                                        {
                                            if (arg2 == 0)
                                                gml_Script_twitch_chat_say("/me " + string(name) + " Aura " + string(myAura) + " (" + string(global.auraInfo[myAura][0]) + " | " + gml_Script_scr_bigNumber(auraBonus[myAura]) + "%) set successfully.");
                                        }
                                        else if (arg2 == 0)
                                        {
                                            gml_Script_twitch_chat_say("/me " + string(name) + " Aura deactivated.");
                                        }
                                    }
                                    else if (arg2 == 0)
                                    {
                                        gml_Script_twitch_chat_say("/me " + string(name) + " You don't own Aura " + string(other.setAura) + ".");
                                    }
                                }
                                else if (arg2 == 0)
                                {
                                    gml_Script_twitch_chat_say("/me " + string(name) + " Aura " + string(other.setAura) + " does not exist.");
                                }
                            }
                        }
                    }
                    else if (arg2 == 0)
                    {
                        gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
                    }
                    
                    exit;
                }
                
                if (string_pos("!swap", _cmd) == 1)
                {
                    if (ds_list_find_index(global.playerList, uname) != -1)
                    {
                        with (obj_player)
                        {
                            if (name == other.uname)
                            {
                                if (state == UnknownEnum.Value_8 || readyRaid != 0)
                                {
                                    if (arg2 == 0)
                                        gml_Script_twitch_chat_say("/me " + string(name) + " You must be in town and not ready to raid to swap your combat position.");
                                    
                                    exit;
                                }
                                
                                if (canSwap == true || global.dev == true)
                                {
                                    ini_open(string(global.platformDir) + string(myCharDir) + "Data.ini");
                                    
                                    if (raidType == 0)
                                    {
                                        raidType = 1;
                                        raidList = global.raidList1;
                                        
                                        if (arg2 == 0)
                                            gml_Script_twitch_chat_say("/me " + string(name) + " You swapped your combat position to ranged.");
                                    }
                                    else
                                    {
                                        raidType = 0;
                                        raidList = global.raidList0;
                                        
                                        if (arg2 == 0)
                                            gml_Script_twitch_chat_say("/me " + string(name) + " You swapped your combat position to melee.");
                                    }
                                    
                                    ini_write_real("Build", "Raid Type", raidType);
                                    ini_close();
                                }
                                else if (arg2 == 0)
                                {
                                    gml_Script_twitch_chat_say("/me " + string(name) + " You don't have the ability to swap your combat position.");
                                }
                            }
                        }
                    }
                    else if (arg2 == 0)
                    {
                        gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
                    }
                    
                    exit;
                }
                
                if (string_pos("!tut", _cmd) == 1)
                {
                    if (ds_list_find_index(global.playerList, uname) != -1)
                    {
                        with (obj_player)
                        {
                            if (name == other.uname)
                            {
                                if (tutorial == 1)
                                {
                                    tutorial = 0;
                                    
                                    if (arg2 == 0)
                                        gml_Script_twitch_chat_say("/me " + string(name) + " You will no longer be pinged on [Tutorial] messages. Type !tutorial again to re-enable it.");
                                }
                                else
                                {
                                    tutorial = 1;
                                    
                                    if (arg2 == 0)
                                        gml_Script_twitch_chat_say("/me " + string(name) + " You will be pinged on [Tutorial] messages from now on. Type !tutorial again to disable it.");
                                }
                                
                                ini_open(string(global.platformDir) + string(myAccDir) + "Account Data.ini");
                                ini_write_real("Misc", "Tutorial", tutorial);
                                ini_close();
                            }
                        }
                    }
                    else if (arg2 == 0)
                    {
                        gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
                    }
                    
                    exit;
                }
                
                if (string_pos("!favrelic", _cmd) == 1 || string_pos("!fav", _cmd) == 1 || (string_pos("?fav", _cmd) == 1 && string_pos("?favor", _cmd) != 1))
                {
                    if (ds_list_find_index(global.playerList, uname) != -1)
                    {
                        var _relic = string_digits(_cmd);
                        
                        if (_relic != "")
                            _relic = real(_relic);
                        else
                            _relic = "list";
                        
                        with (obj_player)
                        {
                            if (name == other.uname)
                            {
                                if (_relic != "list")
                                {
                                    if (_relic <= global.maxUniqueItems && _relic != 0)
                                    {
                                        if (favoriteRelics[_relic] == 1)
                                        {
                                            favoriteRelics[_relic] = 0;
                                            favoriteRelicsTotal -= 1;
                                            
                                            if (arg2 == 0)
                                                gml_Script_twitch_chat_say("/me " + string(name) + " Relic " + string(_relic) + " (" + string(global.uniqueItem[_relic][0]) + ") removed from favorites (" + string(favoriteRelicsTotal) + "/10).");
                                        }
                                        else if (favoriteRelicsTotal < 10)
                                        {
                                            favoriteRelics[_relic] = 1;
                                            favoriteRelicsTotal += 1;
                                            
                                            if (arg2 == 0)
                                                gml_Script_twitch_chat_say("/me " + string(name) + " Relic " + string(_relic) + " (" + string(global.uniqueItem[_relic][0]) + ") added to favorites (" + string(favoriteRelicsTotal) + "/10).");
                                        }
                                        else if (arg2 == 0)
                                        {
                                            gml_Script_twitch_chat_say("/me " + string(name) + " you can't flag more Relics as favorite (10/10).");
                                        }
                                        
                                        ini_open(string(global.platformDir) + string(myCharDir) + "Data.ini");
                                        ini_write_real("Favorite Relic List", "Relic " + string(_relic), favoriteRelics[_relic]);
                                        ini_close();
                                    }
                                    else if (arg2 == 0)
                                    {
                                        gml_Script_twitch_chat_say("/me " + string(name) + " Relic " + string(_relic) + " does not exist.");
                                    }
                                }
                                else
                                {
                                    var _text = "'s " + string(class) + " favorite Relics (" + string(favoriteRelicsTotal) + "/10): ";
                                    
                                    for (var f = 0; f <= global.maxUniqueItems; f++)
                                    {
                                        if (favoriteRelics[f] == 1)
                                            _text += (" Relic " + string(f) + " (" + string(global.uniqueItem[f][0]) + "),");
                                    }
                                    
                                    _text = string_delete(_text, -1, 1);
                                    _text += ".";
                                    
                                    if (arg2 == 0)
                                        gml_Script_twitch_chat_say("/me " + string(name) + string(_text));
                                }
                            }
                        }
                    }
                    else if (arg2 == 0)
                    {
                        gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
                    }
                    
                    exit;
                }
                
                if (string_pos("!setrelic", _cmd) == 1 || string_pos("setrelic", _cmd) == 1)
                {
                    if (ds_list_find_index(global.playerList, uname) != -1)
                    {
                        if (string_pos(":", _cmd) == 0)
                            exit;
                        
                        var _length = real(string_pos(":", _cmd));
                        var _index = string_digits(string_copy(_cmd, 1, _length));
                        
                        if (_index != "")
                            _index = real(_index);
                        else
                            exit;
                        
                        var _amount = string_digits(string_delete(_cmd, 1, _length));
                        
                        if (_amount != "")
                            _amount = real(_amount);
                        else
                            exit;
                        
                        show_debug_message("Relic: slot " + string(_index) + " - id " + string(_amount));
                        var setRelicSlot = _index;
                        var setRelic = _amount;
                        
                        if (string_digits(setRelicSlot) == "")
                            setRelicSlot = 0;
                        else
                            setRelicSlot = real(string_digits(setRelicSlot));
                        
                        if (string_digits(setRelic) == "")
                            setRelic = 0;
                        else
                            setRelic = real(string_digits(setRelic));
                        
                        with (obj_player)
                        {
                            if (name == other.uname)
                            {
                                if (level >= 100)
                                {
                                    if (setRelicSlot > 0 && setRelicSlot <= myRelicSlots)
                                    {
                                        if (setRelic <= global.maxUniqueItems && setRelic != 0)
                                        {
                                            if (equippedUniqueItem[setRelic] == 0 && myPetEquippedRelic[myPetID][setRelic] == 0)
                                            {
                                                if (gotUniqueItem[setRelic] > 0)
                                                {
                                                    if (string_lower(global.uniqueItem[setRelic][3]) == class || global.uniqueItem[setRelic][3] == "All Classes")
                                                    {
                                                        if (state == UnknownEnum.Value_8)
                                                        {
                                                            if (arg2 == 0)
                                                                gml_Script_twitch_chat_say("/me " + string(name) + " You must be in town to change your Relic.");
                                                            
                                                            exit;
                                                        }
                                                        
                                                        ini_open(string(global.platformDir) + string(myCharDir) + "Data.ini");
                                                        ini_write_real("Relics", "Got Unique Item " + string(setRelic), gotUniqueItem[setRelic]);
                                                        ini_write_real("Relics", "Unique Item " + string(setRelic) + " Level", uniqueItemLevel[setRelic]);
                                                        equippedUniqueItem[uniqueSlot[setRelicSlot]] = 0;
                                                        ini_write_real("Relics", "Equipped Unique Item " + string(uniqueSlot[setRelicSlot]), 0);
                                                        uniqueSlot[setRelicSlot] = setRelic;
                                                        equippedUniqueItem[setRelic] = 1;
                                                        uniqueItemLevel[setRelic] = ini_read_real("Relics", "Unique Item " + string(setRelic) + " Level", 1);
                                                        gotUniqueItem[setRelic] = ini_read_real("Relics", "Got Unique Item " + string(setRelic), 0);
                                                        ini_write_real("Relics", "Equipped Unique Item " + string(setRelic), 1);
                                                        ini_write_real("Relics", "Unique Slot " + string(setRelicSlot), setRelic);
                                                        ini_close();
                                                        
                                                        if (arg2 == 0)
                                                            gml_Script_twitch_chat_say("/me " + string(name) + " Relic " + string(setRelic) + " (" + string(global.uniqueItem[setRelic][0]) + ") equipped successfully on slot " + string(setRelicSlot) + ".");
                                                    }
                                                    else if (arg2 == 0)
                                                    {
                                                        gml_Script_twitch_chat_say("/me " + string(name) + " Relic " + string(setRelic) + " is exclusive for " + string(global.uniqueItem[setRelic][3]) + "s only.");
                                                    }
                                                }
                                                else if (arg2 == 0)
                                                {
                                                    gml_Script_twitch_chat_say("/me " + string(name) + " You don't own Relic " + string(setRelic) + ".");
                                                }
                                            }
                                            else
                                            {
                                                if (uniqueSlot[setRelicSlot] == setRelic)
                                                {
                                                    if (arg2 == 0)
                                                        gml_Script_twitch_chat_say("/me " + string(name) + " You are already using Relic " + string(setRelic) + " on slot " + string(setRelicSlot) + ".");
                                                }
                                                
                                                if (uniqueSlot[setRelicSlot] != setRelic)
                                                {
                                                    var _swapRelic = uniqueSlot[setRelicSlot];
                                                    var _swapRelicTo = setRelicSlot;
                                                    var _swapRelicFrom = 0;
                                                    var _fromPlayer = 0;
                                                    var _wearer = "";
                                                    
                                                    for (var s = 1; s <= 5; s++)
                                                    {
                                                        if (uniqueSlot[s] == setRelic)
                                                        {
                                                            _swapRelicFrom = s;
                                                            _fromPlayer = 1;
                                                            _wearer = "personal ";
                                                            break;
                                                        }
                                                        
                                                        if (petRelicSlot[myPetID][s] == setRelic)
                                                        {
                                                            _swapRelicFrom = s;
                                                            _fromPlayer = 0;
                                                            _wearer = "pet ";
                                                            break;
                                                        }
                                                    }
                                                    
                                                    uniqueSlot[setRelicSlot] = setRelic;
                                                    equippedUniqueItem[setRelic] = 1;
                                                    equippedUniqueItem[_swapRelic] = 0;
                                                    
                                                    if (_fromPlayer == 1)
                                                    {
                                                        uniqueSlot[_swapRelicFrom] = _swapRelic;
                                                        equippedUniqueItem[_swapRelic] = 1;
                                                    }
                                                    else
                                                    {
                                                        petRelicSlot[myPetID][_swapRelicFrom] = _swapRelic;
                                                        myPetEquippedRelic[myPetID][_swapRelic] = 1;
                                                        myPetEquippedRelic[myPetID][setRelic] = 0;
                                                    }
                                                    
                                                    if (_swapRelic != 0)
                                                    {
                                                        if (arg2 == 0)
                                                            gml_Script_twitch_chat_say("/me " + string(name) + " Relic " + string(setRelic) + " (" + string(global.uniqueItem[setRelic][0]) + ") swapped successfully with Relic " + string(_swapRelic) + " (" + string(global.uniqueItem[_swapRelic][0]) + ") from " + string(_wearer) + "slot " + string(_swapRelicFrom) + " to personal slot " + string(setRelicSlot) + ".");
                                                    }
                                                    else if (arg2 == 0)
                                                    {
                                                        gml_Script_twitch_chat_say("/me " + string(name) + " Relic " + string(setRelic) + " (" + string(global.uniqueItem[setRelic][0]) + ") moved successfully from " + string(_wearer) + "slot " + string(_swapRelicFrom) + " to personal slot " + string(setRelicSlot) + ".");
                                                    }
                                                }
                                            }
                                        }
                                        else if (setRelic == 0)
                                        {
                                            var _oldRelic = uniqueSlot[setRelicSlot];
                                            ini_open(string(global.platformDir) + string(myCharDir) + "Data.ini");
                                            ini_write_real("Relics", "Got Unique Item " + string(setRelic), gotUniqueItem[setRelic]);
                                            ini_write_real("Relics", "Unique Item " + string(setRelic) + " Level", uniqueItemLevel[setRelic]);
                                            equippedUniqueItem[uniqueSlot[setRelicSlot]] = 0;
                                            ini_write_real("Relics", "Equipped Unique Item " + string(uniqueSlot[setRelicSlot]), 0);
                                            uniqueSlot[setRelicSlot] = setRelic;
                                            equippedUniqueItem[setRelic] = 0;
                                            uniqueItemLevel[setRelic] = 0;
                                            gotUniqueItem[setRelic] = 1;
                                            ini_write_real("Relics", "Equipped Unique Item " + string(setRelic), 1);
                                            ini_write_real("Relics", "Unique Slot " + string(setRelicSlot), setRelic);
                                            ini_close();
                                            
                                            if (_oldRelic > 0)
                                            {
                                                if (arg2 == 0)
                                                    gml_Script_twitch_chat_say("/me " + string(name) + " you unequipped Relic " + string(_oldRelic) + " (" + string(global.uniqueItem[_oldRelic][0]) + ") from slot " + string(setRelicSlot) + ".");
                                            }
                                            else if (arg2 == 0)
                                            {
                                                gml_Script_twitch_chat_say("/me " + string(name) + " there is no Relic equipped on slot " + string(setRelicSlot) + ".");
                                            }
                                        }
                                        else if (arg2 == 0)
                                        {
                                            gml_Script_twitch_chat_say("/me " + string(name) + " Relic " + string(setRelic) + " does not exist.");
                                        }
                                    }
                                    else if (arg2 == 0)
                                    {
                                        gml_Script_twitch_chat_say("/me " + string(name) + " you do not have this Relic slot unlocked.");
                                    }
                                }
                                else if (arg2 == 0)
                                {
                                    gml_Script_twitch_chat_say("/me " + string(name) + " you must be at least level 100 to equip a Relic.");
                                }
                            }
                        }
                    }
                    else if (arg2 == 0)
                    {
                        gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
                    }
                    
                    exit;
                }
                
                if (string_pos("!setspecial", _cmd) == 1 || string_pos("setspecial", _cmd) == 1)
                {
                    if (ds_list_find_index(global.playerList, uname) != -1)
                    {
                        if (string_pos(":", _cmd) == 0)
                            exit;
                        
                        var _length = real(string_pos(":", _cmd));
                        var _index = string_digits(string_copy(_cmd, 1, _length));
                        
                        if (_index != "")
                            _index = real(_index);
                        else
                            exit;
                        
                        var _amount = string_digits(string_delete(_cmd, 1, _length));
                        
                        if (_amount != "")
                            _amount = real(_amount);
                        else
                            exit;
                        
                        show_debug_message("Special Item: slot " + string(_index) + " - id " + string(_amount));
                        var setRelicSlot = _index;
                        var setRelic = _amount;
                        
                        if (string_digits(setRelicSlot) == "")
                            setRelicSlot = 0;
                        else
                            setRelicSlot = real(string_digits(setRelicSlot));
                        
                        if (string_digits(setRelic) == "")
                            setRelic = 0;
                        else
                            setRelic = real(string_digits(setRelic));
                        
                        with (obj_player)
                        {
                            if (name == other.uname)
                            {
                                if (level >= 100)
                                {
                                    if (setRelicSlot > 0 && setRelicSlot <= mySpecialSlots)
                                    {
                                        if (setRelic <= global.maxSpecialItems && setRelic != 0)
                                        {
                                            if (equippedUniqueSpecial[setRelic] == 0)
                                            {
                                                if (gotUniqueSpecial[setRelic] > 0)
                                                {
                                                    if (string_lower(global.specialItem[setRelic][3]) == class || global.specialItem[setRelic][3] == "All Classes")
                                                    {
                                                        if (state == UnknownEnum.Value_8)
                                                        {
                                                            if (arg2 == 0)
                                                                gml_Script_twitch_chat_say("/me " + string(name) + " You must be in town to change your Special Item.");
                                                            
                                                            exit;
                                                        }
                                                        
                                                        ini_open(string(global.platformDir) + string(myCharDir) + "Data.ini");
                                                        ini_write_real("Special Items", "Got Special Item " + string(setRelic), gotSpecialItem[setRelic]);
                                                        ini_write_real("Special Items", "Special Item " + string(setRelic) + " Level", specialItemLevel[setRelic]);
                                                        equippedSpecialItem[specialSlot[setRelicSlot]] = 0;
                                                        ini_write_real("Relics", "Equipped Unique Item " + string(uniqueSlot[setRelicSlot]), 0);
                                                        specialSlot[setRelicSlot] = setRelic;
                                                        equippedSpecialItem[setRelic] = 1;
                                                        specialItemLevel[setRelic] = ini_read_real("Special Items", "Special Item " + string(setRelic) + " Level", 1);
                                                        gotSpecialItem[setRelic] = ini_read_real("Special Items", "Got Special Item " + string(setRelic), 0);
                                                        ini_write_real("Special Items", "Equipped Special Item " + string(setRelic), 1);
                                                        ini_write_real("Special Items", "Special Slot " + string(setRelicSlot), setRelic);
                                                        ini_close();
                                                        
                                                        if (arg2 == 0)
                                                            gml_Script_twitch_chat_say("/me " + string(name) + " Special Item " + string(setRelic) + " (" + string(global.specialItem[setRelic][0]) + ") equipped successfully on slot " + string(setRelicSlot) + ".");
                                                    }
                                                    else if (arg2 == 0)
                                                    {
                                                        gml_Script_twitch_chat_say("/me " + string(name) + " Special Item " + string(setRelic) + " is exclusive for " + string(global.specialItem[setRelic][3]) + "s only.");
                                                    }
                                                }
                                                else if (arg2 == 0)
                                                {
                                                    gml_Script_twitch_chat_say("/me " + string(name) + " You don't own Special Item " + string(setRelic) + ".");
                                                }
                                            }
                                            else if (arg2 == 0)
                                            {
                                                gml_Script_twitch_chat_say("/me " + string(name) + " You have already equipped Special Item " + string(setRelic) + "!");
                                            }
                                        }
                                        else if (setRelic == 0)
                                        {
                                            var _oldRelic = specialSlot[setRelicSlot];
                                            ini_open(string(global.platformDir) + string(myCharDir) + "Data.ini");
                                            ini_write_real("Special Items", "Got Special Item " + string(setRelic), gotSpecialItem[setRelic]);
                                            ini_write_real("Special Items", "Special Item " + string(setRelic) + " Level", specialItemLevel[setRelic]);
                                            equippedSpecialItem[specialSlot[setRelicSlot]] = 0;
                                            ini_write_real("Special Items", "Equipped Special Item " + string(specialSlot[setRelicSlot]), 0);
                                            specialSlot[setRelicSlot] = setRelic;
                                            equippedSpecialItem[setRelic] = 0;
                                            specialItemLevel[setRelic] = 0;
                                            gotSpecialItem[setRelic] = 1;
                                            ini_write_real("Special Items", "Equipped Special Item " + string(setRelic), 1);
                                            ini_write_real("Special Items", "Special Slot " + string(setRelicSlot), setRelic);
                                            ini_close();
                                            
                                            if (arg2 == 0)
                                                gml_Script_twitch_chat_say("/me " + string(name) + " you unequipped Relic " + string(_oldRelic) + " from slot " + string(setRelicSlot) + ".");
                                        }
                                        else if (arg2 == 0)
                                        {
                                            gml_Script_twitch_chat_say("/me " + string(name) + " Relic " + string(setRelic) + " does not exist.");
                                        }
                                    }
                                    else if (arg2 == 0)
                                    {
                                        gml_Script_twitch_chat_say("/me " + string(name) + " you do not have this Relic slot unlocked.");
                                    }
                                }
                                else if (arg2 == 0)
                                {
                                    gml_Script_twitch_chat_say("/me " + string(name) + " you must be at least level 100 to equip a Relic.");
                                }
                            }
                        }
                    }
                    else if (arg2 == 0)
                    {
                        gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
                    }
                    
                    exit;
                }
                
                if (string_pos("!join", _cmd) == 1 || string_pos("join", _cmd) == 1)
                {
                    if (ds_list_find_index(global.playerList, uname) == -1)
                    {
                        var str = _cmd;
                        var chooseClass = string_letters(string_delete(str, 1, 5));
                        
                        if ((global.totalPlayers - global.totalAscensionLevel) < global.maxPlayers)
                            gml_Script_scr_createCharacter(chooseClass, uname);
                        else
                            gml_Script_twitch_chat_say("/me " + string(uname) + " The Town has reached its maximum population (" + string(global.maxPlayers) + ")! You will be able to " + string(global.cmdPrefix) + "join after someone !quits or stays AFK for a while. You can wait for characters to go AFK or visit " + "https://www.twitch.tv/directory/category/tp-dungeon-raiders" + " and look for other Towns to join.");
                    }
                    
                    exit;
                }
                
                if (string_pos("room00", _cmd) == 1)
                {
                    if (ds_list_find_index(global.playerList, uname) == -1)
                    {
                        var str = _cmd;
                        var chooseClass = string_letters(string_delete(str, 1, 6));
                        gml_Script_scr_createCharacter(chooseClass, uname);
                    }
                    
                    exit;
                }
                
                if (string_pos("!sacrifice", _cmd) == 1)
                {
                    if (ds_list_find_index(global.playerList, uname) != -1)
                    {
                        if (instance_exists(obj_build_witchhut))
                        {
                            var _suffix = string_char_at(_cmd, string_length(_cmd) - 2);
                            var _amount = string_digits(_cmd);
                            
                            if (_amount == "")
                            {
                                if (string_pos("all", _cmd) != 0)
                                    _suffix = "all";
                                else
                                    exit;
                            }
                            else
                            {
                                _amount = real(_amount);
                            }
                            
                            show_debug_message("Donated " + string(_amount) + string(_suffix));
                            
                            if (_suffix == "k")
                                _amount *= 1000;
                            
                            if (_suffix == "m")
                                _amount *= 1000000;
                            
                            if (_suffix == "b")
                                _amount *= 1000000000;
                            
                            if (_suffix == "t")
                                _amount *= 1000000000000;
                            
                            with (obj_player)
                            {
                                if (name == other.uname)
                                {
                                    var _donation = _amount;
                                    
                                    if (_suffix == "all")
                                        _donation = global.souls;
                                    
                                    if (_donation > (global.recipeMax - global.recipeProgress))
                                        _donation = global.recipeMax - global.recipeProgress;
                                    
                                    if (global.souls >= _donation)
                                    {
                                        global.souls -= _donation;
                                        global.recipeProgress += _donation;
                                    }
                                    else
                                    {
                                        _donation = global.souls;
                                        global.souls -= _donation;
                                        global.recipeProgress += _donation;
                                    }
                                    
                                    with (gml_Script_instance_create(obj_build_witchhut.x, obj_build_witchhut.y, obj_float))
                                    {
                                        type = 1;
                                        value = round(_donation);
                                        text = "+" + gml_Script_scr_bigNumber(value) + "s";
                                        c1 = 16776960;
                                        c2 = 8421376;
                                        parent = type;
                                    }
                                    
                                    if (global.recipeProgress < global.recipeMax)
                                    {
                                        if (arg2 == 0)
                                            gml_Script_twitch_chat_say("/me " + string(name) + " sacrificed " + gml_Script_scr_bigNumber(round(_donation)) + " souls to the witch, " + gml_Script_scr_bigNumber(global.recipeMax - global.recipeProgress) + " souls left to complete the enchantment.");
                                    }
                                    else if (obj_build_witchhut.alarm[0] == -1)
                                    {
                                        obj_build_witchhut.alarm[0] = room_speed * 3600 * obj_build_witchhut.level;
                                        gml_Script_twitch_chat_say_direct("/me " + string(name) + " sacrificed " + gml_Script_scr_bigNumber(round(_donation)) + " souls to the witch, the enchantment is now ready (" + string(obj_build_witchhut.level) + " hours left)!");
                                        gml_Script_scr_playsound(s_enchantmentReady, 0.9, 1.1, 1);
                                    }
                                }
                            }
                        }
                        else if (arg2 == 0)
                        {
                            gml_Script_twitch_chat_say("/me " + string(uname) + " Why would you want to do that? Hmmmm...");
                        }
                    }
                    else if (arg2 == 0)
                    {
                        gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
                    }
                    
                    exit;
                }
                
                if (string_pos("!recycle", _cmd) == 1)
                {
                    if (ds_list_find_index(global.playerList, uname) != -1)
                    {
                        if (instance_exists(obj_build_forge) && obj_build_forge.level >= 13)
                        {
                            var buyItem, chooseAmount;
                            
                            if (string_pos("*", _cmd) != 0)
                            {
                                var _length = real(string_pos("*", _cmd));
                                var _index = string_digits(string_copy(_cmd, 1, _length));
                                
                                if (_index != "")
                                    _index = real(_index);
                                else
                                    exit;
                                
                                var _amount = string_digits(string_delete(_cmd, 1, _length));
                                
                                if (_amount != "")
                                    _amount = real(_amount);
                                else
                                    exit;
                                
                                show_debug_message("Buy: slot " + string(_index) + " - " + string(_amount) + "x");
                                buyItem = _index;
                                chooseAmount = _amount;
                                
                                if (string_digits(buyItem) == "")
                                    buyItem = 0;
                                else
                                    buyItem = real(string_digits(buyItem));
                                
                                if (string_digits(chooseAmount) == "")
                                    chooseAmount = 1;
                                else
                                    chooseAmount = real(string_digits(chooseAmount));
                            }
                            else if (string_pos("all", _cmd) != 0)
                            {
                                buyItem = "all";
                            }
                            else if (string_digits(_cmd) == "")
                            {
                                buyItem = 0;
                            }
                            else
                            {
                                buyItem = real(string_digits(_cmd));
                                chooseAmount = 1;
                            }
                            
                            var chooseRelic = buyItem;
                            
                            if (chooseRelic != "all")
                            {
                                if (chooseRelic <= global.maxUniqueItems && chooseRelic > 0)
                                {
                                    with (obj_player)
                                    {
                                        if (name == other.uname)
                                        {
                                            if (state == UnknownEnum.Value_8)
                                            {
                                                if (arg2 == 0)
                                                    gml_Script_twitch_chat_say("/me " + string(name) + " you must be in town to recycle your Relics.");
                                                
                                                exit;
                                            }
                                            else if (gotUniqueItem[chooseRelic] > 0)
                                            {
                                                if (equippedUniqueItem[chooseRelic] == 0 && myPetEquippedRelic[myPetID][chooseRelic] == 0 && favoriteRelics[chooseRelic] == 0)
                                                {
                                                    if (gotUniqueItem[chooseRelic] < chooseAmount)
                                                        chooseAmount = gotUniqueItem[chooseRelic];
                                                    
                                                    var recycleGems;
                                                    
                                                    if ((gotUniqueItem[chooseRelic] - chooseAmount) <= 0)
                                                    {
                                                        recycleGems = (chooseAmount + uniqueItemLevel[chooseRelic]) - 1;
                                                        uniqueItemLevel[chooseRelic] = 1;
                                                    }
                                                    else
                                                    {
                                                        recycleGems = chooseAmount;
                                                    }
                                                    
                                                    if (obj_build_forge.alarm[1] == -1)
                                                    {
                                                        obj_build_forge.forgeItem[1][0] += recycleGems;
                                                        
                                                        if (obj_build_forge.forgeItem[1][0] >= obj_build_forge.forgeItem[1][1])
                                                        {
                                                            obj_build_forge.alarm[1] = room_speed * 21601;
                                                            obj_build_forge.forgeItem[1][0] = obj_build_forge.forgeItem[1][1];
                                                        }
                                                    }
                                                    else
                                                    {
                                                        obj_build_forge.alarm[1] += recycleGems * global.roomSpeed;
                                                        
                                                        if (obj_build_forge.alarm[1] > (room_speed * 21600))
                                                            obj_build_forge.alarm[1] = room_speed * 21600;
                                                    }
                                                    
                                                    myGems += recycleGems;
                                                    gotUniqueItem[chooseRelic] -= chooseAmount;
                                                    equippedUniqueItem[chooseRelic] = 0;
                                                    ini_open(string(global.platformDir) + string(myAccDir) + "Character Data.ini");
                                                    ini_write_real("Resources", "Gems", myGems);
                                                    ini_close();
                                                    ini_open(string(global.platformDir) + string(myCharDir) + "Data.ini");
                                                    ini_write_real("Relics", "Unique Item " + string(chooseRelic) + " Level", uniqueItemLevel[chooseRelic]);
                                                    ini_write_real("Relics", "Got Unique Item " + string(chooseRelic), gotUniqueItem[chooseRelic]);
                                                    
                                                    for (var ui = 0; ui < 3; ui += 1)
                                                    {
                                                        if (uniqueSlot[ui] == chooseRelic)
                                                        {
                                                            uniqueSlot[ui] = 0;
                                                            ini_write_real("Relics", "Unique Slot " + string(ui), 0);
                                                        }
                                                    }
                                                    
                                                    ini_close();
                                                    
                                                    if (gotUniqueItem[chooseRelic] <= 0)
                                                    {
                                                        if (global.chatSpam <= 2)
                                                        {
                                                            if (arg2 == 0)
                                                                gml_Script_twitch_chat_say("/me " + string(name) + " the blacksmith recycled all your " + string(global.uniqueItem[chooseRelic][0]) + " Relics. You received " + string(recycleGems) + " room00Gem ! (" + string(obj_build_forge.forgeItem[1][1] - obj_build_forge.forgeItem[1][0]) + " Relics left to !!reforge).");
                                                        }
                                                    }
                                                    else if (global.chatSpam <= 2)
                                                    {
                                                        if (arg2 == 0)
                                                            gml_Script_twitch_chat_say("/me " + string(name) + " the blacksmith recycled (x" + string(chooseAmount) + ") of your " + string(global.uniqueItem[chooseRelic][0]) + " Relics. You received " + string(recycleGems) + " room00Gem ! (" + string(obj_build_forge.forgeItem[1][1] - obj_build_forge.forgeItem[1][0]) + " Relics left to !!reforge).");
                                                    }
                                                    
                                                    gml_Script_scr_playsound(s_forge, 0.9, 1.1, 0.5);
                                                    gml_Script_scr_playsound(s_armored, 0.9, 1.1, 0.5);
                                                }
                                                else if (arg2 == 0)
                                                {
                                                    gml_Script_twitch_chat_say("/me " + string(name) + " you can't recycle equipped or favorite Relics!");
                                                }
                                            }
                                            else if (arg2 == 0)
                                            {
                                                gml_Script_twitch_chat_say("/me " + string(name) + " you don't have this Relic!");
                                            }
                                        }
                                    }
                                }
                                else if (arg2 == 0)
                                {
                                    gml_Script_twitch_chat_say("/me " + string(uname) + " The relic you are trying to recycle does not exist or the command format is incorrect (" + string(global.cmdPrefix) + "recycle #*#).");
                                }
                            }
                            else
                            {
                                with (obj_player)
                                {
                                    if (name == other.uname)
                                    {
                                        if (state == UnknownEnum.Value_8)
                                        {
                                            if (arg2 == 0)
                                                gml_Script_twitch_chat_say("/me " + string(name) + " you must be in town to recycle your Relics.");
                                            
                                            exit;
                                        }
                                        else
                                        {
                                            var _multipleRecycle = 0;
                                            var recycleGems = 0;
                                            ini_open(string(global.platformDir) + string(myCharDir) + "Data.ini");
                                            
                                            for (var f = 0; f <= global.maxUniqueItems; f++)
                                            {
                                                if (gotUniqueItem[f] > 0 && favoriteRelics[f] == 0)
                                                {
                                                    if (equippedUniqueItem[f] == 0 && myPetEquippedRelic[myPetID][f] == 0)
                                                    {
                                                        recycleGems += ((gotUniqueItem[f] + uniqueItemLevel[f]) - 1);
                                                        uniqueItemLevel[f] = 1;
                                                        gotUniqueItem[f] = 0;
                                                        ini_write_real("Relics", "Unique Item " + string(f) + " Level", uniqueItemLevel[f]);
                                                        ini_write_real("Relics", "Got Unique Item " + string(f), gotUniqueItem[f]);
                                                    }
                                                }
                                            }
                                            
                                            ini_close();
                                            ini_open(string(global.platformDir) + string(myAccDir) + "Character Data.ini");
                                            myGems += recycleGems;
                                            ini_write_real("Resources", "Gems", myGems);
                                            ini_close();
                                            
                                            if (obj_build_forge.alarm[1] == -1)
                                            {
                                                obj_build_forge.forgeItem[1][0] += recycleGems;
                                                
                                                if (obj_build_forge.forgeItem[1][0] >= obj_build_forge.forgeItem[1][1])
                                                {
                                                    obj_build_forge.alarm[1] = room_speed * 21601;
                                                    obj_build_forge.forgeItem[1][0] = obj_build_forge.forgeItem[1][1];
                                                }
                                            }
                                            else
                                            {
                                                obj_build_forge.alarm[1] += recycleGems * global.roomSpeed;
                                                
                                                if (obj_build_forge.alarm[1] > (room_speed * 21600))
                                                    obj_build_forge.alarm[1] = room_speed * 21600;
                                            }
                                            
                                            if (recycleGems > 0)
                                            {
                                                if (global.chatSpam <= 2)
                                                {
                                                    if (arg2 == 0)
                                                        gml_Script_twitch_chat_say("/me " + string(name) + " the blacksmith recycled all your unused and non favorite Relics. You received " + string(recycleGems) + " room00Gem for all of them! (" + string(obj_build_forge.forgeItem[1][1] - obj_build_forge.forgeItem[1][0]) + " Relics left to !!reforge).");
                                                }
                                            }
                                            else if (global.chatSpam <= 2)
                                            {
                                                if (arg2 == 0)
                                                    gml_Script_twitch_chat_say("/me " + string(name) + " you dont have any unused or non favorite Relics at the moment.");
                                            }
                                            
                                            gml_Script_scr_playsound(s_forge, 0.9, 1.1, 0.5);
                                            gml_Script_scr_playsound(s_armored, 0.9, 1.1, 0.5);
                                        }
                                    }
                                }
                            }
                            
                            if (obj_build_forge.alarm[1] == (room_speed * 21601))
                                gml_Script_twitch_chat_say_direct("/me The blacksmith collected enough materials to start crafting Relics! Type !reforge(Relic ID)*(amount to craft) to obtain your Relics (" + string((obj_build_forge.level - 13) * 2) + " uses per character).");
                        }
                        else if (arg2 == 0)
                        {
                            gml_Script_twitch_chat_say("/me " + string(uname) + " You need to upgrade the forge to level 13 to do that!");
                        }
                    }
                    else if (arg2 == 0)
                    {
                        gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
                    }
                    
                    exit;
                }
                
                if (string_pos("!enchant", _cmd) == 1)
                {
                    if (ds_list_find_index(global.playerList, uname) != -1)
                    {
                        if (instance_exists(obj_build_witchhut))
                        {
                            if (string_pos("*", _cmd) == 0)
                                exit;
                            
                            var _length = real(string_pos("*", _cmd));
                            var _index = string_digits(string_copy(_cmd, 1, _length));
                            
                            if (_index != "")
                                _index = real(_index);
                            else
                                exit;
                            
                            var _amount = string_digits(string_delete(_cmd, 1, _length));
                            
                            if (_amount != "")
                                _amount = real(_amount);
                            else
                                exit;
                            
                            show_debug_message("Enchant: id " + string(_index) + " - " + string(_amount) + "x");
                            var chooseRelic = _index;
                            var chooseAmount = _amount;
                            
                            if (obj_build_witchhut.alarm[0] != -1)
                            {
                                if (chooseRelic <= global.maxUniqueItems && chooseRelic != 0)
                                {
                                    with (obj_player)
                                    {
                                        if (name == other.uname)
                                        {
                                            if (uniqueItemCorruption[chooseRelic] != 1)
                                            {
                                                if (arg2 == 0)
                                                    gml_Script_twitch_chat_say("/me " + string(name) + " can not enchant a Relic once it has been corrupted.");
                                                
                                                exit;
                                            }
                                            
                                            if (state == UnknownEnum.Value_8)
                                            {
                                                if (arg2 == 0)
                                                    gml_Script_twitch_chat_say("/me " + string(name) + " you must be in town to enchant your Relics.");
                                                
                                                exit;
                                            }
                                            else if (gotUniqueItem[chooseRelic] > 1)
                                            {
                                                if (myGems >= uniqueItemLevel[chooseRelic])
                                                {
                                                    var totalGems = 0;
                                                    
                                                    for (_amount = 0; _amount < chooseAmount; _amount++)
                                                    {
                                                        if (gotUniqueItem[chooseRelic] > 1 && myGems >= uniqueItemLevel[chooseRelic])
                                                        {
                                                            myGems -= uniqueItemLevel[chooseRelic];
                                                            totalGems += uniqueItemLevel[chooseRelic];
                                                            uniqueItemLevel[chooseRelic] += 1;
                                                            gotUniqueItem[chooseRelic] -= 1;
                                                        }
                                                        else
                                                        {
                                                            break;
                                                        }
                                                    }
                                                    
                                                    with (gml_Script_instance_create(x, y, obj_playSound))
                                                    {
                                                        maxTimes = _amount;
                                                        sound = s_enchant1;
                                                    }
                                                    
                                                    gml_Script_scr_addDiaryProgress(7, _amount);
                                                    ini_open(string(global.platformDir) + string(myAccDir) + "Character Data.ini");
                                                    ini_write_real("Resources", "Gems", myGems);
                                                    ini_close();
                                                    ini_open(string(global.platformDir) + string(myCharDir) + "Data.ini");
                                                    ini_write_real("Relics", "Unique Item " + string(chooseRelic) + " Level", uniqueItemLevel[chooseRelic]);
                                                    ini_write_real("Relics", "Got Unique Item " + string(chooseRelic), gotUniqueItem[chooseRelic]);
                                                    ini_close();
                                                    
                                                    if (global.chatSpam <= 2)
                                                    {
                                                        if (arg2 == 0)
                                                            gml_Script_twitch_chat_say("/me " + string(name) + " you successfully enchanted (x" + string(_amount) + ") " + string(global.uniqueItem[chooseRelic][0]) + " to level " + string(uniqueItemLevel[chooseRelic]) + " for " + gml_Script_scr_bigNumber(totalGems) + " room00Gem ! (" + string(gotUniqueItem[chooseRelic]) + " units and " + gml_Script_scr_bigNumber(myGems) + " room00Gem left).");
                                                    }
                                                }
                                                else if (arg2 == 0)
                                                {
                                                    gml_Script_twitch_chat_say("/me " + string(name) + " you need " + string(uniqueItemLevel[chooseRelic] - myGems) + " more room00Gem to enchant Relic " + string(chooseRelic) + ".");
                                                }
                                            }
                                            else if (arg2 == 0)
                                            {
                                                gml_Script_twitch_chat_say("/me " + string(name) + " you must have at least 2 units of a Relic if you want to enchant it.");
                                            }
                                        }
                                    }
                                }
                                else if (arg2 == 0)
                                {
                                    gml_Script_twitch_chat_say("/me " + string(uname) + " The Relic you are trying to enchant does not exist or the command format is incorrect (!enchant #*#).");
                                }
                            }
                            else if (arg2 == 0)
                            {
                                gml_Script_twitch_chat_say("/me " + string(uname) + " The witch needs more souls to produce an enchantment.");
                            }
                        }
                    }
                    else if (arg2 == 0)
                    {
                        gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
                    }
                    
                    exit;
                }
                
                if (string_pos("!corrupt", _cmd) == 1)
                {
                    if (ds_list_find_index(global.playerList, uname) != -1)
                    {
                        if (instance_exists(obj_build_forge))
                        {
                            if ((obj_build_forge.level >= 20 && global.unlockCorrupted == true) || global.dev == true)
                            {
                                var _index = string_digits(_cmd);
                                
                                if (_index != "")
                                    _index = real(_index);
                                else
                                    exit;
                                
                                show_debug_message("Corrupt: id " + string(_index));
                                var chooseRelic = _index;
                                
                                if (global.bloodgems > 0)
                                {
                                    if (chooseRelic <= global.maxUniqueItems && chooseRelic != 0)
                                    {
                                        with (obj_player)
                                        {
                                            if (name == other.uname)
                                            {
                                                if (state == UnknownEnum.Value_8)
                                                {
                                                    if (arg2 == 0)
                                                        gml_Script_twitch_chat_say("/me " + string(name) + " you must be in town to corrupt your Relics.");
                                                    
                                                    exit;
                                                }
                                                else if (uniqueItemLevel[chooseRelic] >= 100)
                                                {
                                                    if (uniqueItemCorruption[chooseRelic] == 1)
                                                    {
                                                        global.bloodgems -= 1;
                                                        uniqueItemCorruption[chooseRelic] = random_range(0.5, global.maxRelicCorruption);
                                                        
                                                        if (uniqueItemCorruption[chooseRelic] == 1)
                                                            uniqueItemCorruption[chooseRelic] = 0.9;
                                                        
                                                        with (gml_Script_instance_create(x, y, obj_playSound))
                                                        {
                                                            maxTimes = 1;
                                                            sound = s_enchant1;
                                                            sound = s_forge;
                                                        }
                                                        
                                                        ini_open(string(global.platformDir) + string(myCharDir) + "Data.ini");
                                                        ini_write_real("Relics", "Unique Item " + string(chooseRelic) + " Corruption", uniqueItemCorruption[chooseRelic]);
                                                        ini_close();
                                                        
                                                        if (global.chatSpam <= 2)
                                                        {
                                                            if (arg2 == 0)
                                                                gml_Script_twitch_chat_say("/me " + string(name) + " you corrupted your level " + string(uniqueItemLevel[chooseRelic]) + " " + string(global.uniqueItem[chooseRelic][0]) + " for 1 Blood Gem, permanently modifying its power to x" + string(uniqueItemCorruption[chooseRelic]) + " [0.5 - " + string(global.maxRelicCorruption) + "].");
                                                        }
                                                    }
                                                    else if (arg2 == 0)
                                                    {
                                                        gml_Script_twitch_chat_say("/me " + string(name) + " each Relic can only be corrupted once... You can " + string(global.cmdPrefix) + "!purify it to remove its corruption, but at a high cost.");
                                                    }
                                                }
                                                else if (arg2 == 0)
                                                {
                                                    gml_Script_twitch_chat_say("/me " + string(name) + " your Relics must be enchanted to at least level 100 before corrupting them, otherwise they would not be able to handle corruption.");
                                                }
                                            }
                                        }
                                    }
                                    else if (arg2 == 0)
                                    {
                                        gml_Script_twitch_chat_say("/me " + string(uname) + " The Relic you are trying to corrupt does not exist or the command format is incorrect (!corrupt #).");
                                    }
                                }
                                else if (arg2 == 0)
                                {
                                    gml_Script_twitch_chat_say("/me " + string(uname) + " The Blacksmith needs more !!Blood Gems to corrupt your Relics.");
                                }
                            }
                        }
                    }
                    else if (arg2 == 0)
                    {
                        gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
                    }
                    
                    exit;
                }
                
                if (string_pos("!purify", _cmd) == 1)
                {
                    if (ds_list_find_index(global.playerList, uname) != -1)
                    {
                        if (instance_exists(obj_build_forge))
                        {
                            if ((obj_build_forge.level >= 20 && global.unlockCorrupted == true) || global.dev == true)
                            {
                                var _index = string_digits(_cmd);
                                
                                if (_index != "")
                                    _index = real(_index);
                                else
                                    exit;
                                
                                show_debug_message("Corrupt: id " + string(_index));
                                var chooseRelic = _index;
                                
                                if (chooseRelic <= global.maxUniqueItems && chooseRelic != 0)
                                {
                                    with (obj_player)
                                    {
                                        if (name == other.uname)
                                        {
                                            if (state == UnknownEnum.Value_8)
                                            {
                                                if (arg2 == 0)
                                                    gml_Script_twitch_chat_say("/me " + string(name) + " you must be in town to purify your Relics.");
                                                
                                                exit;
                                            }
                                            else if (uniqueItemCorruption[chooseRelic] != 1)
                                            {
                                                var _cost = 300 + (uniqueItemLevel[chooseRelic] * 5);
                                                
                                                if (myGems >= _cost)
                                                {
                                                    myGems -= _cost;
                                                    uniqueItemCorruption[chooseRelic] = 1;
                                                    
                                                    with (gml_Script_instance_create(x, y, obj_playSound))
                                                    {
                                                        maxTimes = 1;
                                                        sound = s_enchant1;
                                                        sound = s_forge;
                                                    }
                                                    
                                                    ini_open(string(global.platformDir) + string(myCharDir) + "Data.ini");
                                                    ini_key_delete("Relics", "Unique Item " + string(chooseRelic) + " Corruption");
                                                    ini_close();
                                                    
                                                    if (global.chatSpam <= 2)
                                                    {
                                                        if (arg2 == 0)
                                                            gml_Script_twitch_chat_say("/me " + string(name) + " you purified your level " + string(uniqueItemLevel[chooseRelic]) + " " + string(global.uniqueItem[chooseRelic][0]) + " for " + gml_Script_scr_bigNumber(_cost) + " room00Gem , restoring it back to its natural state (" + gml_Script_scr_bigNumber(myGems) + " room00Gem left).");
                                                    }
                                                }
                                                else if (arg2 == 0)
                                                {
                                                    gml_Script_twitch_chat_say("/me " + string(name) + " Purifying a corrupted Relic requires 300 room00Gem + 5 more per each enchantment level, you need " + gml_Script_scr_bigNumber(_cost - myGems) + " more room00Gem to purify your level " + string(uniqueItemLevel[chooseRelic]) + " " + string(global.uniqueItem[chooseRelic][0]) + ".");
                                                }
                                            }
                                            else if (arg2 == 0)
                                            {
                                                gml_Script_twitch_chat_say("/me " + string(name) + " You can only purify " + string(global.cmdPrefix) + "!corrupted Relics.");
                                            }
                                        }
                                    }
                                }
                                else if (arg2 == 0)
                                {
                                    gml_Script_twitch_chat_say("/me " + string(uname) + " The Relic you are trying to corrupt does not exist or the command format is incorrect (!corrupt #).");
                                }
                            }
                        }
                    }
                    else if (arg2 == 0)
                    {
                        gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
                    }
                    
                    exit;
                }
                
                if (string_pos("!craftgemstone", _cmd) == 1)
                {
                    if (ds_list_find_index(global.playerList, uname) != -1)
                    {
                        if (instance_exists(obj_build_witchhut))
                        {
                            if (obj_build_witchhut.level >= 2 || global.dev == true)
                            {
                                if (string_pos(":", _cmd) == 0)
                                    exit;
                                
                                var _length = real(string_pos(":", _cmd));
                                var _index = string_digits(string_copy(_cmd, 1, _length));
                                
                                if (_index != "")
                                    _index = real(_index);
                                else
                                    exit;
                                
                                var _size = string_digits(string_delete(_cmd, 1, _length));
                                _size = string_delete(_size, 2, 100);
                                
                                if (_size != "")
                                    _size = real(_size);
                                else
                                    exit;
                                
                                show_debug_message("Craft gem type " + string(_index) + " size " + string(_size));
                                var chooseGem = _index;
                                
                                if (chooseGem <= 6 && chooseGem != 0)
                                {
                                    if (_size <= 3 && _size != 0)
                                    {
                                        with (obj_player)
                                        {
                                            if (name == other.uname)
                                            {
                                                if (state == UnknownEnum.Value_8)
                                                {
                                                    if (arg2 == 0)
                                                        gml_Script_twitch_chat_say("/me " + string(name) + " you must be in town to craft gemstones.");
                                                    
                                                    exit;
                                                }
                                                else
                                                {
                                                    var _craftAmount = 1;
                                                    
                                                    if (string_pos("*", _cmd) != 0)
                                                    {
                                                        var _amountLength = real(string_pos("*", _cmd));
                                                        var _checkAmount = string_digits(string_copy(_cmd, _amountLength, 10));
                                                        
                                                        if (_checkAmount != "")
                                                            _checkAmount = real(_checkAmount);
                                                        
                                                        _craftAmount = _checkAmount;
                                                    }
                                                    
                                                    show_debug_message("Craft gem " + string(_craftAmount) + " times");
                                                    var _cost = 0;
                                                    var _goldCost = 1000000;
                                                    var _textSize = "";
                                                    var _textType = "";
                                                    
                                                    if (_size == 1)
                                                    {
                                                        _cost = 15000;
                                                        _textSize = "small";
                                                    }
                                                    
                                                    if (_size == 2 || _size == 3)
                                                        _cost = 4;
                                                    
                                                    if (_size == 2)
                                                        _textSize = "medium";
                                                    
                                                    if (_size == 3)
                                                        _textSize = "big";
                                                    
                                                    if (chooseGem == 1)
                                                        _textType = "constitution";
                                                    
                                                    if (chooseGem == 2)
                                                        _textType = "strength";
                                                    
                                                    if (chooseGem == 3)
                                                        _textType = "intelligence";
                                                    
                                                    if (chooseGem == 4)
                                                        _textType = "physical resistance";
                                                    
                                                    if (chooseGem == 5)
                                                        _textType = "special resistance";
                                                    
                                                    if (chooseGem == 6)
                                                        _textType = "status resistance";
                                                    
                                                    _goldCost *= power(1000, _size);
                                                    var _currency = myGems * 100;
                                                    
                                                    if (_size == 2 || _size == 3)
                                                        _currency = myGemstoneInfo[chooseGem - 1][_size - 2];
                                                    
                                                    if (_currency >= _cost)
                                                    {
                                                        if (mygold >= _goldCost)
                                                        {
                                                            var _successfulAmount = 0;
                                                            
                                                            repeat (_craftAmount)
                                                            {
                                                                if (_currency >= _cost && mygold >= _goldCost)
                                                                {
                                                                    _currency = myGems * 100;
                                                                    _successfulAmount += 1;
                                                                    mygold -= _goldCost;
                                                                    
                                                                    if (_size == 1)
                                                                    {
                                                                        if (myGems >= (_cost / 100))
                                                                            myGems -= (_cost / 100);
                                                                        else
                                                                            break;
                                                                    }
                                                                    
                                                                    if (_size == 2 || _size == 3)
                                                                    {
                                                                        if (myGemstoneInfo[chooseGem - 1][_size - 2] >= 4)
                                                                            myGemstoneInfo[chooseGem - 1][_size - 2] -= _cost;
                                                                        else
                                                                            break;
                                                                    }
                                                                    
                                                                    myGemstoneInfo[chooseGem - 1][_size - 1] += 1;
                                                                    
                                                                    with (gml_Script_instance_create(x, y, obj_playSound))
                                                                    {
                                                                        maxTimes = 1;
                                                                        sound = s_enchant1;
                                                                        sound = s_forge;
                                                                    }
                                                                    
                                                                    show_debug_message("Converted " + string(_cost) + " into 1 " + string(_textSize) + " " + string(_textType) + " gemstone");
                                                                    ini_open(string(global.platformDir) + string(myAccDir) + "Character Data.ini");
                                                                    ini_write_real("Gemstones", "Stat " + string(chooseGem) + " Size " + string(_size - 1), myGemstoneInfo[chooseGem - 1][_size - 1]);
                                                                    
                                                                    if (_size == 2 || _size == 3)
                                                                        ini_write_real("Gemstones", "Stat " + string(chooseGem) + " Size " + string(_size - 2), myGemstoneInfo[chooseGem - 1][_size - 2]);
                                                                    
                                                                    ini_close();
                                                                    ini_open(string(global.platformDir) + string(myAccDir) + "Character Data.ini");
                                                                    
                                                                    if (_size == 1)
                                                                        ini_write_real("Resources", "Gems", myGems);
                                                                    
                                                                    ini_close();
                                                                }
                                                                else
                                                                {
                                                                    break;
                                                                }
                                                            }
                                                            
                                                            var _multipleString = "";
                                                            
                                                            if (_successfulAmount > 1)
                                                                _multipleString = "s";
                                                            
                                                            if (_size == 1 && arg2 == 0)
                                                                gml_Script_twitch_chat_say("/me " + string(name) + " you crafted x" + string(_successfulAmount) + " " + string(_textSize) + " " + string(_textType) + " gemstone" + string(_multipleString) + " for " + gml_Script_scr_bigNumber(_cost * _successfulAmount) + " gem dust (" + gml_Script_scr_bigNumber((_cost / 100) * _successfulAmount) + " room00Gem ) and " + gml_Script_scr_bigNumber(_goldCost * _successfulAmount) + " gold! (" + gml_Script_scr_bigNumber(myGems) + " room00Gem and " + gml_Script_scr_bigNumber(mygold) + " gold left).");
                                                            
                                                            if (_size == 2 && arg2 == 0)
                                                                gml_Script_twitch_chat_say("/me " + string(name) + " you crafted x" + string(_successfulAmount) + " precious " + string(_textSize) + " " + string(_textType) + " gemstone" + string(_multipleString) + " for " + string(_cost * _successfulAmount) + " small gemstones and " + gml_Script_scr_bigNumber(_goldCost * _successfulAmount) + " gold!");
                                                            
                                                            if (_size == 3 && arg2 == 0)
                                                                gml_Script_twitch_chat_say("/me " + string(name) + " you crafted x" + string(_successfulAmount) + " perfect " + string(_textSize) + " " + string(_textType) + " gemstone" + string(_multipleString) + " for " + string(_cost * _successfulAmount) + " medium gemstones and " + gml_Script_scr_bigNumber(_goldCost * _successfulAmount) + " gold!!");
                                                        }
                                                        else if (arg2 == 0)
                                                        {
                                                            gml_Script_twitch_chat_say("/me " + string(name) + " You need " + gml_Script_scr_bigNumber(_goldCost - mygold) + " more gold to craft a " + string(_textSize) + " " + string(_textType) + " gemstone.");
                                                        }
                                                    }
                                                    else
                                                    {
                                                        if (_size == 1 && arg2 == 0)
                                                            gml_Script_twitch_chat_say("/me " + string(name) + " You would need " + gml_Script_scr_bigNumber(_cost - (myGems * 100)) + " (or " + gml_Script_scr_bigNumber((_cost / 100) - myGems) + " room00Gem ) more gem dust to craft this gemstone. (1 gem = 100 gem dust).");
                                                        
                                                        if (_size == 2 && arg2 == 0)
                                                            gml_Script_twitch_chat_say("/me " + string(name) + " You need " + gml_Script_scr_bigNumber(_cost - _currency) + " more small " + string(_textType) + " gemstones to craft a medium gemstone.");
                                                        
                                                        if (_size == 3 && arg2 == 0)
                                                            gml_Script_twitch_chat_say("/me " + string(name) + " You need " + gml_Script_scr_bigNumber(_cost - _currency) + " more medium " + string(_textType) + " gemstones to craft a big gemstone.");
                                                    }
                                                }
                                            }
                                        }
                                    }
                                    else if (arg2 == 0)
                                    {
                                        gml_Script_twitch_chat_say("/me " + string(uname) + " The gemstone size you are trying to craft doest not exist (1 = small, 2 = medium, 3 = big).");
                                    }
                                }
                                else if (arg2 == 0)
                                {
                                    gml_Script_twitch_chat_say("/me " + string(uname) + " The gemstone type you are trying to craft doest not exist (1 = constitution, 2 = strength, 3 = intelligence, 4 = physical resistance, 5 = special resistance, 6 = status resistance).");
                                }
                            }
                            else if (arg2 == 0)
                            {
                                gml_Script_twitch_chat_say("/me " + string(uname) + " You must upgrade the Witch Hut to level 2 to unlock gem cutting.");
                            }
                        }
                    }
                    else if (arg2 == 0)
                    {
                        gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
                    }
                    
                    exit;
                }
                
                if (string_pos("!setgemstone", _cmd) == 1 || string_pos("!removegemstone", _cmd) == 1 || string_pos("!insertgemstone", _cmd) == 1 || string_pos("!equipgemstone", _cmd) == 1)
                {
                    if (ds_list_find_index(global.playerList, uname) != -1)
                    {
                        var _index, _slot;
                        
                        if (string_pos("!setgemstone", _cmd) == 1)
                        {
                            if (string_pos(":", _cmd) == 0)
                                exit;
                            
                            var _length = real(string_pos(":", _cmd));
                            _index = string_digits(string_copy(_cmd, 1, _length));
                            
                            if (_index != "")
                                _index = real(_index);
                            else
                                exit;
                            
                            _slot = string_digits(string_delete(_cmd, 1, _length));
                            
                            if (_slot != "")
                                _slot = real(_slot);
                            else
                                exit;
                            
                            show_debug_message("Gemstone: stat " + string(_index) + " - item slot " + string(_slot));
                        }
                        else
                        {
                            _slot = string_digits(_cmd);
                            
                            if (_slot != "")
                                _slot = real(_slot);
                            else
                                exit;
                            
                            _index = 0;
                        }
                        
                        var gemType = _index;
                        var _textType = "";
                        var _textSize = "";
                        
                        if (gemType == 1)
                            _textType = "Constitution";
                        
                        if (gemType == 2)
                            _textType = "Strength";
                        
                        if (gemType == 3)
                            _textType = "Intelligence";
                        
                        if (gemType == 4)
                            _textType = "Physical Resistance";
                        
                        if (gemType == 5)
                            _textType = "Special Resistance";
                        
                        if (gemType == 6)
                            _textType = "Status Resistance";
                        
                        var _readable = _slot;
                        _slot -= 1;
                        var _temp = _slot;
                        
                        if (_slot == 0)
                            _temp = 3;
                        
                        if (_slot == 1)
                            _temp = 8;
                        
                        if (_slot == 2)
                            _temp = 6;
                        
                        if (_slot == 3)
                            _temp = 7;
                        
                        if (_slot == 4)
                            _temp = 0;
                        
                        if (_slot == 5)
                            _temp = 5;
                        
                        if (_slot == 6)
                            _temp = 4;
                        
                        if (_slot == 7)
                            _temp = 1;
                        
                        if (_slot == 8)
                            _temp = 2;
                        
                        if (_slot == 9)
                            _temp = 9;
                        
                        _slot = _temp + 1;
                        
                        with (obj_player)
                        {
                            if (name == other.uname)
                            {
                                if (_slot > 0 && _slot <= 10)
                                {
                                    show_debug_message("Gemstone: item id check");
                                    
                                    if (gemType <= 6 && gemType >= 0)
                                    {
                                        show_debug_message("Gemstone: gemstone id check");
                                        
                                        if (gemType > 0)
                                        {
                                            show_debug_message("Gemstone: free slot check");
                                            var _type = [];
                                            var _gotAny = 0;
                                            
                                            for (var gs = 0; gs <= 2; gs++)
                                            {
                                                _type[gs] = myGemstoneInfo[gemType - 1][gs];
                                                show_debug_message(string("Gemstone: checking all available, size " + string(gs) + ": " + string(_type[gs])));
                                                
                                                if (_type[gs] > 0)
                                                    _gotAny = 1;
                                            }
                                            
                                            if (_gotAny > 0)
                                            {
                                                if (state == UnknownEnum.Value_8)
                                                {
                                                    if (arg2 == 0)
                                                        gml_Script_twitch_chat_say("/me " + string(name) + " You must be in town to change your gear's gemstones.");
                                                    
                                                    exit;
                                                }
                                                
                                                var _oldGem = myItemInfo[_slot - 1][6];
                                                var _oldSize = 0;
                                                var _oldText1 = "";
                                                var _oldText2 = "";
                                                var _oldgemStat = 0;
                                                var _oldPct = 0;
                                                var _slotBonus = ((_slot - 1) == 0 || (_slot - 1) == 9) ? 2 : 1;
                                                
                                                if (_oldGem != 0)
                                                {
                                                    _oldSize = myItemInfo[_slot - 1][7];
                                                    myGemstoneInfo[_oldGem - 1][_oldSize] += 1;
                                                    
                                                    if (_oldGem == 1)
                                                        _oldText1 = "Constitution";
                                                    
                                                    if (_oldGem == 2)
                                                        _oldText1 = "Strength";
                                                    
                                                    if (_oldGem == 3)
                                                        _oldText1 = "Intelligence";
                                                    
                                                    if (_oldGem == 4)
                                                        _oldText1 = "Physical Resistance";
                                                    
                                                    if (_oldGem == 5)
                                                        _oldText1 = "Special Resistance";
                                                    
                                                    if (_oldGem == 6)
                                                        _oldText1 = "Status Resistance";
                                                    
                                                    if (_oldSize == 0)
                                                        _oldText2 = "Small";
                                                    
                                                    if (_oldSize == 1)
                                                        _oldText2 = "Medium";
                                                    
                                                    if (_oldSize == 2)
                                                        _oldText2 = "Big";
                                                    
                                                    if (_oldGem == 1)
                                                        _oldgemStat = 8;
                                                    
                                                    if (_oldGem == 2)
                                                        _oldgemStat = 0;
                                                    
                                                    if (_oldGem == 3)
                                                        _oldgemStat = 9;
                                                    
                                                    if (_oldGem == 4)
                                                        _oldgemStat = 1;
                                                    
                                                    if (_oldGem == 5)
                                                        _oldgemStat = 2;
                                                    
                                                    if (_oldGem == 6)
                                                        _oldgemStat = 3;
                                                    
                                                    _oldPct = 0.02 * (1 + _oldSize) * _slotBonus;
                                                }
                                                
                                                myItemInfo[_slot - 1][6] = gemType;
                                                var _bestSize = 0;
                                                
                                                for (var gs = 2; gs >= 0; gs--)
                                                {
                                                    if (_type[gs] > 0)
                                                    {
                                                        _bestSize = gs;
                                                        myItemInfo[_slot - 1][7] = _bestSize;
                                                        myGemstoneInfo[gemType - 1][_bestSize] -= 1;
                                                        
                                                        if (_bestSize == 0)
                                                            _textSize = "Small";
                                                        
                                                        if (_bestSize == 1)
                                                            _textSize = "Medium";
                                                        
                                                        if (_bestSize == 2)
                                                            _textSize = "Big";
                                                        
                                                        show_debug_message(string(_textSize) + " " + string(_textType) + " gemstone equipped on item " + string(_slot));
                                                        break;
                                                    }
                                                }
                                                
                                                var _gemStat = 0;
                                                
                                                if (gemType == 1)
                                                    _gemStat = 8;
                                                
                                                if (gemType == 2)
                                                    _gemStat = 0;
                                                
                                                if (gemType == 3)
                                                    _gemStat = 9;
                                                
                                                if (gemType == 4)
                                                    _gemStat = 1;
                                                
                                                if (gemType == 5)
                                                    _gemStat = 2;
                                                
                                                if (gemType == 6)
                                                    _gemStat = 3;
                                                
                                                var _newPct = 0.02 * (1 + _bestSize) * _slotBonus;
                                                var _oldStat = myStatInfo[_gemStat][3];
                                                
                                                if (gemType > 3)
                                                    _oldStat = myResistance[0][_gemStat];
                                                
                                                var _oldStat2 = (_oldGem != 0) ? myStatInfo[_oldgemStat][3] : 0;
                                                
                                                if (_oldGem > 3)
                                                    _oldStat2 = myResistance[0][_oldgemStat];
                                                
                                                gml_Script_scr_updateStats();
                                                var _statGain = _oldStat * _newPct;
                                                
                                                if (gemType > 3)
                                                    _statGain = _newPct;
                                                
                                                var _statLoss = (_oldGem != 0) ? (_oldStat2 * _oldPct) : 0;
                                                
                                                if (_oldGem > 3)
                                                    _statLoss = _oldPct;
                                                
                                                if (_statGain < 0.15)
                                                    _statGain = string(round(_statGain * 100)) + "%";
                                                else
                                                    _statGain = gml_Script_scr_bigNumber(_statGain);
                                                
                                                if (_statLoss < 0.15)
                                                    _statLoss = string(round(_statLoss * 100)) + "%";
                                                else
                                                    _statLoss = gml_Script_scr_bigNumber(_statLoss);
                                                
                                                show_debug_message("stats on gemstone change: " + gml_Script_scr_bigNumber(_oldStat) + " " + string(_textType) + " -> " + gml_Script_scr_bigNumber(myStatInfo[_gemStat][3]));
                                                ini_open(string(global.platformDir) + string(myCharDir) + "Data.ini");
                                                ini_write_real("Items", "Item " + string(_slot - 1) + " Gemstone Type", myItemInfo[_slot - 1][6]);
                                                ini_write_real("Items", "Item " + string(_slot - 1) + " Gemstone Size", myItemInfo[_slot - 1][7]);
                                                ini_close();
                                                ini_open(string(global.platformDir) + string(myAccDir) + "Character Data.ini");
                                                ini_write_real("Gemstones", "Stat " + string(gemType) + " Size " + string(_bestSize), myGemstoneInfo[gemType - 1][_bestSize]);
                                                
                                                if (_oldGem != 0)
                                                    ini_write_real("Gemstones", "Stat " + string(_oldGem) + " Size " + string(_oldSize), myGemstoneInfo[_oldGem - 1][_oldSize]);
                                                
                                                ini_close();
                                                
                                                if (arg2 == 0)
                                                {
                                                    if (_oldGem == 0)
                                                    {
                                                        gml_Script_twitch_chat_say("/me " + string(name) + " " + string(_textSize) + " " + string(_textType) + " gemstone inserted successfully on your " + string(global.globalItemInfo[_slot - 1][0]) + " [+" + string(_statGain) + " " + string(_textType) + "].");
                                                    }
                                                    else if (_oldgemStat == _gemStat)
                                                    {
                                                        var _net = _statGain - _statLoss;
                                                        
                                                        if (_net < 0.15)
                                                            _net = string(round(_net * 100)) + "%";
                                                        else
                                                            _net = gml_Script_scr_bigNumber(_net);
                                                        
                                                        if (_net != 0)
                                                            gml_Script_twitch_chat_say("/me " + string(name) + " You replaced your " + string(global.globalItemInfo[_slot - 1][0]) + " " + string(_oldText2) + " " + string(_oldText1) + " gemstone for a " + string(_textSize) + " one [+" + string(_net) + " " + string(_textType) + "].");
                                                    }
                                                    else
                                                    {
                                                        gml_Script_twitch_chat_say("/me " + string(name) + " You replaced your " + string(global.globalItemInfo[_slot - 1][0]) + " " + string(_oldText2) + " " + string(_oldText1) + " gemstone for a " + string(_textSize) + " " + string(_textType) + " one [-" + string(_statLoss) + " " + string(_oldText1) + ", +" + string(_statGain) + " " + string(_textType) + "].");
                                                    }
                                                }
                                            }
                                            else if (arg2 == 0)
                                            {
                                                gml_Script_twitch_chat_say("/me " + string(name) + " You don't have any " + string(_textSize) + " " + string(_textType) + " gemstone, you can craft them with !craftgemstone (type)*(size) at the Witch Hut (level 2+).");
                                            }
                                        }
                                        else
                                        {
                                            gemType = 0;
                                            
                                            if (myItemInfo[_slot - 1][6] != 0)
                                            {
                                                show_debug_message("Gemstone: used slot " + string(_slot - 1) + " check");
                                                
                                                if (state == UnknownEnum.Value_8)
                                                {
                                                    if (arg2 == 0)
                                                        gml_Script_twitch_chat_say("/me " + string(name) + " You must be in town to remove your gear's gemstones.");
                                                    
                                                    exit;
                                                }
                                                
                                                if (myItemInfo[_slot - 1][6] == 1)
                                                    _textType = "Constitution";
                                                
                                                if (myItemInfo[_slot - 1][6] == 2)
                                                    _textType = "Strength";
                                                
                                                if (myItemInfo[_slot - 1][6] == 3)
                                                    _textType = "Intelligence";
                                                
                                                if (myItemInfo[_slot - 1][6] == 4)
                                                    _textType = "Physical Resistance";
                                                
                                                if (myItemInfo[_slot - 1][6] == 5)
                                                    _textType = "Special Resistance";
                                                
                                                if (myItemInfo[_slot - 1][6] == 6)
                                                    _textType = "Status Resistance";
                                                
                                                if (myItemInfo[_slot - 1][7] == 0)
                                                    _textSize = "Small";
                                                
                                                if (myItemInfo[_slot - 1][7] == 1)
                                                    _textSize = "Medium";
                                                
                                                if (myItemInfo[_slot - 1][7] == 2)
                                                    _textSize = "Big";
                                                
                                                show_debug_message(string(_textSize) + " " + string(_textType) + " Gemstone: used on item " + string(global.globalItemInfo[_slot - 1][0]));
                                                show_debug_message("Removing gemstone '" + string(myItemInfo[_slot - 1][6]) + ":" + string(myItemInfo[_slot - 1][7]));
                                                myGemstoneInfo[myItemInfo[_slot - 1][6] - 1][myItemInfo[_slot - 1][7]] += 1;
                                                ini_open(string(global.platformDir) + string(myAccDir) + "Character Data.ini");
                                                ini_write_real("Gemstones", "Stat " + string(myItemInfo[_slot - 1][6]) + " Size " + string(myItemInfo[_slot - 1][7]), myGemstoneInfo[myItemInfo[_slot - 1][6] - 1][myItemInfo[_slot - 1][7]]);
                                                ini_close();
                                                ini_open(string(global.platformDir) + string(myCharDir) + "Data.ini");
                                                var _gemStat = 0;
                                                
                                                if (myItemInfo[_slot - 1][6] == 1)
                                                    _gemStat = 8;
                                                
                                                if (myItemInfo[_slot - 1][6] == 2)
                                                    _gemStat = 0;
                                                
                                                if (myItemInfo[_slot - 1][6] == 3)
                                                    _gemStat = 9;
                                                
                                                if (myItemInfo[_slot - 1][6] == 4)
                                                    _gemStat = 1;
                                                
                                                if (myItemInfo[_slot - 1][6] == 5)
                                                    _gemStat = 2;
                                                
                                                if (myItemInfo[_slot - 1][6] == 6)
                                                    _gemStat = 3;
                                                
                                                var _oldStat = myStatInfo[_gemStat][3];
                                                
                                                if (_gemStat == 1 || _gemStat == 2 || _gemStat == 3)
                                                    _oldStat = myResistance[0][_gemStat];
                                                
                                                show_debug_message("old gemstone resitance: " + string(_oldStat));
                                                myItemInfo[_slot - 1][6] = 0;
                                                myItemInfo[_slot - 1][7] = 0;
                                                ini_key_delete("Items", "Item " + string(_slot - 1) + " Gemstone Type");
                                                ini_key_delete("Items", "Item " + string(_slot - 1) + " Gemstone Size");
                                                gml_Script_scr_updateStats();
                                                var _newStat = myStatInfo[_gemStat][3];
                                                
                                                if (_gemStat == 1 || _gemStat == 2 || _gemStat == 3)
                                                    _newStat = myResistance[0][_gemStat];
                                                
                                                show_debug_message("new gemstone resitance: " + string(_oldStat));
                                                var _statLoss = _newStat - _oldStat;
                                                show_debug_message("gemstone resitance loss: " + string(_statLoss));
                                                
                                                if (_statLoss < 0.15)
                                                    _statLoss = string(round(_statLoss * 100)) + "%";
                                                else
                                                    _statLoss = gml_Script_scr_bigNumber(_statLoss);
                                                
                                                show_debug_message("gemstone resitance loss (format): " + string(_statLoss));
                                                ini_close();
                                                
                                                if (arg2 == 0)
                                                    gml_Script_twitch_chat_say("/me " + string(name) + " " + string(_textSize) + " " + string(_textType) + " gemstone removed successfully from your " + string(global.globalItemInfo[_slot - 1][0]) + " [-" + string(_statLoss) + " " + string(_textType) + "].");
                                            }
                                        }
                                    }
                                    
                                    gml_Script_scr_updateStats();
                                }
                                else if (arg2 == 0)
                                {
                                    gml_Script_twitch_chat_say("/me " + string(name) + " please enter a valid item ID slot (1 to 10).");
                                }
                            }
                        }
                    }
                    else if (arg2 == 0)
                    {
                        gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
                    }
                    
                    exit;
                }
                
                if (string_pos("!crushgemstone", _cmd) == 1)
                {
                    if (ds_list_find_index(global.playerList, uname) != -1)
                    {
                        if (instance_exists(obj_build_witchhut))
                        {
                            if (obj_build_witchhut.level >= 2 || global.dev == true)
                            {
                                if (string_pos(":", _cmd) == 0)
                                    exit;
                                
                                var _length = real(string_pos(":", _cmd));
                                var _index = string_digits(string_copy(_cmd, 1, _length));
                                
                                if (_index != "")
                                    _index = real(_index);
                                else
                                    exit;
                                
                                var _size = string_digits(string_delete(_cmd, 1, _length));
                                _size = string_delete(_size, 2, 100);
                                
                                if (_size != "")
                                    _size = real(_size);
                                else
                                    exit;
                                
                                show_debug_message("Crush gem type " + string(_index) + " size " + string(_size));
                                var chooseGem = _index;
                                
                                if (chooseGem <= 6 && chooseGem != 0)
                                {
                                    if (_size <= 3 && _size != 0)
                                    {
                                        with (obj_player)
                                        {
                                            if (name == other.uname)
                                            {
                                                if (state == UnknownEnum.Value_8)
                                                {
                                                    if (arg2 == 0)
                                                        gml_Script_twitch_chat_say("/me " + string(name) + " you must be in town to crush gemstones.");
                                                    
                                                    exit;
                                                }
                                                else
                                                {
                                                    var _crushAmount = 1;
                                                    
                                                    if (string_pos("*", _cmd) != 0)
                                                    {
                                                        var _amountLength = real(string_pos("*", _cmd));
                                                        var _checkAmount = string_digits(string_copy(_cmd, _amountLength, 10));
                                                        
                                                        if (_checkAmount != "")
                                                            _checkAmount = real(_checkAmount);
                                                        
                                                        _crushAmount = _checkAmount;
                                                    }
                                                    
                                                    show_debug_message("Crush gem " + string(_crushAmount) + " times");
                                                    var _returnGems = 0;
                                                    var _textSize = "";
                                                    var _textType = "";
                                                    
                                                    if (_size == 1)
                                                    {
                                                        _textSize = "small";
                                                        _returnGems = 150;
                                                    }
                                                    
                                                    if (_size == 2)
                                                    {
                                                        _textSize = "medium";
                                                        _returnGems = 600;
                                                    }
                                                    
                                                    if (_size == 3)
                                                    {
                                                        _textSize = "big";
                                                        _returnGems = 2400;
                                                    }
                                                    
                                                    if (chooseGem == 1)
                                                        _textType = "constitution";
                                                    
                                                    if (chooseGem == 2)
                                                        _textType = "strength";
                                                    
                                                    if (chooseGem == 3)
                                                        _textType = "intelligence";
                                                    
                                                    if (chooseGem == 4)
                                                        _textType = "physical resistance";
                                                    
                                                    if (chooseGem == 5)
                                                        _textType = "special resistance";
                                                    
                                                    if (chooseGem == 6)
                                                        _textType = "status resistance";
                                                    
                                                    var _currentGems = myGemstoneInfo[chooseGem - 1][_size - 1];
                                                    
                                                    if (_currentGems > 0)
                                                    {
                                                        var _actualCrushAmount = min(_crushAmount, _currentGems);
                                                        var _successfulAmount = 0;
                                                        
                                                        repeat (_actualCrushAmount)
                                                        {
                                                            if (myGemstoneInfo[chooseGem - 1][_size - 1] >= 1)
                                                            {
                                                                _successfulAmount += 1;
                                                                myGemstoneInfo[chooseGem - 1][_size - 1] -= 1;
                                                                myGems += _returnGems;
                                                                
                                                                with (gml_Script_instance_create(x, y, obj_playSound))
                                                                {
                                                                    maxTimes = 1;
                                                                    sound = s_forge;
                                                                }
                                                                
                                                                show_debug_message("Crushed 1 " + string(_textSize) + " " + string(_textType) + " gemstone → +" + string(_returnGems) + " gems");
                                                                ini_open(string(global.platformDir) + string(myAccDir) + "Character Data.ini");
                                                                ini_write_real("Gemstones", "Stat " + string(chooseGem) + " Size " + string(_size - 1), myGemstoneInfo[chooseGem - 1][_size - 1]);
                                                                ini_write_real("Resources", "Gems", myGems);
                                                                ini_close();
                                                            }
                                                            else
                                                            {
                                                                break;
                                                            }
                                                        }
                                                        
                                                        var _multipleString = "";
                                                        
                                                        if (_successfulAmount > 1)
                                                            _multipleString = "s";
                                                        
                                                        var _totalGemsReturned = _returnGems * _successfulAmount;
                                                        var _gemDust = _totalGemsReturned * 100;
                                                        var _qualityPrefix = "";
                                                        
                                                        if (_size == 2)
                                                            _qualityPrefix = "precious ";
                                                        
                                                        if (_size == 3)
                                                            _qualityPrefix = "perfect ";
                                                        
                                                        if (arg2 == 0)
                                                            gml_Script_twitch_chat_say("/me " + string(name) + " you crushed x" + string(_successfulAmount) + " " + string(_qualityPrefix) + string(_textSize) + " " + string(_textType) + " gemstone" + string(_multipleString) + " and recovered " + gml_Script_scr_bigNumber(_gemDust) + " gem dust (" + gml_Script_scr_bigNumber(_totalGemsReturned) + " room00Gem )! (" + gml_Script_scr_bigNumber(myGems) + " room00Gem available).");
                                                    }
                                                    else if (arg2 == 0)
                                                    {
                                                        gml_Script_twitch_chat_say("/me " + string(name) + " You don't have any " + string(_textSize) + " " + string(_textType) + " gemstones to crush.");
                                                    }
                                                }
                                            }
                                        }
                                    }
                                    else if (arg2 == 0)
                                    {
                                        gml_Script_twitch_chat_say("/me " + string(uname) + " The gemstone size you are trying to crush does not exist (1 = small, 2 = medium, 3 = big).");
                                    }
                                }
                                else if (arg2 == 0)
                                {
                                    gml_Script_twitch_chat_say("/me " + string(uname) + " The gemstone type you are trying to crush does not exist (1 = constitution, 2 = strength, 3 = intelligence, 4 = physical resistance, 5 = special resistance, 6 = status resistance).");
                                }
                            }
                            else if (arg2 == 0)
                            {
                                gml_Script_twitch_chat_say("/me " + string(uname) + " You must upgrade the Witch Hut to level 2 to unlock gem crushing.");
                            }
                        }
                    }
                    else if (arg2 == 0)
                    {
                        gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
                    }
                    
                    exit;
                }
                
                if (string_pos("!redeem", _cmd) == 1)
                {
                    if (ds_list_find_index(global.playerList, uname) != -1)
                    {
                        with (obj_player)
                        {
                            if (name == other.uname)
                            {
                                if (state == UnknownEnum.Value_8)
                                {
                                    if (arg2 == 0)
                                        gml_Script_twitch_chat_say("/me " + string(name) + " you must be in town to redeem an item from the Honor Shop.");
                                    
                                    exit;
                                }
                                else
                                {
                                    var chooseAmount = 0;
                                    var buyItem;
                                    
                                    if (string_pos("*", _cmd) != 0)
                                    {
                                        var _length = real(string_pos("*", _cmd));
                                        var _index = string_digits(string_copy(_cmd, 1, _length));
                                        
                                        if (_index != "")
                                            _index = real(_index);
                                        else
                                            exit;
                                        
                                        var _amount = string_digits(string_delete(_cmd, 1, _length));
                                        
                                        if (_amount != "")
                                            _amount = real(_amount);
                                        else
                                            exit;
                                        
                                        show_debug_message("Buy: item " + string(_index) + " - " + string(_amount) + "x");
                                        buyItem = _index;
                                        chooseAmount = _amount;
                                        
                                        if (string_digits(buyItem) == "")
                                            buyItem = 0;
                                        else
                                            buyItem = real(string_digits(buyItem));
                                        
                                        if (string_digits(chooseAmount) == "")
                                            chooseAmount = 1;
                                        else
                                            chooseAmount = real(string_digits(chooseAmount));
                                    }
                                    else if (string_digits(_cmd) == "")
                                    {
                                        buyItem = 0;
                                        chooseAmount = 1;
                                    }
                                    else
                                    {
                                        buyItem = real(string_digits(_cmd));
                                        chooseAmount = 1;
                                    }
                                    
                                    show_debug_message("Reedeming " + string(chooseAmount) + "x item " + string(buyItem));
                                    
                                    if (buyItem < global.honorItems && buyItem > 0)
                                        gml_Script_scr_redeemHonor(buyItem, chooseAmount);
                                    else if (arg2 == 0)
                                        gml_Script_twitch_chat_say("/me " + string(name) + " Honor Shop Item " + string(buyItem) + " does not exist! NotLikeThis");
                                }
                            }
                        }
                    }
                    else if (arg2 == 0)
                    {
                        gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
                    }
                    
                    exit;
                }
                
                if ((string_pos("!buy", _cmd) == 1 || string_pos("buy", _cmd) == 1) && instance_exists(obj_build_shop))
                {
                    if (ds_list_find_index(global.playerList, uname) != -1)
                    {
                        var chooseAmount = 1;
                        var buyItem;
                        
                        if (string_pos("*", _cmd) != 0)
                        {
                            var _length = real(string_pos("*", _cmd));
                            var _index = string_digits(string_copy(_cmd, 1, _length));
                            
                            if (_index != "")
                                _index = real(_index);
                            else
                                exit;
                            
                            var _amount = string_digits(string_delete(_cmd, 1, _length));
                            
                            if (_amount != "")
                                _amount = real(_amount);
                            else
                                exit;
                            
                            show_debug_message("Buy: slot " + string(_index) + " - " + string(_amount) + "x");
                            buyItem = _index;
                            chooseAmount = _amount;
                            
                            if (string_digits(buyItem) == "")
                                buyItem = 0;
                            else
                                buyItem = real(string_digits(buyItem));
                            
                            if (string_digits(chooseAmount) == "")
                                chooseAmount = 1;
                            else
                                chooseAmount = real(string_digits(chooseAmount));
                        }
                        else if (string_digits(_cmd) == "")
                        {
                            buyItem = 0;
                            chooseAmount = 1;
                        }
                        else
                        {
                            buyItem = real(string_digits(_cmd));
                            chooseAmount = 1;
                        }
                        
                        with (obj_player)
                        {
                            if (name == other.uname)
                            {
                                if (state == UnknownEnum.Value_8)
                                {
                                    if (arg2 == 0)
                                        gml_Script_twitch_chat_say("/me " + string(name) + " you must be in town to purchase an item.");
                                    
                                    exit;
                                }
                            }
                        }
                        
                        if (buyItem <= instance_number(obj_itemBuy) && buyItem > 0)
                        {
                            with (obj_player)
                            {
                                if (name == other.uname)
                                {
                                    var tellItemType = obj_build_shop.itemRealType[buyItem];
                                    var tellItemCost = floor(obj_build_shop.itemCost[buyItem] * costReduction);
                                    var tellItemName = obj_build_shop.itemName[buyItem];
                                    
                                    if (tellItemType == 0)
                                    {
                                        var tellItem = obj_build_shop._itemType[buyItem];
                                        var tellItemTier = obj_build_shop.itemTier[buyItem];
                                        var tellItemSubTier = obj_build_shop.itemSubTier[buyItem];
                                        var tellItemLevel = obj_build_shop.itemLevel[buyItem];
                                        
                                        if (myItemInfo[tellItem][0] > tellItemTier || (myItemInfo[tellItem][0] == tellItemTier && myItemInfo[tellItem][1] >= tellItemSubTier))
                                        {
                                            if (arg2 == 0)
                                                gml_Script_twitch_chat_say("/me " + string(name) + " your current equipment is better than item nº" + string(buyItem) + "...");
                                            
                                            exit;
                                        }
                                        else if (mygold >= tellItemCost && level >= tellItemLevel)
                                        {
                                            gml_Script_scr_playsound(choose(s_equip1, s_equip2, s_equip3, s_equip4), 0.9, 1.1, 1);
                                            gml_Script_scr_playsound(choose(s_buy1, s_buy2, s_buy3), 0.9, 1.1, 1);
                                            mygold -= tellItemCost;
                                            gml_Script_scr_townXP(round(tellItemCost / costReduction));
                                            myItemInfo[tellItem][0] = tellItemTier;
                                            myItemInfo[tellItem][1] = tellItemSubTier;
                                            gml_Script_scr_updatePlayerItems();
                                            
                                            if (global.chatSpam <= 2)
                                            {
                                                if (arg2 == 0)
                                                    gml_Script_twitch_chat_say("/me " + string(name) + " has bought Tier " + string(myItemInfo[tellItem][0]) + " [" + string(myItemInfo[tellItem][2]) + "] " + string(myItemInfo[tellItem][4]) + " for " + gml_Script_scr_bigNumber(tellItemCost) + " gold from the town shop! (item nº" + string(buyItem) + "). You now have " + gml_Script_scr_bigNumber(mygold) + " gold.");
                                            }
                                        }
                                        else if (global.chatSpam <= 2)
                                        {
                                            if (arg2 == 0)
                                                gml_Script_twitch_chat_say("/me " + string(name) + " You can't buy this item. Either level requirement is too high or you don't have enough gold. Type " + string(global.cmdPrefix) + "me too see your level and gold.");
                                        }
                                        
                                        exit;
                                    }
                                    
                                    if (tellItemType == 1)
                                    {
                                        if (boughtItem[buyItem] > 0)
                                        {
                                            if (myGems >= tellItemCost)
                                            {
                                                var totalCost = 0;
                                                var _amount;
                                                
                                                for (_amount = 0; _amount < chooseAmount; _amount++)
                                                {
                                                    if (boughtItem[buyItem] > 0)
                                                    {
                                                        if (myGems >= tellItemCost)
                                                        {
                                                            myShopID = global.globalShopID;
                                                            boughtItem[buyItem] -= 1;
                                                            myGems -= tellItemCost;
                                                            totalCost += tellItemCost;
                                                            gml_Script_scr_townXP(round(tellItemCost / costReduction) * 1000000);
                                                            ini_open(string(global.platformDir) + string(myAccDir) + "Character Data.ini");
                                                            gotUniqueItem[obj_build_shop.itemNumber[buyItem]] += 1;
                                                            ini_write_real("Resources", "Gems", myGems);
                                                            ini_write_real("Shop", "Bought Item " + string(buyItem), boughtItem[buyItem]);
                                                            ini_close();
                                                            ini_open(string(global.platformDir) + string(myCharDir) + "Data.ini");
                                                            ini_write_real("Relics", "Got Unique Item " + string(obj_build_shop.itemNumber[buyItem]), gotUniqueItem[obj_build_shop.itemNumber[buyItem]]);
                                                            ini_close();
                                                        }
                                                        else
                                                        {
                                                            break;
                                                        }
                                                    }
                                                    else
                                                    {
                                                        break;
                                                    }
                                                }
                                                
                                                with (gml_Script_instance_create(x, y, obj_playSound))
                                                {
                                                    maxTimes = _amount;
                                                    sound = "buy";
                                                }
                                                
                                                if (arg2 == 0)
                                                    gml_Script_twitch_chat_say("/me " + string(name) + " has bought (x" + string(_amount) + ") " + string(tellItemName) + " for " + string(totalCost) + " room00Gem from the town shop! (item nº" + string(buyItem) + "). You now have " + string(gotUniqueItem[obj_build_shop.itemNumber[buyItem]]) + " " + string(tellItemName) + " and " + gml_Script_scr_bigNumber(myGems) + " room00Gem .");
                                            }
                                            else if (arg2 == 0)
                                            {
                                                gml_Script_twitch_chat_say("/me " + string(name) + " you need more room00Gem to purchase item nº" + string(buyItem) + "!");
                                            }
                                        }
                                        else if (arg2 == 0)
                                        {
                                            gml_Script_twitch_chat_say("/me " + string(name) + " I only have a limited amount of units of this item, and I've already sold enough to you.. but thanks for your gems, heheheh... Come back when I restock the shop, I'll be here waiting for you.");
                                        }
                                        
                                        exit;
                                    }
                                }
                            }
                        }
                        else if (arg2 == 0)
                        {
                            gml_Script_twitch_chat_say("/me " + string(uname) + " The item you are trying to buy does not exist or the command format is incorrect (" + string(global.cmdPrefix) + "buy #*# for Relics).");
                        }
                    }
                    else if (arg2 == 0)
                    {
                        gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
                    }
                    
                    exit;
                }
                
                if (string_pos("!quit", _cmd) == 1 || string_pos("!exit", _cmd) == 1 || string_pos("!leave", _cmd) == 1)
                {
                    if (ds_list_find_index(global.playerList, uname) != -1)
                    {
                        with (obj_player)
                        {
                            if (name == other.uname)
                            {
                                if (state != UnknownEnum.Value_8 && readyRaid == 0 && toPortal == false)
                                    alarm[10] = 1;
                                else
                                    gml_Script_twitch_chat_say("/me " + string(name) + " You must be in town to quit!");
                            }
                        }
                    }
                    else if (arg2 == 0)
                    {
                        gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
                    }
                    
                    exit;
                }
            }
        }
        
        if (string_pos("!discord", _cmd) == 1 || string_pos("discord", _cmd) == 1)
        {
            if (arg2 == 0)
                gml_Script_twitch_chat_say("/me Join the game discord here: https://discord.gg/qrBTDvE (patch notes, bug repots, suggestions, other TP:DR streams...)");
            
            exit;
        }
        
        if (string_pos("!me", _cmd) == 1 || string_pos("?me", _cmd) == 1)
        {
            var _inspect = "";
            
            if (string_pos("@", _cmd) != 0)
            {
                var _length = real(string_pos("@", _cmd));
                _inspect = string_copy(_cmd, _length + 1, 4);
            }
            
            var _name = "";
            show_debug_message(string(uname) + " is inspecting " + string(_inspect));
            
            if (_inspect == "")
                _name = uname;
            else
                _name = _inspect;
            
            if (ds_list_find_index(global.playerList, uname) != -1)
            {
                with (obj_player)
                {
                    if (name == _name)
                    {
                        if (state != UnknownEnum.Value_12)
                        {
                            var vpLeft = "";
                            
                            if (action > 0 && action < 5)
                            {
                                if (myVocationInfo[action - 1][1] > -1)
                                    vpLeft = " (" + gml_Script_scr_bigNumber(myVocationInfo[action - 1][2] - myVocationInfo[action - 1][1]) + " VP for lv." + string(myVocationInfo[action - 1][0]) + ")";
                                else
                                    vpLeft = " (Maxed)";
                            }
                            
                            var _sp = "";
                            
                            if (specialized != 0)
                                _sp = string(gml_Script_scr_bigNumber(specialPoints[myAbilityInfo[0]]) + " SP, ");
                            
                            gml_Script_twitch_chat_say("/me " + string(name) + " (lv." + gml_Script_scr_bigNumber(level) + " - " + string(class) + "): Build " + string(build) + " (" + string(buildName) + "), " + string(global.actionText[action]) + string(vpLeft) + ", " + gml_Script_scr_bigNumber(round(energy)) + " energy, " + gml_Script_scr_bigNumber(skillPoints) + " room00Talent , " + string(_sp) + gml_Script_scr_bigNumber(ceil(mygold)) + " G, " + gml_Script_scr_bigNumber(myGems) + " room00Gem, " + gml_Script_scr_bigNumber(ceil(myfood)) + " F, " + gml_Script_scr_bigNumber(honorPoints) + " H");
                        }
                    }
                }
            }
            else if (arg2 == 0)
            {
                gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
            }
            
            exit;
        }
        
        if (string_pos("?temp", _cmd) == 1 || string_pos("?bonus", _cmd) == 1)
        {
            var _inspect = "";
            
            if (string_pos("@", _cmd) != 0)
            {
                var _length = real(string_pos("@", _cmd));
                _inspect = string_copy(_cmd, _length + 1, 4);
            }
            
            var _name = "";
            show_debug_message(string(uname) + " is inspecting " + string(_inspect));
            
            if (_inspect == "")
                _name = uname;
            else
                _name = _inspect;
            
            if (ds_list_find_index(global.playerList, uname) != -1)
            {
                with (obj_player)
                {
                    if (string_pos(_name, name) == 1)
                    {
                        gml_Script_scr_updateStats();
                        var _text = " No active bonuses.";
                        
                        for (var i = 0; i <= 5; i++)
                        {
                            var _display;
                            _display[i] = gml_Script_scr_alarm_get(i);
                            
                            if (_display[i] != -1)
                            {
                                if (_text == " No active bonuses.")
                                    _text = "";
                                
                                if (i == 0)
                                    _text += (" Resource Bonus: 20%[x] for " + string(ceil(_display[i] / 30 / 60 / 60)) + " hours.");
                                
                                if (i == 1)
                                    _text += (" XP Bonus: 20%[x] for " + string(ceil(_display[i] / 30 / 60 / 60)) + " hours.");
                                
                                if (i == 2)
                                    _text += (" VP Bonus: 20%[x] for " + string(ceil(_display[i] / 30 / 60 / 60)) + " hours.");
                                
                                if (i == 3)
                                    _text += (" DMG Bonus: 20%[+] for " + string(ceil(_display[i] / 30 / 60 / 60)) + " hours.");
                                
                                if (i == 4)
                                    _text += (" RES Bonus: 10%[+] for " + string(ceil(_display[i] / 30 / 60 / 60)) + " hours.");
                                
                                if (i == 5)
                                    _text += (" Stats Bonus: 10%[x] for " + string(ceil(_display[i] / 30 / 60 / 60)) + " hours.");
                            }
                        }
                        
                        gml_Script_twitch_chat_say("/me " + string(name) + " " + string_upper(class) + " TEMPORARY BONUSES:" + string(_text));
                    }
                }
            }
            else if (arg2 == 0)
            {
                gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
            }
            
            exit;
        }
        
        if (string_pos("!myst", _cmd) == 1 || string_pos("!stat", _cmd) == 1)
        {
            var _inspect = "";
            
            if (string_pos("@", _cmd) != 0)
            {
                var _length = real(string_pos("@", _cmd));
                _inspect = string_copy(_cmd, _length + 1, 4);
            }
            
            var _name = "";
            show_debug_message(string(uname) + " is inspecting " + string(_inspect));
            
            if (_inspect == "")
                _name = uname;
            else
                _name = _inspect;
            
            if (ds_list_find_index(global.playerList, uname) != -1)
            {
                with (obj_player)
                {
                    if (string_pos(_name, name) == 1)
                    {
                        gml_Script_scr_updatePlayerItems();
                        var _displayCap;
                        
                        for (var i = 0; i < 10; i++)
                        {
                            if (myStatInfo[i][5] != -1)
                            {
                                if (myStatInfo[i][4] >= myStatInfo[i][5])
                                    myStatInfo[i][4] = myStatInfo[i][5];
                            }
                            
                            if (myStatInfo[i][6] != -1 && myStatInfo[i][4] > myStatInfo[i][6])
                                myStatInfo[i][4] = myStatInfo[i][6];
                            
                            if (myStatInfo[i][3] > myStatInfo[i][4])
                                myStatInfo[i][3] = myStatInfo[i][4];
                            
                            _displayCap[i] = myStatInfo[i][4];
                        }
                        
                        gml_Script_twitch_chat_say("/me " + string(name) + " " + string_upper(class) + " STATS: " + string(global.baseStatText[3]) + ": " + gml_Script_scr_bigNumber(myStatInfo[3][3]) + "/" + gml_Script_scr_bigNumber(_displayCap[3]) + " | " + string(global.baseStatText[8]) + ": " + gml_Script_scr_bigNumber(myStatInfo[8][3]) + "/" + gml_Script_scr_bigNumber(_displayCap[8]) + " | " + string(global.baseStatText[6]) + ": " + gml_Script_scr_bigNumber(myStatInfo[6][3]) + "/" + gml_Script_scr_bigNumber(_displayCap[6]) + " | " + string(global.baseStatText[7]) + ": " + string(myStatInfo[7][3]) + "/" + string(_displayCap[7]) + "% | " + string(global.baseStatText[0]) + ": " + gml_Script_scr_bigNumber(myStatInfo[0][3]) + "/" + gml_Script_scr_bigNumber(_displayCap[0]) + " | " + string(global.baseStatText[5]) + ": " + string(myStatInfo[5][3]) + "/" + string(_displayCap[5]) + "% | " + string(global.baseStatText[4]) + ": " + gml_Script_scr_bigNumber(myStatInfo[4][3]) + "/" + gml_Script_scr_bigNumber(_displayCap[4]) + " | " + string(global.baseStatText[1]) + ": " + string(myStatInfo[1][3]) + "/" + string(_displayCap[1]) + " | " + string(global.baseStatText[2]) + ": " + gml_Script_scr_bigNumber(myStatInfo[2][3]) + "/" + gml_Script_scr_bigNumber(_displayCap[2]) + "% | " + string(global.baseStatText[9]) + ": " + gml_Script_scr_bigNumber(myStatInfo[9][3]) + "/" + gml_Script_scr_bigNumber(_displayCap[9]) + " | Damage Resistances: Global " + string(sign(myResistance[0][0] - 1) * (myResistance[0][0] - 1) * 100) + "% | Physical " + string(sign(myResistance[0][1] - 1) * (myResistance[0][1] - 1) * 100) + "% | Special " + string(sign(myResistance[0][2] - 1) * (myResistance[0][2] - 1) * 100) + "% | Status " + string(sign(myResistance[0][3] - 1) * (myResistance[0][3] - 1) * 100) + "% | Global Damage Bonus: " + string((myDamage[0] - 1) * 100) + "%.");
                    }
                }
            }
            else if (arg2 == 0)
            {
                gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
            }
            
            exit;
        }
        
        if (string_pos("!myin", _cmd) == 1)
        {
            var _inspect = "";
            
            if (string_pos("@", _cmd) != 0)
            {
                var _length = real(string_pos("@", _cmd));
                _inspect = string_copy(_cmd, _length + 1, 4);
            }
            
            var _name = "";
            show_debug_message(string(uname) + " is inspecting " + string(_inspect));
            
            if (_inspect == "")
                _name = uname;
            else
                _name = _inspect;
            
            if (ds_list_find_index(global.playerList, uname) != -1)
            {
                with (obj_player)
                {
                    if (string_pos(_name, name) == 1)
                    {
                        gml_Script_scr_updatePlayerItems();
                        gml_Script_twitch_chat_say("/me " + string(name) + " " + string_upper(class) + " INFO: Level: " + gml_Script_scr_bigNumber(level) + " | Honor Level: " + gml_Script_scr_bigNumber(honorLevel) + " | Account Honor: " + gml_Script_scr_bigNumber(round(honor)) + " | Honor Points: " + gml_Script_scr_bigNumber(round(honorPoints)) + " | XP: " + gml_Script_scr_bigNumber(round(xp)) + "/" + gml_Script_scr_bigNumber(maxxp) + " | Energy: " + gml_Script_scr_bigNumber(floor(energy)) + "/" + gml_Script_scr_bigNumber(floor(maxEnergy)) + " | Raids: " + gml_Script_scr_bigNumber(raids) + " | Kills: " + gml_Script_scr_bigNumber(kills) + " | Gold: " + gml_Script_scr_bigNumber(round(mygold)) + " | XP Bonus: +" + string(((myMultiplier[2] * global.globalXPBonus) - 1) * 100) + "% (" + string((myMultiplier[2] - 1) * 100) + "%[x] personal x " + string((global.globalXPBonus - 1) * 100) + "%[x] global) | Gold Bonus: +" + string(((myMultiplier[4] * global.globalGoldBonus) - 1) * 100) + "% (" + string((myMultiplier[4] - 1) * 100) + "%[x] personal x " + string((global.globalGoldBonus - 1) * 100) + "%[x] global) | Food Bonus: +" + string(((myMultiplier[4] * global.globalFoodBonus) - 1) * 100) + "% (" + string((myMultiplier[4] - 1) * 100) + "%[x] personal x " + string((global.globalFoodBonus - 1) * 100) + "%[x] global)");
                    }
                }
            }
            else if (arg2 == 0)
            {
                gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
            }
            
            exit;
        }
        
        if (string_pos("!myp", _cmd) == 1)
        {
            var _inspect = "";
            
            if (string_pos("@", _cmd) != 0)
            {
                var _length = real(string_pos("@", _cmd));
                _inspect = string_copy(_cmd, _length + 1, 4);
            }
            
            var _name = "";
            show_debug_message(string(uname) + " is inspecting " + string(_inspect));
            
            if (_inspect == "")
                _name = uname;
            else
                _name = _inspect;
            
            if (ds_list_find_index(global.playerList, uname) != -1)
            {
                with (obj_player)
                {
                    if (string_pos(_name, name) == 1)
                    {
                        var _text = "";
                        ini_open(string(global.platformDir) + string(myCharDir) + "Data.ini");
                        var _petText;
                        
                        for (var _p = 1; _p <= global.maxPets; _p++)
                        {
                            _text = "";
                            var _petInfo;
                            _petInfo[_p][0] = ini_read_real("Pets", "My Pet " + string(_p) + " Level", 0);
                            
                            for (var _l = 1; _l <= 5; _l++)
                            {
                                _petInfo[_p][_l] = ini_read_real("Pets", "My Pet " + string(_p) + " Relic Slot " + string(_l), 0);
                                
                                if (_petInfo[_p][_l] > 0)
                                    _text += ("R" + string(_petInfo[_p][_l]) + "|");
                            }
                            
                            show_debug_message("pets debug text:" + string(_text));
                            
                            if (_text != "")
                            {
                                _text = string_delete(_text, string_length(_text), 1);
                                _text = " [" + string(_text) + "]";
                            }
                            
                            _petText[_p] = " - Not owned yet.";
                            
                            if (gotPet[_p] != 0)
                                _petText[_p] = " - lv." + string(_petInfo[_p][0]) + " (" + gml_Script_scr_bigNumber(myPetInfo[_p][5]) + "/" + gml_Script_scr_bigNumber(myPetInfo[_p][6]) + "xp)" + string(_text) + ".";
                        }
                        
                        gml_Script_twitch_chat_say("/me " + string(name) + " " + string_upper(class) + " PETS: Pet 1 (" + string(global.globalPetInfo[1][1]) + ") " + string(_petText[1]) + " | Pet 2 (" + string(global.globalPetInfo[2][1]) + ") " + string(_petText[2]) + " | Pet 3 (" + string(global.globalPetInfo[3][1]) + ") " + string(_petText[3]));
                        ini_close();
                    }
                }
            }
            else if (arg2 == 0)
            {
                gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
            }
            
            exit;
        }
        
        if (string_pos("!myt", _cmd) == 1)
        {
            var _inspect = "";
            
            if (string_pos("@", _cmd) != 0)
            {
                var _length = real(string_pos("@", _cmd));
                _inspect = string_copy(_cmd, _length + 1, 4);
            }
            
            var _name = "";
            show_debug_message(string(uname) + " is inspecting " + string(_inspect));
            
            if (_inspect == "")
                _name = uname;
            else
                _name = _inspect;
            
            if (ds_list_find_index(global.playerList, uname) != -1)
            {
                with (obj_player)
                {
                    if (string_pos(_name, name) == 1)
                        gml_Script_twitch_chat_say("/me " + string(name) + " TALENTS: Talent points: " + gml_Script_scr_bigNumber(skillPoints) + "/" + gml_Script_scr_bigNumber(totalSkillPoints) + " | " + string(global.baseStatText[3]) + ": " + gml_Script_scr_bigNumber(baseStat[3][0]) + " (+" + gml_Script_scr_bigNumber(baseStat[3][0] / global.talentValue[3]) + ") | " + string(global.baseStatText[8]) + ": " + gml_Script_scr_bigNumber(baseStat[8][0]) + " (+" + gml_Script_scr_bigNumber(baseStat[8][0] / global.talentValue[8]) + ") | " + string(global.baseStatText[6]) + ": " + gml_Script_scr_bigNumber(baseStat[6][0]) + " (+" + gml_Script_scr_bigNumber(baseStat[6][0] / global.talentValue[6]) + ") | " + string(global.baseStatText[7]) + ": " + gml_Script_scr_bigNumber(baseStat[7][0]) + " (+" + string(baseStat[7][0] / global.talentValue[7]) + ") | " + string(global.baseStatText[0]) + ": " + gml_Script_scr_bigNumber(baseStat[0][0]) + " (+" + gml_Script_scr_bigNumber(baseStat[0][0] / global.talentValue[0]) + ") | " + string(global.baseStatText[5]) + ": " + gml_Script_scr_bigNumber(baseStat[5][0]) + " (+" + gml_Script_scr_bigNumber(baseStat[5][0] / global.talentValue[5]) + ") | " + string(global.baseStatText[4]) + ": " + gml_Script_scr_bigNumber(baseStat[4][0]) + " (+" + gml_Script_scr_bigNumber(baseStat[4][0] / global.talentValue[4]) + ") | " + string(global.baseStatText[1]) + ": " + gml_Script_scr_bigNumber(baseStat[1][0]) + " (+" + string(baseStat[1][0] / global.talentValue[1]) + ") | " + string(global.baseStatText[2]) + ": " + gml_Script_scr_bigNumber(baseStat[2][0]) + " (+" + string(baseStat[2][0] / global.talentValue[2]) + ") | " + string(global.baseStatText[9]) + ": " + gml_Script_scr_bigNumber(baseStat[9][0]) + " (+" + gml_Script_scr_bigNumber(baseStat[9][0] / global.talentValue[9]) + ")");
                }
            }
            else if (arg2 == 0)
            {
                gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
            }
            
            exit;
        }
        
        if (string_pos("!myv", _cmd) == 1)
        {
            var _inspect = "";
            
            if (string_pos("@", _cmd) != 0)
            {
                var _length = real(string_pos("@", _cmd));
                _inspect = string_copy(_cmd, _length + 1, 4);
            }
            
            var _name = "";
            show_debug_message(string(uname) + " is inspecting " + string(_inspect));
            
            if (_inspect == "")
                _name = uname;
            else
                _name = _inspect;
            
            if (ds_list_find_index(global.playerList, uname) != -1)
            {
                with (obj_player)
                {
                    if (string_pos(_name, name) == 1)
                    {
                        gml_Script_scr_updatePlayerItems();
                        var _text = "VOCATIONS: ";
                        
                        for (var _v = 0; _v < 4; _v++)
                        {
                            _text += (string(global.actionText[_v + 1]) + " level " + string(myVocationInfo[_v][0] - 1));
                            
                            if (myVocationInfo[_v][1] > -1)
                                _text += (" (" + gml_Script_scr_bigNumber(round(myVocationInfo[_v][1])) + "/" + gml_Script_scr_bigNumber(round(myVocationInfo[_v][2])) + " vp) | ");
                            else
                                _text += " (Maxed) | ";
                        }
                        
                        _text += ("Vocation Stats Bonus: " + string(round((vocationStatsBonus - 1) * 100)) + "%[x]");
                        gml_Script_twitch_chat_say("/me " + string(name) + " " + string(_text));
                    }
                }
            }
            else if (arg2 == 0)
            {
                gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
            }
            
            exit;
        }
        
        if (string_pos("!mya", _cmd) == 1)
        {
            var _inspect = "";
            
            if (string_pos("@", _cmd) != 0)
            {
                var _length = real(string_pos("@", _cmd));
                _inspect = string_copy(_cmd, _length + 1, 4);
            }
            
            var _name = "";
            show_debug_message(string(uname) + " is inspecting " + string(_inspect));
            
            if (_inspect == "")
                _name = uname;
            else
                _name = _inspect;
            
            if (ds_list_find_index(global.playerList, uname) != -1)
            {
                with (obj_player)
                {
                    if (string_pos(_name, name) == 1)
                    {
                        gml_Script_scr_updatePlayerItems();
                        gml_Script_twitch_chat_say("/me " + string(name) + " AURAS: 1 - " + string(global.auraInfo[1][0]) + ": " + gml_Script_scr_bigNumber(auraBonus[1]) + "%[x] " + "| 2 - " + string(global.auraInfo[2][0]) + ": " + gml_Script_scr_bigNumber(auraBonus[2]) + "%[x] " + "| 3 - " + string(global.auraInfo[3][0]) + ": " + gml_Script_scr_bigNumber(auraBonus[3]) + "%[x] " + "| 4 - " + string(global.auraInfo[4][0]) + ": " + gml_Script_scr_bigNumber(auraBonus[4]) + "%[x] " + "| 5 - " + string(global.auraInfo[5][0]) + ": " + gml_Script_scr_bigNumber(auraBonus[5]) + "%[x] " + "| Currently projecting Auras: " + string(myAura) + " | Farm: " + string(farmAura) + " | Mine: " + string(mineAura) + " | Train: " + string(trainAura) + " | Raid: " + string(raidAura) + " | Portal: " + string(portalAura) + ".");
                    }
                }
            }
            else if (arg2 == 0)
            {
                gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
            }
            
            exit;
        }
        
        if (string_pos("!myi", _cmd) == 1)
        {
            var _inspect = "";
            
            if (string_pos("@", _cmd) != 0)
            {
                var _length = real(string_pos("@", _cmd));
                _inspect = string_copy(_cmd, _length + 1, 4);
            }
            
            var _name = "";
            show_debug_message(string(uname) + " is inspecting " + string(_inspect));
            
            if (_inspect == "")
                _name = uname;
            else
                _name = _inspect;
            
            if (ds_list_find_index(global.playerList, uname) != -1)
            {
                with (obj_player)
                {
                    if (string_pos(_name, name) == 1)
                    {
                        gml_Script_scr_updatePlayerItems();
                        var _itemInfo;
                        
                        for (var s = 0; s <= 9; s++)
                            _itemInfo[s][3] = (((myStatInfo[s][0] * ((myStatInfo[s][1] * level) - (level - 1))) + (baseStat[s][0] / global.talentValue[s]) + myItemInfo[s][3]) * (1 + (myItemInfo[s][3] / 100))) - (baseStat[s][0] / global.talentValue[s]);
                        
                        gml_Script_twitch_chat_say("/me " + string(name) + " ITEMS: " + string(myItemInfo[3][4]) + ": T" + string(myItemInfo[3][0]) + " (" + string(myItemInfo[3][2]) + ") [+" + string(_itemInfo[3][3]) + " " + string(myItemInfo[3][5]) + "]" + " | " + string(myItemInfo[8][4]) + ": T" + string(myItemInfo[8][0]) + " (" + string(myItemInfo[8][2]) + ") [+" + gml_Script_scr_bigNumber(_itemInfo[8][3]) + " " + string(myItemInfo[8][5]) + "]" + " | " + string(myItemInfo[6][4]) + ": T" + string(myItemInfo[6][0]) + " (" + string(myItemInfo[6][2]) + ") [+" + gml_Script_scr_bigNumber(_itemInfo[6][3]) + " " + string(myItemInfo[6][5]) + "]" + " | " + string(myItemInfo[7][4]) + ": T" + string(myItemInfo[7][0]) + " (" + string(myItemInfo[7][2]) + ") [+" + string(_itemInfo[7][3]) + " " + string(myItemInfo[7][5]) + "]" + " | " + string(myItemInfo[0][4]) + ": T" + string(myItemInfo[0][0]) + " (" + string(myItemInfo[0][2]) + ") [+" + gml_Script_scr_bigNumber(_itemInfo[0][3]) + " " + string(myItemInfo[0][5]) + "]" + " | " + string(myItemInfo[5][4]) + ": T" + string(myItemInfo[5][0]) + " (" + string(myItemInfo[5][2]) + ") [+" + string(_itemInfo[5][3]) + " " + string(myItemInfo[5][5]) + "]" + " | " + string(myItemInfo[4][4]) + ": T" + string(myItemInfo[4][0]) + " (" + string(myItemInfo[4][2]) + ") [+" + string(_itemInfo[4][3]) + " " + string(myItemInfo[4][5]) + "]" + " | " + string(myItemInfo[1][4]) + ": T" + string(myItemInfo[1][0]) + " (" + string(myItemInfo[1][2]) + ") [+" + string(_itemInfo[1][3]) + " " + string(myItemInfo[1][5]) + "]" + " | " + string(myItemInfo[2][4]) + ": T" + string(myItemInfo[2][0]) + " (" + string(myItemInfo[2][2]) + ") [+" + string(_itemInfo[2][3]) + " " + string(myItemInfo[2][5]) + "]" + " | " + string(myItemInfo[9][4]) + ": T" + string(myItemInfo[9][0]) + " (" + string(myItemInfo[9][2]) + ") [+" + gml_Script_scr_bigNumber(_itemInfo[9][3]) + " " + string(myItemInfo[9][5]) + "]");
                    }
                }
            }
            else if (arg2 == 0)
            {
                gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
            }
            
            exit;
        }
        
        if (string_pos("!myr", _cmd) == 1)
        {
            var _inspect = "";
            
            if (string_pos("@", _cmd) != 0)
            {
                var _length = real(string_pos("@", _cmd));
                _inspect = string_copy(_cmd, _length + 1, 4);
            }
            
            var _name = "";
            show_debug_message(string(uname) + " is inspecting " + string(_inspect));
            
            if (_inspect == "")
                _name = uname;
            else
                _name = _inspect;
            
            if (ds_list_find_index(global.playerList, uname) != -1)
            {
                with (obj_player)
                {
                    if (string_pos(_name, name) == 1)
                    {
                        var _isFav = "";
                        var _totaltext = " RELICS: [Relic: Level - Amount] ";
                        var _text;
                        
                        for (var i = 1; i <= global.maxUniqueItems; i++)
                        {
                            if (favoriteRelics[i] == 1)
                                _isFav = " (f)";
                            
                            var _corrupted = "";
                            
                            if (uniqueItemCorruption[i] != 1)
                                _corrupted = " [x" + string(uniqueItemCorruption[i]) + "]";
                            
                            _text[i] = "R" + string(i) + string(_isFav) + string(_corrupted) + ": " + string(uniqueItemLevel[i]) + " - " + string(gotUniqueItem[i]) + " | ";
                            
                            if (uniqueItemLevel[i] > 1 || gotUniqueItem[i] > 0)
                                _totaltext += _text[i];
                            
                            _isFav = "";
                        }
                        
                        for (var _r = 1; _r <= 3; _r++)
                        {
                            var _relic;
                            _relic[_r] = uniqueSlot[_r];
                            var _relicLv;
                            _relicLv[_r] = uniqueItemLevel[_relic[_r]];
                            
                            if (_r > myRelicSlots)
                            {
                                _text[_r] = "Slot " + string(_r) + ": Locked";
                            }
                            else if (_relic[_r] > 0)
                            {
                                _text[_r] = "Slot " + string(_r) + ": " + string(global.uniqueItem[_relic[_r]][0]) + " (R" + string(_relic[_r]) + " - lv." + string(_relicLv[_r]);
                                var _corrupted = uniqueItemCorruption[_relic[_r]];
                                
                                if (_corrupted != 1)
                                    _text[_r] += " [x" + string(_corrupted) + "]";
                                
                                _text[_r] += ")";
                            }
                            else
                            {
                                _text[_r] = "Slot " + string(_r) + ": Empty";
                            }
                        }
                        
                        var _relicText = "Equiped Relics: " + string(_text[1]) + " | " + string(_text[2]) + " | " + string(_text[3]) + ".";
                        var _petText = "";
                        
                        if (myPetID > 0)
                        {
                            _petText = " Pet Relics: none";
                            
                            for (var _r = 1; _r <= 5; _r++)
                            {
                                var _relic;
                                _relic[_r] = petRelicSlot[myPetID][_r];
                                var _relicLv;
                                _relicLv[_r] = uniqueItemLevel[_relic[_r]];
                                
                                if (_r > floor(myPetInfo[myPetID][4] / 10))
                                    _text[_r] = "Slot " + string(_r) + ": Locked";
                                else if (_relic[_r] > 0)
                                    _text[_r] = "Slot " + string(_r) + ": " + string(global.uniqueItem[_relic[_r]][0]) + " (R" + string(_relic[_r]) + " - lv." + string(_relicLv[_r]) + " [" + string(floor(myPetRelicSlotEffect[myPetID][_r] * 100)) + "%])";
                                else
                                    _text[_r] = "Slot " + string(_r) + ": Empty";
                            }
                            
                            _petText = " Pet Relics: " + string(_text[1]) + " | " + string(_text[2]) + " | " + string(_text[3]) + ".";
                        }
                        
                        show_debug_message("/me " + string(name) + string(_totaltext));
                        gml_Script_twitch_chat_say("/me " + string(name) + string(_totaltext));
                    }
                }
            }
            else if (arg2 == 0)
            {
                gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
            }
            
            exit;
        }
        
        if (string_pos("!mysk", _cmd) == 1 || string_pos("!myab", _cmd) == 1)
        {
            var _inspect = "";
            
            if (string_pos("@", _cmd) != 0)
            {
                var _length = real(string_pos("@", _cmd));
                _inspect = string_copy(_cmd, _length + 1, 4);
            }
            
            var _name = "";
            show_debug_message(string(uname) + " is inspecting " + string(_inspect));
            
            if (_inspect == "")
                _name = uname;
            else
                _name = _inspect;
            
            if (ds_list_find_index(global.playerList, uname) != -1)
            {
                with (obj_player)
                {
                    if (string_pos(_name, name) == 1)
                    {
                        var _classType = string(class);
                        var out = string_upper(string_char_at(_classType, 1));
                        out += string_copy(_classType, 2, string_length(_classType) - 1);
                        _classType = out;
                        
                        if (specialized != 0)
                            _classType = string(global.skillSpecialization[classType][specialized - 1]);
                        
                        ini_open(string(global.platformDir) + string(myCharDir) + "Data.ini");
                        var _skillXPText;
                        
                        if (specialized == 0)
                        {
                            ini_write_real("Build", "Ability " + string(myAbilityInfo[0]) + " Level", myAbilityInfo[4]);
                            ini_write_real("Build", "Ability " + string(myAbilityInfo[0]) + " Tier", myAbilityInfo[5]);
                            ini_write_real("Build", "Ability " + string(myAbilityInfo[0]) + " XP", myAbilityInfo[7]);
                            
                            for (var s = 0; s < 3; s += 1)
                            {
                                skillName[s] = global.playerAbilityInfo[classType][s][1];
                                skillLevel[s] = ini_read_real("Build", "Ability " + string(s) + " Level", 1);
                                skillTier[s] = ini_read_real("Build", "Ability " + string(s) + " Tier", 1);
                                skillXP[s] = round(ini_read_real("Build", "Ability " + string(s) + " XP", 1));
                                skillMaxXP[s] = skillLevel[s] * 300;
                                skillTierText[s] = string_repeat("I", skillTier[s]);
                                
                                if (skillXP[s] > -1)
                                    _skillXPText[s] = gml_Script_scr_bigNumber(skillXP[s]) + "/" + gml_Script_scr_bigNumber(skillMaxXP[s]) + "xp";
                                else
                                    _skillXPText[s] = "Maxed";
                            }
                        }
                        else
                        {
                            ini_write_real("Build", "Spec " + string(specialized - 1) + " Ability " + string(myAbilityInfo[0]) + " Level", myAbilityInfo[4]);
                            ini_write_real("Build", "Spec " + string(specialized - 1) + " Ability " + string(myAbilityInfo[0]) + " Tier", myAbilityInfo[5]);
                            ini_write_real("Build", "Spec " + string(specialized - 1) + " Ability " + string(myAbilityInfo[0]) + " XP", myAbilityInfo[7]);
                            
                            for (var s = 0; s < 3; s += 1)
                            {
                                skillName[s] = global.playerSpecAbilityInfo[classType][specialized - 1][s][1];
                                skillLevel[s] = ini_read_real("Build", "Spec " + string(specialized - 1) + " Ability " + string(s) + " Level", 1);
                                skillTier[s] = ini_read_real("Build", "Spec " + string(specialized - 1) + " Ability " + string(s) + " Tier", 1);
                                skillXP[s] = round(ini_read_real("Build", "Spec " + string(specialized - 1) + " Ability " + string(s) + " XP", 1));
                                skillMaxXP[s] = floor(power(global.maxAbilityLevel + skillLevel[s], 2) * 500);
                                skillTierText[s] = string_repeat("I", skillTier[s]);
                                
                                if (skillXP[s] > -1)
                                    _skillXPText[s] = gml_Script_scr_bigNumber(skillXP[s]) + "/" + gml_Script_scr_bigNumber(skillMaxXP[s]) + "xp";
                                else
                                    _skillXPText[s] = "Maxed";
                            }
                        }
                        
                        gml_Script_twitch_chat_say("/me " + string(name) + "'s " + string(_classType) + " Abilities: Currently using: " + string(myAbilityInfo[1]) + ". " + string(skillName[0]) + " " + string(skillTierText[0]) + " - Level " + string(skillLevel[0]) + " (" + string(_skillXPText[0]) + ") | " + string(skillName[1]) + " " + string(skillTierText[1]) + " - Level " + string(skillLevel[1]) + " (" + string(_skillXPText[1]) + ") | " + string(skillName[2]) + " " + string(skillTierText[2]) + " - Level " + string(skillLevel[2]) + " (" + string(_skillXPText[2]) + ")");
                        ini_close();
                    }
                }
            }
            else if (arg2 == 0)
            {
                gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
            }
            
            exit;
        }
        
        if (string_pos("!myg", _cmd) == 1)
        {
            var _inspect = "";
            
            if (string_pos("@", _cmd) != 0)
            {
                var _length = real(string_pos("@", _cmd));
                _inspect = string_copy(_cmd, _length + 1, 4);
            }
            
            var _name = "";
            show_debug_message(string(uname) + " is inspecting " + string(_inspect));
            
            if (_inspect == "")
                _name = uname;
            else
                _name = _inspect;
            
            if (ds_list_find_index(global.playerList, uname) != -1)
            {
                with (obj_player)
                {
                    if (string_pos(_name, name) == 1)
                    {
                        var _classType = string(class);
                        var out = string_upper(string_char_at(_classType, 1));
                        out += string_copy(_classType, 2, string_length(_classType) - 1);
                        _classType = out;
                        var _gemsText = "";
                        var _gemType = "";
                        var _gemSize = "";
                        
                        for (var gt = 0; gt <= 5; gt++)
                        {
                            if (gt == 0)
                                _gemType = "CON";
                            
                            if (gt == 1)
                                _gemType = "STR";
                            
                            if (gt == 2)
                                _gemType = "INT";
                            
                            if (gt == 3)
                                _gemType = "PHY-RES";
                            
                            if (gt == 4)
                                _gemType = "SPE-RES";
                            
                            if (gt == 5)
                                _gemType = "STA-RES";
                            
                            _gemsText += (string(_gemType) + ":");
                            var _any = false;
                            
                            for (var gs = 0; gs <= 2; gs++)
                            {
                                if (gs == 0)
                                    _gemSize = "S";
                                
                                if (gs == 1)
                                    _gemSize = "M";
                                
                                if (gs == 2)
                                    _gemSize = "B";
                                
                                if (myGemstoneInfo[gt][gs] > 0)
                                {
                                    _any = true;
                                    _gemsText += (" " + string(myGemstoneInfo[gt][gs]) + " " + string(_gemSize) + ",");
                                }
                                
                                if (gs == 2 && _any == false)
                                    _gemsText += " None";
                                
                                if (gs == 2 && _any == true)
                                    _gemsText = string_delete(_gemsText, string_length(_gemsText), 1);
                                
                                if (gs == 2)
                                    _gemsText += " | ";
                            }
                        }
                        
                        var _gemsTextItems = "";
                        var _bufferText = "";
                        var _equipGemBonus = [0, 0, 0, 0, 0, 0];
                        
                        for (var ig = 0; ig <= 9; ig++)
                        {
                            var adapt = 0;
                            
                            if (ig == 0)
                                adapt = 3;
                            
                            if (ig == 1)
                                adapt = 8;
                            
                            if (ig == 2)
                                adapt = 6;
                            
                            if (ig == 3)
                                adapt = 7;
                            
                            if (ig == 4)
                                adapt = 0;
                            
                            if (ig == 5)
                                adapt = 5;
                            
                            if (ig == 6)
                                adapt = 4;
                            
                            if (ig == 7)
                                adapt = 1;
                            
                            if (ig == 8)
                                adapt = 2;
                            
                            if (ig == 9)
                                adapt = 9;
                            
                            var _checkItem = myItemInfo[adapt][6];
                            show_debug_message("gemstone: checking if inserted on item " + string(adapt));
                            
                            if (_checkItem != 0)
                            {
                                show_debug_message("gemstone: it is inserted on item " + string(adapt));
                                var _checkSize = myItemInfo[adapt][7];
                                var _slotBonus = 1;
                                var _effect = "(+" + string((_checkSize * 2) + 2) + "%)";
                                
                                if (adapt == 0 || adapt == 9)
                                {
                                    _slotBonus = 2;
                                    _effect = "(+" + string(((_checkSize * 2) + 2) * 2) + "%)";
                                }
                                
                                _equipGemBonus[_checkItem - 1] += 0.02 * (1 + _checkSize) * _slotBonus;
                                
                                if (_checkItem == 1)
                                    _checkItem = "CON";
                                
                                if (_checkItem == 2)
                                    _checkItem = "STR";
                                
                                if (_checkItem == 3)
                                    _checkItem = "INT";
                                
                                if (_checkItem == 4)
                                    _checkItem = "PHY-RES";
                                
                                if (_checkItem == 5)
                                    _checkItem = "SPE-RES";
                                
                                if (_checkItem == 6)
                                    _checkItem = "STA-RES";
                                
                                if (_checkSize == 0)
                                    _checkSize = "S";
                                
                                if (_checkSize == 1)
                                    _checkSize = "M";
                                
                                if (_checkSize == 2)
                                    _checkSize = "B";
                                
                                _bufferText += (" " + string(_checkSize) + " " + string(_checkItem) + " " + string(_effect) + " on " + string(global.globalItemInfo[adapt][0] + ","));
                            }
                        }
                        
                        var _totalGemText = "";
                        var _gemStats = [8, 0, 9, 1, 2, 3];
                        var _gemNames = ["CON", "STR", "INT", "PHY-RES", "SPE-RES", "STA-RES"];
                        
                        for (var gt = 0; gt <= 5; gt++)
                        {
                            var _bonus = _equipGemBonus[gt];
                            
                            if (_bonus > 0)
                            {
                                var _statIndex = _gemStats[gt];
                                var _realGain;
                                
                                if (_statIndex == 0 || _statIndex == 8 || _statIndex == 9)
                                {
                                    var _baseStat = myStatInfo[_statIndex][3];
                                    _realGain = floor(_baseStat * _bonus);
                                    _realGain = gml_Script_scr_bigNumber(_realGain);
                                }
                                else
                                {
                                    var _baseStat = myResistance[0][_statIndex];
                                    _realGain = string(round(_bonus * 100)) + "%";
                                }
                                
                                if (gt < 3)
                                    _totalGemText += (string(_gemNames[gt]) + " (" + string(round(_bonus * 100)) + "%, +" + string(_realGain) + "), ");
                                else
                                    _totalGemText += (string(_gemNames[gt]) + " (+" + string(_realGain) + "), ");
                            }
                        }
                        
                        if (_totalGemText != "")
                            _totalGemText = " | Total Gemstone Stats: " + string_delete(_totalGemText, string_length(_totalGemText) - 1, 2) + ".";
                        
                        if (_bufferText != "")
                            _gemsTextItems = "Inserted Gemstones:" + string_delete(_bufferText, string_last_pos(",", _bufferText), 5) + ".";
                        
                        if (_gemsTextItems == "")
                            _gemsText = string_delete(_gemsText, string_last_pos("|", _gemsText) - 1, 5) + ".";
                        
                        gml_Script_twitch_chat_say("/me " + string(name) + "'s " + string(_classType) + " Available Gemstones: " + string(_gemsText) + string(_gemsTextItems) + string(_totalGemText));
                    }
                }
            }
            else if (arg2 == 0)
            {
                gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
            }
            
            exit;
        }
        
        if (string_pos("!diary", _cmd) == 1 || string_pos("?diary", _cmd) == 1)
        {
            var _inspect = "";
            
            if (string_pos("@", _cmd) != 0)
            {
                var _length = real(string_pos("@", _cmd));
                _inspect = string_copy(_cmd, _length + 1, 4);
            }
            
            var _name = "";
            var _quest = 0;
            
            if (string_digits(_cmd) != "")
                _quest = real(string_digits(_cmd));
            
            if (_quest > global.totalDiaryChapters)
                _quest = 0;
            
            var _specificProgress = "";
            show_debug_message("Total quests: " + string(global.totalDiaryQuests) + " | Total chapters: " + string(global.totalDiaryChapters));
            show_debug_message(string(uname) + " is inspecting " + string(_inspect));
            
            if (_inspect == "")
                _name = uname;
            else
                _name = _inspect;
            
            if (ds_list_find_index(global.playerList, uname) != -1)
            {
                with (obj_player)
                {
                    if (string_pos(_name, name) == 1)
                    {
                        gml_Script_scr_checkDiaryProgress();
                        var _progressText = "";
                        
                        if (_quest == 0)
                        {
                            var _isCompleted = 1;
                            
                            for (var i = 0; i < global.totalDiaryQuests; i += 1)
                            {
                                if (global.diaryQuestInfo[i][0] > 0)
                                {
                                    if ((i % 5) == 0)
                                    {
                                        if (i != 0)
                                            _progressText += " | ";
                                        
                                        _progressText += (" #" + string(floor(i / 5) + 1) + ": ");
                                        
                                        if (diaryQuest[i][2] == 1)
                                        {
                                            if (diaryQuest[i][1] != 1)
                                            {
                                                _progressText += (string(floor((diaryQuest[i][0] / global.diaryQuestInfo[i][0]) * 100)) + "%");
                                                _isCompleted = 0;
                                            }
                                            else
                                            {
                                                _progressText += "V";
                                            }
                                        }
                                        else
                                        {
                                            _progressText += "X";
                                            _isCompleted = 0;
                                        }
                                    }
                                    else if (diaryQuest[i][2] == 1)
                                    {
                                        if (diaryQuest[i - 1][1] == 1)
                                        {
                                            if (diaryQuest[i][1] != 1)
                                            {
                                                _progressText += ("," + string(floor((diaryQuest[i][0] / global.diaryQuestInfo[i][0]) * 100)) + "%");
                                                _isCompleted = 0;
                                            }
                                            else
                                            {
                                                _progressText += ",V";
                                            }
                                        }
                                    }
                                    else
                                    {
                                        _isCompleted = 0;
                                    }
                                }
                            }
                            
                            if (_isCompleted == 1)
                            {
                                _progressText = " 100% Completed | Secret Chapters: ";
                                var _secretCompletions = 0;
                                
                                for (var i = 0; i < 3; i += 1)
                                {
                                    if (i > 0)
                                        _progressText += " | ";
                                    
                                    _progressText += (" #" + string(i + 1) + ": " + string(floor((diarySecretQuest[i][0] / diarySecretQuest[i][2]) * 100)) + "%");
                                    _secretCompletions += diarySecretQuest[i][1];
                                }
                                
                                _progressText += (" | " + string(_secretCompletions) + " completed");
                            }
                            
                            var _getDiary = "";
                            
                            if (fullDiary == 0 && sub == 0)
                                _getDiary = "Get all Kenji's Diary Chapters by subscribing to @Room_001 or for 125 Honor Points in the !!Honor Shop (!redeem10) |";
                            
                            if (arg2 == 0)
                                gml_Script_twitch_chat_say("/me " + string(name) + " Kenji's Diary progress: " + string(_progressText) + " | " + string(_getDiary) + " You can see all quests here: https://dungeon-raiders.netlify.app/diary/");
                            
                            show_debug_message("New Kenji's Diary progress:" + string(_progressText));
                        }
                        else if (diaryCompleted == 0)
                        {
                            var _chapter = _quest;
                            _quest = (_quest - 1) * 5;
                            var _currentQuest = 0;
                            
                            for (var i = 0; i < 5; i += 1)
                            {
                                if (diaryQuest[_quest + i][0] >= global.diaryQuestInfo[_quest + i][0] || diaryQuest[_quest + i][1] == 1)
                                    _currentQuest += 1;
                            }
                            
                            if (_currentQuest > 4)
                            {
                                _currentQuest = 4;
                                _progressText = "Completed!";
                            }
                            else
                            {
                                _progressText += string(gml_Script_scr_bigNumber(diaryQuest[_quest + _currentQuest][0]) + "/" + gml_Script_scr_bigNumber(global.diaryQuestInfo[_quest + _currentQuest][0]));
                            }
                            
                            if (arg2 == 0)
                                gml_Script_twitch_chat_say("/me " + string(name) + " Kenji's Diary progress: Chapter " + string(_chapter) + " (Q" + string(_currentQuest + 1) + "/5) - " + string(global.diaryQuestInfo[_quest + _currentQuest][1]) + ": " + string(_progressText) + " | You can see all quests here: https://dungeon-raiders.netlify.app/diary/");
                            
                            show_debug_message("New Kenji's Diary Quest progress: Chapter " + string(_chapter) + " Quest " + string(_currentQuest) + " (" + string(global.diaryQuestInfo[_quest + _currentQuest][1]) + "): " + string(_progressText));
                        }
                        else
                        {
                            _quest = clamp(_quest - 1, 0, 2);
                            _progressText += string(gml_Script_scr_bigNumber(diarySecretQuest[_quest][0]) + "/" + gml_Script_scr_bigNumber(diarySecretQuest[_quest][2]));
                            
                            if (arg2 == 0)
                                gml_Script_twitch_chat_say("/me " + string(name) + " Kenji's Diary progress: Lost Chapter " + string(_quest + 1) + ": " + string(global.secretQuestReq[_quest][1]) + ": " + string(_progressText) + " (" + string(diarySecretQuest[_quest][1]) + "x) | You can see all quests here: https://dungeon-raiders.netlify.app/diary/");
                            
                            show_debug_message("New Kenji's Diary Secret Chapters progress: Chapter " + string(_quest + 1) + " (" + string(global.secretQuestReq[_quest][1]) + "): " + string(_progressText));
                        }
                    }
                    
                    gml_Script_scr_updateStats();
                }
            }
            else if (arg2 == 0)
            {
                gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
            }
            
            exit;
        }
        
        if (string_pos("!!diary", _cmd) == 1)
        {
            if (ds_list_find_index(global.playerList, uname) != -1)
            {
                with (obj_player)
                {
                    if (name == other.uname)
                    {
                        if (arg2 == 0)
                            gml_Script_twitch_chat_say("/me " + string(name) + " Kenji's Diary is a mysterious book which contains personal quests with special rewards for all members of the Town. Subscribing to @Room_001 unlocks extra quests. You can check your progress with ?diary, and you can see all quests here: https://dungeon-raiders.netlify.app/diary/");
                    }
                }
            }
            else if (arg2 == 0)
            {
                gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
            }
            
            exit;
        }
        
        if (string_pos("!honor", _cmd) == 1 || string_pos("?honor", _cmd) == 1)
        {
            ds_grid_sort(global.honorRanking, 1, 0);
            var _inspect = "";
            
            if (string_pos("@", _cmd) != 0)
            {
                var _length = real(string_pos("@", _cmd));
                _inspect = string_copy(_cmd, _length + 1, 4);
            }
            
            var _name = "";
            show_debug_message(string(uname) + " is inspecting " + string(_inspect));
            
            if (_inspect == "")
                _name = uname;
            else
                _name = _inspect;
            
            if (ds_list_find_index(global.playerList, uname) != -1)
            {
                with (obj_player)
                {
                    if (string_pos(_name, name) == 1)
                    {
                        var _rank = -1;
                        
                        for (var h = 0; h < ds_grid_height(global.honorRanking); h++)
                        {
                            if (ds_grid_get(global.honorRanking, 0, h) == name)
                            {
                                _rank = h + 1;
                                break;
                            }
                        }
                        
                        if (arg2 == 0)
                            gml_Script_twitch_chat_say("/me " + string(name) + " has " + gml_Script_scr_bigNumber(honorPoints) + " honor points. (Level " + gml_Script_scr_bigNumber(honorLevel) + " - " + gml_Script_scr_bigNumber(honor) + " total Honor, " + gml_Script_scr_bigNumber(maxHonor - honor) + " for next level). #" + string(_rank) + " in Honor Ranking. Current top 1: " + string(ds_grid_get(global.honorRanking, 0, 0)) + " (" + gml_Script_scr_bigNumber(ds_grid_get(global.honorRanking, 1, 0)) + " total Honor). !!Honor Shop items: https://docs.google.com/document/d/1ccoonL4PnuEFQlvhb53imMXsc-nfZWkboV2tIFWmlW8");
                    }
                }
            }
            else if (arg2 == 0)
            {
                gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
            }
            
            exit;
        }
        
        if (string_pos("!fixsound", _cmd) == 1)
        {
            if (uname == "room_001" || uname == "erohzify" || uname == "alcoholickangaroo" || uname == "sawode")
                audio_stop_all();
            
            exit;
        }
        
        if (string_pos("!kick", _cmd) == 1)
        {
            if (uname == "room_001" || uname == "erohzify" || uname == global.channelName || uname == "sawode" || uname == "lawtribal")
            {
                var kicked = string_lower(string_delete(_cmd, 1, 5));
                show_debug_message("Kicking " + string(kicked));
                
                with (obj_player)
                {
                    if (string_lower(name) == kicked)
                    {
                        state = UnknownEnum.Value_0;
                        alarm[10] = 1;
                        show_debug_message("Kicked " + string(name));
                    }
                }
            }
            
            exit;
        }
        
        if (string_pos("!sub", _cmd) == 1)
        {
            if (uname == "room_001" || uname == "erohzify" || uname == "room_002" || uname == "sawode" || uname == "lawtribal" || uname == "Moobot" || (uname == "situ" && global.premiumChannel == 1))
            {
                var nameLength = real(string_length(_cmd));
                var subscriber = string_copy(_cmd, 5, nameLength - 5);
                subscriber = string_delete(subscriber, string_length(subscriber), 100);
                ini_open(string(global.platformDir) + "Core Data/Subscriber List.ini");
                ini_write_real("Subscribers", string_lower(subscriber), 1);
                ini_close();
                show_debug_message("*Subscribing " + string(subscriber) + "*");
                ds_list_add(global.subList, string(subscriber));
                
                with (obj_player)
                {
                    if (string_pos(subscriber, name) != 0)
                        gml_Script_scr_playerSubscribe(name);
                }
            }
            
            exit;
        }
        
        if (string_pos("!unsub", _cmd) == 1)
        {
            if (uname == "room_001" || uname == "erohzify" || uname == "room_002" || uname == "sawode" || uname == "lawtribal" || uname == "Moobot" || (uname == "situ" && global.premiumChannel == 1))
            {
                var nameLength = real(string_length(_cmd));
                var subscriber = string_copy(_cmd, 7, nameLength - 7);
                subscriber = string_delete(subscriber, string_length(subscriber), 100);
                ini_open(string(global.platformDir) + "Core Data/Subscriber List.ini");
                ini_key_delete("Subscribers", string_lower(subscriber));
                ini_close();
                show_debug_message("*Unsubscribing " + string(subscriber) + "*");
                ds_list_delete(global.subList, ds_list_find_index(global.subList, string(subscriber)));
                
                with (obj_player)
                {
                    if (string_pos(subscriber, name) != 0)
                        gml_Script_scr_playerUnsubscribe(name);
                }
            }
            
            exit;
        }
        
        if (string_pos("!tip", _cmd) == 1)
        {
            if (uname == "room_001" || uname == "erohzify" || uname == "room_002" || uname == "sawode" || uname == "lawtribal" || uname == "Moobot" || (uname == "situ" && global.premiumChannel == 1))
            {
                var nameLength = real(string_pos("*", _cmd)) - 5;
                var _name = string_copy(_cmd, 5, nameLength);
                var _amount = string_digits(string_delete(_cmd, 1, nameLength + 5));
                
                if (_amount != "")
                    _amount = real(_amount);
                else
                    _amount = 0;
                
                show_debug_message("*Tipping " + string(_name) + " " + string(_amount) + " Honor Points*");
                gml_Script_scr_gainHonor(_amount, 1, _name);
            }
            
            exit;
        }
        
        if (string_pos("!fixthisdamngame", _cmd) == 1)
        {
            if (uname == "fxpeanut" || uname == "sawode" || uname == "room_001" || uname == "erohzify" || uname == "razzor1" || uname == "ethiniel" || uname == "fatninja145")
                game_restart();
            
            exit;
        }
        
        if (string_pos("!potion", _cmd) == 1 || string_pos("!pot", _cmd) == 1)
        {
            if (ds_list_find_index(global.playerList, uname) != -1)
            {
                if (global.raiding == true)
                {
                    with (obj_warrior)
                    {
                        if (name == other.uname && myRaidNumber == 0)
                            gml_Script_scr_usePotion();
                    }
                }
                else if (arg2 == 0)
                {
                    gml_Script_twitch_chat_say("/me You can only use your potion in combat");
                }
            }
            else if (arg2 == 0)
            {
                gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
            }
            
            exit;
        }
        
        if (string_pos("!surrender", _cmd) == 1 || string_pos("!ff", _cmd) == 1)
        {
            if (ds_list_find_index(global.playerList, uname) != -1)
            {
                if (global.raiding == true)
                {
                    with (obj_warrior)
                    {
                        if (name == other.uname && myRaidNumber == 0 && (!instance_exists(obj_raidResults) && !instance_exists(obj_raidPortalResults)))
                        {
                            alarm[7] = -1;
                            gml_Script_scr_death("", "", "", "");
                        }
                    }
                }
                else if (arg2 == 0)
                {
                    gml_Script_twitch_chat_say("/me You can only surrender when you are in combat");
                }
            }
            else if (arg2 == 0)
            {
                gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
            }
            
            exit;
        }
        
        if (string_pos("!switch", _cmd) == 1 || string_pos("!tag", _cmd) == 1)
        {
            if (ds_list_find_index(global.playerList, uname) != -1)
            {
                if (global.raiding == true)
                {
                    with (obj_warrior)
                        gml_Script_scr_switch(other.uname);
                }
                else if (arg2 == 0)
                {
                    gml_Script_twitch_chat_say("/me You can only switch when you are in combat");
                }
            }
            else if (arg2 == 0)
            {
                gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
            }
            
            exit;
        }
        
        if (string_pos("!help", _cmd) == 1 || string_pos("help", _cmd) == 1)
        {
            if (arg2 == 0)
                gml_Script_twitch_chat_say("/me How to play: https://dungeon-raiders.netlify.app room00Raid");
            
            exit;
        }
        
        if (string_pos("!!raid", _cmd) == 1)
        {
            if (ds_list_find_index(global.playerList, uname) != -1)
            {
                if (arg2 == 0)
                    gml_Script_twitch_chat_say("/me " + string(uname) + " Raiding will test your strenght. Fight against enemies to earn XP, items and gold. If you are defeated in a raid, you will go back to town and will need to !rest to recover. All the rewards from the raid will be obtained when the raid ends, and items will automatically equip for everyone. Raids can be started with the " + string(global.cmdPrefix) + "raid(level) command, and a 30 second countdown will start. When the countdown reaches 0, no one will be able to join anymore and the raid will start. For example: " + string(global.cmdPrefix) + "raid 10.");
            }
            else if (arg2 == 0)
            {
                gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
            }
            
            exit;
        }
        
        if (string_pos("!!forge", _cmd) == 1)
        {
            if (ds_list_find_index(global.playerList, uname) != -1)
            {
                if (arg2 == 0)
                    gml_Script_twitch_chat_say("/me " + string(uname) + " When a raid ends, some items will not be used by anyone, and they will get recycled by the blacksmith on the forge. Recycled items will give the blacksmith forging materials, which he will use to upgrade your items once the forging materials are full. To use the forge, type !forge #*# (item you want to upgrade * times you want to upgrade). For example: !forge 1*3. The blacksmith unlocks Relic materials at level 13.");
            }
            else if (arg2 == 0)
            {
                gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
            }
            
            exit;
        }
        
        if (string_pos("!!recycle", _cmd) == 1)
        {
            if (ds_list_find_index(global.playerList, uname) != -1)
            {
                if (arg2 == 0)
                    gml_Script_twitch_chat_say("/me " + string(uname) + " You can !recycle #*# the Relics you don't use, granting Relic materials to the blacksmith and earning some room00Gem for yourself. Keep in mind that recycling a Relic will destroy it and all its levels.");
            }
            else if (arg2 == 0)
            {
                gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
            }
            
            exit;
        }
        
        if (string_pos("!!reforge", _cmd) == 1)
        {
            if (ds_list_find_index(global.playerList, uname) != -1)
            {
                if (arg2 == 0)
                    gml_Script_twitch_chat_say("/me " + string(uname) + " You can !reforge #*# a Relic of your choice when the blacksmith has enough Relic materials. You can !!recycle Relics you don't use to obtain Relic materials.");
            }
            else if (arg2 == 0)
            {
                gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
            }
            
            exit;
        }
        
        if (string_pos("!!guild", _cmd) == 1)
        {
            if (ds_list_find_index(global.playerList, uname) != -1)
            {
                if (arg2 == 0)
                    gml_Script_twitch_chat_say("/me " + string(uname) + " Guild Hall unlocks quests, each one provided by one guild; Miners, Hunters or Farmers. When a player helps completing a quests, it fills its contribution bar (blue bar bellow energy bar), and the respective Guild for that quest receives some XP, making it level up over time, increasing its bonuses and effects. In addition, at level 10 they will unlock Guild !!Chests, which contain big rewards that refresh every 24h. Completing quests increases the value of the upcoming Chests (yellow number on quest).");
            }
            else if (arg2 == 0)
            {
                gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
            }
            
            exit;
        }
        
        if (string_pos("!!talent", _cmd) == 1 || string_pos("!!academy", _cmd) == 1)
        {
            if (ds_list_find_index(global.playerList, uname) != -1)
            {
                if (arg2 == 0)
                    gml_Script_twitch_chat_say("/me " + string(uname) + " Talent points room00Talent are obtained by leveling up, opening Guild !!Chest #2, defeating ?Territory Bosses, completing raids... They allow you to increase your base stats at your own liking, and the amount of TPs you can spend on each stat is determined by the quality of your !!items. You need the Academy building to start using talent points. The command to spend TPs is !talent (stat)*(number of times to upgrade). For example: !talent 1*10 would invest 10 TPs into your armor stat. You can !respec#*# the same way to remove TPs from your desired stats. Stats ID: 1 Armor, 2 Constitution, 3 HP Regeneration, 4 Luck, 5 Strength, 6 Lifesteal, 7 Fury Generation, 8 Dexterity, 9 Agility, 10 Intelligence.");
            }
            else if (arg2 == 0)
            {
                gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
            }
            
            exit;
        }
        
        if (string_pos("!!chest", _cmd) == 1)
        {
            if (ds_list_find_index(global.playerList, uname) != -1)
            {
                if (arg2 == 0)
                    gml_Script_twitch_chat_say("/me " + string(uname) + " Guild Chests are unlocked at Guild Hall level 10+. Everyone in Town has access to 1 key (+1 every 10 extra Guild Hall Levels) that will open a Chest of your choice. You can open the same Chest multiple times if you have more than 1 key. To open a Chest, type !chest(ID)*(times to open), for example !chest2*1. Guild Chests and keys refresh every 24h and their value depends on how many quests were completed on the last 24h, so make sure to help completing quests and remember to open them daily!");
            }
            else if (arg2 == 0)
            {
                gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
            }
            
            exit;
        }
        
        if (string_pos("!!aura", _cmd) == 1)
        {
            if (ds_list_find_index(global.playerList, uname) != -1)
            {
                if (arg2 == 0)
                    gml_Script_twitch_chat_say("/me " + string(uname) + " Auras grant you stat bonuses that can be increased overtime. Available Auras: 1- " + string(global.auraInfo[1][0]) + ": " + string(global.auraInfo[1][1]) + " 2- " + string(global.auraInfo[2][0]) + ": " + string(global.auraInfo[2][1]) + " 3- " + string(global.auraInfo[3][0]) + ": " + string(global.auraInfo[3][1]) + " 4- " + string(global.auraInfo[4][0]) + ": " + string(global.auraInfo[4][1]) + " 5- " + string(global.auraInfo[5][0]) + ": " + string(global.auraInfo[5][1]) + " (obtainable in the !!Underworld.");
            }
            else if (arg2 == 0)
            {
                gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
            }
            
            exit;
        }
        
        if (string_pos("!!portal", _cmd) == 1)
        {
            if (ds_list_find_index(global.playerList, uname) != -1)
            {
                if (arg2 == 0)
                    gml_Script_twitch_chat_say("/me " + string(uname) + " The Underworld Portal slowly fills up with enemy deaths. Once it is full (check progress with ?portal), if the Witch has been found, anyone can type !portal to open it (instantly receiving a 20%[x] XP and Resource bonus for 1h), starting a 1h timer for the Portal event to start. When the timer ends, players that joined the event will travel to the !!Underworld.");
            }
            else if (arg2 == 0)
            {
                gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
            }
            
            exit;
        }
        
        if (string_pos("!!underworld", _cmd) == 1)
        {
            if (ds_list_find_index(global.playerList, uname) != -1)
            {
                if (global.newUnderworld == false)
                {
                    if (arg2 == 0)
                        gml_Script_twitch_chat_say("/me " + string(uname) + " The Underworld is a dangerous place where only the strongest raiders stand a chance. To enter the Underworld you must complete the Underworld !!Portal and use it. Currently there are 7 floors, each one protected by a Guardian, which will drop 1 !!Relic and 5%[+] Aura power for a random !!Aura when defeated. Each Underworld floor is equivalent to 200 regular raid levels. If the !!witch hut is built, defeating enemies there will also grant passive rewards and buffs.");
                }
                else if (arg2 == 0)
                {
                    gml_Script_twitch_chat_say("/me " + string(uname) + " The Underworld is a dangerous place where only the strongest raiders stand a chance. To enter the Underworld you must complete the Underworld !!Portal and use it. An evil force has captured 3 of the 4 mythical creatures of this world, draining their energy for an unknown purpose... With the help of the Witch, you will have to make your way through the Underworld Fortress and liberate all the mythical creatures before it is too late... You can obtain !!Auras and Blood gems in the Underworld.");
                }
            }
            else if (arg2 == 0)
            {
                gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
            }
            
            exit;
        }
        
        if (string_pos("!!witch", _cmd) == 1)
        {
            if (ds_list_find_index(global.playerList, uname) != -1)
            {
                if (arg2 == 0)
                    gml_Script_twitch_chat_say("/me " + string(uname) + " The Witch Hut (unlocked after completing the Underworld Portal for the first time) will unlock Relic !!enchanting and also help you by collecting the souls of the demons you defeat.");
            }
            else if (arg2 == 0)
            {
                gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
            }
            
            exit;
        }
        
        if (string_pos("!!boss", _cmd) == 1)
        {
            if (ds_list_find_index(global.playerList, uname) != -1)
            {
                if (arg2 == 0)
                    gml_Script_twitch_chat_say("/me " + string(uname) + " Bosses are still under development but for now, they will give a huge amount of items, XP, gold, talent points and a Relic. To summon a boss you must complete its key, then type " + string(global.cmdPrefix) + "boss. Once a Dungeon Boss raid is started, you can type " + string(global.cmdPrefix) + "raid to fight it until you defeat it or until it leaves.");
            }
            else if (arg2 == 0)
            {
                gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
            }
            
            exit;
        }
        
        if (string_pos("!!skill", _cmd) == 1 || string_pos("!!ability", _cmd) == 1)
        {
            if (ds_list_find_index(global.playerList, uname) != -1)
            {
                if (arg2 == 0)
                    gml_Script_twitch_chat_say("/me " + string(uname) + " You can choose between 3 abilities, to equip one type " + string(global.cmdPrefix) + "setskill# (# meaning 1, 2 or 3). You will level up your set skill by training and raiding (raiding will level it up faster). Check out the " + string(global.cmdPrefix) + "help document to see more details!");
            }
            else if (arg2 == 0)
            {
                gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
            }
            
            exit;
        }
        
        if (string_pos("!!hero", _cmd) == 1)
        {
            if (ds_list_find_index(global.playerList, uname) != -1)
            {
                if (arg2 == 0)
                    gml_Script_twitch_chat_say("/me " + string(uname) + " Hero status is earned at level 250. It unlocks an extra potion, " + string(global.cmdPrefix) + "setautopot, " + string(global.cmdPrefix) + "autopot and auto-rest.");
            }
            else if (arg2 == 0)
            {
                gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
            }
            
            exit;
        }
        
        if (string_pos("!!legend", _cmd) == 1)
        {
            if (ds_list_find_index(global.playerList, uname) != -1)
            {
                if (arg2 == 0)
                    gml_Script_twitch_chat_say("/me " + string(uname) + " Legend status is earned at level 500 or by subscribing to @Room_001 on Twitch. It unlocks an extra potion, a 2nd Relic slot, a 3rd Build Slot, an extra talent point per level up, " + string(global.cmdPrefix) + "autoskill and auto-auras.");
            }
            else if (arg2 == 0)
            {
                gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
            }
            
            exit;
        }
        
        if (string_pos("!!demigod", _cmd) == 1)
        {
            if (ds_list_find_index(global.playerList, uname) != -1)
            {
                if (arg2 == 0)
                    gml_Script_twitch_chat_say("/me " + string(uname) + " Demigod status is earned at level 1000. It unlocks a 3rd Relic slot, a 4th Build Slot, and an extra talent point per level up.");
            }
            else if (arg2 == 0)
            {
                gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
            }
            
            exit;
        }
        
        if (string_pos("!!item", _cmd) == 1 || string_pos("!!gear", _cmd) == 1)
        {
            if (ds_list_find_index(global.playerList, uname) != -1)
            {
                if (arg2 == 0)
                    gml_Script_twitch_chat_say("/me " + string(uname) + " Items or gear pieces can be obtained by defeating enemies in raids or by buying them in the Town Shop. Once unlocking the blacksmith, you can upgrade your equipped items with " + string(global.cmdPrefix) + "!forge. Items ID: 1 Helmet, 2 Vest, 3 Belt, 4 Pants, 5 Weapon, 6 Amulet, 7 Ring, 8 Gloves, 9 Boots, 10 Spellbook. More information, scroll down to 'Stats and Gear pieces': https://dungeon-raiders.netlify.app/classes/ ");
            }
            else if (arg2 == 0)
            {
                gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
            }
            
            exit;
        }
        
        if (string_pos("!!relic", _cmd) == 1)
        {
            if (ds_list_find_index(global.playerList, uname) != -1)
            {
                if (arg2 == 0)
                    gml_Script_twitch_chat_say("/me " + string(uname) + " Relics can be obtained by defeating Dungeon Bosses and Underworld Guardians, as well as by buying them in the Town Shop. Relics require level 100+ to equip, and are linked to the account. You can upgrade their effects by " + string(global.cmdPrefix) + "!enchanting them with the help of the Witch. List of Relics: https://dungeon-raiders.netlify.app/relics/");
            }
            else if (arg2 == 0)
            {
                gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
            }
            
            exit;
        }
        
        if (string_pos("!!honor", _cmd) == 1 || string_pos("!!redeem", _cmd) == 1 || string_pos("?redeem", _cmd) == 1)
        {
            if (ds_list_find_index(global.playerList, uname) != -1)
            {
                var _isPremium = "";
                
                if (global.premiumChannel == 1)
                    _isPremium = " (" + string(global.channelName) + " is a Premium Channel room00Starsmall ! You can tip through https://streamelements.com/" + string(global.channelName) + "/tip ).";
                
                if (arg2 == 0)
                    gml_Script_twitch_chat_say("/me " + string(uname) + " You can " + string(global.cmdPrefix) + "redeem your Honor Points for useful items to enhance your character: resources, temporary bonuses and cosmetics (coming soon). Full list of Honor Shop items: https://docs.google.com/document/d/1ccoonL4PnuEFQlvhb53imMXsc-nfZWkboV2tIFWmlW8 . Additionally, you will gain Honor Points when !!tipping or cheering on !!Premium Channels, and when subscribing to @Room_001." + string(_isPremium));
            }
            else if (arg2 == 0)
            {
                gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
            }
            
            exit;
        }
        
        if (string_pos("!!pet", _cmd) == 1)
        {
            if (ds_list_find_index(global.playerList, uname) != -1)
            {
                if (arg2 == 0)
                    gml_Script_twitch_chat_say("/me " + string(uname) + " Pets Information: https://dungeon-raiders.netlify.app/pets/");
            }
            else if (arg2 == 0)
            {
                gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
            }
            
            exit;
        }
        
        if (string_pos("!!bloodgem", _cmd) == 1)
        {
            if (ds_list_find_index(global.playerList, uname) != -1)
            {
                if (arg2 == 0)
                    gml_Script_twitch_chat_say("/me " + string(uname) + " There are legends that talk about Blood Gems... Mysterious minerals that could corrupt anything if used the wrong way... Its rumoured that they come from the hearts of the most evil and powerful demons...");
            }
            else if (arg2 == 0)
            {
                gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
            }
            
            exit;
        }
        
        if (string_pos("!!gemstone", _cmd) == 1)
        {
            if (ds_list_find_index(global.playerList, uname) != -1)
            {
                if (arg2 == 0)
                    gml_Script_twitch_chat_say("/me " + string(uname) + " The Witch can crush your gems ( room00Gem ) and turn them into your desired gemstones, boosting specific stats when inserted on your gear. You must choose a type (1 = CON, 2 = STR, 3 = INT, 4 = PHYSICAL RES., 5 = SPECIAL RES., 6 = STATUS RES.) and a size (1 = Small, 2 = Medium, 3 = Big) to craft with !craftgemstone(type):(size)*(amount, 1 by default), then you can equip them with !setgemstone(type):(item slot), and the biggest one available will be inserted into your gear piece (x2 value in Weapon (slot 5) and Spellbook (slot10)). You can also remove equipped gemstones with !removegemstone(item slot) and turn unused gemstones back into gems (no gold refunded) with !crushgemstone(type):(size). Check your gemstone inventory with !mygemstones. The process of cutting gemstones is exponentially expensive the bigger the gemstone.");
            }
            else if (arg2 == 0)
            {
                gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
            }
            
            exit;
        }
        
        if (string_pos("!!gem", _cmd) == 1)
        {
            if (ds_list_find_index(global.playerList, uname) != -1)
            {
                if (arg2 == 0)
                    gml_Script_twitch_chat_say("/me " + string(uname) + " You can get gems ( room00Gem ) by mining, opening raid chests, defeating Biome and Dungeon Bosses, opening Reward Chests... Gems are a highly valuable resource mostly used to " + string(global.cmdPrefix) + "!enchant Relics, craft " + string(global.cmdPrefix) + "!gemstones, upgrade buildings at high levels...");
            }
            else if (arg2 == 0)
            {
                gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
            }
            
            exit;
        }
        
        if (string_pos("!!enchant", _cmd) == 1)
        {
            if (ds_list_find_index(global.playerList, uname) != -1)
            {
                if (arg2 == 0)
                    gml_Script_twitch_chat_say("/me " + string(uname) + " Once the !!Witch Hut is discovered and you have !!sacrificed enough souls to the Witch, you can !enchant #*# your desired " + string(global.cmdPrefix) + "!Relic, needing 1 " + string(global.cmdPrefix) + "!gem per Relic level and at least 2 units of the same Relic.");
            }
            else if (arg2 == 0)
            {
                gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
            }
            
            exit;
        }
        
        if (string_pos("!!sacrifice", _cmd) == 1)
        {
            if (ds_list_find_index(global.playerList, uname) != -1)
            {
                if (arg2 == 0)
                    gml_Script_twitch_chat_say("/me " + string(uname) + " Sacrificing souls to the Witch will grant you the ability to " + string(global.cmdPrefix) + "!enchant your " + string(global.cmdPrefix) + "!Relics. You can specify the amount of souls you want to " + string(global.cmdPrefix) + "sacrifice#.");
            }
            else if (arg2 == 0)
            {
                gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
            }
            
            exit;
        }
        
        if (string_pos("!!special", _cmd) == 1)
        {
            if (ds_list_find_index(global.playerList, uname) != -1)
            {
                if (arg2 == 0)
                    gml_Script_twitch_chat_say("/me " + string(uname) + " Specialized characters gain Special Points when leveling up their ability. You can spend them on the different upgrade branches with !spec#*# (upgrade branch * amount to spent) and remove them with !unspec#*#. For more information: https://dungeon-raiders.netlify.app/classes/ )");
            }
            else if (arg2 == 0)
            {
                gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
            }
            
            exit;
        }
        
        if (string_pos("!!spec", _cmd) == 1)
        {
            if (ds_list_find_index(global.playerList, uname) != -1)
            {
                if (arg2 == 0)
                    gml_Script_twitch_chat_say("/me " + string(uname) + " Having a level 30+ Academy unlocks class specializations. To be eligible to " + string(global.cmdPrefix) + "specialize you must reach the maximum level of a tier 2 ability. For more information: https://dungeon-raiders.netlify.app/classes/");
            }
            else if (arg2 == 0)
            {
                gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
            }
            
            exit;
        }
        
        if (string_pos("!!pets", _cmd) == 1)
        {
            if (ds_list_find_index(global.playerList, uname) != -1)
            {
                if (arg2 == 0)
                    gml_Script_twitch_chat_say("/me " + string(uname) + " To get yourself a pet you must have the Creature Keeper built and actively raid to encounter them in the wild.");
            }
            else if (arg2 == 0)
            {
                gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
            }
            
            exit;
        }
        
        if (string_pos("!!favor", _cmd) == 1)
        {
            if (ds_list_find_index(global.playerList, uname) != -1)
            {
                var _premium = "";
                
                if (global.premiumChannel == 1)
                    _premium = " (This is a Premium Channel room00Starsmall ).";
                
                if (arg2 == 0)
                    gml_Script_twitch_chat_say("/me " + string(uname) + " Gods' Favors are global buffs or effects granted to everyone in Town. Their duration, effects power and frequency depend on your !!Gods' Level. Gaining Honor Points from any source (Completing Kenji's !!Diary quests, leveling up vocations, !!tipping and cheering on !!premium channels...) will contribute to Gods Favors progress." + string(_premium));
            }
            else if (arg2 == 0)
            {
                gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
            }
            
            exit;
        }
        
        if (string_pos("?favor", _cmd) == 1)
        {
            if (ds_list_find_index(global.playerList, uname) != -1)
            {
                var _favor = "none";
                
                if (obj_god.alarm[1] != -1)
                    _favor = "XP Rain | +" + gml_Script_scr_bigNumber(global.ostage * (1 + (global.ostage / 100)) * room_speed) + " character XP/s for " + string(ceil(obj_god.alarm[1] / room_speed)) + " seconds.";
                
                if (obj_god.alarm[2] != -1)
                    _favor = "Bonanza | +" + string((global.bonanzaBonus - 1) * 100) + "%[x] more Gold and Food from all sources and 2x chance of finding a gem while mining for " + string(ceil(obj_god.alarm[2] / room_speed)) + " seconds.";
                
                if (obj_god.alarm[3] != -1)
                    _favor = "Heaven's Power | +" + string(global.godsDmgBonus * 100) + "%[+] damage output while in combat for " + string(obj_god.raidsLeft) + " raids.";
                
                if (arg2 == 0)
                    gml_Script_twitch_chat_say("/me " + string(uname) + " Active Gods Favor: " + string(_favor) + " (" + string(global.godsFavorStacks) + " in queue).");
            }
            else if (arg2 == 0)
            {
                gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
            }
            
            exit;
        }
        
        if (string_pos("?premium", _cmd) == 1)
        {
            if (ds_list_find_index(global.playerList, uname) != -1)
            {
                if (global.premiumChannel == 1)
                    gml_Script_twitch_chat_say("/me " + string(uname) + " This is a Premium Channel room00Starsmall .");
                else
                    gml_Script_twitch_chat_say("/me " + string(uname) + " This is currently not a Premium Channel.");
            }
            else if (arg2 == 0)
            {
                gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
            }
            
            exit;
        }
        
        if (string_pos("!!god", _cmd) == 1)
        {
            if (ds_list_find_index(global.playerList, uname) != -1)
            {
                if (arg2 == 0)
                    gml_Script_twitch_chat_say("/me " + string(uname) + " Gods Level are a permanent and persistent variable that will help you progress faster throughout Campaigns. Gods will notice you and decide to help you the more you advance on each of your Campaigns. Buffs like Gods !!Favors effects, extra gold and food gain, higher chance to find gems ( room00Gem ) while mining... will slowly stack up the higher your Gods Level are. You can see your Gods Level progress at the end of each Campaign, after the Final War ends.");
            }
            else if (arg2 == 0)
            {
                gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
            }
            
            exit;
        }
        
        if (string_pos("?god", _cmd) == 1)
        {
            if (ds_list_find_index(global.playerList, uname) != -1)
            {
                if (arg2 == 0)
                    gml_Script_twitch_chat_say("/me " + string(uname) + " Current Gods Level: " + string(global.godLevel) + " | Granting +" + string((global.godResourceBonus - 1) * 100) + "%[x] Gold and Food gain, Higher !!Favors duration, effects and frequency, +" + string(((global.godLevel * 50) / 5000) * 100) + "%[x] chance to find room00Gem while mining.");
            }
            else if (arg2 == 0)
            {
                gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
            }
            
            exit;
        }
        
        if (string_pos("!!tip", _cmd) == 1)
        {
            if (ds_list_find_index(global.playerList, uname) != -1)
            {
                var _link = "";
                
                if (global.premiumChannel == 1)
                    _link = " You can tip through https://streamelements.com/" + string(global.channelName) + "/tip .";
                
                if (arg2 == 0)
                    gml_Script_twitch_chat_say("/me " + string(uname) + " Tips and cheers on !!premium channels (if enabled by the streamer) will reward you with !!honor points." + string(_link));
            }
            else if (arg2 == 0)
            {
                gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the town! Use " + string(global.cmdPrefix) + "join (class) to spawn your character.");
            }
            
            exit;
        }
        
        if (string_pos("!commands", _cmd) == 1 || string_pos("!!commands", _cmd) == 1)
        {
            if (arg2 == 0)
                gml_Script_twitch_chat_say("/me List of commands: https://dungeon-raiders.netlify.app/command-list/");
            
            exit;
        }
        
        if (string_pos("!credits", _cmd) == 1 || string_pos("!music", _cmd) == 1 || string_pos("!art", _cmd) == 1)
        {
            if (arg2 == 0)
                gml_Script_twitch_chat_say("/me Game idea and development by @erohzify, characters and animations by @kenji_893, music by @YouFulca. Also a huge shout-out to everyone that has enjoyed playing the game so far, you keep the game alive.");
            
            exit;
        }
        
        if (string_pos("!!premium", _cmd) == 1 || string_pos("?premium", _cmd) == 1)
        {
            var _text = "";
            var _text2 = "";
            
            if (global.premiumChannel == 1)
            {
                _text = " (" + string(global.channelName) + " is a Premium Channel room00Starsmall ! You can tip through https://streamelements.com/" + string(global.channelName) + "/tip ).";
            }
            else
            {
                _text = " [" + string(global.channelName) + " is not a Premium Channel]";
                _text2 = " (get Premium version by subscribing with Tier 3 on @Room_001 https://www.twitch.tv/subs/room_001 )";
            }
            
            if (arg2 == 0)
                gml_Script_twitch_chat_say("/me Premium Channels ( room00Starsmall on top left corner) are big supporters of the game" + string(_text2) + ", and they can directly reward their players with !!Honor Points when receiving !!tips and cheers!" + string(_text));
            
            exit;
        }
        
        if (string_pos("!!corrupted", _cmd) == 1)
        {
            if (arg2 == 0)
                gml_Script_twitch_chat_say("/me You unlock access to the Corrupted Dimension after defeating Hollow Finis Vitae for the first time. There you will fight World Corruption and gain permanent perks and bonuses while fighting mysterious and exponentially challenging combats through the Shattered Islands. To enter the Corrupted Dimension after the 1st time, you must complete the Red Portal ritual, consuming 5 Blood Gems.");
            
            exit;
        }
        
        if (string_pos("!!corruption", _cmd) == 1)
        {
            if (arg2 == 0)
                gml_Script_twitch_chat_say("/me World ?Corruption appears after opening the Red Portal for the first time, and slightly increases every 24h. In order to reduce it, you must travel to the Corrupted Dimension and consume Corruption !!Shards, scattered across the Shattered Islands. If World Corruption level reaches 100%, you must be prepared to fight The Final War...");
            
            exit;
        }
        
        if (string_pos("!!shard", _cmd) == 1)
        {
            if (arg2 == 0)
                gml_Script_twitch_chat_say("/me Corruption Shards are obtained after clearing Shatterd Islands in the !!Corrupted Dimension. They hold a fraction of the World's corruption, granting permanent global bonuses when consumed. You can check your current consumed ?Shards.");
            
            exit;
        }
        
        if (string_pos("?shard", _cmd) == 1)
        {
            if (global.unlockCorrupted == 1)
            {
                var _shards = "";
                var _total = 0;
                
                with (obj_corruptedControl)
                {
                    for (var r = 0; r <= global.maxCorruptedRewards; r++)
                    {
                        if (corruptedReward[r][3] > 0)
                        {
                            var _rewardText = "";
                            var _rewardValue = "";
                            
                            if (string_pos("%", corruptedReward[r][1]) != 0)
                                _rewardValue = string(gml_Script_scr_bigNumber(corruptedReward[r][0] * corruptedReward[r][3] * 100));
                            else
                                _rewardValue = string(gml_Script_scr_bigNumber(corruptedReward[r][0] * corruptedReward[r][3]));
                            
                            _rewardText = string_replace(corruptedReward[r][1], "*", _rewardValue);
                            _shards += (" (x" + string(corruptedReward[r][3]) + ") " + string(corruptedReward[r][2]) + ",");
                            _total += corruptedReward[r][3];
                        }
                    }
                }
                
                _shards = string_copy(_shards, 1, string_length(_shards) - 1);
                
                if (arg2 == 0)
                    gml_Script_twitch_chat_say("/me Consumed Corruption Shards (" + string(_total) + "):" + string(_shards) + ".");
                
                exit;
            }
            else
            {
                if (arg2 == 0)
                    gml_Script_twitch_chat_say("/me You haven't consumed any Corruption Shards.");
                
                exit;
            }
        }
        
        if (string_pos("!!corrupt", _cmd) == 1)
        {
            if (arg2 == 0)
                gml_Script_twitch_chat_say("/me You can !corrupt# (Relic ID) your Relics in your level 20+ Forge after enchanting them to level 100 and unlocking the Corrupted Dimension. Corrupting a Relic will randomly increase or decrease its power, ranging from a -50% to a +" + string(round((global.maxRelicCorruption - 1) * 100)) + "% modification (increased by Forge level). Relic corruption costs 1 Blood Gem per use, with no cooldown. The same Relic can only be corrupted once, but you can restore a Relic status by !!purifying it (at a really high gem cost), allowing to corrupt it again.");
            
            exit;
        }
        
        if (string_pos("?corruption", _cmd) == 1)
        {
            if (instance_exists(obj_seasonControl))
            {
                if (global.unlockCorrupted == 1)
                {
                    if (arg2 == 0)
                        gml_Script_twitch_chat_say("/me Current World Coruption: " + string(global.totalCorruption) + "%. Next corruption wave will set it to " + string(global.totalCorruption + floor(global.corruptionIncrease)) + "% (in " + string(ceil(obj_seasonControl.alarm[4] / room_speed / 60 / 60)) + "h).");
                    
                    exit;
                }
                else
                {
                    if (arg2 == 0)
                        gml_Script_twitch_chat_say("/me Your World is not being affected by corruption...");
                    
                    exit;
                }
            }
        }
        
        if (string_pos("?corrupt", _cmd) == 1)
        {
            if (global.unlockCorrupted == 1)
            {
                if (arg2 == 0)
                    gml_Script_twitch_chat_say("/me Corrupting a Relic will randomly modify its effect by [-50% to +" + string(round((global.maxRelicCorruption - 1) * 100)) + "%] and prevent it from getting enchanted any further. You can ?purify corrupted Relics to restore their status back to normal. Relic Corruption is unlocked after entering the Corrupted Dimension for the first time, needing a level 20+ forge. You can upgrade the Forge to increase the maximum possible multiplier.");
                
                exit;
            }
        }
        
        if (string_pos("!!purify", _cmd) == 1)
        {
            if (arg2 == 0)
                gml_Script_twitch_chat_say("/me You can !purify# (Relic ID) your Relics after ?corrupting them, removing their corruption status and modifier. This process is very expensive, costing 300 room00Gem + 5 more per Relic level.");
            
            exit;
        }
        
        if (string_pos("?purify", _cmd) == 1)
        {
            var _relic = "";
            _relic = string_digits(_cmd);
            
            if (_relic != "")
                _relic = real(_relic);
            
            if (global.unlockCorrupted == 1)
            {
                if (_relic == "")
                {
                    if (arg2 == 0)
                        gml_Script_twitch_chat_say("/me You can check the cost of purifying a Relic by including its ID in this command (?purify#).");
                }
                else
                {
                    with (obj_player)
                    {
                        if (name == other.uname)
                        {
                            if (uniqueItemCorruption != 1)
                            {
                                if (arg2 == 0)
                                    gml_Script_twitch_chat_say("/me Purifying your level " + string(uniqueItemLevel[_relic]) + " " + string(global.uniqueItem[_relic][0]) + " would cost " + string(gml_Script_scr_bigNumber(300 + (uniqueItemLevel[_relic] * 5))) + " personal room00Gem .");
                            }
                            else if (arg2 == 0)
                            {
                                gml_Script_twitch_chat_say("/me You can only purify corrupted Relics, but it would cost you " + string(gml_Script_scr_bigNumber(300 + (uniqueItemLevel[_relic] * 5))) + " personal room00Gem to purify your level " + string(uniqueItemLevel[_relic]) + " " + string(global.uniqueItem[_relic][0]) + ".");
                            }
                        }
                    }
                }
                
                exit;
            }
        }
        
        if (string_pos("!!ascend", _cmd) == 1)
        {
            if (arg2 == 0)
                gml_Script_twitch_chat_say("/me Ascending sends your character to the !!Eternal Realm, locking it to its current build (Auras, Relics, Pet, Talents, Auto-actions...), making it permanently unmodifiable and removing your access to control it. Ascending also erases all your possessions and memories (all your character data except Kenji's Diary, Honor and Auto-actions is reset), however, you gain 1 Ascension Level (more information soon), 10% higher stat caps for all your future characters, and +2% stat cap for all your allies (including organic caps like dexterity or agility). After Ascending you must !join the Town again with your desired class to keep playing. Ascending is limited to 1 time per class/subclass. For more details:  .");
            
            exit;
        }
        
        if (string_pos("!!eternal", _cmd) == 1)
        {
            if (arg2 == 0)
                gml_Script_twitch_chat_say("/me The Eternal Realm is where the Ascended heroes past lives stay. There, characters' stats are 'frozen', they can no longer gain rewards and can not modify their build. Characters in the Eternal Realm will always join !portal and !redportal events.");
            
            exit;
        }
        
        if (string_pos("?aura", _cmd) == 1)
        {
            var _inspect = "";
            
            if (string_pos("@", _cmd) != 0)
            {
                var _length = real(string_pos("@", _cmd));
                _inspect = string_copy(_cmd, _length + 1, 4);
            }
            
            var _name = "";
            show_debug_message(string(uname) + " is inspecting " + string(_inspect));
            
            if (_inspect == "")
                _name = uname;
            else
                _name = _inspect;
            
            with (obj_player)
            {
                if (string_pos(_name, name) == 1)
                {
                    if (myAura > 0)
                    {
                        if (arg2 == 0)
                            gml_Script_twitch_chat_say("/me " + string(name) + " Current Aura: " + string(myAura) + " (" + string(global.auraInfo[myAura][0]) + " | " + gml_Script_scr_bigNumber(auraBonus[myAura]) + "%[x])");
                    }
                    else if (arg2 == 0)
                    {
                        gml_Script_twitch_chat_say("/me " + string(name) + " No active Aura.");
                    }
                }
            }
            
            exit;
        }
        
        if (string_pos("?build", _cmd) == 1)
        {
            var _inspect = "";
            
            if (string_pos("@", _cmd) != 0)
            {
                var _length = real(string_pos("@", _cmd));
                _inspect = string_copy(_cmd, _length + 1, 4);
            }
            
            var _name = "";
            show_debug_message(string(uname) + " is inspecting " + string(_inspect));
            
            if (_inspect == "")
                _name = uname;
            else
                _name = _inspect;
            
            with (obj_player)
            {
                if (string_pos(_name, name) == 1)
                {
                    if (arg2 == 0)
                        gml_Script_twitch_chat_say("/me " + string(name) + " Current Build: " + string(build) + "/" + string(myBuildSlots) + " (" + string(buildName) + ")");
                }
            }
            
            exit;
        }
        
        if (string_pos("?debugpet", _cmd) == 1)
        {
            with (obj_player)
            {
                if (name == other.uname)
                {
                    if (myPetID != 0)
                    {
                        _str = "";
                        
                        for (var i = 0; i < global.maxUniqueItems; i++)
                            _str += (string(i) + ": " + string(myPetEquippedRelic[myPetID][i]) + " | ");
                        
                        if (arg2 == 0)
                            gml_Script_twitch_chat_say("/me " + string(name) + " Active Pet Relics: " + string(_str));
                    }
                }
            }
        }
        
        if (string_pos("?dere", _cmd) == 1)
        {
            with (obj_player)
            {
                if (name == other.uname)
                {
                    var _text = "";
                    
                    for (var i = 1; i <= global.maxUniqueItems; i++)
                    {
                        if (equippedUniqueItem[i] == 1)
                            _text += (" R" + string(i));
                        
                        if (myPetEquippedRelic[myPetID][i] == 1)
                            _text += (" R" + string(i) + " (PET)");
                    }
                    
                    show_debug_message("DEBUG All active Relics:" + string(_text));
                    
                    if (arg2 == 0)
                        gml_Script_twitch_chat_say("/me " + string(name) + " DEBUG All active Relics:" + string(_text));
                }
            }
            
            exit;
        }
        
        if (string_pos("?pet", _cmd) == 1)
        {
            var _inspect = "";
            
            if (string_pos("@", _cmd) != 0)
            {
                var _length = real(string_pos("@", _cmd));
                _inspect = string_copy(_cmd, _length + 1, 4);
            }
            
            var _name = "";
            show_debug_message(string(uname) + " is inspecting " + string(_inspect));
            
            if (_inspect == "")
                _name = uname;
            else
                _name = _inspect;
            
            with (obj_player)
            {
                if (string_pos(_name, name) == 1)
                {
                    var _traintext = "";
                    
                    if (myPetID != 0)
                    {
                        ini_open(string(global.platformDir) + string(myCharDir) + "Data.ini");
                        var _petInfo;
                        
                        for (var _p = 1; _p <= global.maxPets; _p++)
                        {
                            _petInfo[_p][0] = ini_read_real("Pets", "My Pet " + string(_p) + " Level", 0);
                            
                            for (var _l = 1; _l <= 5; _l++)
                                _petInfo[_p][_l] = ini_read_real("Pets", "My Pet " + string(_p) + " Relic Slot " + string(_l), 0);
                        }
                        
                        ini_close();
                        var _petText = "";
                        _petText = " Pet Relics: none";
                        var _text;
                        
                        for (var _r = 1; _r <= 5; _r++)
                        {
                            var _relic;
                            _relic[_r] = petRelicSlot[myPetID][_r];
                            var _relicLv;
                            _relicLv[_r] = uniqueItemLevel[_relic[_r]];
                            
                            if (_r > floor(myPetInfo[myPetID][4] / 10))
                            {
                                _text[_r] = "Slot " + string(_r) + ": Locked";
                            }
                            else if (_relic[_r] > 0)
                            {
                                _text[_r] = "Slot " + string(_r) + ": " + string(global.uniqueItem[_relic[_r]][0]) + " (R" + string(_relic[_r]) + " - lv." + string(_relicLv[_r]) + " [" + string(round(myPetRelicSlotEffect[myPetID][_r] * 100)) + "%])";
                                var _corrupted = uniqueItemCorruption[_relic[_r]];
                                
                                if (_corrupted != 1)
                                    _text[_r] += " [x" + string(_corrupted) + "]";
                            }
                            else
                            {
                                _text[_r] = "Slot " + string(_r) + ": Empty";
                            }
                        }
                        
                        _petText = " Pet Relics: " + string(_text[1]) + " | " + string(_text[2]) + " | " + string(_text[3]) + " | " + string(_text[4]) + " | " + string(_text[5]) + ".";
                        
                        if (arg2 == 0)
                            gml_Script_twitch_chat_say("/me " + string(name) + " Currently using Pet #" + string(myPetID) + " (" + string(global.globalPetInfo[myPetID][1]) + " - lv." + string(_petInfo[myPetID][0]) + ") (" + gml_Script_scr_bigNumber(myPetInfo[myPetID][5]) + "/" + gml_Script_scr_bigNumber(myPetInfo[myPetID][6]) + "xp) |" + string(_petText));
                    }
                    else
                    {
                        if (petTraining != 0)
                        {
                            var _petText = "";
                            _petText = " Pet Relics: none";
                            var _text;
                            
                            for (var _r = 1; _r <= 5; _r++)
                            {
                                var _relic;
                                _relic[_r] = petRelicSlot[petTraining][_r];
                                var _relicLv;
                                _relicLv[_r] = uniqueItemLevel[_relic[_r]];
                                
                                if (_r > floor(myPetInfo[petTraining][4] / 10))
                                {
                                    _text[_r] = "Slot " + string(_r) + ": Locked";
                                }
                                else if (_relic[_r] > 0)
                                {
                                    _text[_r] = "Slot " + string(_r) + ": " + string(global.uniqueItem[_relic[_r]][0]) + " (R" + string(_relic[_r]) + " - lv." + string(_relicLv[_r]) + " [" + string(floor(myPetRelicSlotEffect[petTraining][_r] * 100)) + "%])";
                                    var _corrupted = uniqueItemCorruption[_relic[_r]];
                                    
                                    if (_corrupted != 1)
                                        _text[_r] += " [x" + string(_corrupted) + "]";
                                }
                                else
                                {
                                    _text[_r] = "Slot " + string(_r) + ": Empty";
                                }
                            }
                            
                            _petText = " Pet Relics: " + string(_text[1]) + " | " + string(_text[2]) + " | " + string(_text[3]) + " | " + string(_text[4]) + " | " + string(_text[5]) + ".";
                            var _fulltext = "";
                            
                            for (var i = 1; i <= 5; i++)
                            {
                                var _petslot;
                                _petslot[i] = petRelicSlot[myPetID][i];
                                var _petslottext;
                                
                                if (_petslot[i] != 0)
                                    _petslottext[i] = " | Slot " + string(i) + ": Relic " + string(_petslot[i]) + " (" + string(round(myPetRelicSlotEffect[myPetID][i] * 100)) + "% effect)";
                                else
                                    _petslottext[i] = "";
                                
                                _fulltext += _petslottext[i];
                            }
                            
                            _traintext = " Currently training Pet #" + string(petTraining) + " (" + string(myPetInfo[petTraining][1]) + " - lv." + string(myPetInfo[petTraining][4]) + " - " + gml_Script_scr_bigNumber(myPetInfo[petTraining][5]) + "/" + gml_Script_scr_bigNumber(myPetInfo[petTraining][6]) + "xp) " + string(_petText);
                        }
                        
                        if (arg2 == 0)
                            gml_Script_twitch_chat_say("/me " + string(name) + " You do not have any pet following you." + string(_traintext));
                    }
                }
            }
            
            exit;
        }
        
        if (string_pos("?portal", _cmd) == 1)
        {
            var _inspect = "";
            
            if (string_pos("@", _cmd) != 0)
            {
                var _length = real(string_pos("@", _cmd));
                _inspect = string_copy(_cmd, _length + 1, 4);
            }
            
            var _name = "";
            show_debug_message(string(uname) + " is inspecting " + string(_inspect));
            
            if (_inspect == "")
                _name = uname;
            else
                _name = _inspect;
            
            var _list = "(";
            
            with (obj_player)
            {
                if (ds_list_find_index(global.raidListPortalName, string(name)) != -1)
                    _list += (string(name) + ", ");
            }
            
            _list = string_delete(_list, string_length(_list) - 1, 2);
            _list += " are ready!).";
            
            if (room == r_1)
            {
                with (obj_bossKey)
                {
                    if (alarm[0] == -1)
                    {
                        if (global.portalPoints == 0)
                        {
                            if (arg2 == 0)
                                gml_Script_twitch_chat_say("/me Underworld Portal room00Portal is currently closed.");
                        }
                        else if (global.portalPoints < global.portalMaxPoints)
                        {
                            if (arg2 == 0)
                                gml_Script_twitch_chat_say("/me The Underworld Portal room00Portal requires " + string(floor(100 - ((global.portalPoints / global.portalMaxPoints) * 100))) + "% more power to be completed.");
                        }
                        else if (arg2 == 0)
                        {
                            gml_Script_twitch_chat_say("/me The Underworld Portal room00Portal is completed, type " + string(global.cmdPrefix) + "portal to trigger it.");
                        }
                    }
                    
                    if (alarm[0] != -1)
                    {
                        if (alarm[0] > (room_speed * 60))
                        {
                            if (arg2 == 0)
                                gml_Script_twitch_chat_say("/me The Underworld Portal room00Portal is completed, " + string(ds_list_size(global.raidListPortalName)) + " raiders travelling to the Underworld in " + string(round(alarm[0] / room_speed / 60)) + " minutes " + string(_list));
                        }
                        else if (arg2 == 0)
                        {
                            gml_Script_twitch_chat_say("/me The Underworld Portal room00Portal is completed, " + string(ds_list_size(global.raidListPortalName)) + " raiders travelling to the Underworld in " + string(round(alarm[0] / room_speed)) + " seconds " + string(_list));
                        }
                    }
                }
            }
            
            if (room == global.room_underworld)
            {
                if (obj_raidPortal.alarm[0] != -1)
                {
                    if (arg2 == 0)
                        gml_Script_twitch_chat_say("/me " + string(instance_number(obj_warrior)) + " raiders are progressing in the Underworld (Floor " + string(0 - (global.portalStage - 1)) + ").");
                }
                else if (arg2 == 0)
                {
                    gml_Script_twitch_chat_say("/me Currently in the Underworld.");
                }
            }
            
            if (room == r_corrupted)
            {
                if (arg2 == 0)
                    gml_Script_twitch_chat_say("/me Currently in the Corrupted Dimension.");
            }
            
            exit;
        }
        
        if (string_pos("?redportal", _cmd) == 1)
        {
            if (global.unlockCorrupted == false)
                exit;
            
            var _inspect = "";
            
            if (string_pos("@", _cmd) != 0)
            {
                var _length = real(string_pos("@", _cmd));
                _inspect = string_copy(_cmd, _length + 1, 4);
            }
            
            var _name = "";
            show_debug_message(string(uname) + " is inspecting " + string(_inspect));
            
            if (_inspect == "")
                _name = uname;
            else
                _name = _inspect;
            
            var _list = "(";
            
            with (obj_player)
            {
                if (ds_list_find_index(global.raidListRedPortalName, string(name)) != -1)
                    _list += (string(name) + ", ");
            }
            
            _list = string_delete(_list, string_length(_list) - 1, 2);
            _list += " are ready!).";
            
            if (room == r_1)
            {
                with (obj_corruptedControl)
                {
                    if (alarm[0] == -1)
                    {
                        if (global.redPortalOpen == false)
                        {
                            if (global.redPortalCost == 0)
                            {
                                if (arg2 == 0)
                                    gml_Script_twitch_chat_say("/me The Red Portal room00Portal is completed, type " + string(global.cmdPrefix) + "redportal to trigger it.");
                            }
                            else if (arg2 == 0)
                            {
                                gml_Script_twitch_chat_say("/me The Red Portal room00Portal ritual requires " + string(global.redPortalCost) + " more Blood Gems to be completed.");
                            }
                        }
                        else if (arg2 == 0)
                        {
                            gml_Script_twitch_chat_say("/me The Red Portal room00Portal is opened, type " + string(global.cmdPrefix) + "redportal to enter it.");
                        }
                    }
                    
                    if (alarm[0] != -1)
                    {
                        if (alarm[0] > (room_speed * 60 * 60))
                        {
                            if (arg2 == 0)
                                gml_Script_twitch_chat_say("/me The Red Portal room00Portal is completed, " + string(ds_list_size(global.raidListRedPortalName)) + " raiders travelling to the Corrupted Dimension in " + string(round(alarm[0] / room_speed / 60 / 60)) + " hours " + string(_list));
                        }
                        else if (alarm[0] > (room_speed * 60))
                        {
                            if (arg2 == 0)
                                gml_Script_twitch_chat_say("/me The Red Portal room00Portal is completed, " + string(ds_list_size(global.raidListRedPortalName)) + " raiders travelling to the Corrupted Dimension in " + string(round(alarm[0] / room_speed / 60)) + " minutes " + string(_list));
                        }
                        else if (arg2 == 0)
                        {
                            gml_Script_twitch_chat_say("/me The Red Portal room00Portal is completed, " + string(ds_list_size(global.raidListRedPortalName)) + " raiders travelling to the Corrupted Dimension in " + string(round(alarm[0] / room_speed)) + " seconds " + string(_list));
                        }
                    }
                }
            }
            
            exit;
        }
        
        if (string_pos("?chest", _cmd) == 1)
        {
            var _name = "";
            var _value;
            
            with (obj_player)
            {
                if (name == other.uname)
                {
                    _value = ds_map_find_value(global.keyMap, string(name));
                    _name = name;
                    
                    if (is_undefined(_value))
                    {
                        ds_map_add(global.keyMap, string(name), 0);
                        _value = 0;
                    }
                }
            }
            
            if (uname == _name)
            {
                if (room == r_1)
                {
                    if (instance_exists(obj_build_guildhall))
                    {
                        if (obj_build_guildhall.level > 9)
                        {
                            with (obj_gameControl)
                            {
                                if (alarm[4] == -1)
                                {
                                    var _timeLeft = ceil(alarm[3] / room_speed / 60);
                                    
                                    if (_timeLeft > 60)
                                        _timeLeft = string(round(_timeLeft / 60)) + " hours";
                                    else
                                        _timeLeft = string(_timeLeft) + " minutes";
                                    
                                    if (arg2 == 0)
                                        gml_Script_twitch_chat_say("/me " + string(_name) + " Guild Chests (" + gml_Script_scr_bigNumber(lastChestValue) + " value) are available! Keys left: " + string(global.maxChestUses - _value) + "/" + string(global.maxChestUses) + " (" + string(_timeLeft) + " left).");
                                }
                                else
                                {
                                    var _timeLeft = ceil(alarm[4] / room_speed / 60);
                                    
                                    if (_timeLeft > 60)
                                        _timeLeft = string(round(_timeLeft / 60)) + " hours";
                                    else
                                        _timeLeft = string(_timeLeft) + " minutes";
                                    
                                    if (arg2 == 0)
                                        gml_Script_twitch_chat_say("/me " + string(_name) + " Guild Chests will be available in " + string(_timeLeft) + " ! (" + gml_Script_scr_bigNumber(global.rewardChestProgress) + " value | " + string(global.maxChestUses) + " keys)");
                                }
                            }
                        }
                        else if (arg2 == 0)
                        {
                            gml_Script_twitch_chat_say("/me " + string(_name) + " Guild Chests are unlocked with Guild Hall level 10.");
                        }
                    }
                    else if (arg2 == 0)
                    {
                        gml_Script_twitch_chat_say("/me " + string(_name) + " Guild Chests are unlocked with Guild Hall level 10.");
                    }
                }
                
                if (room == global.room_underworld)
                {
                    with (obj_gameControl)
                    {
                        if (alarm[4] == -1)
                        {
                            if (arg2 == 0)
                                gml_Script_twitch_chat_say("/me " + string(_name) + " Guild Chests (" + gml_Script_scr_bigNumber(lastChestValue) + " value) are available! Keys left: " + string(global.maxChestUses - _value) + "/" + string(global.maxChestUses) + " (" + string(ceil(alarm[3] / room_speed / 60)) + " minutes left).");
                        }
                        else if (arg2 == 0)
                        {
                            gml_Script_twitch_chat_say("/me " + string(_name) + " Guild Chests will be available in " + string(ceil(alarm[4] / room_speed / 60)) + " minutes! (" + gml_Script_scr_bigNumber(global.rewardChestProgress) + " value | " + string(global.maxChestUses) + " keys)");
                        }
                    }
                }
            }
            
            exit;
        }
        
        if (string_pos("?inn", _cmd) == 1 || string_pos("?town", _cmd) == 1)
        {
            var _underworld = "";
            
            if (global.souls > 0 || global.unlockCorrupted == 1)
                _underworld = " | Souls: " + gml_Script_scr_bigNumber(global.souls) + " | Blood Gems: " + gml_Script_scr_bigNumber(global.bloodgems);
            
            if (arg2 == 0)
                gml_Script_twitch_chat_say("/me Town information: Gold: " + gml_Script_scr_bigNumber(global.gold) + "/" + gml_Script_scr_bigNumber(global.maxGold) + " (" + string(round((global.gold / global.maxGold) * 100)) + "%) | Food: " + gml_Script_scr_bigNumber(global.food) + "/" + gml_Script_scr_bigNumber(global.maxFood) + " (" + string(round((global.food / global.maxFood) * 100)) + "%) | Gems: " + gml_Script_scr_bigNumber(global.gems) + string(_underworld) + " | HP: " + gml_Script_scr_bigNumber(global.townHP) + "/" + gml_Script_scr_bigNumber(global.townMaxHP) + " (" + string(round((global.townHP / global.townMaxHP) * 100)) + "%) | XP: " + gml_Script_scr_bigNumber(global.townXP) + "/" + gml_Script_scr_bigNumber(global.townMaxXP) + " (" + string(round((global.townXP / global.townMaxXP) * 100)) + "%). Town Bonuses: XP: " + gml_Script_scr_bigNumber((global.globalXPBonus - 1) * 100) + "%[x], Gold: " + gml_Script_scr_bigNumber((global.globalGoldBonus - 1) * 100) + "%[x], Food: " + gml_Script_scr_bigNumber((global.globalFoodBonus - 1) * 100) + "%[x]");
            
            exit;
        }
        
        if (string_pos("?underworld", _cmd) == 1)
        {
            if (arg2 == 0)
                gml_Script_twitch_chat_say("/me Underworld Level " + gml_Script_scr_bigNumber(global.underworldLevel) + " | XP: " + gml_Script_scr_bigNumber(global.underworldMaxXP) + " (" + string(round((global.underworldXP / global.underworldMaxXP) * 100)) + "%). Increasing enemies constitution by " + string(round((global.underworldLevel - 1) * 0.05 * (1 + (global.underworldLevel / 5)) * 100)) + "%[x]");
            
            exit;
        }
        
        if (room == r_1)
        {
            if (string_pos("!upg", _cmd) == 1)
            {
                var _buildName = string_letters(string_copy(_cmd, 5, 20));
                show_debug_message("Trying to upgrade building: " + string(_buildName));
                var _buildObj = -1;
                _buildObj = asset_get_index("obj_build_" + string(_buildName));
                
                if (!object_exists(_buildObj))
                    exit;
                
                if (ds_list_find_index(global.playerList, uname) != -1)
                {
                    if (instance_exists(_buildObj))
                    {
                        var _cost1 = _buildObj.cost;
                        var _cost2 = _buildObj.cost2;
                        
                        if (_buildObj.costText != "Maximum Level")
                        {
                            if (global.gold >= _cost1)
                            {
                                if (global.gems >= _cost2)
                                {
                                    if (!instance_exists(obj_votePoll_new))
                                    {
                                        with (gml_Script_instance_create(x, y, obj_votePoll_new))
                                        {
                                            name = other.uname;
                                            buildObj = _buildObj;
                                            buildName = _buildName;
                                            cost1 = _cost1;
                                            cost2 = _cost2;
                                            cost1type = "gold";
                                            cost2type = "gems";
                                            votes = 0;
                                            alarm[0] = 1;
                                            alarm[1] = room_speed * 60;
                                        }
                                    }
                                    else if (arg2 == 0)
                                    {
                                        gml_Script_twitch_chat_say("/me A poll is currently being made, please wait until the decision is made to start a new one.");
                                    }
                                }
                                else if (arg2 == 0)
                                {
                                    gml_Script_twitch_chat_say("/me You need more !!gems to upgrade " + string(_buildName) + ".");
                                }
                            }
                            else if (arg2 == 0)
                            {
                                gml_Script_twitch_chat_say("/me You need more gold to upgrade " + string(_buildName) + ".");
                            }
                        }
                        else if (arg2 == 0)
                        {
                            gml_Script_twitch_chat_say("/me You cannot upgrade the " + string(_buildName) + " any further!");
                        }
                    }
                    else if (arg2 == 0)
                    {
                        gml_Script_twitch_chat_say("/me You haven't built the " + string(_buildName) + " yet.");
                    }
                }
                else if (arg2 == 0)
                {
                    gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in Town!");
                }
                
                exit;
            }
        }
        
        if (string_pos("?tower", _cmd) == 1 || string_pos("?outpost", _cmd) == 1)
        {
            var _tower = string_digits(_cmd);
            
            if (_tower == "")
                _tower = 0;
            else
                _tower = real(_tower);
            
            var _text = "";
            var _upgradeText = "";
            
            if (string_pos("?outpost", _cmd) == 1)
                _tower = 0;
            else
                _tower = clamp(_tower, 1, global.portalTower);
            
            if (ds_list_find_index(global.playerList, uname) != -1)
            {
                if (_tower > 0)
                {
                    if (global.towerBuilding[_tower][4] < 1)
                    {
                        gml_Script_twitch_chat_say("/me " + string(uname) + " You must clear Underworld Tower " + string(_tower) + " first!");
                        exit;
                    }
                    
                    var _timeLeft = " hours left)";
                    var _timer = obj_portal.alarm[_tower] / room_speed / 60 / 60;
                    
                    if (_timer < 1)
                    {
                        _timer *= 60;
                        _timeLeft = " minutes left)";
                    }
                    
                    _timer = ceil(_timer);
                    _timeLeft = string(_timer) + _timeLeft;
                    _text += ("Underworld Tower " + string(_tower) + " (lv." + string(global.towerBuilding[_tower][4]) + "): ");
                    _text += (string(global.towerBuilding[_tower][0]) + " has a production rate of " + string(global.towerBuilding[_tower][1]) + "/" + string(global.towerBuilding[_tower][2] / 60 / 60) + "h (current cycle: " + string(_timeLeft));
                    _upgradeText = " | Upgrade cost: " + gml_Script_scr_bigNumber(global.towerBuilding[_tower][5]) + " souls";
                    
                    if (global.towerBuilding[_tower][6] > 0)
                        _upgradeText += (" and " + string(global.towerBuilding[_tower][6]) + " Blood Gems");
                    
                    _text += (string(_upgradeText) + ".");
                    gml_Script_twitch_chat_say("/me " + string(uname) + " " + string(_text));
                }
                else
                {
                    if (global.towerBuilding[_tower][1] < 1)
                    {
                        gml_Script_twitch_chat_say("/me " + string(uname) + " You must build the Underworld Outpost first!");
                        exit;
                    }
                    
                    _text += ("Underworld Outpost (lv." + string(global.towerBuilding[_tower][1]) + "): ");
                    _text += ("+" + gml_Script_scr_bigNumber(global.towerBuilding[_tower][4]) + " gold/h (" + string(ceil(obj_portal.alarm[5] / room_speed / 60)) + "m left)");
                    
                    if (global.towerBuilding[_tower][6] > 0)
                        _upgradeText += (" and " + string(global.towerBuilding[_tower][6]) + " Blood Gems");
                    
                    if (global.towerBuilding[_tower][1] > 4)
                        _text += (" | +" + gml_Script_scr_bigNumber(global.towerBuilding[_tower][7]) + " XP/h (" + string(ceil(obj_portal.alarm[6] / room_speed / 60)) + "m left)");
                    
                    if (global.towerBuilding[_tower][1] > 9)
                        _text += (" | +" + gml_Script_scr_bigNumber(global.towerBuilding[_tower][10]) + " room00Talent /h (" + string(ceil(obj_portal.alarm[7] / room_speed / 60)) + "m left)");
                    
                    if (global.towerBuilding[_tower][1] > 14)
                        _text += (" | +" + gml_Script_scr_bigNumber(global.towerBuilding[_tower][13]) + " gems/h (" + string(ceil(obj_portal.alarm[8] / room_speed / 60)) + "m left)");
                    
                    _upgradeText = " | Upgrade cost: " + gml_Script_scr_bigNumber(global.towerBuilding[_tower][2]) + " souls";
                    
                    if (global.towerBuilding[_tower][3] > 0)
                        _upgradeText += (" and " + string(global.towerBuilding[_tower][3]) + " Blood Gems");
                    
                    _text += (string(_upgradeText) + ".");
                    gml_Script_twitch_chat_say("/me " + string(uname) + " " + string(_text));
                }
            }
            else if (arg2 == 0)
            {
                gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the Underworld!");
            }
        }
        
        if (room == r_underworld_new)
        {
            if (string_pos("!upgtower", _cmd) == 1 || string_pos("!upgoutpost", _cmd) == 1 || string_pos("!buildoutpost", _cmd) == 1 || string_pos("!buildtower", _cmd) == 1)
            {
                var _tower;
                
                if (string_pos("!upgtower", _cmd) == 1 || string_pos("!buildtower", _cmd) == 1)
                {
                    _tower = string_digits(_cmd);
                    
                    if (_tower == "")
                        _tower = 0;
                    else
                        _tower = real(_tower);
                }
                else
                {
                    _tower = 0;
                }
                
                if (string_pos("!upgoutpost", _cmd) == 1 || string_pos("!buildoutpost", _cmd) == 1)
                    _tower = 0;
                else
                    _tower = clamp(_tower, 1, global.portalTower);
                
                var _cost1 = 0;
                var _cost2 = 0;
                var _buildname = "";
                var _buildName;
                
                if (_tower != 0)
                {
                    _tower = clamp(_tower, 1, global.portalTower);
                    _cost1 = global.towerBuilding[_tower][5];
                    _cost2 = global.towerBuilding[_tower][6];
                    _buildName = "Underworld Tower " + string(_tower);
                    
                    if (global.towerBuilding[_tower][4] == 0)
                    {
                        _cost1 = 100000000 * (_tower * 10);
                        _cost2 = 0;
                    }
                }
                else
                {
                    _cost1 = global.towerBuilding[_tower][2];
                    _cost2 = global.towerBuilding[_tower][3];
                    _buildName = "the Underworld Outpost";
                    
                    if (global.towerBuilding[0][1] == 0)
                    {
                        _cost1 = 50000000;
                        _cost2 = 0;
                    }
                }
                
                if (_tower != 0 && global.towerBuilding[0][1] == 0)
                {
                    gml_Script_twitch_chat_say("/me " + string(uname) + " you need an Underworld Outpost before building on the Underworld Towers! (!build outpost)");
                    exit;
                }
                
                if (ds_list_find_index(global.playerList, uname) != -1)
                {
                    if (_tower != 0)
                    {
                        if (global.portalTower > _tower)
                        {
                            if (global.towerBuilding[_tower][4] == 0)
                            {
                                if (global.gold >= _cost1)
                                {
                                    global.towerBuilding[_tower][4] = 1;
                                    global.gold -= _cost1;
                                    gml_Script_scr_updateTowers();
                                }
                                else
                                {
                                    gml_Script_twitch_chat_say("/me " + string(uname) + " The Town needs " + gml_Script_scr_bigNumber(_cost1 - global.gold) + " more gold to build on the Underworld Tower " + string(_tower) + "!");
                                }
                                
                                exit;
                            }
                        }
                        else
                        {
                            gml_Script_twitch_chat_say("/me " + string(uname) + " You have not cleared Underworld Tower " + string(_tower) + " yet...");
                            exit;
                        }
                    }
                    else if (global.towerBuilding[0][1] == 0)
                    {
                        if (global.gold >= _cost1)
                        {
                            global.towerBuilding[0][1] = 1;
                            global.gold -= _cost1;
                            gml_Script_twitch_chat_say("/me " + string(uname) + " You built the Underworld Outpost. You can now expand and build on Towers when you clear them, but be careful, it seems like the more souls you spend on the Underworld, the stronger the enemies will become...");
                            gml_Script_scr_updateTowers();
                        }
                        else
                        {
                            gml_Script_twitch_chat_say("/me " + string(uname) + " The Town needs " + gml_Script_scr_bigNumber(_cost1 - global.gold) + " more gold to build the Underworld Oupost!");
                        }
                        
                        exit;
                    }
                    
                    if (global.portalTower > _tower)
                    {
                        if (global.souls >= _cost1)
                        {
                            if (global.bloodgems >= _cost2)
                            {
                                if (!instance_exists(obj_votePoll_new))
                                {
                                    with (instance_create_depth(x, y, depth - 100, obj_votePoll_new))
                                    {
                                        name = other.uname;
                                        buildObj = obj_portal;
                                        buildName = _buildName;
                                        cost1 = _cost1;
                                        cost2 = _cost2;
                                        cost1type = "souls";
                                        cost2type = "blood gems";
                                        votes = 0;
                                        alarm[0] = 1;
                                        alarm[1] = room_speed * 60;
                                    }
                                }
                                else if (arg2 == 0)
                                {
                                    gml_Script_twitch_chat_say("/me A poll is currently being made, please wait until the decision is made to start a new one.");
                                }
                            }
                            else if (arg2 == 0)
                            {
                                gml_Script_twitch_chat_say("/me You need more !!Blood Gems to upgrade " + string(_buildName) + ".");
                            }
                        }
                        else if (arg2 == 0)
                        {
                            gml_Script_twitch_chat_say("/me You need more !!Souls to upgrade " + string(_buildName) + ".");
                        }
                    }
                    else if (arg2 == 0)
                    {
                        gml_Script_twitch_chat_say("/me You have not cleared " + string(_buildName) + " yet.");
                    }
                }
                else if (arg2 == 0)
                {
                    gml_Script_twitch_chat_say("/me " + string(uname) + " Looks like you are not in the Underworld!");
                }
                
                exit;
            }
        }
        
        if (string_pos("?forge", _cmd) == 1)
        {
            if (room == r_1)
            {
                with (obj_player)
                {
                    if (name == other.uname)
                    {
                        var _uses = forgedItem;
                        
                        if (instance_exists(obj_build_forge))
                        {
                            with (obj_build_forge)
                            {
                                if (alarm[0] == -1)
                                {
                                    if (arg2 == 0)
                                        gml_Script_twitch_chat_say("/me The blacksmith needs " + gml_Script_scr_bigNumber(forgeItem[0][1] - forgeItem[0][0]) + " more materials to start forging.");
                                }
                                else if (arg2 == 0)
                                {
                                    gml_Script_twitch_chat_say("/me " + string(other.name) + " Forging is available for " + string(ceil(alarm[0] / room_speed / 60)) + " minutes (" + string(_uses) + " uses left).");
                                }
                            }
                        }
                        else if (arg2 == 0)
                        {
                            gml_Script_twitch_chat_say("/me " + string(name) + " Forging requires a blacksmith.");
                        }
                    }
                }
            }
            
            exit;
        }
        
        if (string_pos("?reforge", _cmd) == 1)
        {
            if (room == r_1)
            {
                with (obj_player)
                {
                    if (name == other.uname)
                    {
                        var _uses = forgedRelic;
                        
                        if (instance_exists(obj_build_forge))
                        {
                            if (obj_build_forge.level > 13)
                            {
                                with (obj_build_forge)
                                {
                                    if (alarm[1] == -1)
                                    {
                                        if (arg2 == 0)
                                            gml_Script_twitch_chat_say("/me The blacksmith needs " + string(forgeItem[1][1] - forgeItem[1][0]) + " more Relics to start reforging.");
                                    }
                                    else if (arg2 == 0)
                                    {
                                        gml_Script_twitch_chat_say("/me " + string(other.name) + " Reforging is available for " + string(ceil(alarm[1] / room_speed / 60)) + " minutes (" + string(_uses) + " uses left).");
                                    }
                                }
                            }
                            else if (arg2 == 0)
                            {
                                gml_Script_twitch_chat_say("/me " + string(name) + " Reforging requires a level 14 forge.");
                            }
                        }
                        else if (arg2 == 0)
                        {
                            gml_Script_twitch_chat_say("/me " + string(name) + " Forging requires a blacksmith.");
                        }
                    }
                }
            }
            
            exit;
        }
        
        if (string_pos("?witch", _cmd) == 1 || string_pos("?enchant", _cmd) == 1 || string_pos("?sac", _cmd) == 1)
        {
            if (room == r_1)
            {
                if (instance_exists(obj_build_witchhut))
                {
                    with (obj_build_witchhut)
                    {
                        if (alarm[0] == -1)
                        {
                            if (arg2 == 0)
                                gml_Script_twitch_chat_say("/me The witch needs " + gml_Script_scr_bigNumber(global.recipeMax - global.recipeProgress) + " more souls in her cauldron...");
                        }
                        else if (arg2 == 0)
                        {
                            gml_Script_twitch_chat_say("/me Enchanting is available for " + string(ceil(alarm[0] / room_speed / 60)) + " minutes.");
                        }
                    }
                }
                else if (arg2 == 0)
                {
                    gml_Script_twitch_chat_say("/me " + string(uname) + " Enchanting requires a witch.");
                }
            }
            
            exit;
        }
        
        if (string_pos("?auto", _cmd) == 1)
        {
            var _inspect = "";
            
            if (string_pos("@", _cmd) != 0)
            {
                var _length = real(string_pos("@", _cmd));
                _inspect = string_copy(_cmd, _length + 1, 4);
            }
            
            var _name = "";
            show_debug_message(string(uname) + " is inspecting " + string(_inspect));
            
            if (_inspect == "")
                _name = uname;
            else
                _name = _inspect;
            
            with (obj_player)
            {
                if (string_pos(_name, name) == 1)
                {
                    var _autopot = autoPot;
                    
                    if (_autopot == 1)
                        _autopot = "ON (at " + string(autoPotHP * 100) + "% HP)";
                    else
                        _autopot = "OFF";
                    
                    var _autoskill = autoAbility;
                    
                    if (_autoskill == 1)
                        _autoskill = "ON";
                    else
                        _autoskill = "OFF";
                    
                    var _autoswitch = autoSwitch;
                    
                    if (_autoswitch == 1)
                        _autoswitch = "ON";
                    else
                        _autoswitch = "OFF";
                    
                    var _autorest = "";
                    
                    if (myTier > 0)
                        _autorest = "ON";
                    else
                        _autorest = "OFF";
                    
                    var _autoloot = autoLoot;
                    
                    if (_autoloot == 1)
                        _autoloot = "ON";
                    else
                        _autoloot = "OFF";
                    
                    var _autobuy = autoBuy;
                    
                    if (_autobuy == 1)
                        _autobuy = "ON";
                    else
                        _autobuy = "OFF";
                    
                    var _autoMine = "";
                    var _autoFarm = "";
                    var _autoGuard = "";
                    var _autoRaid = "";
                    
                    if (canAutoAction[0] == 1)
                    {
                        if (autoAction[0] == 1)
                            _autoMine = " | Auto-mine: ON";
                        else
                            _autoMine = " | Auto-mine: OFF";
                    }
                    
                    if (canAutoAction[1] == 1)
                    {
                        if (autoAction[1] == 1)
                            _autoFarm = " | Auto-farm: ON";
                        else
                            _autoFarm = " | Auto-farm: OFF";
                    }
                    
                    if (canAutoAction[2] == 1)
                    {
                        if (autoAction[2] == 1)
                            _autoGuard = " | Auto-guard: ON";
                        else
                            _autoGuard = " | Auto-guard: OFF";
                    }
                    
                    if (canAutoAction[3] == 1)
                    {
                        if (autoAction[3] == 1)
                            _autoRaid = " | Auto-raid: ON";
                        else
                            _autoRaid = " | Auto-raid: OFF";
                    }
                    
                    if (arg2 == 0)
                        gml_Script_twitch_chat_say("/me " + string(name) + " Auto-pot: " + string(_autopot) + " | Auto-ability: " + string(_autoskill) + " | Auto-switch: " + string(_autoswitch) + " | Auto-rest: " + string(_autorest) + " | Auto-loot: " + string(_autoloot) + " | Auto-buy: " + string(_autobuy) + string(_autoMine) + string(_autoFarm) + string(_autoGuard) + string(_autoRaid) + ".");
                }
            }
        }
        
        if (string_pos("?skill", _cmd) == 1 || string_pos("?ability", _cmd) == 1)
        {
            var _inspect = "";
            
            if (string_pos("@", _cmd) != 0)
            {
                var _length = real(string_pos("@", _cmd));
                _inspect = string_copy(_cmd, _length + 1, 4);
            }
            
            var _name = "";
            show_debug_message(string(uname) + " is inspecting " + string(_inspect));
            
            if (_inspect == "")
                _name = uname;
            else
                _name = _inspect;
            
            with (obj_player)
            {
                if (string_pos(_name, name) == 1)
                {
                    gml_Script_scr_updateStats();
                    var _text = string(myAbilityInfo[0] + 1) + " (" + string(myAbilityInfo[1]) + " " + string(myAbilityInfo[6]) + ") - Level " + string(myAbilityInfo[4]) + " (";
                    
                    if (myAbilityInfo[7] > -1)
                        _text += (gml_Script_scr_bigNumber(myAbilityInfo[7]) + "/" + gml_Script_scr_bigNumber(myAbilityInfo[8]) + "xp)");
                    else
                        _text += "Maxed)";
                    
                    _text += (": " + gml_Script_scr_skillDesc(myAbilityInfo[2], myAbilityInfo[4]));
                    
                    if (specialized != 0)
                        _text += " Check Upgrade Branches info with ?spec.";
                    
                    if (arg2 == 0)
                        gml_Script_twitch_chat_say("/me " + string(name) + " using ability " + string(_text));
                }
                else
                {
                    show_debug_message(string(_inspect) + " player not found");
                }
            }
        }
        
        if (string_pos("?spec", _cmd) == 1)
        {
            var _inspect = "";
            
            if (string_pos("@", _cmd) != 0)
            {
                var _length = real(string_pos("@", _cmd));
                _inspect = string_copy(_cmd, _length + 1, 4);
            }
            
            var _name = "";
            show_debug_message(string(uname) + " is inspecting " + string(_inspect));
            
            if (_inspect == "")
                _name = uname;
            else
                _name = _inspect;
            
            with (obj_player)
            {
                if (string_pos(_name, name) == 1)
                {
                    var _text = string(myAbilityInfo[0] + 1) + " (" + string(myAbilityInfo[1]) + " " + string(myAbilityInfo[6]) + ", Level " + string(myAbilityInfo[4]) + "):";
                    
                    if (specialized != 0)
                    {
                        for (var i = 0; i < global.globalSpecialBranches; i += 1)
                        {
                            var _makePercent = 1;
                            
                            if (string(global.globalSpecialInfo[classType][specialized - 1][myAbilityInfo[0]][i][4]) == "%")
                                _makePercent = 100;
                            
                            var _extraPoints = floor(mySpecialInfo[classType][specialized - 1][myAbilityInfo[0]][i] / 3);
                            _text += (" " + string(i + 1) + " (" + string(global.globalSpecialInfo[classType][specialized - 1][myAbilityInfo[0]][i][1]) + " [" + string(global.globalSpecialInfo[classType][specialized - 1][myAbilityInfo[0]][i][2] * _makePercent) + string(global.globalSpecialInfo[classType][specialized - 1][myAbilityInfo[0]][i][4]) + "/SP]): " + string(mySpecialInfo[classType][specialized - 1][myAbilityInfo[0]][i]) + "/" + string(global.globalSpecialInfo[classType][specialized - 1][myAbilityInfo[0]][i][3]) + " [+" + string(global.globalSpecialInfo[classType][specialized - 1][myAbilityInfo[0]][i][2] * (mySpecialInfo[classType][specialized - 1][myAbilityInfo[0]][i] + _extraPoints) * _makePercent) + string(global.globalSpecialInfo[classType][specialized - 1][myAbilityInfo[0]][i][4]) + "],");
                        }
                        
                        _text += (" " + string(specialPoints[myAbilityInfo[0]]) + " SP available.");
                    }
                    
                    if (arg2 == 0)
                        gml_Script_twitch_chat_say("/me " + string(name) + " Upgrade Branches for ability " + string(_text));
                }
                else
                {
                    show_debug_message(string(_inspect) + " player not found");
                }
            }
        }
        
        if (string_pos("?voc", _cmd) == 1)
        {
            var _inspect = "";
            
            if (string_pos("@", _cmd) != 0)
            {
                var _length = real(string_pos("@", _cmd));
                _inspect = string_copy(_cmd, _length + 1, 4);
            }
            
            var _name = "";
            show_debug_message(string(uname) + " is inspecting " + string(_inspect));
            
            if (_inspect == "")
                _name = uname;
            else
                _name = _inspect;
            
            with (obj_player)
            {
                if (string_pos(_name, name) == 1)
                {
                    var vpLeft = "";
                    
                    if (action > 0 && action < 5)
                    {
                        var _vpgain = actionPoints[action] * vpBonus;
                        show_debug_message(string(global.actionText[action]) + " VP/s = " + string(_vpgain) + " (" + string(actionPoints[action]) + " * " + string(vpBonus) + ")");
                        var _reward = "";
                        var _amount = "";
                        var _text = "";
                        
                        if (action == 1)
                        {
                            var _max = obj_build_mine.amount;
                            _reward = "gold";
                            _amount = goldvalue * myMultiplier[4] * global.globalGoldBonus;
                            
                            if (_amount > _max)
                                _amount = _max;
                        }
                        
                        if (action == 2)
                        {
                            var _max = obj_build_farm.amount;
                            _reward = "food";
                            _amount = foodvalue * myMultiplier[4] * global.globalFoodBonus;
                            
                            if (_amount > _max)
                                _amount = _max;
                        }
                        
                        if (_reward != "")
                            _text = " and " + gml_Script_scr_bigNumber(_amount) + " " + string(_reward);
                        else
                            _text = "";
                        
                        vpLeft = " (+" + gml_Script_scr_bigNumber(_vpgain) + " VP" + string(_text) + " per tick | ";
                        
                        if (myVocationInfo[action - 1][1] > -1)
                            vpLeft += (gml_Script_scr_bigNumber(myVocationInfo[action - 1][2] - myVocationInfo[action - 1][1]) + " VP for lv." + string(myVocationInfo[action - 1][0]) + ")");
                        else
                            vpLeft += "Maxed)";
                    }
                    
                    if (action == 5)
                    {
                        var _amount = obj_build_train.amount;
                        var _amount2 = 1 * myMultiplier[2] * global.academyXpBonus * skillBonus;
                        _amount *= (myMultiplier[2] * global.academyXpBonus);
                        vpLeft = " (+" + string(gml_Script_scr_bigNumber(_amount)) + "XP and " + string(gml_Script_scr_bigNumber(_amount2)) + " Ability XP per tick)";
                    }
                    
                    if (arg2 == 0)
                        gml_Script_twitch_chat_say("/me " + string(name) + " currently " + string(global.actionText[action]) + string(vpLeft) + ".");
                }
            }
        }
        
        if (string_pos("?don", _cmd) == 1)
        {
            var _inspect = "";
            
            if (string_pos("@", _cmd) != 0)
            {
                var _length = real(string_pos("@", _cmd));
                _inspect = string_copy(_cmd, _length + 1, 4);
            }
            
            var _name = "";
            show_debug_message(string(uname) + " is inspecting " + string(_inspect));
            
            if (_inspect == "")
                _name = uname;
            else
                _name = _inspect;
            
            with (obj_player)
            {
                if (string_pos(_name, name) == 1)
                {
                    var _gold = gml_Script_scr_bigNumber(donated);
                    var _food = gml_Script_scr_bigNumber(donated_food);
                    var _gems = gml_Script_scr_bigNumber(donated_gems);
                    var _text = "has donated/spent " + string(_gold) + " gold, " + string(_food) + " food and " + string(_gems) + " room00Gem during this Campaign.";
                    
                    if (donated_gems >= 1000)
                    {
                        _text += " PogChamp";
                        var _repeat = floor(donated_gems / 3000);
                        
                        repeat (_repeat)
                            _text += " PogChamp";
                    }
                    
                    if (arg2 == 0)
                        gml_Script_twitch_chat_say("/me " + string(name) + " " + string(_text));
                }
            }
        }
        
        if (string_pos("?relic", _cmd) == 1 || string_pos("?r", _cmd) == 1)
        {
            var _inspect = "";
            
            if (string_pos("@", _cmd) != 0)
            {
                var _length = real(string_pos("@", _cmd));
                _inspect = string_copy(_cmd, _length + 1, 4);
            }
            
            var _name = "";
            var _relicID = 0;
            
            if (string_digits(_cmd) != "")
                _relicID = real(string_digits(_cmd));
            
            if (_relicID > (array_length(global.uniqueItem) - 1))
                _relicID = 0;
            
            show_debug_message(string(uname) + " is inspecting " + string(_inspect));
            
            if (_inspect == "")
                _name = uname;
            else
                _name = _inspect;
            
            with (obj_player)
            {
                if (string_pos(_name, name) == 1)
                {
                    if (_relicID == 0)
                    {
                        show_debug_message("my relic slots: " + string(myRelicSlots));
                        var _text;
                        
                        for (var _r = 1; _r <= 3; _r++)
                        {
                            var _relic;
                            _relic[_r] = uniqueSlot[_r];
                            var _relicLv;
                            _relicLv[_r] = uniqueItemLevel[_relic[_r]];
                            
                            if (_r > myRelicSlots || level < 100)
                            {
                                _text[_r] = "Slot " + string(_r) + ": Locked";
                            }
                            else if (_relic[_r] > 0)
                            {
                                _text[_r] = "Slot " + string(_r) + ": " + string(global.uniqueItem[_relic[_r]][0]) + " (R" + string(_relic[_r]) + " - lv." + string(_relicLv[_r]);
                                var _corrupted = uniqueItemCorruption[_relic[_r]];
                                
                                if (_corrupted != 1)
                                    _text[_r] += " [x" + string(_corrupted) + "]";
                                
                                _text[_r] += ")";
                            }
                            else
                            {
                                _text[_r] = "Slot " + string(_r) + ": Empty";
                            }
                        }
                        
                        var _relicText = "Equiped Relics: " + string(_text[1]) + " | " + string(_text[2]) + " | " + string(_text[3]) + ".";
                        var _petText = "";
                        
                        if (myPetID > 0)
                        {
                            _petText = " Pet Relics: none";
                            
                            for (var _r = 1; _r <= 5; _r++)
                            {
                                var _relic;
                                _relic[_r] = petRelicSlot[myPetID][_r];
                                var _relicLv;
                                _relicLv[_r] = uniqueItemLevel[_relic[_r]];
                                
                                if (_r > floor(myPetInfo[myPetID][4] / 10))
                                {
                                    _text[_r] = "Slot " + string(_r) + ": Locked";
                                }
                                else if (_relic[_r] > 0)
                                {
                                    _text[_r] = "Slot " + string(_r) + ": " + string(global.uniqueItem[_relic[_r]][0]) + " (R" + string(_relic[_r]) + " - lv." + string(_relicLv[_r]) + " [" + string(round(myPetRelicSlotEffect[myPetID][_r] * 100)) + "%]";
                                    var _corrupted = uniqueItemCorruption[_relic[_r]];
                                    
                                    if (_corrupted != 1)
                                        _text[_r] += " [x" + string(_corrupted) + "]";
                                    
                                    _text[_r] += ")";
                                }
                                else
                                {
                                    _text[_r] = "Slot " + string(_r) + ": Empty";
                                }
                            }
                            
                            _petText = " Pet Relics: " + string(_text[1]) + " | " + string(_text[2]) + " | " + string(_text[3]) + " | " + string(_text[4]) + " | " + string(_text[5]) + ".";
                        }
                        
                        var _relicSetText = "";
                        var _activeSet = 0;
                        
                        if ((equippedUniqueItem[21] == 1 || myPetEquippedRelic[myPetID][21] == 1) && (equippedUniqueItem[22] == 1 || myPetEquippedRelic[myPetID][22] == 1) && (equippedUniqueItem[23] == 1 || myPetEquippedRelic[myPetID][23] == 1))
                        {
                            _activeSet = 1;
                            _relicSetText += (" Odd Stones Set (+" + string((gml_Script_scr_relicSetCheck(id, 0, 21) / 2) + (gml_Script_scr_relicSetCheck(id, 0, 22) / 2) + (gml_Script_scr_relicSetCheck(id, 0, 23) / 2)) + "%[+] damage output).");
                        }
                        
                        if ((equippedUniqueItem[10] == 1 || myPetEquippedRelic[myPetID][10] == 1) && (equippedUniqueItem[11] == 1 || myPetEquippedRelic[myPetID][11] == 1) && (equippedUniqueItem[12] == 1 || myPetEquippedRelic[myPetID][12] == 1))
                        {
                            _activeSet = 1;
                            _relicSetText += " Sim's Gear Set: (Deal damage when losing stacks).";
                        }
                        
                        if (arg2 == 0)
                            gml_Script_twitch_chat_say("/me " + string(name) + " " + string(_relicText) + string(_petText));
                        
                        if (arg2 == 0 && _activeSet > 0)
                            gml_Script_twitch_chat_say("/me " + string(name) + " Active Relic Sets:" + string(_relicSetText));
                    }
                    else
                    {
                        var _relic = _relicID;
                        var _relicEffect, _relicPetEffect, _relicText, _petSlot, _relicEffectText;
                        
                        if (gotUniqueItem[_relic] > 0)
                        {
                            var _relicLv = uniqueItemLevel[_relic];
                            _relicEffect = (global.uniqueItem[_relic][2] + (global.uniqueItem[_relic][4] * (uniqueItemLevel[_relic] - 1))) * uniqueItemCorruption[_relic];
                            _relicEffectText = gml_Script_scr_relicCheck(id, 0, _relic);
                            _relicPetEffect = 1;
                            var _relicPetEffectText = "";
                            _petSlot = 1;
                            _relicText = "Your Relic " + string(_relic) + " (" + string(global.uniqueItem[_relic][0]) + ") is at level " + string(_relicLv);
                            var _corrupted = uniqueItemCorruption[_relic];
                            
                            if (_corrupted != 1)
                                _relicText += (" [x" + string(_corrupted) + " corruption effect]");
                            
                            _relicText += ".";
                        }
                        else
                        {
                            var _relicLv = 1;
                            _relicEffect = global.uniqueItem[_relic][2] + (global.uniqueItem[_relic][4] * _relicLv);
                            _relicEffectText = gml_Script_scr_relicCheck(id, 0, _relic);
                            _relicPetEffect = 1;
                            var _relicPetEffectText = "";
                            _petSlot = 1;
                            _relicText = "You don't own this Relic yet (showing level 1 scaling).";
                        }
                        
                        for (var _r = 1; _r <= 5; _r++)
                        {
                            if (petRelicSlot[myPetID][_r] == _relic)
                            {
                                _relicPetEffect = myPetRelicSlotEffect[myPetID][_r];
                                _relicPetEffect = _relicEffect * _relicPetEffect;
                                _petSlot = _r;
                            }
                        }
                        
                        if (_relic == 9)
                            _relicEffectText = string(gml_Script_scr_bigNumber(((myStatInfo[0][3] / 4000) + (myStatInfo[9][3] / 4000)) * (myStatInfo[4][3] / 10) * (90 + (uniqueItemLevel[9] * 10)) * uniqueItemCorruption[9]));
                        
                        if (_relicPetEffect != 1)
                        {
                            if (_relic != 9)
                            {
                                if (global.uniqueItem[_relic][6] == "%")
                                    _relicPetEffect *= 100;
                                
                                var _relicPetEffectText = string(gml_Script_scr_bigNumber(_relicPetEffect)) + global.uniqueItem[_relic][6];
                                _relicText += (" " + string_replace(global.uniqueItem[_relic][7], "*", _relicPetEffectText) + " (at " + string(floor(myPetRelicSlotEffect[myPetID][_petSlot] * 100)) + "% effectiveness from Pet Relic Slot " + string(_petSlot) + ")");
                            }
                            
                            if (_relic == 9)
                            {
                                var _relicPetEffectText = string(gml_Script_scr_bigNumber(((myStatInfo[0][3] / 4000) + (myStatInfo[9][3] / 4000)) * (myStatInfo[4][3] / 10) * ((90 + (uniqueItemLevel[9] * 10)) * uniqueItemCorruption[9] * myPetRelicSlotEffect[myPetID][_petSlot])));
                                _relicText += (" " + string_replace(global.uniqueItem[9][7], "*", _relicPetEffectText) + " (at " + string(floor(myPetRelicSlotEffect[myPetID][_petSlot] * 100)) + "% effectiveness from Pet Relic Slot " + string(_petSlot) + ")");
                            }
                            
                            if (_relic == 13)
                            {
                                var _relicPetEffectText = string(gml_Script_scr_bigNumber(myStatInfo[8][3] * (0.05 + (0.01 * (uniqueItemLevel[13] - 1))) * uniqueItemCorruption[13] * myPetRelicSlotEffect[myPetID][_petSlot]));
                                _relicText = string_replace(_relicText, "*", _relicPetEffectText);
                            }
                            
                            if (_relic == 19)
                            {
                                var _relicPetEffectText = string(gml_Script_scr_bigNumber(((myStatInfo[4][3] * 10 * (uniqueItemLevel[19] - 1)) / 5) * uniqueItemCorruption[19] * myPetRelicSlotEffect[myPetID][_petSlot]));
                                _relicText = string_replace(_relicText, "*", _relicPetEffectText);
                            }
                            
                            if (_relic == 20)
                            {
                                var _relicPetEffectText = string(gml_Script_scr_bigNumber((global.uniqueItem[20][2] + (global.uniqueItem[20][4] * (uniqueItemLevel[20] - 1))) * 10 * uniqueItemCorruption[20] * myPetRelicSlotEffect[myPetID][_petSlot] * 100) + "%");
                                _relicText = string_replace(_relicText, "*", _relicPetEffectText);
                            }
                            
                            if (_relic == 24)
                            {
                                var _relicPetEffectText = string(gml_Script_scr_bigNumber((global.uniqueItem[24][2] + (global.uniqueItem[24][4] * (uniqueItemLevel[24] - 1))) * 0.5 * uniqueItemCorruption[24] * myPetRelicSlotEffect[myPetID][_petSlot] * 100) + "%");
                                _relicText = string_replace(_relicText, "*", _relicPetEffectText);
                            }
                            
                            if (_relic == 27)
                            {
                                _relicEffectText = string(gml_Script_scr_bigNumber((global.uniqueItem[27][2] + (global.uniqueItem[27][4] * (uniqueItemLevel[27] - 1))) * 0.5 * uniqueItemCorruption[27] * 100) + "%");
                                _relicText = string_replace(_relicText, "*", _relicEffectText);
                            }
                        }
                        else
                        {
                            _relicText += (" " + string_replace(global.uniqueItem[_relic][7], "*", _relicEffectText));
                            
                            if (_relic == 13)
                            {
                                _relicEffectText = string(gml_Script_scr_bigNumber(myStatInfo[8][3] * (0.05 + (0.01 * (uniqueItemLevel[13] - 1))) * uniqueItemCorruption[13]));
                                _relicText = string_replace(_relicText, "*", _relicEffectText);
                            }
                            
                            if (_relic == 19)
                            {
                                _relicEffectText = string(gml_Script_scr_bigNumber(((myStatInfo[4][3] * 10 * (uniqueItemLevel[19] - 1)) / 5) * uniqueItemCorruption[19]));
                                _relicText = string_replace(_relicText, "*", _relicEffectText);
                            }
                            
                            if (_relic == 20)
                            {
                                _relicEffectText = string(gml_Script_scr_bigNumber((global.uniqueItem[20][2] + (global.uniqueItem[20][4] * (uniqueItemLevel[20] - 1))) * 10 * uniqueItemCorruption[20] * 100) + "%");
                                _relicText = string_replace(_relicText, "*", _relicEffectText);
                            }
                            
                            if (_relic == 24)
                            {
                                _relicEffectText = string(gml_Script_scr_bigNumber((global.uniqueItem[24][2] + (global.uniqueItem[24][4] * (uniqueItemLevel[24] - 1))) * 0.5 * uniqueItemCorruption[24] * 100) + "%");
                                _relicText = string_replace(_relicText, "*", _relicEffectText);
                            }
                            
                            if (_relic == 27)
                            {
                                _relicEffectText = string(gml_Script_scr_bigNumber((global.uniqueItem[27][2] + (global.uniqueItem[27][4] * (uniqueItemLevel[27] - 1))) * 0.5 * uniqueItemCorruption[27] * 100) + "%");
                                _relicText = string_replace(_relicText, "*", _relicEffectText);
                            }
                        }
                        
                        var _relicSetText = "";
                        var _status = "inactive";
                        
                        if (_relic == 21 || _relic == 22 || _relic == 23)
                        {
                            if ((equippedUniqueItem[21] == 1 || myPetEquippedRelic[myPetID][21] == 1) && (equippedUniqueItem[22] == 1 || myPetEquippedRelic[myPetID][22] == 1) && (equippedUniqueItem[23] == 1 || myPetEquippedRelic[myPetID][23] == 1))
                                _status = "active";
                            
                            _relicSetText = " | Odd Stones Set effect (" + string(_status) + "): All your Odd Stones debuffs become permanent.";
                        }
                        
                        if (_relic == 10 || _relic == 11 || _relic == 12)
                        {
                            if ((equippedUniqueItem[10] == 1 || myPetEquippedRelic[myPetID][10] == 1) && (equippedUniqueItem[11] == 1 || myPetEquippedRelic[myPetID][11] == 1) && (equippedUniqueItem[12] == 1 || myPetEquippedRelic[myPetID][12] == 1))
                                _status = "active";
                            
                            _relicSetText = " | Sim's Gear Set effect (" + string(_status) + "): When losing your stacks deal physical, special, and true damage based on the amount of stats obtained with each Relic.";
                        }
                        
                        var _relicTerrText = "Relic " + string(_relic) + " detected on areas:";
                        
                        for (var i = 1; i < array_length(obj_raid.specialRaid); i++)
                        {
                            for (var ii = 1; ii <= 3; ii += 1)
                            {
                                if (obj_raid.specialRaid[floor(i)][ii] == _relic)
                                {
                                    _relicTerrText += (" " + string(i * 50));
                                    show_debug_message("Territory Boss " + string(i) + " (raid " + string(i * 50) + ") has it.");
                                    
                                    if (obj_raid.custom_alarm[50 + i][0] > -1)
                                        _relicTerrText += " (on cooldown)";
                                    
                                    _relicTerrText += ",";
                                    show_debug_message(_relicTerrText);
                                }
                            }
                        }
                        
                        if (string_pos(",", _relicTerrText) != 0)
                            _relicTerrText = string_delete(_relicTerrText, string_last_pos(",", _relicTerrText), 1);
                        
                        if (arg2 == 0)
                            gml_Script_twitch_chat_say("/me " + string(name) + " " + string(_relicText) + string(_relicSetText) + " | " + string(_relicTerrText) + ".");
                    }
                }
            }
        }
        
        if (string_pos("?terr", _cmd) == 1 || string_pos("?bio", _cmd) == 1 || string_pos("?leg", _cmd) == 1)
        {
            if (room == r_1)
            {
                var _bossText;
                
                if (string_pos("?terr", _cmd) == 1)
                {
                    _bossText = "Territory Bosses detected on areas:";
                    
                    for (var i = 1; i < array_length(obj_raid.specialRaid); i++)
                    {
                        if (obj_raid.custom_alarm[50 + i][0] == -1)
                            _bossText += (" " + string(i * 50) + ",");
                    }
                    
                    if (_bossText == "Territory Bosses detected on areas:")
                        _bossText = "No Territory Bosses detected.";
                    else
                        _bossText = string_delete(_bossText, string_last_pos(",", _bossText), 1);
                }
                
                if (string_pos("?bio", _cmd) == 1)
                {
                    _bossText = "Biome Bosses detected on areas:";
                    
                    for (var i = 1; i < array_length(obj_raid.specialRaid); i++)
                    {
                        if (((i * 50) % 250) == 0)
                        {
                            if (obj_raid.custom_alarm[50 + i][0] == -1)
                                _bossText += (" " + string(i * 50) + ",");
                        }
                    }
                    
                    if (_bossText == "Biome Bosses detected on areas:")
                        _bossText = "No Biome Bosses detected.";
                    else
                        _bossText = string_delete(_bossText, string_last_pos(",", _bossText), 1);
                }
                
                if (string_pos("?leg", _cmd) == 1)
                {
                    _bossText = "Legendary Bosses detected on areas:";
                    
                    for (var i = 1; i < array_length(obj_raid.specialRaid); i++)
                    {
                        if (((i * 50) % 1000) == 0)
                        {
                            if (obj_raid.custom_alarm[50 + i][0] == -1)
                                _bossText += (" " + string(i * 50) + ",");
                        }
                    }
                    
                    if (_bossText == "Legendary Bosses detected on areas:")
                        _bossText = "No Legendary Bosses detected.";
                    else
                        _bossText = string_delete(_bossText, string_last_pos(",", _bossText), 1);
                }
                
                var _totalText = "Currently exploring " + string(global.stageTypeWorld) + ". " + string(_bossText);
                gml_Script_twitch_chat_say_direct("/me " + string(_totalText));
            }
            else if (room == global.room_underworld)
            {
                gml_Script_twitch_chat_say("/me Currently exploring the Underworld, can't detect Territory Bosses from down here Kappa");
            }
        }
        
        if (string_pos("!stuck", _cmd) == 1)
        {
            with (obj_player)
            {
                if (name == other.uname)
                {
                    if (state != UnknownEnum.Value_8)
                    {
                        if (path_exists(actionPath))
                            path_end();
                        
                        readyRaid = 0;
                        x = 1420;
                        y = 480;
                        state = UnknownEnum.Value_0;
                        usePortal = global.portalID - 1;
                        useRedPortal = global.redPortalID - 1;
                        
                        if (ds_list_find_index(global.raidListPortalName, string(name)) != -1)
                        {
                            ds_list_delete(global.raidListPortalName, ds_list_find_index(global.raidListPortalName, string(name)));
                            ds_list_delete(global.raidListPortalClass, ds_list_find_index(global.raidListPortalClass, string(class)));
                        }
                        
                        if (ds_list_find_index(global.raidListRedPortalName, string(name)) != -1)
                        {
                            ds_list_delete(global.raidListRedPortalName, ds_list_find_index(global.raidListRedPortalName, string(name)));
                            ds_list_delete(global.raidListRedPortalClass, ds_list_find_index(global.raidListRedPortalClass, string(class)));
                        }
                    }
                }
            }
        }
        
        if (string_pos("!allstuck", _cmd) == 1)
        {
            if (uname == "erohzify" || uname == "room_001" || uname == global.channelName)
            {
                with (obj_player)
                {
                    if (state != UnknownEnum.Value_8)
                    {
                        if (path_exists(actionPath))
                            path_end();
                        
                        readyRaid = 0;
                        x = 1420;
                        y = 480;
                        state = UnknownEnum.Value_0;
                        usePortal = global.portalID - 1;
                        useRedPortal = global.redPortalID - 1;
                        
                        if (ds_list_find_index(global.raidListPortalName, string(name)) != -1)
                        {
                            ds_list_delete(global.raidListPortalName, ds_list_find_index(global.raidListPortalName, string(name)));
                            ds_list_delete(global.raidListPortalClass, ds_list_find_index(global.raidListPortalClass, string(class)));
                        }
                        
                        if (ds_list_find_index(global.raidListRedPortalName, string(name)) != -1)
                        {
                            ds_list_delete(global.raidListRedPortalName, ds_list_find_index(global.raidListRedPortalName, string(name)));
                            ds_list_delete(global.raidListRedPortalClass, ds_list_find_index(global.raidListRedPortalClass, string(class)));
                        }
                    }
                }
            }
        }
    }
};

enum UnknownEnum
{
    Value_0,
    Value_3 = 3,
    Value_4,
    Value_5,
    Value_6,
    Value_7,
    Value_8,
    Value_12 = 12
}
