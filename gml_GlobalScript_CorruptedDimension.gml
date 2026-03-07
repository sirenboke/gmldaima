self.scr_loadCorruptedDimension = function()
{
    if (instance_exists(obj_corruptedIsland))
    {
        with (obj_corruptedIsland)
            instance_destroy();
    }
    
    with (gml_Script_instance_create((room_width / 2) - 250, (room_height / 2) + 100, obj_corruptedIsland))
    {
        sector = 0;
        level = 0;
        voteID = 1;
        votes = 0;
        name = "Your World";
        icon = 0;
        challenge = [];
        challengeText = [];
        challengeValue = [];
    }
    
    ini_open(string(global.platformDir) + "Village Data/Data.ini");
    var _currentIslands = ini_read_real("Corrupted Dimension", "Islands Amount", 0);
    var baseY = (room_height / 2) - 200;
    var spacing = 480;
    var startX = (room_width / 2) - 250 - ((spacing * (_currentIslands - 1)) / 2);
    
    if (_currentIslands > 0)
    {
        for (var i = 0; i < _currentIslands; i++)
        {
            with (gml_Script_instance_create(startX + (spacing * i), baseY, obj_corruptedIsland))
            {
                sector = global.corruptedSector;
                level = global.corruptedLevel;
                voteID = i + 1;
                votes = 0;
                challenge = [];
                challengeText = [];
                challengeValue = [];
                challengeAmount = clamp(global.corruptedSector, 1, 8);
                var savedAmount = ini_read_real("Corrupted Dimension", "Island " + string(i) + " Challenge Amount", -1);
                
                if (savedAmount < challengeAmount)
                {
                    var generated = gml_Script_scr_generateCorruptedChallenges(global.corruptedSector);
                    
                    for (var k = 0; k < challengeAmount; k++)
                    {
                        var _id = generated[k];
                        challenge[k] = _id;
                        challengeValue[k] = gml_Script_scr_updateChallengeValue(_id, sector);
                        challengeText[k] = gml_Script_scr_updateChallengeString(_id, challengeValue[k]);
                        ini_write_real("Corrupted Dimension", "Island " + string(i) + " Challenge " + string(k), _id);
                    }
                    
                    ini_write_real("Corrupted Dimension", "Island " + string(i) + " Challenge Amount", challengeAmount);
                }
                else
                {
                    for (var k = 0; k < challengeAmount; k++)
                    {
                        var _id = ini_read_real("Corrupted Dimension", "Island " + string(i) + " Challenge " + string(k), 0);
                        challenge[k] = _id;
                        challengeValue[k] = gml_Script_scr_updateChallengeValue(_id, sector);
                        challengeText[k] = gml_Script_scr_updateChallengeString(_id, challengeValue[k]);
                    }
                }
            }
        }
    }
    else
    {
        gml_Script_scr_generateCorruptedDimension();
    }
    
    ini_close();
};

self.scr_generateCorruptedDimension = function()
{
    var _islands = irandom_range(2, 3);
    var baseY = (room_height / 2) - 200;
    var spacing = 480;
    var startX = (room_width / 2) - 250 - ((spacing * (_islands - 1)) / 2);
    
    for (var i = 0; i < _islands; i++)
    {
        with (gml_Script_instance_create(startX + (spacing * i), baseY, obj_corruptedIsland))
        {
            sector = global.corruptedSector;
            level = global.corruptedLevel;
            voteID = i + 1;
            votes = 0;
            challenge = [];
            challengeText = [];
            challengeValue = [];
            var generated = gml_Script_scr_generateCorruptedChallenges(sector);
            challengeAmount = array_length(generated);
            
            for (var k = 0; k < challengeAmount; k++)
            {
                var _id = generated[k];
                challenge[k] = _id;
                challengeValue[k] = gml_Script_scr_updateChallengeValue(_id, sector);
                challengeText[k] = gml_Script_scr_updateChallengeString(_id, challengeValue[k]);
                show_debug_message("Island " + string(i) + " Challenge " + string(k) + ": " + string(_id) + " (" + string(challengeText[k]) + ")");
                ini_write_real("Corrupted Dimension", "Island " + string(i) + " Challenge " + string(k), _id);
                ini_write_real("Corrupted Dimension", "Island " + string(i) + " Challenge Amount", challengeAmount);
            }
        }
    }
    
    ini_write_real("Corrupted Dimension", "Islands Amount", _islands);
};

