if (alarm[0] == -1)
{
    if (instance_exists(player))
    {
        player.lastRaidTime += 1 / room_speed;
        player.hp = hp;
        player.xp = xp;
    }
    
    gml_Script_scr_alarm_step();
    
    if (castingAbility == true)
    {
        if (sprite_index != spr_cast)
            sprite_index = spr_cast;
        
        image_speed = image_number / abilityCastTime;
        canAttack = false;
    }
    
    if (class == "mage" && specialized == 1 && myAbilityInfo[0] == 2 && alarm[2] > -1)
    {
        sprite_index = spr_attack;
        image_index = 4;
    }
    
    if (myRaidNumber == 0)
    {
        if (raidList == global.raidList0)
            global.xpGoto[0] = id;
        
        if (raidList == global.raidList1)
            global.xpGoto[1] = id;
    }
    
    if (global.xpGoto[0] != -2 && global.xpGoto[1] != -2)
    {
        if (global.xpGoto[0] == id)
        {
            if (enteredCombat == true)
            {
                if (equippedUniqueItem[13] == 1 || player.myPetEquippedRelic[myPetID][13] == 1)
                {
                    redirectTo = global.xpGoto[1];
                    redirectTo.redirectTo = id;
                    redirectTo.redirectDmg = relic13dmgred;
                }
                else
                {
                    global.xpGoto[1].redirectDmg = 0;
                }
            }
        }
        
        if (global.xpGoto[1] == id)
        {
            if (enteredCombat == true)
            {
                if (equippedUniqueItem[13] == 1 || player.myPetEquippedRelic[myPetID][13] == 1)
                {
                    redirectTo = global.xpGoto[0];
                    redirectTo.redirectTo = id;
                    redirectTo.redirectDmg = relic13dmgred;
                }
                else
                {
                    global.xpGoto[0].redirectDmg = 0;
                }
            }
        }
    }
    
    if (speedBuff > 0.1)
        speedBuff /= 1.01;
    else
        speedBuff = 0;
    
    if (alarm[0] == -1)
    {
        if (class == "warrior" && specialized == 1 && myAbilityInfo[0] == 0)
        {
            if ((alarm[2] / room_speed) > (skillTimer / 2))
                x += (4 + mySpecialBuff[1]);
            
            if ((alarm[2] / room_speed) <= (skillTimer / 2) && alarm[2] != -1)
                x -= (4 + mySpecialBuff[1]);
            
            if (alarm[2] > -1)
            {
                with (obj_enemy)
                {
                    if (distance_to_object(other) <= 200)
                    {
                        if (other.mySpecialBuff[3] > 0)
                        {
                            var _distance = other.mySpecialBuff[3];
                            
                            if (x < other.x)
                                x += _distance;
                            
                            if (x > other.x)
                                x -= _distance;
                        }
                    }
                }
            }
        }
    }
    
    var _speedBuff = speedBuff;
    
    if (canMove == false)
    {
        moveSpeed = 0;
        _speedBuff = 0;
    }
    
    moveSpeed = baseSpeed + _speedBuff;
    
    if (moveSpeed > 0)
    {
        if (!instance_exists(sprint))
        {
            sprint = gml_Script_instance_create(x, y, obj_sprint);
            
            with (sprint)
            {
                image_xscale = 2 + (other.moveSpeed / 10);
                image_yscale = 2 + (other.moveSpeed / 10);
            }
        }
    }
    
    if ((obj_raid.alarm[1] == -1 || obj_raidPortal.alarm[1] == -1 || obj_raidCorrupted.alarm[1] == -1) && state == UnknownEnum.Value_1)
    {
        if (myRaidNumber == 0)
        {
            if (x < maxPos)
            {
                x += (0.5 * global.roomSpeed * (moveSpeed - _speedBuff));
                
                if (sprite_index == spr_move)
                    image_speed = 0.024 * global.roomSpeed * ((moveSpeed - _speedBuff) + global.raidSpeed);
            }
            
            if (sprite_index == spr_move)
            {
                image_speed = 0.024 * global.roomSpeed * (moveSpeed - _speedBuff);
                
                if (alarm[3] == -1)
                {
                    gml_Script_scr_playsound(s_walking, 0.9, 1.1, 0.5);
                    alarm[3] = room_speed / 2.5;
                }
            }
        }
    }
    
    if ((obj_raid.alarm[1] == -1 || obj_raidPortal.alarm[1] == -1 || obj_raidCorrupted.alarm[1] == -1) && myRaidNumber == 0)
    {
        if (raidType == 0)
        {
            var _ally = -1;
            var _allyX = 0;
            
            with (obj_warrior)
            {
                if (raidType == 1 && myRaidNumber == 0)
                    _ally = id;
            }
            
            if (_ally != -1)
            {
                _allyX = _ally.x;
                
                if (_allyX > (x - 20) || x < maxPos)
                {
                    if (state == UnknownEnum.Value_2)
                        x += (0.5 * global.roomSpeed * (moveSpeed - _speedBuff));
                }
            }
        }
    }
    
    if (myRaidNumber == 0 && state != UnknownEnum.Value_9)
    {
        if (player.autoPot == 1)
        {
            if (potion > 0 && hp <= (myStatInfo[8][3] * player.autoPotHP))
                gml_Script_scr_usePotion();
        }
        
        with (obj_trees)
        {
            if (depth < other.depth)
            {
                if (distance_to_object(obj_warrior) < 50)
                    alpha = 0.2 + (distance_to_object(obj_warrior) / 50);
            }
        }
        
        with (obj_dungeonItems)
        {
            if (depth < other.depth)
            {
                if (distance_to_object(obj_warrior) < 50)
                    alpha = 0.2 + (distance_to_object(obj_warrior) / 50);
            }
        }
    }
    
    switch (state)
    {
        case UnknownEnum.Value_0:
            gml_Script_scr_idle();
            break;
        
        case UnknownEnum.Value_1:
            gml_Script_scr_move();
            break;
        
        case UnknownEnum.Value_2:
            script_execute(scr_attack);
            break;
        
        case UnknownEnum.Value_9:
            gml_Script_scr_playerWin();
            break;
        
        case UnknownEnum.Value_10:
            gml_Script_scr_playerNextFloor();
            break;
    }
}

if (gml_Script_scr_alarm_get(11) != -1)
{
    state = UnknownEnum.Value_0;
    image_speed = 0;
}

if (charging == true)
{
    if (instance_exists(obj_playerGhost))
    {
        if (distance_to_object(instance_nearest(x, y, obj_playerGhost)) >= (50 - (moveSpeed * 2)))
        {
            with (instance_create_depth(x, y, depth + 1, obj_playerGhost))
            {
                sprite_index = other.sprite_index;
                image_index = other.image_index;
                image_xscale = other.image_xscale;
                image_yscale = other.image_yscale;
                color = 16776960;
                alpha = 0 + (other.moveSpeed / 10);
            }
        }
    }
    else
    {
        with (instance_create_depth(x, y, depth + 1, obj_playerGhost))
        {
            sprite_index = other.sprite_index;
            image_index = other.image_index;
            image_xscale = other.image_xscale;
            image_yscale = other.image_yscale;
            color = 16776960;
            alpha = 0 + (other.moveSpeed / 10);
        }
    }
}

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2,
    Value_9 = 9,
    Value_10
}
