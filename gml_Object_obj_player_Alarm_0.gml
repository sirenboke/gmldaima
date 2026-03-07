if (room == r_1)
{
    energy -= energyUsed;
    
    if (energy > maxEnergy)
        energy = maxEnergy;
    
    if (energy < 0)
        energy = 0;
    
    if (hp < 0)
        hp = 0;
    
    if (state != UnknownEnum.Value_0)
        gml_Script_scr_player_notafk();
    
    if (energy > 0)
    {
        gml_Script_scr_player_reward(xpvalue, 0);
        var _actionhit = 1;
        
        if (class == "farmer")
            _actionhit += 0.25;
        
        if (state != UnknownEnum.Value_8 && state != UnknownEnum.Value_5 && toPortal == false)
        {
            if (autoAction[2] == 1)
            {
                if (obj_raid.alarm[4] <= (room_speed * 30))
                {
                    path_end();
                    state = UnknownEnum.Value_7;
                    alarm[1] = 1;
                }
            }
        }
        
        if (instance_exists(obj_quest))
        {
            if (state != UnknownEnum.Value_8 && state != UnknownEnum.Value_5 && toPortal == false && ((state == UnknownEnum.Value_7 && obj_raid.alarm[4] > (room_speed * 30)) || state != UnknownEnum.Value_7))
            {
                if (obj_quest.questType == "mine" && autoAction[0] == 1)
                {
                    if (state != UnknownEnum.Value_4)
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
                    }
                }
                
                if (obj_quest.questType == "farm" && autoAction[1] == 1)
                {
                    if (state != UnknownEnum.Value_3)
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
                    }
                }
            }
            else
            {
            }
        }
        
        if (state == UnknownEnum.Value_4 && !path_exists(actionPath))
        {
            obj_build_mine.hp += _actionhit * (1 + (myVocationInfo[0][0] / 10));
            gml_Script_scr_player_reward(goldvalue, 1);
            
            if (instance_exists(obj_quest))
            {
                if (obj_quest.questType == "mine")
                {
                    if ((reputation + goldvalue) < questReputation)
                    {
                        reputation += goldvalue;
                    }
                    else
                    {
                        with (gml_Script_instance_create(x, y, obj_blueOrb))
                        {
                            xx = obj_build_guildhall.x - 120;
                            yy = obj_build_guildhall.y - 30;
                            type = "mine";
                        }
                        
                        reputation = 0;
                        
                        if (reputationCompleted == false)
                            achievement[24] += 1;
                        
                        reputationCompleted = true;
                        questReputation *= 1.5;
                        tickxpvalue = 6 + obj_build_train.level + ((maxxp / 20 / level) * (1 + (obj_build_train.level / 20)));
                        gml_Script_scr_player_reward(tickxpvalue, 0);
                    }
                }
            }
        }
        
        if (state == UnknownEnum.Value_3 && !path_exists(actionPath))
        {
            obj_build_farm.hp += _actionhit * (1 + (myVocationInfo[1][0] / 10));
            gml_Script_scr_player_reward(foodvalue, 2);
            
            if (instance_exists(obj_quest))
            {
                if (obj_quest.questType == "farm")
                {
                    if ((reputation + foodvalue) < questReputation)
                    {
                        reputation += foodvalue;
                    }
                    else
                    {
                        with (gml_Script_instance_create(x, y, obj_blueOrb))
                        {
                            xx = obj_build_guildhall.x + 120;
                            yy = obj_build_guildhall.y - 30;
                            type = "farm";
                        }
                        
                        reputation = 0;
                        
                        if (reputationCompleted == false)
                            achievement[24] += 1;
                        
                        reputationCompleted = true;
                        questReputation *= 1.5;
                        tickxpvalue = 6 + obj_build_train.level + ((maxxp / 20 / level) * (1 + (obj_build_train.level / 20)));
                        gml_Script_scr_player_reward(tickxpvalue, 0);
                    }
                }
            }
        }
        
        if (state == UnknownEnum.Value_5 && !path_exists(actionPath))
        {
            if (foodvalue < 0)
            {
                global.food += foodvalue;
                
                with (gml_Script_instance_create(520, 25, obj_float))
                {
                    type = 6;
                    value = ceil(other.foodvalue) * -1;
                    text = "-" + gml_Script_scr_bigNumber(value);
                    c1 = 255;
                    c2 = 128;
                    parent = type;
                }
            }
            
            if (hpvalue > 0)
            {
                hp += hpvalue;
                
                if (hp > myStatInfo[8][3])
                    hp = myStatInfo[8][3];
                
                gml_Script_scr_playsound(s_eat1, 0.9, 1.1, 1);
                
                with (gml_Script_instance_create(x, y - (height * 1.5), obj_float))
                {
                    type = 3;
                    value = round(other.hpvalue);
                    text = "+" + gml_Script_scr_bigNumber(value);
                    c1 = 65280;
                    c2 = 32768;
                    parent = other.id;
                }
            }
            
            if (energyUsed < 0 && energy < maxEnergy)
            {
                with (gml_Script_instance_create(x, y - (height * 2), obj_float))
                {
                    type = 5;
                    value = real(string_digits(other.energyUsed));
                    text = "+" + string(value) + " energy";
                    c1 = 65535;
                    c2 = 4235519;
                    parent = other.id;
                }
            }
        }
    }
    
    if (myTier > 0)
    {
        if (energy == 0)
        {
            if (readyRaid == 0 && toPortal == false)
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
    else if (energy == 0 && toPortal == false)
    {
        state = UnknownEnum.Value_0;
        
        if (alarm[1] == -1)
            alarm[1] = room_speed * 3;
    }
}

for (var _v = 0; _v < 4; _v++)
{
    if (action == (_v + 1))
    {
        if (myVocationInfo[_v][0] < maxVocationLevel)
            myVocationInfo[_v][1] += (actionPoints[action] * vpBonus);
        else
            myVocationInfo[_v][1] = -1;
    }
}

for (var _v = 0; _v < 4; _v++)
{
    if (myVocationInfo[_v][0] < maxVocationLevel)
    {
        if (myVocationInfo[_v][1] >= myVocationInfo[_v][2])
        {
            myVocationInfo[_v][0] += 1;
            myVocationInfo[_v][1] -= myVocationInfo[_v][2];
            myVocationInfo[_v][2] = 500 * myVocationInfo[_v][0] * myVocationInfo[_v][0] * (myVocationInfo[_v][0] + 1);
            myVocationInfo[_v][2] /= clamp(myVocationInfo[_v][0] / 10, 1, 2);
            
            if (myVocationInfo[_v][0] < maxVocationLevel)
            {
                gml_Script_twitch_chat_say("/me " + string(name) + " reached " + string(global.actionText[_v + 1]) + " level " + string(myVocationInfo[_v][0] - 1) + "! [+1 Honor]");
                gml_Script_scr_gainHonor(1);
            }
            else
            {
                var _auto = "";
                
                if (canAutoAction[_v] == 0)
                {
                    _auto = " (unlocked and activated auto-" + string(global.actionText[_v + 1]) + ")";
                    canAutoAction[_v] = 1;
                    autoAction[_v] = 1;
                }
                
                gml_Script_twitch_chat_say_direct("/me " + string(name) + " maxed " + string(global.actionText[_v + 1]) + string(_auto) + "! [+5 Honor]");
                gml_Script_scr_gainHonor(5);
                achievement[9] += 1;
            }
            
            gml_Script_scr_playsound(s_levelUp, 1, 1.2, 0.5);
            gml_Script_scr_updateStats();
            ini_close();
        }
    }
    else
    {
        myVocationInfo[_v][1] = -1;
    }
}

var _check = 0;

for (var _v = 0; _v < 4; _v++)
{
    if (myVocationInfo[_v][0] > 6)
        _check += 1;
}

if (_check >= 1)
{
    if (global.milestone[10][4] == 0)
    {
        with (gml_Script_instance_create(room_width / 2, room_height / 2, obj_showMilestone))
        {
            type = 10;
            icon = 0;
            name = other.name;
        }
    }
}

_check = 0;

for (var _v = 0; _v < 4; _v++)
{
    if (myVocationInfo[_v][0] >= maxVocationLevel)
        _check += 1;
}

if (_check >= 1)
{
    if (global.milestone[11][4] == 0)
    {
        with (gml_Script_instance_create(room_width / 2, room_height / 2, obj_showMilestone))
        {
            type = 11;
            icon = 1;
            name = other.name;
        }
    }
}

_check = 0;

for (var _v = 0; _v < 4; _v++)
{
    if (myVocationInfo[_v][0] >= maxVocationLevel)
        _check += 1;
}

if (_check >= 4)
{
}

if (myAura > 0 && ascended == false)
{
    if (state != UnknownEnum.Value_7 && state != UnknownEnum.Value_8 && state != UnknownEnum.Value_0 && state != UnknownEnum.Value_5)
    {
        auraBonus[myAura] += 0.001 * auraPowerBonus;
        
        if (auraBonus[myAura] >= 50)
        {
            if (global.milestone[4][4] == 0)
            {
                with (gml_Script_instance_create(room_width / 2, room_height / 2, obj_showMilestone))
                {
                    type = 4;
                    icon = 0;
                    name = other.name;
                }
            }
        }
        
        if (auraBonus[myAura] >= 200)
        {
            if (global.milestone[5][4] == 0)
            {
                with (gml_Script_instance_create(room_width / 2, room_height / 2, obj_showMilestone))
                {
                    type = 5;
                    icon = 1;
                    name = other.name;
                }
            }
        }
        
        if (auraBonus[myAura] >= 500)
        {
            if (global.milestone[6][4] == 0)
            {
                with (gml_Script_instance_create(room_width / 2, room_height / 2, obj_showMilestone))
                {
                    type = 6;
                    icon = 2;
                    name = other.name;
                }
            }
        }
        
        if (auraBonus[myAura] >= 1000)
        {
            if (global.milestone[7][4] == 0)
            {
                with (gml_Script_instance_create(room_width / 2, room_height / 2, obj_showMilestone))
                {
                    type = 7;
                    icon = 3;
                    name = other.name;
                }
            }
        }
    }
}

enum UnknownEnum
{
    Value_0,
    Value_3 = 3,
    Value_4,
    Value_5,
    Value_7 = 7,
    Value_8
}