self.scr_generateUniqueIndices = function(arg0)
{
    var arr = [];
    
    for (var i = 0; i < arg0; i++)
        arr[i] = i;
    
    array_shuffle(arr);
    return arr;
};

self.scr_generateCorruptedChallenges = function(arg0 = 1)
{
    var challengeAmount = clamp(arg0, 1, 8);
    var maxChallenges = array_length(obj_corruptedControl.corruptedChallenge);
    var pool = [];
    
    for (var i = 0; i < maxChallenges; i++)
        pool[i] = i;
    
    var shuffled = [];
    
    while (array_length(pool) > 0)
    {
        var idx = irandom(array_length(pool) - 1);
        array_push(shuffled, pool[idx]);
        array_delete(pool, idx, 1);
    }
    
    var result = [];
    
    for (var i = 0; i < challengeAmount; i++)
        result[i] = shuffled[i];
    
    return result;
};

self.scr_generateCorruptedRewards = function(arg0 = 1)
{
    var rewardAmount = 1;
    var maxRewards = global.maxCorruptedRewards;
    var pool = [];
    
    for (var i = 0; i < maxRewards; i++)
        pool[i] = i;
    
    var shuffled = [];
    
    while (array_length(pool) > 0)
    {
        var idx = irandom(array_length(pool) - 1);
        array_push(shuffled, pool[idx]);
        array_delete(pool, idx, 1);
    }
    
    var result = [];
    
    for (var i = 0; i < rewardAmount; i++)
        result[i] = shuffled[i];
    
    return result;
};

self.scr_updateChallengeString = function(arg0, arg1)
{
    if (arg0 == undefined)
        return "";
    
    var text = obj_corruptedControl.corruptedChallenge[arg0][1];
    
    if (string_pos("%", text))
        arg1 *= 100;
    
    return string_replace(text, "*", string(round(arg1)));
};

self.scr_updateChallengeValue = function(arg0, arg1)
{
    if (arg0 == undefined)
        return 0;
    
    var _value = obj_corruptedControl.corruptedChallenge[arg0][0] * power(1.15, arg1);
    _value *= random_range(0.8, 1.05);
    _value = round(_value * 100) / 100;
    
    if (arg0 == 0 || arg0 == 8 || arg0 == 9 || arg0 == 10 || arg0 == 16 || arg0 == 17 || arg0 == 18 || arg0 == 21)
    {
        if (_value > 0.99)
            _value = 0.99;
    }
    
    if (arg0 == 4 || arg0 == 5 || arg0 == 6 || arg0 == 13)
    {
        if (_value > 1)
            _value = 1;
    }
    
    if (arg0 == 12 || arg0 == 14 || arg0 == 15)
    {
        if (_value > 5)
            _value = 5;
    }
    
    if (arg0 == 20 || arg0 == 23 || arg0 == 24)
    {
        if (_value > 9)
            _value = 9;
    }
    
    if (arg0 == 19)
    {
        if (_value > 10)
            _value = 10;
    }
    
    if (arg0 == 22)
    {
        if (_value > 0.5)
            _value = 0.5;
    }
    
    return _value;
};

self.scr_updateRewardString = function(arg0, arg1)
{
    if (arg0 == undefined)
        return "";
    
    var baseValue = obj_corruptedControl.corruptedReward[arg0][0];
    var text = obj_corruptedControl.corruptedReward[arg0][1];
    
    if (string_pos("%", text))
        baseValue *= 100;
    
    return string_replace(text, "*", string(baseValue));
};

