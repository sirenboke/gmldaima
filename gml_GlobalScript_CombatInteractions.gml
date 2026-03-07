self.scr_shield = function(arg0, arg1 = -1, arg2 = 0)
{
    return gml_Script_scr_statChange(arg0, undefined, 19, arg1, undefined, undefined, undefined, undefined, undefined, arg2);
};

self.scr_shield_end = function(arg0)
{
    if (shield >= arg0)
        shield -= arg0;
    else
        shield = 0;
    
    if (decayableShield >= arg0)
        decayableShield -= arg0;
    else
        decayableShield = 0;
};

self.scr_interrupt = function()
{
    if (castingAbility == true)
        castingAbility = false;
    
    if (canAttack == false && isStunned == false && castingAbility == false)
        canAttack = true;
    
    if (alarm[2] != -1)
        alarm[2] = 1;
    
    if (skillBuff != 0)
    {
        skillBuff = 0;
        buffed = 0;
    }
    
    mana = 0;
    
    if (object_get_name(object_get_parent(object_index)) == "obj_enemy")
    {
        if (tired == false)
        {
            stamina -= 1;
            
            if (stamina < 0)
                stamina = 0;
        }
    }
};

self.scr_knockup = function(arg0, arg1 = 4 / arg0)
{
    if (arg0 > 0)
    {
        if (knockup == false)
        {
            canAttack = false;
            canMove = false;
            knockup = true;
            knockup_str = arg1;
            arg0 *= clamp(myResistance[1][1], 0.01, 10);
            
            if (object_get_name(object_get_parent(object_index)) == "obj_enemy")
            {
                if (tired == false)
                {
                    stamina -= (5 + (arg0 * 2));
                    
                    if (stamina < 0)
                        stamina = 0;
                }
            }
            
            gml_Script_scr_statChange(0.05, -1, 15, arg0 * 2, undefined);
            gml_Script_scr_alarm_start(14, room_speed * arg0, gml_Script_scr_knockup_end);
        }
    }
};

self.scr_knockup_end = function()
{
    knockup_str = 0;
};

self.scr_freeze = function(arg0, arg1)
{
    frozen = true;
    canFreeze = false;
    arg1 /= tierReduction;
    
    if (type == "final")
        arg1 = 0;
    
    gml_Script_scr_shield(arg1, undefined, 1);
    gml_Script_scr_playsound(s_frozen, 1, 1.2, 0.5);
    gml_Script_scr_statChange(0.5, undefined, 11, arg0, undefined);
    gml_Script_scr_stun(arg0);
    gml_Script_scr_alarm_start(13, room_speed * arg0 * myResistance[1][1], gml_Script_scr_freeze_end);
    show_debug_message("Freeze debug: Duration = " + string(arg0) + " Resistance[1,1] = " + string(myResistance[1][1]));
    show_debug_message("Freeze debug: stat change for " + string(arg0 * room_speed) + "s, status change for " + string(room_speed * arg0 * myResistance[1][1]) + "s");
};

self.scr_freeze_end = function()
{
    frozen = false;
};

self.scr_zap = function(arg0)
{
    gml_Script_scr_statChange(0.1, undefined, 13, arg0 * 10, undefined);
    gml_Script_scr_stun(arg0);
    gml_Script_scr_interrupt();
    var _size = size;
    
    with (instance_create_depth(x, y - height, depth - 1, obj_raidAnimation))
    {
        sprite_index = choose(spr_zapped1);
        image_angle = irandom(359);
        image_xscale = (0.7 + _size) - 1;
        image_yscale = (0.7 + _size) - 1;
        spd = room_speed / 2;
        color = 16777215;
        alpha = 0.9;
        fade = false;
        fadeSpeed = 0.9;
        follow = other.id;
    }
};

self.scr_stun = function(arg0)
{
    if (arg0 > 0)
    {
        isStunned = true;
        gml_Script_scr_stun_stack(arg0);
        arg0 *= clamp(myResistance[1][1], 0.01, 10);
        
        if (object_get_name(object_get_parent(object_index)) == "obj_enemy")
        {
            if (tired == false)
            {
                stamina -= (3 + (arg0 * 2));
                
                if (stamina < 0)
                    stamina = 0;
            }
        }
        
        show_debug_message("Stunned for " + string(arg0) + "s");
        gml_Script_scr_alarm_start(11, arg0 * room_speed, gml_Script_scr_stun_end);
    }
};

