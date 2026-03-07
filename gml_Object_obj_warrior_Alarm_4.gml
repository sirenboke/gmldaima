if (myRaidNumber == 0)
{
    hpRegenHeal = myStatInfo[6][3];
    var _relic18dmg = relic18dmg;
    
    if (myStatInfo[6][3] > 0)
    {
        var _relic5effect = gml_Script_scr_relicEffect(player, 0, 5);
        relicRegen = floor(myStatInfo[6][3] * (1 - (hp / myStatInfo[8][3])) * _relic5effect);
        hpRegenHeal = myStatInfo[6][3] + relicRegen;
        relic18dmg = hpRegenHeal * gml_Script_scr_relicEffect(player, 0, 18);
        _relic18dmg = relic18dmg;
        
        if (hp < myStatInfo[8][3] || shield < maxshield)
            gml_Script_scr_player_heal(hpRegenHeal / player.myMultiplier[1] / 5);
    }
    
    if (regenShield > 0)
    {
        if (regenShield < regenShieldMax)
        {
            var _autoshield = ceil((regenShieldMax * 0.1) / 5);
            regenShield += _autoshield;
            gml_Script_scr_shield(_autoshield);
        }
    }
    
    if (instance_exists(obj_enemy))
    {
        with (obj_enemy)
        {
            if (state == UnknownEnum.Value_2)
            {
                if (target != -1)
                {
                    if (target == other.id)
                    {
                        if (_relic18dmg > 0)
                        {
                            gml_Script_scr_enemy_takeDamage(_relic18dmg, 4, other.player, 0, 0, 0, undefined);
                            show_debug_message("Relic 18 hit for " + string(_relic18dmg) + " true damage.");
                        }
                    }
                }
            }
        }
    }
    
    if (decayableShield > myStatInfo[8][3])
    {
        shieldDecayTimer++;
        
        if (shieldDecayTimer >= shieldDecayDelay)
        {
            shieldDecayTimer = shieldDecayDelay;
            var _multiplier = floor(decayableShield / myStatInfo[8][3] / 2);
            var _decayRate = clamp(0.05 * _multiplier, 0, 0.5);
            var _baseDecay = (decayableShield * _decayRate) / 5;
            var _actualDecay = min(_baseDecay, decayableShield);
            decayableShield -= _actualDecay;
            shield -= _actualDecay;
            decayableShield = max(floor(decayableShield), 0);
            shield = max(floor(shield), 0);
            
            if (decayableShield <= 1)
            {
                decayableShield = 0;
                shieldDecayTimer = 0;
            }
            
            if (shield <= 0)
                shield = 0;
        }
        
        if (shieldDamageAccumulator > 0)
        {
            shieldDamageAccumulator -= (shieldDamageAccumulator / (room_speed / 5));
            
            if (shieldDamageAccumulator < 0.1)
                shieldDamageAccumulator = 0;
        }
    }
    else
    {
        shieldDecayTimer = 0;
    }
    
    if (instance_exists(target))
    {
        var _dmgReflection = target.dmgReflection;
        
        if (state == UnknownEnum.Value_2 && _dmgReflection > 0)
            gml_Script_scr_player_takeDamage(_dmgReflection, 2, target, 0, 0, undefined, undefined, undefined, 1);
    }
    
    if (state == UnknownEnum.Value_2 || gml_Script_scr_alarm_get(1) != -1)
    {
        if (stamina > 0)
        {
            if (stamina > maxStamina)
                stamina = maxStamina;
            
            if (global.dev == 0)
                stamina -= (0.8 * global.challenge_allyStamina);
        }
        else
        {
            if (player.autoSwitch == 1)
            {
                var _listSize;
                
                if (raidList == global.raidList0)
                    _listSize = ds_list_size(global.raidListMelee);
                
                if (raidList == global.raidList1)
                    _listSize = ds_list_size(global.raidListRanged);
                
                if (_listSize > 1)
                    gml_Script_scr_switch(name);
                else if (resurrect == 1)
                    gml_Script_scr_death();
            }
            
            stamina = 0;
            
            if (alarm[7] == -1)
            {
                for (var i = 0; i < 10; i++)
                {
                    if (myStatInfo[i][3] > (myStatInfo[i][2] * 0.1))
                        gml_Script_scr_statChange(myStatInfo[i][3] - (myStatInfo[i][3] * 0.99), -1, i, undefined, undefined);
                }
            }
        }
    }
    
    if (class == "mage")
    {
        if (myRaidNumber == 0)
        {
            if (buffed == 0 && alarm[2] == -1)
            {
                if ((mana + (myStatInfo[4][3] / 10 / 5)) < maxmana)
                    mana += (myStatInfo[4][3] / 10 / 5);
                else
                    mana = maxmana;
            }
        }
    }
    
    if (player.autoAbility == 1 && mana >= maxmana && (buffed == 0 && alarm[2] == -1) && (state != UnknownEnum.Value_9 && state != UnknownEnum.Value_10))
        gml_Script_scr_castAbility();
    
    if (alarm[2] != -1 || buffed != 0)
    {
        var _relic19shield = myStatInfo[4][3] * 10 * gml_Script_scr_relicEffect(player, 0, 19);
        
        if (_relic19shield > 0)
            gml_Script_scr_shield(_relic19shield);
    }
    
    if (class == "archer" && specialized == 2 && myAbilityInfo[0] == 0 && (alarm[2] != -1 || buffed > 0))
    {
        var _shieldGen = myStatInfo[8][3] * mySpecialBuff[2];
        gml_Script_scr_shield(_shieldGen / 5, undefined, 1);
    }
    
    if (class == "mage" && specialized == 2 && myAbilityInfo[0] == 2 && alarm[2] != -1)
    {
        var _shieldGen = myStatInfo[9][3] * mySpecialBuff[2];
        gml_Script_scr_shield(_shieldGen / 5, undefined, 1);
    }
}
else if (stamina < maxStamina)
{
    for (var i = 0; i < 10; i++)
        myStatInfo[i][3] = myStatInfo[i][2];
    
    stamina += 1;
}
else
{
    stamina = maxStamina;
}

gml_Script_scr_player_abilityXP(player);

if (player.myAura > 0)
{
    player.auraBonus[player.myAura] += 0.0004 * player.auraPowerBonus;
    
    if (player.auraBonus[player.myAura] >= 50)
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
    
    if (player.auraBonus[player.myAura] >= 200)
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
    
    if (player.auraBonus[player.myAura] >= 500)
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
    
    if (player.auraBonus[player.myAura] >= 1000)
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

if (bleedTimer > 0)
    bleedTimer -= 0.2;
else
    hemorrhageTrigger = 0;

if (hemorrhageTimer > 0)
    hemorrhageTimer -= 0.2;

alarm[4] = room_speed / 5;

enum UnknownEnum
{
    Value_2 = 2,
    Value_9 = 9,
    Value_10
}
