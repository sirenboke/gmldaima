self.scr_player_takeDamage = function(arg0, arg1, arg2 = 0, arg3 = 0, arg4 = 0, arg5 = 1, arg6 = 0, arg7 = 1, arg8 = 0, arg9 = 1)
{
    var _ypos = 0;
    var _type = 2;
    var _c1 = 255;
    var _c2 = 128;
    var _totalDmg = arg0;
    
    if (arg2 == -4 || arg2 <= 0)
        arg2 = false;
    
    if (instance_exists(obj_warrior))
        obj_warrior.alarm[11] = room_speed * 60;
    
    if (arg1 != 4)
    {
        if (arg8 == 1)
        {
            if (instance_exists(arg2))
            {
                var _critChance = irandom(99);
                var _r24chance = arg2.myStatInfo[7][3] * gml_Script_scr_relicEffect(arg2, 0, 24);
                
                if (_r24chance > _critChance)
                {
                    var _critMulti = 2 + (2 + gml_Script_scr_relicEffect(arg2, 0, 7) + gml_Script_scr_relicEffect(arg2, 0, 24));
                    arg0 *= _critMulti;
                    gml_Script_scr_playsound(s_crit, 3, 3, 0.07);
                    show_debug_message("R24 dot crit proc!");
                    
                    if (gml_Script_scr_relicEffect(arg2, 0, 26) > 0)
                    {
                        var _r26crit = irandom(99);
                        
                        if ((gml_Script_scr_relicEffect(arg2, 0, 26) * 100) > _r26crit)
                        {
                            show_debug_message("R26 crit proc bleed");
                            
                            global.___struct___153 = function() constructor
                            {
                                self.player = argument[0];
                                self.bleedHealReduction = 0.5;
                                self.duration = 3;
                                self.target = argument[1];
                            };
                            
                            instance_create_depth(x, y, depth, obj_bleedEffect, new function() constructor
                            {
                                self.player = argument[0];
                                self.bleedHealReduction = 0.5;
                                self.duration = 3;
                                self.target = argument[1];
                            }(arg2, id));
                        }
                    }
                    
                    show_debug_message("R24 critted DoT for " + string(_critMulti) + "x damage! (from " + string(arg0 / _critMulti) + " to " + string(arg0) + ")");
                }
            }
        }
        
        if (instance_exists(arg2) && arg2 != false)
        {
            if (!variable_instance_exists(arg2, "shield"))
                arg2.shield = 0;
            
            if (arg2.shield > 0)
            {
                var _relic17dmg = arg2.shield * gml_Script_scr_relicEffect(arg2, 0, 17);
                
                if (arg4 == 0)
                    _relic17dmg /= 2;
                
                if (arg8 == 1)
                    _relic17dmg /= 5;
                
                show_debug_message(string(arg2.name) + "'s Relic 17 damaging " + string(name) + " for: " + string(_relic17dmg));
                
                if (_relic17dmg > 0)
                    gml_Script_scr_player_takeDamage(_relic17dmg, 4, arg2, undefined, undefined, undefined, undefined, 0);
            }
        }
        
        if (instance_exists(arg2) && arg2 != false)
        {
            var _relic20dmg = arg0 * gml_Script_scr_relicEffect(arg2, 0, 20);
            
            if (_relic20dmg > 0)
            {
                var _chance = 100 * gml_Script_scr_relicEffect(arg2, 0, 20);
                
                if (arg4 == 0)
                {
                    _chance /= 2;
                    _relic20dmg /= 2;
                }
                
                if (arg8 == 1)
                {
                    _chance /= 5;
                    _relic20dmg /= 5;
                }
                
                if (arg8 == 1 && arg1 == 3)
                {
                    var _relic20BaseDamage = arg2.myStatInfo[0][3] + arg2.myStatInfo[9][3];
                    _relic20dmg = _relic20BaseDamage * gml_Script_scr_relicEffect(arg2, 0, 20);
                }
                
                var _stackBonus = 1;
                _stackBonus += (burnStacks / 40);
                _stackBonus += (poisonStacks / 1000);
                _stackBonus += (freezeStacks / 20);
                _relic20dmg *= _stackBonus;
                var _random = random(100);
                
                if (_chance >= _random)
                {
                    show_debug_message("Relic 20 proc'd! (" + string(_random) + " over " + string(_chance) + ") Damage: " + string(_relic20dmg));
                    _type = choose(0, 1, 2);
                    
                    if (_type == 0)
                    {
                        global.___struct___154 = function() constructor
                        {
                            self.warrior = argument[0];
                            self.stack = 1;
                            self.duration = 3;
                            self.target = argument[1];
                        };
                        
                        instance_create_depth(x, y, depth, obj_freezeStack, new function() constructor
                        {
                            self.warrior = argument[0];
                            self.stack = 1;
                            self.duration = 3;
                            self.target = argument[1];
                        }(arg2, id));
                    }
                    
                    if (_type == 1)
                    {
                        global.___struct___155 = function() constructor
                        {
                            self.player = argument[0];
                            self.warrior = argument[1];
                            self.target = argument[2];
                            self.dmg = argument[3];
                            self.duration = 2;
                            self.fireStacks = 1;
                        };
                        
                        instance_create_depth(x, y, depth, obj_burnStack_new, new function() constructor
                        {
                            self.player = argument[0];
                            self.warrior = argument[1];
                            self.target = argument[2];
                            self.dmg = argument[3];
                            self.duration = 2;
                            self.fireStacks = 1;
                        }(arg2, arg2, id, _relic20dmg));
                    }
                    
                    if (_type == 2)
                    {
                        global.___struct___156 = function() constructor
                        {
                            self.target = argument[0];
                            self.dmg = argument[1];
                            self.player = argument[2];
                            self.warrior = argument[3];
                        };
                        
                        instance_create_depth(x, y - (height / 2), depth, obj_poisonStack_new, new function() constructor
                        {
                            self.target = argument[0];
                            self.dmg = argument[1];
                            self.player = argument[2];
                            self.warrior = argument[3];
                        }(id, _relic20dmg, arg2, arg2));
                    }
                }
            }
        }
        
        arg0 *= clamp(myResistance[0][0], 0, 100);
        
        if (myPetID == 3)
            arg0 *= 0.9;
    }
    
    if (arg1 == 1)
    {
        arg0 /= myStatInfo[3][3];
        
        if (instance_exists(arg2) && arg2 != false)
        {
            if (arg3 == 0)
            {
                var critChance = irandom(99);
                var critHit;
                
                if (arg2.myStatInfo[7][3] >= critChance)
                {
                    critHit = true;
                    var cantMiss = true;
                }
                else
                {
                    critHit = false;
                    var cantMiss = false;
                }
                
                var dodgeChance = irandom_range(0, 100);
                
                if (arg2.cantMiss == true)
                    dodgeChance = 101;
                
                if (dodgeChance > myStatInfo[2][3])
                {
                    if (arg2.buffed == 0 && arg2.alarm[2] == -1)
                    {
                        arg2.mana += arg2.myStatInfo[4][3];
                        
                        if (arg2.mana > arg2.maxmana)
                            arg2.mana = arg2.maxmana;
                    }
                    
                    gml_Script_scr_playsound(s_swordhit1, 0.9, 1.1, 0.1);
                    _c1 = 255;
                    _c2 = 128;
                    
                    if (critHit == true)
                    {
                        var _beforeCrit = arg0;
                        var _critMulti = 2 + gml_Script_scr_relicEffect(arg2, 0, 7);
                        arg0 *= _critMulti;
                        
                        if (gml_Script_scr_relicEffect(arg2, 0, 26) > 0)
                        {
                            var _r26crit = irandom(99);
                            
                            if ((gml_Script_scr_relicEffect(arg2, 0, 26) * 100) > _r26crit)
                            {
                                show_debug_message("R26 crit proc bleed");
                                
                                global.___struct___157 = function() constructor
                                {
                                    self.player = argument[0];
                                    self.bleedHealReduction = 0.5;
                                    self.duration = 3;
                                    self.target = argument[1];
                                };
                                
                                instance_create_depth(x, y, depth, obj_bleedEffect, new function() constructor
                                {
                                    self.player = argument[0];
                                    self.bleedHealReduction = 0.5;
                                    self.duration = 3;
                                    self.target = argument[1];
                                }(arg2, id));
                            }
                        }
                        
                        if (arg4 == 1)
                            show_debug_message("Crit damage basic: Original: " + string(_beforeCrit) + " Crit (" + string(_critMulti) + "x): " + string(arg0));
                        
                        if (arg4 == 0)
                        {
                            arg0 = _beforeCrit + ((arg0 - _beforeCrit) / 4);
                            show_debug_message("Crit damage AOE: Original: " + string(_beforeCrit) + " Crit (" + string(_critMulti) + "x): " + string(arg0));
                        }
                        
                        gml_Script_scr_playsound(s_crit, 1, 1.2, 0.1);
                        _c1 = 65535;
                        _c2 = 4235519;
                    }
                }
                else
                {
                    var _dodgeReduction = 1;
                    
                    if (arg2.buffed == 0 && arg2.alarm[2] == -1)
                    {
                        arg2.mana += arg2.myStatInfo[4][3] / 2;
                        
                        if (arg2.mana > arg2.maxmana)
                            arg2.mana = arg2.maxmana;
                    }
                    
                    _dodgeReduction = gml_Script_scr_relicEffect(player, 1, 8);
                    arg0 *= 0.5;
                    
                    if (_dodgeReduction != 1)
                    {
                        show_debug_message("Dodged Damage Reduction BEFORE RELIC: " + string(arg0));
                        arg0 /= _dodgeReduction;
                        show_debug_message("Dodged Damage Reduction AFTER RELIC (" + string(_dodgeReduction) + "): " + string(arg0));
                    }
                    
                    gml_Script_scr_playsound(s_dodge, 1, 1.2, 0.1);
                    _c1 = 16777215;
                    _c2 = 12632256;
                }
                
                if (arg1 == 1 && poisonStacks > 0)
                    arg0 *= (1 + gml_Script_scr_relicEffect(arg2, 0, 15));
                
                if (arg2.myStatInfo[5][3] > 0)
                {
                    var _healHit = arg0 * (arg2.myStatInfo[5][3] / 100);
                    
                    if (arg4 == 0)
                        _healHit /= 4;
                    
                    with (arg2)
                        gml_Script_scr_enemy_heal(_healHit);
                }
            }
            
            if (arg2.myStatInfo[5][3] > 0)
            {
                var _healHit = arg0 * (arg2.myStatInfo[5][3] / 100);
                _healHit *= arg2.healReduction;
                arg2.hp += _healHit;
                
                with (gml_Script_instance_create(arg2.x, arg2.y - (arg2.height * 1.5) - 25, obj_float))
                {
                    type = 3;
                    value = _healHit;
                    text = "+" + gml_Script_scr_bigNumber(value);
                    c1 = 65280;
                    c2 = 32768;
                    parent = type;
                }
            }
        }
    }
    
    if (arg1 == 2)
    {
        if (!instance_exists(obj_wiz2_1))
        {
            arg0 /= (myStatInfo[3][3] / 2);
            
            if (instance_exists(arg2) && arg2 != false)
            {
                if (choose(0, 1) == 0)
                    arg0 *= (1 + gml_Script_scr_relicEffect(arg2, 0, 14));
                
                var _warlord = (arg2.myStatInfo[5][3] / 100) * gml_Script_scr_relicEffect(arg2, 0, 6);
                
                if (_warlord > 0)
                {
                    show_debug_message("Warlord healing " + string(arg2.name) + " for: " + string(arg0 * _warlord));
                    
                    with (arg2)
                        gml_Script_scr_enemy_heal(arg0 * _warlord);
                }
            }
        }
        else
        {
            with (obj_wiz2_1)
            {
                var _stunChance = stunChance;
                var _oldhp = hp;
                var _heal = heal;
                
                with (obj_warrior)
                {
                    if (myRaidNumber == 0)
                        gml_Script_scr_shield((arg0 / (myStatInfo[3][3] / 2)) * _heal, undefined, 1);
                }
                
                hp -= arg0;
                
                if (hp <= 0)
                {
                    arg0 -= _oldhp;
                    
                    with (arg2)
                    {
                        if (irandom(99) < _stunChance)
                            gml_Script_scr_stun(2);
                    }
                    
                    alarm[0] = 1;
                }
                else
                {
                    exit;
                }
            }
        }
    }
    
    if (arg1 == 3)
    {
        arg0 /= (myStatInfo[3][3] / 2);
        _ypos = -20;
        _type = 14;
        _c1 = 32768;
        _c2 = 128;
        
        if (instance_exists(arg2) && arg2 != false)
        {
            var _relic16Effect = arg0 * gml_Script_scr_relicEffect(arg2, 0, 16);
            
            if (_relic16Effect > 0)
            {
                show_debug_message("Original poison damage: " + string(arg0));
                arg0 -= _relic16Effect;
                
                if (arg0 < 0)
                    arg0 = 0;
                
                show_debug_message("New poison damage: " + string(arg0));
                show_debug_message("New special damage: " + string(_relic16Effect));
                gml_Script_scr_player_takeDamage(_relic16Effect, 2, arg2, undefined, 0, undefined, undefined, undefined, arg8);
            }
        }
    }
    
    var _dmgDealt, lastHitHP;
    
    if (instance_exists(arg2) && arg2 != false)
    {
        var _armorDebuff = gml_Script_scr_relicEffect(arg2, 0, 29);
        
        if (_armorDebuff > arg2.uniqueItemLevel[29])
            _armorDebuff = arg2.uniqueItemLevel[29];
        
        if (arg4 == 0)
            _armorDebuff /= 2;
        
        if (arg8 == 1)
            _armorDebuff /= 5;
        
        gml_Script_scr_statChange(myStatInfo[3][3] * _armorDebuff, -1, 3, undefined, undefined);
        
        if (gml_Script_scr_relicEffect(arg2, 0, 2) > 0)
        {
            var executeHP = myStatInfo[8][3] * 0.05;
            
            if (arg4 == 0)
                executeHP /= 2;
            
            if (arg8 == 1)
                executeHP /= 5;
            
            executeHP /= tierReduction;
            
            if (executeHP > 0 && hp <= executeHP && dying == false)
            {
                _dmgDealt = executeHP;
                arg1 = 4;
                lastHitHP = hp + shield;
                
                if (instance_exists(arg2))
                {
                    gml_Script_scr_playsound(s_executeDemon, 0.9, 1.1, 1);
                    gml_Script_instance_create(x, room_height - 300, obj_execution);
                    
                    with (gml_Script_instance_create(x, -height / 1.5, obj_float))
                    {
                        type = 100;
                        value = executeHP;
                        text = "Executed (" + gml_Script_scr_bigNumber(value) + "HP)";
                        c1 = 255;
                        c2 = 128;
                        parent = other.id;
                    }
                    
                    if (instance_exists(arg2))
                        gml_Script_scr_death(arg2.name, arg2.level, arg0, lastHitHP);
                    else
                        gml_Script_scr_death("", "", arg0, lastHitHP);
                    
                    return 0;
                }
            }
        }
        
        if (arg3 == 0 && redirectDmg > 0 && arg0 > 0)
        {
            var _redirectDmgDealt = arg0 - (arg0 / redirectDmg);
            show_debug_message("Damage taken reduced from " + string(arg0) + " to " + string(arg0 / redirectDmg) + ", ally (" + string(redirectTo.name) + ") took " + string(_redirectDmgDealt) + " true damage.");
            arg0 /= redirectDmg;
            
            if (redirectTo != -2)
            {
                with (redirectTo)
                    gml_Script_scr_player_takeDamage(_redirectDmgDealt, 4, arg2, 1, 0);
            }
        }
    }
    
    if (arg0 < 0)
        arg0 = 0;
    
    if (arg6 == 0)
    {
        if (shield < 0)
            shield = 0;
        
        _dmgDealt = arg0;
        
        if (((hp + shield) - arg0) <= 0)
            _dmgDealt = hp + shield;
        
        lastHitHP = hp + shield;
        
        if (shield > 0)
        {
            var _lastShield = shield;
            var _thresholdShield = shield * 0.01;
            var _significantThreshold = max(_thresholdShield, 50);
            
            if (pet != 0)
            {
                with (pet)
                {
                    if (type == 1)
                    {
                        shield -= arg0;
                        
                        if (shield < 0)
                            shield = 0;
                    }
                }
            }
            
            shield -= arg0;
            var _shieldDmgAbsorbed = 0;
            
            if (shield <= 0)
            {
                _shieldDmgAbsorbed = _lastShield;
                decayableShield = max(decayableShield - _shieldDmgAbsorbed, 0);
                shield = 0;
                hp -= (arg0 - _lastShield);
            }
            else
            {
                _shieldDmgAbsorbed = arg0;
                decayableShield = max(decayableShield - _shieldDmgAbsorbed, 0);
            }
            
            shieldDamageAccumulator += _shieldDmgAbsorbed;
            
            if (shieldDamageAccumulator >= _significantThreshold)
                shieldDecayTimer = 0;
        }
        else
        {
            shieldDecayTimer = 0;
            hp -= arg0;
        }
    }
    else
    {
        _dmgDealt = arg0;
        
        if ((hp - arg0) <= 0)
            _dmgDealt = hp;
        
        lastHitHP = hp;
        hp -= arg0;
    }
    
    var _dmgMitigated = _totalDmg - _dmgDealt;
    player.combatDamageMitigated[arg1] += _totalDmg - arg0;
    
    if (hp <= 0)
        _dmgMitigated -= (_dmgDealt - lastHitHP);
    
    if (immune == false)
    {
        _ypos = 0;
        
        if (ds_grid_value_exists(global.combatStats2, 0, 0, 0, global.raidNumber, name))
        {
            _ypos = ds_grid_value_y(global.combatStats2, 0, 0, 0, global.raidNumber, name);
            statsNumber[2] = _ypos;
        }
        
        ds_grid_add(global.combatStats2, arg1 + 1, _ypos, _totalDmg);
        ds_grid_add(global.combatStats2, 1, _ypos, _totalDmg);
        ds_grid_sort(global.combatStats2, 1, false);
    }
    
    if (absorb == true)
    {
        if (instance_exists(obj_war3_1))
        {
            with (obj_war3_1)
            {
                if ((value + _dmgMitigated) <= maxValue)
                    value += _dmgMitigated;
                else
                    value = maxValue;
            }
        }
    }
    
    if (hp <= 0)
    {
        hp = 0;
        gml_Script_scr_playsound(s_swordhit2, 0.9, 1.1, 0.1);
        
        if (instance_exists(arg2))
            gml_Script_scr_death(arg2.name, arg2.level, arg0, lastHitHP);
        else
            gml_Script_scr_death("", "", arg0, lastHitHP);
    }
    
    if (raidType == 0)
    {
        if (buffed == false && alarm[2] == -1)
        {
            if ((mana + (myStatInfo[4][3] * 0.05)) >= maxmana)
                mana = maxmana;
            else
                mana += (myStatInfo[4][3] * 0.05);
        }
    }
    
    with (gml_Script_instance_create(x, (y - (height * 1.5)) + _ypos, obj_showDamage))
    {
        type = 2;
        value = arg0;
        text = "-" + gml_Script_scr_bigNumber(value);
        c1 = _c1;
        c2 = _c2;
        parent = other.id;
        alarm[1] = 1;
    }
    
    if (immune == true)
    {
        with (gml_Script_instance_create(x, y - (height / 1.5), obj_float))
        {
            type = 24;
            value = "Invulnerable!";
            text = value;
            c1 = 65535;
            c2 = 4235519;
            parent = other.id;
        }
    }
};