self.scr_stun_end = function()
{
    isStunned = false;
    show_debug_message("Stun ended on " + string(name));
};

self.scr_stun_stack = function(arg0)
{
    if (arg0 > 0)
        gml_Script_scr_statChange(0.1, -1, 15, arg0 * 5, undefined, undefined, 0);
};

self.scr_trap = function(arg0)
{
    if (arg0 > 0)
    {
        isTrapped = true;
        show_debug_message("Trapped for " + string(arg0) + "s");
        gml_Script_scr_alarm_start(13, arg0 * room_speed, gml_Script_scr_trap_end);
    }
};

self.scr_trap_end = function()
{
    isTrapped = false;
    show_debug_message("Stun ended on " + string(name));
};

self.scr_statChangeDisplay = function(arg0, arg1, arg2 = id)
{
    if (global.showStatChange == true)
    {
        if (arg0 != 0)
        {
            with (gml_Script_instance_create(x, y - (height / 2), obj_statChange))
            {
                type = arg1;
                value = arg0;
                player = arg2;
            }
        }
    }
};

self.scr_statChange = function(arg0, arg1 = 1, arg2, arg3 = -1, arg4 = id, arg5 = -1, arg6 = 1, arg7 = 0, arg8 = other.id, arg9 = 0)
{
    if (alarm[0] == -1)
    {
        if (arg0 == 0)
            exit;
        
        var _ovalue = arg0 * arg1;
        var _oduration = arg3;
        var _rawvalue = arg0;
        var _statBefore = "";
        arg0 *= arg1;
        var _exceed = 0;
        
        if (arg7 == 1)
            arg6 = 0;
        
        if (instance_exists(arg8) && instance_exists(arg4) && variable_instance_exists(arg8, "name") && variable_instance_exists(arg4, "name"))
        {
            show_debug_message(string(arg4.name) + " is receiving a " + string(arg0) + " on stat " + string(arg2) + " buff/debuff from " + string(arg8.name) + " for " + string(arg3) + " seconds");
            
            if (gml_Script_scr_relicEffect(arg8.player, 0, 27) > 0 && arg6 == 1)
            {
                var _r27effect = gml_Script_scr_relicEffect(arg8.player, 0, 27);
                
                if (arg8.name == arg4.name)
                {
                    show_debug_message(string(arg4.name) + " is using Relic 27 on self, effect reduced by 50%");
                    _r27effect *= 0.5;
                }
                
                arg0 *= (1 + _r27effect);
                
                if (arg3 > -1)
                    arg3 = clamp(arg3 * (1 + (_r27effect / 2)), arg3, 10000);
                
                _oduration = arg3;
                show_debug_message(string(arg4.name) + " Relic 27 buff/debuff increased to " + string(arg0) + " (" + string(1 + _r27effect) + "x) for " + string(arg3) + " seconds");
            }
        }
        
        if (arg2 <= 9)
        {
            _statBefore = myStatInfo[arg2][3];
            
            if (arg0 < 0 && arg6 == 1)
            {
                arg0 *= clamp(myResistance[2][0], 0, 10);
                
                if (arg3 > 0)
                {
                    arg3 *= clamp(myResistance[2][1], 0.01, 10);
                    
                    if (arg3 <= 1)
                        arg3 = 1;
                }
            }
            
            myStatInfo[arg2][3] += arg0;
            
            if (arg5 == 1)
                myStatInfo[arg2][4] += arg0;
            
            if (arg2 == 1 && myStatInfo[1][4] > 30)
                myStatInfo[1][4] = 30;
            
            if (arg2 == 2 && myStatInfo[2][4] > 100)
                myStatInfo[2][4] = 100;
            
            if (arg2 == 7 && myStatInfo[7][4] > 100)
                myStatInfo[7][4] = 100;
            
            if (myStatInfo[arg2][4] > myStatInfo[arg2][5])
            {
                _exceed = myStatInfo[arg2][4] - myStatInfo[arg2][5];
                show_debug_message("Stat hard cap reached (" + string(myStatInfo[arg2][5]) + "), reducing value from " + string(arg0) + " to " + string(arg0 - _exceed));
                myStatInfo[arg2][4] = myStatInfo[arg2][5];
                arg0 -= _exceed;
                
                if (myStatInfo[arg2][3] > myStatInfo[arg2][4])
                    myStatInfo[arg2][3] = myStatInfo[arg2][4];
            }
            
            if (myStatInfo[arg2][3] > myStatInfo[arg2][4])
            {
                _exceed = myStatInfo[arg2][3] - myStatInfo[arg2][4];
                show_debug_message("Stat cap reached (" + string(myStatInfo[arg2][4]) + "), reducing value from " + string(arg0) + " to " + string(arg0 - _exceed));
                myStatInfo[arg2][3] = myStatInfo[arg2][4];
                arg0 -= _exceed;
            }
            
            if (myStatInfo[arg2][3] < (myStatInfo[arg2][2] * 0.1))
            {
                _exceed = (myStatInfo[arg2][2] * 0.1) - myStatInfo[arg2][3];
                myStatInfo[arg2][3] = myStatInfo[arg2][2] * 0.1;
                arg0 += _exceed;
            }
            
            if (arg2 == 3 && myStatInfo[3][3] < 0.5)
            {
                _exceed = 0.5 - myStatInfo[3][3];
                myStatInfo[3][3] = 0.5;
                arg0 += _exceed;
            }
            
            if (arg2 == 1 && myStatInfo[1][3] < 0.1)
            {
                _exceed = 0.1 - myStatInfo[1][3];
                myStatInfo[1][3] = 0.1;
                arg0 += _exceed;
            }
            
            if (myStatInfo[arg2][3] > myStatInfo[arg2][4])
            {
                _exceed = myStatInfo[arg2][3] - myStatInfo[arg2][4];
                myStatInfo[arg2][3] = myStatInfo[arg2][4];
                arg0 -= _exceed;
            }
            
            if (hp > myStatInfo[8][3])
                hp = myStatInfo[8][3];
            
            var _debugtext = "";
            
            if (arg7 == 1)
                _debugtext += "Returning ";
            
            if (instance_exists(arg4))
                _debugtext += ("Stat change (" + string(global.baseStatText[arg2]) + ") on " + string(arg4.name) + ": " + string(arg0));
            
            if (arg6 == 1)
                _debugtext += (" (reduced from " + string(_ovalue) + " x" + string(myResistance[2][0]));
            
            _debugtext += (", had " + string(_statBefore) + " " + string(global.baseStatText[arg2]) + " before, changed to " + string(myStatInfo[arg2][3]) + " now, " + string(_exceed) + " exceed) for " + string(arg3) + "s");
            
            if (arg6 == 1)
                _debugtext += (" (reduced from " + string(_oduration) + "s x" + string(myResistance[2][1]) + ")");
            
            show_debug_message(_debugtext);
            gml_Script_scr_statChangeDisplay(arg0, arg2, arg4);
        }
        
        if (arg2 == 10 || arg2 == 40)
        {
            if (arg0 < 0 && arg6 == 1 && arg7 == 0)
            {
                arg0 *= clamp(myResistance[1][0], 0, 10);
                arg3 *= clamp(myResistance[1][1], 0.01, 10);
            }
            
            gml_Script_scr_statChangeDisplay(arg0, arg2, arg4);
        }
        
        if (arg2 == 11 || arg2 == 12 || arg2 == 13 || arg2 == 14 || arg2 == 15 || arg2 == 16 || arg2 == 17)
        {
            if (arg0 > 0 && arg6 == 1)
            {
                arg0 *= clamp(myResistance[2][0], 0, 10);
                
                if (arg3 > 0)
                    arg3 *= clamp(myResistance[2][1], 0.01, 10);
            }
            
            gml_Script_scr_statChangeDisplay(arg0 * -1, arg2, arg4);
            
            if (instance_exists(arg4))
            {
                if (arg6 == 1)
                    show_debug_message("CC Stat Change applied on " + string(arg4.name) + ": " + string(arg2) + ", value: " + string(arg4.myResistance[0][2]) + " (" + string(arg0) + ") for " + string(arg3) + "s.");
                
                if (arg6 == 0)
                    show_debug_message("CC Stat Change returning on " + string(arg4.name) + ": " + string(arg2) + ", value: " + string(arg4.myResistance[0][2]) + " (" + string(arg0) + ") for " + string(arg3) + "s.");
            }
        }
        
        if (arg2 == 20 || arg2 == 21 || arg2 == 22 || arg2 == 23 || arg2 == 25)
        {
            if (arg0 < 0 && arg6 == 1)
            {
                arg0 *= clamp(myResistance[2][0], 0, 10);
                
                if (arg3 > 0)
                    arg3 *= clamp(myResistance[2][1], 0.01, 10);
            }
            
            gml_Script_scr_statChangeDisplay(arg0, arg2, arg4);
        }
        
        if (arg2 == 10)
        {
            baseSpeed += arg0;
            
            if (baseSpeed < (omoveSpeed * 0.1))
            {
                _exceed = baseSpeed - (omoveSpeed * 0.1);
                baseSpeed = omoveSpeed * 0.1;
                arg0 += _exceed;
            }
        }
        
        if (arg2 == 11 || arg2 == 12 || arg2 == 13 || arg2 == 14)
        {
            if (arg2 == 11)
            {
                if ((myResistance[0][0] + arg0) < 0)
                    arg0 = 0 - myResistance[0][0];
                
                myResistance[0][0] += arg0;
            }
            
            if (arg2 == 12)
            {
                if ((myResistance[0][1] + arg0) < 0)
                    arg0 = 0 - myResistance[0][1];
                
                myResistance[0][1] += arg0;
            }
            
            if (arg2 == 13)
            {
                if ((myResistance[0][2] + arg0) < 0)
                    arg0 = 0 - myResistance[0][2];
                
                myResistance[0][2] += arg0;
                
                if (instance_exists(arg4))
                    show_debug_message("Special Resistance " + string(arg4.name) + ": " + string(arg2) + ", value: " + string(arg4.myResistance[0][2]));
            }
            
            if (arg2 == 14)
            {
                if ((myResistance[0][3] + arg0) < 0)
                    arg0 = 0 - myResistance[0][3];
                
                myResistance[0][3] += arg0;
            }
            
            for (var _res = 0; _res < 4; _res++)
            {
                if (myResistance[0][_res] > (omyResistance[0][_res] * 50))
                {
                    _exceed = (omyResistance[0][_res] * 5) - myResistance[0][_res];
                    myResistance[0][_res] = omyResistance[0][_res] * 5;
                    arg0 += _exceed;
                    show_debug_message("Resistance reduction organic cap reached! (from " + string(omyResistance[0][_res]) + " to " + string(myResistance[0][_res]) + ")");
                }
                
                if (myResistance[0][_res] > 2)
                {
                    _exceed = 2 - myResistance[0][_res];
                    myResistance[0][_res] = 2;
                    arg0 += _exceed;
                    show_debug_message("Resistance reduction maximum cap reached! (from " + string(omyResistance[0][_res]) + " to " + string(myResistance[0][_res]) + ")");
                }
            }
        }
        
        if (arg2 == 15)
        {
            if ((myResistance[1][1] + arg0) < 0)
                arg0 = 0 - myResistance[1][1];
            
            myResistance[1][1] += arg0;
            
            if (myResistance[1][1] < 0)
            {
                _exceed = myResistance[1][1];
                myResistance[1][1] = 0;
                arg0 -= _exceed;
            }
        }
        
        if (arg2 == 16)
        {
        }
        
        if (arg2 == 17)
        {
            if (myResistance[2][0] < 1)
            {
                if ((myResistance[2][0] + arg0) < 0)
                    arg0 = 0 - myResistance[2][0];
                
                myResistance[2][0] += arg0;
                
                if (myResistance[2][0] >= 1)
                {
                    _exceed = myResistance[2][0];
                    myResistance[2][0] = 1;
                    arg0 -= _exceed;
                }
            }
            else
            {
                arg0 = 0;
                myResistance[2][0] = 1;
            }
        }
        
        if (arg2 == 18)
        {
            critMulti += arg0;
            
            if (critMulti < 2)
                critMulti = 2;
        }
        
        if (arg2 == 19)
        {
            shield += arg0;
            
            if (arg9 == 1)
                decayableShield += arg0;
            
            if (shield < 0)
                shield = 0;
            
            if (decayableShield < 0)
                decayableShield = 0;
        }
        
        if (arg2 == 20)
            myDamage[0] += arg0;
        
        if (arg2 == 21)
            myDamage[1] += arg0;
        
        if (arg2 == 22)
            myDamage[2] += arg0;
        
        if (arg2 == 23)
            myDamage[3] += arg0;
        
        if (arg2 == 25)
            rng += arg0;
        
        if (arg2 == 30)
            onHitSpecial += arg0;
        
        if (arg2 == 31)
            onHitFire += arg0;
        
        if (arg2 == 32)
            onHitTrue += arg0;
        
        if (arg2 == 37)
            basicOnHitTrue += arg0;
        
        if (arg2 == 40)
        {
            healReduction += arg0;
            
            if (healReduction < 0)
            {
                _exceed = healReduction;
                healReduction = 0;
                arg0 += _exceed;
            }
        }
        
        if (arg2 == 41)
        {
            fireshieldReflect += arg0;
            
            if (fireshieldReflect < 0)
                fireshieldReflect = 0;
        }
        
        if (arg2 == 42)
        {
            dmgReflection += arg0;
            
            if (dmgReflection < 0)
                dmgReflection = 0;
        }
        
        _rawvalue = arg0 * arg1;
        
        if (arg3 != -1)
        {
            with (gml_Script_instance_create(x, y, obj_tempStat))
            {
                duration = arg3;
                value = _rawvalue;
                type = arg2;
                player = arg4;
                cap = arg5;
                Sign = arg1 * -1;
                reducible = 0;
                Return = 1;
                
                if (arg3 != 0)
                    alarm[0] = arg3 * room_speed;
                
                show_debug_message("new tempStat with duration = " + string(arg3));
            }
        }
        
        return arg0;
    }
};

