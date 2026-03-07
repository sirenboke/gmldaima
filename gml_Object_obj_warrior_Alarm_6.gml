with (obj_warrior)
    alarm[11] = room_speed * 60;

if (castingAbility == false)
{
    var _dmg = myStatInfo[0][3];
    var _player = player;
    var _ability = myAbilityInfo[0];
    var _specialized = specialized;
    var _specialBuffs;
    
    if (_specialized > 0)
    {
        _specialBuffs[0] = mySpecialBuff[0];
        _specialBuffs[1] = mySpecialBuff[1];
        _specialBuffs[2] = mySpecialBuff[2];
        _specialBuffs[3] = mySpecialBuff[3];
        _specialBuffs[4] = mySpecialBuff[4];
    }
    
    var _arrowY = y - 70;
    
    repeat (totalArrows)
    {
        with (instance_create_depth(x + 10, _arrowY, depth - 1, obj_arrow))
        {
            sprite = spr_arrow;
            sprite_color = 16777215;
            ability = _ability;
            specialized = _specialized;
            mySpecialBuff[0] = 0;
            mySpecialBuff[1] = 0;
            mySpecialBuff[2] = 0;
            mySpecialBuff[3] = 0;
            mySpecialBuff[4] = 0;
            
            if (specialized > 0 && (other.buffed > 0 || other.alarm[2] > -1))
            {
                mySpecialBuff[0] = _specialBuffs[0];
                mySpecialBuff[1] = _specialBuffs[1];
                mySpecialBuff[2] = _specialBuffs[2];
                mySpecialBuff[3] = _specialBuffs[3];
                mySpecialBuff[4] = _specialBuffs[4];
            }
            
            if (specialized == 3)
            {
                sprite = spr_arrowMagic;
                sprite_color = 12632256;
                
                if (_ability == 0 && (other.buffed > 0 || other.alarm[2] > -1))
                    sprite_color = 4235519;
                
                if (_ability == 1 && (other.buffed > 0 || other.alarm[2] > -1))
                    sprite_color = 16776960;
                
                if (_ability == 2 && (other.buffed > 0 || other.alarm[2] > -1))
                    sprite_color = 65280;
            }
            
            player = _player;
            warrior = other.id;
            rng = other.rng * 2;
            maxHitCount = other.maxHitCount;
            dmg = _dmg;
            intelligence = other.myStatInfo[9][3];
            cantMiss = other.cantMiss;
            pierce = false;
            bounces = 0;
            arrowdmgReduction = 0.3;
            poisonDmg = 0;
            fireDmg = 0;
            lightningDmg = 0;
            fireDuration = other.fireDuration;
            fireStacks = other.fireStacks;
            totalArrows = other.totalArrows;
            explosiveArrow = other.explosiveArrow;
            explosionRange = other.explosionRange;
            fireArrow = other.fireArrow;
            lightningArrow = other.lightningArrow;
            lightBounces = other.lightBounces;
            lightBounceRng = other.lightBounceRng;
            poisonArrow = other.poisonArrow;
            iceArrow = other.iceArrow;
            targetWeaker = other.targetWeaker;
            
            if (targetWeaker == true)
            {
                if (distance_to_object(instance_nearest(x, y, obj_enemy)) > 200)
                {
                    for (var i = 0; i < instance_number(obj_enemy); i++)
                    {
                        if (instance_find(obj_enemy, i).x <= (x + (rng / 1.5)) && instance_find(obj_enemy, i).hp < target.hp)
                            target = instance_find(obj_enemy, i);
                    }
                }
            }
            
            if (lightningArrow == true)
            {
                if (other.buffed > 0)
                {
                    image_index = 3;
                    lightBounces = other.lightBounces;
                    lightningDmg = (2 + (((dmg / 2) + (intelligence / 3)) * (1 + (intelligence / 15000)))) * (1 + mySpecialBuff[4]);
                }
            }
            
            if (fireArrow == true)
            {
                if (other.buffed > 0)
                {
                    image_index = 2;
                    fireDmg = (2 + (((dmg / 2) + (intelligence / 1.8)) * (0.1 + (other.myAbilityInfo[4] / 10)))) * (1 + (intelligence / 15000));
                }
            }
            
            if (explosiveArrow == true)
            {
                if (other.buffed > 0)
                {
                    fireDmg *= (1 + mySpecialBuff[4]);
                    image_index = 2;
                    
                    if (instance_exists(obj_enemy))
                    {
                        var _target = instance_nearest(x, y, obj_enemy);
                        target = instance_nearest(_target.x + (explosionRange / 2), y, obj_enemy);
                    }
                }
            }
            
            if (poisonArrow == true)
            {
                if (other.buffed > 0)
                {
                    image_index = 1;
                    poisonDmg = (2 + (((dmg / 2) + (intelligence / 2)) * (1 + (intelligence / 15000)))) * (1 + mySpecialBuff[4]);
                    
                    if (instance_exists(obj_enemy))
                    {
                        target = instance_nearest(x, y, obj_enemy);
                        
                        for (var i = 0; i < instance_number(obj_enemy); i++)
                        {
                            if (instance_find(obj_enemy, i).x <= (x + (rng / 1.5)) && (instance_find(obj_enemy, i).hp + instance_find(obj_enemy, i).shield) > (target.hp + target.shield))
                                target = instance_find(obj_enemy, i);
                        }
                    }
                }
            }
            
            if ((other.specialized == 0 && other.myAbilityInfo[0] == 1) || (other.specialized == 2 && other.myAbilityInfo[0] == 0))
            {
                if (other.specialized == 0)
                {
                    if (other.buffed > 0)
                    {
                        image_index = 0;
                        
                        if (other.myAbilityInfo[5] == 1)
                            bounces = 4;
                        else
                            bounces = 4 + round((other.myAbilityInfo[4] - 17) / 3);
                        
                        pierce = true;
                        arrowdmgReduction = other.arrowdmgReduction;
                    }
                }
                else if (other.specialized == 2)
                {
                    if (other.buffed > 0)
                    {
                        image_index = 0;
                        bounces = 10;
                        pierce = true;
                        arrowdmgReduction = other.arrowdmgReduction;
                        armorReduction = other.armorReduction;
                    }
                }
            }
        }
    }
    
    if (buffed > 0)
    {
        buffed -= 1;
        
        if (buffed <= 0)
        {
            alarm[2] = 1;
            
            with (obj_tempStat)
            {
                if (player == other.id && duration == 0)
                    alarm[0] = 1;
            }
        }
    }
    
    thirdAttack += 1;
}

if (class == "archer" && specialized == 1)
{
    if (thirdAttack == 3)
        alarm[6] = 1;
}

if (thirdAttack >= 3)
    thirdAttack = 0;
