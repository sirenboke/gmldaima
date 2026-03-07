self.scr_move = function()
{
    allyInRange = true;
    meInRange = true;
    
    if (x < xx)
    {
        x += (0.5 * global.roomSpeed * moveSpeed);
        
        if (sprite_index != spr_move)
            sprite_index = spr_move;
        
        image_speed = 0.024 * global.roomSpeed * (moveSpeed - speedBuff);
    }
    
    if (instance_exists(obj_enemy))
    {
        if (distance_to_object(target) > rng)
            meInRange = false;
        else
            meInRange = true;
        
        with (obj_warrior)
        {
            if (myRaidNumber == 0 && id != other.id)
            {
                if (distance_to_object(target) > rng)
                    allyInRange = false;
                else
                    allyInRange = true;
            }
        }
    }
    else
    {
        meInRange = true;
        allyInRange = true;
    }
    
    if (x >= 530)
    {
        if (enteredCombat == false)
        {
            enteredCombat = true;
            immune = false;
        }
        
        if (instance_exists(obj_enemy))
        {
            if (targetFixed == false)
                target = instance_nearest(x, y, obj_enemy);
            
            if (targetFixed == false)
            {
                for (var t = 0; t < instance_number(obj_enemy); t++)
                {
                    if (distance_to_object(instance_find(obj_enemy, t)) <= rng)
                    {
                        if (t == 0)
                            target = instance_find(obj_enemy, t);
                        else if (distance_to_object(instance_find(obj_enemy, t)) < distance_to_object(target))
                            target = instance_find(obj_enemy, t);
                    }
                }
            }
            
            if (myRaidNumber == 0 && meInRange == true && allyInRange == true)
            {
                if (charging == false)
                {
                    if (canAttack == true)
                    {
                        sprite_index = spr_attack;
                        image_index = 0;
                        image_speed = 0;
                    }
                    
                    state = UnknownEnum.Value_2;
                }
                else if (charging == true)
                {
                    canAttack = false;
                    
                    if (buffed > 0)
                    {
                        var _charges = buffed;
                        var _distance = w3s3_distance;
                        var _dmg = myStatInfo[9][3] * 2 * moveSpeed * (1 + mySpecialBuff[4]);
                        
                        if (_distance > 0)
                            _dmg *= _distance;
                        
                        var _player = player;
                        
                        with (target)
                        {
                            var _collisionDmg = myStatInfo[0][3];
                            var _target = id;
                            
                            if (_distance > 0)
                            {
                                with (gml_Script_instance_create(other.x, other.y, obj_pusher))
                                    spd = 15;
                                
                                w3s3_distance = 0;
                            }
                            else
                            {
                                with (other)
                                    gml_Script_scr_shield(_dmg / 50, 3, 1);
                                
                                _dmg += other.shield;
                            }
                            
                            if (gml_Script_scr_enemy_takeDamage(_dmg, 1, _player, 1) > 0)
                            {
                                with (other)
                                {
                                    gml_Script_scr_statChange(_chargingInt, -1, 9, undefined, undefined);
                                    buffed = 0;
                                    skillBuff = 0;
                                    charging = false;
                                    baseSpeed = 1;
                                    canAttack = true;
                                    w3s3_distance = 0;
                                    _chargingInt = 0;
                                }
                            }
                            else
                            {
                                with (other)
                                {
                                    gml_Script_scr_player_takeDamage(_collisionDmg, 1, _target);
                                    show_debug_message("Shield charge collision damage: " + string(_collisionDmg));
                                    
                                    if (mySpecialBuff[1] > 0)
                                        gml_Script_scr_statChange(myStatInfo[9][2] * mySpecialBuff[1], undefined, 9, undefined, undefined, 1);
                                    
                                    if ((buffed + buffGain) < skillBuff)
                                        buffed += buffGain;
                                    else
                                        buffed = skillBuff;
                                    
                                    w3s3_distance /= 2;
                                }
                            }
                        }
                        
                        show_debug_message("shield charge dealt " + string(_dmg) + " damage (" + string(_charges) + " charges)");
                    }
                    else
                    {
                        canAttack = true;
                        charging = false;
                        baseSpeed = 1;
                        w3s3_distance = 0;
                    }
                }
            }
            else if (castingAbility == false)
            {
                if (class == "mage" && specialized == 1 && myAbilityInfo[0] == 2 && alarm[2] > -1)
                {
                    sprite_index = spr_attack;
                    image_index = 4;
                    image_speed = 0;
                }
                else if (sprite_index != spr_move)
                {
                    sprite_index = spr_move;
                    image_speed = 0.05 * global.roomSpeed;
                }
            }
        }
        else
        {
            sprite_index = spr_idle;
            state = UnknownEnum.Value_0;
        }
    }
    else
    {
        with (obj_warrior)
        {
            if (gml_Script_scr_alarm_get(12) > 0)
                custom_alarm[12][0] += 1;
        }
        
        var _movePart = 0;
        
        with (obj_warrior)
        {
            if (raidList == global.raidList0)
                _movePart = 2;
        }
        
        if (myRaidNumber == 0 && raidList == global.raidList1)
        {
            x += 1.5;
            var moveX = 2;
            
            with (obj_warrior)
            {
                if (raidList == global.raidList0 && myRaidNumber == 0 && x < maxPos)
                    state = UnknownEnum.Value_0;
            }
            
            sprite_index = spr_idle;
            image_speed = 0;
            global.partBgPos += (global.partBgSpd * _movePart);
            
            with (obj_enemy)
                state = UnknownEnum.Value_0;
            
            with (obj_raidObject)
                x += (bgSpd * moveX);
            
            with (obj_raidBackground)
                x += (bgSpd * moveX);
            
            with (obj_float)
            {
                if (y > (room_height - 300))
                    x += (bgSpd * moveX);
            }
        }
    }
};

enum UnknownEnum
{
    Value_0,
    Value_2 = 2
}