self.scr_initializeStats = function()
{
    gml_Script_scr_statChange(global.rogueBonusAmount, undefined, 1, undefined, undefined, 1);
    myStatInfo[1][2] += global.rogueBonusAmount;
    gml_Script_scr_statChange(global.warriorBonusAmount, undefined, 3, undefined, undefined, 1);
    myStatInfo[3][2] += global.warriorBonusAmount;
    gml_Script_scr_statChange(global.wizardBonusAmount, undefined, 4, undefined, undefined, 1);
    myStatInfo[4][2] += global.wizardBonusAmount;
    gml_Script_scr_statChange(global.rangerBonusAmount, undefined, 7, undefined, undefined, 1);
    myStatInfo[7][2] += global.rangerBonusAmount;
    
    if (class == "warrior" && specialized == 2)
    {
        with (obj_warrior)
        {
            if (id != other.id)
            {
                gml_Script_scr_statChange(other.myStatInfo[3][3] * 0.1, undefined, 3, undefined, undefined, 1);
                gml_Script_scr_statChange(other.myStatInfo[6][3] * 0.1, undefined, 6, undefined, undefined, 1);
                gml_Script_scr_statChange(other.myStatInfo[8][3] * 0.1, undefined, 8, undefined, undefined, 1);
                
                for (var i = 0; i < 10; i++)
                    myStatInfo[i][2] = myStatInfo[i][3];
            }
            
            show_debug_message("Paladin buffed me!");
        }
    }
    
    if (class == "warrior" && specialized == 3)
    {
        gml_Script_scr_statChange(0.1, -1, 11, undefined, undefined);
        gml_Script_scr_statChange(0.05, -1, 12, undefined, undefined);
        gml_Script_scr_statChange(0.05, -1, 13, undefined, undefined);
        gml_Script_scr_statChange(0.05, -1, 14, undefined, undefined);
        
        for (var i = 0; i <= global.damageTypes; i++)
            omyResistance[0][i] = myResistance[0][i];
        
        if (myAbilityInfo[0] == 2 && myRaidNumber == 0)
        {
            mana = maxmana;
            gml_Script_scr_castAbility();
        }
    }
    
    if (class == "mage")
    {
        if (specialized == 1)
        {
            var _int = myStatInfo[9][3] * 0.25;
            gml_Script_scr_statChange(_int, undefined, 9, undefined, undefined, 1);
            abilityCastTime *= 0.9;
        }
        
        if (specialized == 3)
        {
            statusDurationBonus *= 1.5;
            var _statusDmg = myDamage[3] * 0.5;
            gml_Script_scr_statChange(_statusDmg, undefined, 23, undefined, undefined, 1);
        }
    }
    
    if (class == "archer")
    {
        if (specialized == 2)
        {
        }
    }
    
    relic13dmgred = gml_Script_scr_relicEffect(player, 0, 13);
    
    if (relic13dmgred > 0)
    {
        var _relic13shield = myStatInfo[8][3] * (gml_Script_scr_relicEffect(player, 0, 13) - 1);
        show_debug_message("Relic 13 damage redirection (divided by): " + string(relic13dmgred) + ", shielded for " + string(_relic13shield));
        regenShieldMax += gml_Script_scr_shield(_relic13shield);
        show_debug_message("Relic 13 actual shield: " + string(regenShieldMax));
        regenShield += regenShieldMax;
    }
};