self.scr_updateRewardValue = function(arg0, arg1)
{
    if (arg0 == undefined)
        return 0;
    
    var _value = obj_corruptedControl.corruptedReward[arg0][0];
    return _value;
};

self.scr_generateUniqueCorruptedReward = function(arg0)
{
    var maxAttempts = 100;
    var attempt = 0;
    var _id = -1;
    
    repeat (maxAttempts)
    {
        _id = irandom(global.maxCorruptedRewards - 1);
        
        if (!array_contains(global.usedCorruptedRewards, _id))
            break;
        
        attempt++;
    }
    
    if (array_contains(global.usedCorruptedRewards, _id))
        show_debug_message("WARNING: no se pudo evitar duplicado, usando reward " + string(_id));
    else
        array_push(global.usedCorruptedRewards, _id);
    
    return _id;
};

self.scr_applyChallenge = function(arg0 = -1)
{
    show_debug_message("challenge " + string(arg0 + 1));
    var _value = global.globalChallengeValue[arg0];
    var _challengeID = challenge[arg0];
    
    if (_value == -1 || _challengeID == -1)
        exit;
    
    show_debug_message("challenge " + string(arg0 + 1) + " script: " + string(gml_Script_scr_updateChallengeString(_challengeID, _value)));
    
    if (_challengeID == 0)
    {
        with (obj_warrior)
            healReduction *= clamp(_value, 0, 1);
        
        exit;
    }
    
    if (_challengeID == 4)
    {
        global.challenge_enemyCollision = _value;
        exit;
    }
    
    if (_challengeID == 5)
    {
        global.challenge_canSwitch = 0;
        exit;
    }
    
    if (_challengeID == 6)
    {
        global.challenge_canPot = 0;
        exit;
    }
    
    if (_challengeID == 7)
    {
        with (obj_warrior)
        {
            maxmana *= _value;
            abilityCastTime *= _value;
        }
        
        exit;
    }
    
    if (_challengeID == 8)
        exit;
    
    if (_challengeID == 9)
    {
        global.challenge_petRelicEffect -= _value;
        
        if (global.challenge_petRelicEffect < 0)
            global.challenge_petRelicEffect = 0;
        
        show_debug_message("challenge pet relic effect: " + string(global.challenge_petRelicEffect));
        exit;
    }
    
    if (_challengeID == 10)
    {
        global.challenge_relicEffect -= _value;
        
        if (global.challenge_relicEffect < 0)
            global.challenge_relicEffect = 0;
        
        show_debug_message("challenge relic effect: " + string(global.challenge_relicEffect));
        exit;
    }
    
    with (obj_warrior)
    {
        if (_challengeID == 9 || _challengeID == 10)
        {
            resTimer = gml_Script_scr_relicEffect(player, 0, 1);
            oshieldCapacity = gml_Script_scr_relicEffect(player, oshieldCapacity, 3);
            
            if (oshieldCapacity > 0)
            {
                shieldCapacity = oshieldCapacity;
                omaxshield = floor(myStatInfo[8][3] * shieldCapacity);
                maxshield = omaxshield;
                shield = 0;
            }
            
            myDamage[3] = omyDamage[3] * (1 + (gml_Script_scr_relicEffect(player, 0, 20) * 10));
            statusDurationBonus = 1 * (1 + (gml_Script_scr_relicEffect(player, 0, 20) * 10));
            abilityCastTime = myAbilityInfo[9];
            abilityCastTime /= (1 + gml_Script_scr_relicEffect(player, 1, 4));
            abilityCastTime = round(abilityCastTime);
            
            if (abilityCastTime < 1)
                abilityCastTime = 1;
            
            abilityDurationBonus += gml_Script_scr_relicEffect(player, 0, 19);
            relic18dmg = hpRegenHeal * gml_Script_scr_relicEffect(player, 0, 18);
        }
        
        exit;
    }
    
    if (_challengeID == 12)
    {
        global.challenge_bloodRain = _value;
        exit;
    }
    
    if (_challengeID == 14)
    {
        global.challenge_enemyStamina = _value;
        exit;
    }
    
    if (_challengeID == 15)
    {
        global.challenge_allyStamina = _value;
        exit;
    }
    
    if (_challengeID == 16)
    {
        global.challenge_basicMiss = _value;
        exit;
    }
    
    if (_challengeID == 17)
    {
        global.challenge_trueReduction = _value;
        exit;
    }
    
    if (_challengeID == 18)
    {
        global.challenge_specialReduction = _value;
        exit;
    }
    
    if (_challengeID == 19)
    {
        global.challenge_enemyConst = _value;
        exit;
    }
    
    if (_challengeID == 20)
    {
        global.challenge_lessRewards = _value;
        exit;
    }
    
    if (_challengeID == 21)
    {
        global.challenge_blockPhysical = _value;
        exit;
    }
    
    if (_challengeID == 22)
    {
        global.challenge_interruption = _value;
        exit;
    }
    
    if (_challengeID == 25)
    {
        global.challenge_enemyRevive = _value;
        exit;
    }
};

self.scr_corruptionDecrease = function(arg0 = 5)
{
    var _text = "";
    
    if (global.finalWar == false)
    {
        if (obj_seasonControl.alarm[3] != -1)
        {
            _text = " You saved your world at the last moment, but evil never sleeps... Keep fighting back corruption or your world will be erased from reality!";
            obj_seasonControl.alarm[3] = -1;
        }
        
        global.totalCorruption -= arg0;
        global.corruptionIncrease = 3;
        
        if (global.totalCorruption <= 0)
            global.totalCorruption = 0;
        
        gml_Script_twitch_chat_say_direct("/me World Corruption decreased from " + string(global.totalCorruption + arg0) + "% to " + string(global.totalCorruption) + "%! Next corruption wave decreased to " + string(global.corruptionIncrease) + "%" + string(_text) + ".");
    }
    
    ini_open(string(global.platformDir) + "Campaign Data/Season Results.ini");
    ini_write_real("Corrupted Dimension", "Current Corruption", global.totalCorruption);
    ini_close();
};

self.scr_corruptionIncrease = function(arg0 = 4)
{
    if (obj_seasonControl.alarm[3] == -1 || global.finalWar == false)
    {
        global.totalCorruption += floor(global.corruptionIncrease);
        global.corruptionIncrease *= 1.2;
        
        if (global.totalCorruption < 100)
        {
            gml_Script_twitch_chat_say_direct("/me World Corruption increased to " + string(global.totalCorruption) + "%! Next corruption wave will increase it by " + string(floor(global.corruptionIncrease)) + "%!");
        }
        else
        {
            global.totalCorruption = 100;
            gml_Script_twitch_chat_say_direct("/me The World Corruption is finally becoming inevitable, decrease it in the next 24 hours or prepare for your last fight... [24h left for The Final War if corruption is not reduced]");
            
            if (obj_seasonControl.alarm[3] == -1)
                obj_seasonControl.alarm[3] = 86400;
        }
    }
    
    ini_open(string(global.platformDir) + "Campaign Data/Season Results.ini");
    ini_write_real("Corrupted Dimension", "Current Corruption", global.totalCorruption);
    ini_write_real("Corrupted Dimension", "Corruption Increase", global.corruptionIncrease);
    ini_write_real("Time", "Final War Timer", obj_seasonControl.alarm[3]);
    ini_close();
};

self.scr_updateCorruptionShards = function()
{
    with (obj_corruptedControl)
    {
        ini_open(string(global.platformDir) + "Village Data/Data.ini");
        
        for (var r = 0; r <= global.maxCorruptedRewards; r++)
        {
            global.corruptionShardEffect[r] = corruptedReward[r][0] * corruptedReward[r][3];
            
            if (corruptedReward[r][3] > 0)
                ini_write_real("Corrupted Dimension", "Reward " + string(r) + " Amount", corruptedReward[r][3]);
        }
        
        ini_close();
    }
};
