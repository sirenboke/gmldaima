self.scr_enemy_takeDamage = function(arg0, arg1, arg2, arg3 = 0, arg4 = 0, arg5 = 1, arg6 = 0, arg7 = 1, arg8 = 1, arg9 = 0, arg10 = 0, arg11 = 0, arg12 = 0, arg13 = 0)
{
    if (alarm[0] == -1)
    {
        var _ypos = 0;
        var _type = 2;
        var _c1 = 255;
        var _c2 = 128;
        
        if (arg2 == -4 || arg2 == -1)
            arg2 = false;
        
        var _executed = false;
        var _originalDamage = arg0;
        
        if (tired == true)
            arg0 *= 2;
        
        if (arg3 == true)
        {
            if (random_range(0.1, 1) <= global.challenge_basicMiss)
            {
                gml_Script_scr_playsound(s_dodge, 0.9, 1.1, 0.5);
                return hp;
            }
        }
        
        if (arg1 == 4)
            arg0 *= global.challenge_trueReduction;
        
        if (arg1 == 2)
        {
            if (random_range(0.1, 1) <= 0.5)
                arg0 *= global.challenge_specialReduction;
        }
        
        if (arg1 == 1)
        {
            if (random_range(0.1, 1) <= global.challenge_blockPhysical)
            {
                gml_Script_scr_playsound(s_armored, 0.9, 1.1, 0.5);
                return hp;
            }
        }
        
        if (!variable_instance_exists(arg2, "myWarrior"))
            return hp;
        
        if (instance_exists(obj_warrior))
            obj_warrior.alarm[11] = room_speed * 60;
        
        if (instance_exists(arg2) && arg2 != false)
        {
            if (instance_exists(arg2.myWarrior))
            {
                if (arg7 == 1)
                    arg7 = arg2.myWarrior.myDamage[0];
                
                var _typeBonus = arg2.myWarrior.myDamage[arg1];
                
                if (arg1 != 4)
                {
                    arg0 *= arg7;
                    arg0 *= _typeBonus;
                }
            }
        }
        else
        {
            return hp;
            exit;
        }
        
        if (arg1 == 4 && arg12 == 1)
        {
            if (instance_exists(arg2.myWarrior))
            {
                var critChance = irandom(99);
                
                if (arg13 == 1)
                    critChance = 0;
                
                if ((arg2.myWarrior.myStatInfo[7][3] / 4) > critChance)
                {
                    var critHit = true;
                    var _beforeCrit = arg0;
                    var _critMulti = clamp((arg2.myWarrior.critMulti * (1 + gml_Script_scr_relicEffect(arg2, 0, 7))) / 4, 1.25, 1000);
                    arg0 *= _critMulti;
                    
                    if (gml_Script_scr_relicEffect(arg2, 0, 26) > 0)
                    {
                        var _r26crit = irandom(99);
                        
                        if ((gml_Script_scr_relicEffect(arg2, 0, 26) * 100) > _r26crit)
                        {
                            global.___struct___139 = function() constructor
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
                    
                    gml_Script_scr_playsound(s_crit, 1, 1.2, 0.1);
                    _c1 = 65535;
                    _c2 = 4235519;
                }
            }
        }
        
        if (arg1 != 4)
        {
            if (arg6 == 1)
            {
                if (instance_exists(arg2.myWarrior))
                {
                    var _critChance = irandom(99);
                    var _r24chance = arg2.myWarrior.myStatInfo[7][3] * gml_Script_scr_relicEffect(arg2, 0, 24);
                    
                    if (_r24chance > _critChance)
                    {
                        var _critMulti = arg2.myWarrior.critMulti * ((1 + gml_Script_scr_relicEffect(arg2, 0, 7)) * (1 + gml_Script_scr_relicEffect(arg2, 0, 24)));
                        arg0 *= _critMulti;
                        gml_Script_scr_playsound(s_crit, 3, 3, 0.07);
                        
                        if (gml_Script_scr_relicEffect(arg2, 0, 26) > 0)
                        {
                            var _r26crit = irandom(99);
                            
                            if ((gml_Script_scr_relicEffect(arg2, 0, 26) * 100) > _r26crit)
                            {
                                global.___struct___140 = function() constructor
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
                    }
                }
            }
            
            if (instance_exists(arg2.myWarrior))
            {
                if (arg2.myWarrior.shield > 0)
                {
                    var _relic17dmg = arg2.myWarrior.shield * gml_Script_scr_relicEffect(arg2, 0, 17);
                    
                    if (arg3 == 0)
                        _relic17dmg /= 2;
                    
                    if (arg6 == 1)
                        _relic17dmg /= 5;
                    
                    if (_relic17dmg > 0)
                        gml_Script_scr_enemy_takeDamage(_relic17dmg, 4, arg2, undefined, undefined, 0);
                }
            }
            
            if (instance_exists(arg2.myWarrior))
            {
                var _relic20dmg = arg0 * gml_Script_scr_relicEffect(arg2, 0, 20);
                
                if (_relic20dmg > 0)
                {
                    var _chance = 100 * gml_Script_scr_relicEffect(arg2, 0, 20);
                    
                    if (arg3 == 0)
                    {
                        _chance /= 2;
                        _relic20dmg /= 2;
                    }
                    
                    if (arg6 == 1)
                    {
                        _chance /= 5;
                        _relic20dmg /= 5;
                    }
                    
                    if (arg6 == 1 && arg1 == 3)
                    {
                        var _relic20BaseDamage = arg2.myWarrior.myStatInfo[0][3] + arg2.myWarrior.myStatInfo[9][3];
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
                        _type = choose(0, 1, 2);
                        
                        if (_type == 0)
                        {
                            global.___struct___141 = function() constructor
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
                            }(arg2.myWarrior, id));
                        }
                        
                        if (_type == 1)
                        {
                            global.___struct___142 = function() constructor
                            {
                                self.player = argument[0];
                                self.warrior = argument[1];
                                self.target = other;
                                self.dmg = argument[2];
                                self.duration = 2;
                                self.fireStacks = 1;
                            };
                            
                            instance_create_depth(x, y, depth, obj_burnStack_new, new function() constructor
                            {
                                self.player = argument[0];
                                self.warrior = argument[1];
                                self.target = other;
                                self.dmg = argument[2];
                                self.duration = 2;
                                self.fireStacks = 1;
                            }(arg2, arg2.myWarrior, _relic20dmg));
                        }
                        
                        if (_type == 2)
                        {
                            global.___struct___143 = function() constructor
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
                            }(id, _relic20dmg, arg2, arg2.myWarrior));
                        }
                    }
                }
            }
            
            arg0 *= clamp(myResistance[0][0], 0, 100);
        }
        else if (arg5 == 1)
        {
            _ypos = -40;
            _type = 15;
            _c1 = 16777215;
            _c2 = 16777215;
            
            if (type == "final")
                arg0 = 0;
            
            gml_Script_scr_enemy_takeDamage(arg0 - (arg0 / tierReduction), 2, arg2, undefined, undefined, undefined, undefined, undefined, 0);
            arg0 /= tierReduction;
        }
        
        if (arg1 < 4)
        {
            var _oddStoneSet = 3;
            
            if (instance_exists(arg2.myWarrior))
            {
                with (arg2.myWarrior)
                {
                    if ((equippedUniqueItem[21] == 1 || player.myPetEquippedRelic[myPetID][21] == 1) && (equippedUniqueItem[22] == 1 || player.myPetEquippedRelic[myPetID][22] == 1) && (equippedUniqueItem[23] == 1 || player.myPetEquippedRelic[myPetID][23] == 1))
                        _oddStoneSet = -1;
                }
            }
            
            var _oddStone = gml_Script_scr_relicEffect(arg2, 0, 20 + arg1);
            
            if (_oddStone > 0)
            {
                if (arg6 == 1)
                    _oddStone /= 5;
                
                gml_Script_scr_statChange(_oddStone, undefined, 11 + arg1, _oddStoneSet);
            }
        }
        
        if (arg1 != 4)
            arg0 *= clamp(myResistance[0][arg1], 0, 100);
        
        if (arg1 == 1 || arg3 == 1)
        {
            if (arg10 == 0)
                arg0 /= myStatInfo[3][3];
            
            if (instance_exists(arg2) && instance_exists(arg2.myWarrior))
            {
                var critChance = irandom(99);
                var cantMiss, critHit;
                
                if (arg2.myWarrior.myStatInfo[7][3] > critChance)
                {
                    critHit = true;
                    cantMiss = true;
                }
                else
                {
                    critHit = false;
                    cantMiss = false;
                }
                
                if (arg11 == 1)
                    cantMiss = true;
                
                var dodgeChance = irandom(99);
                
                if (arg2.myWarrior.cantMiss == true || cantMiss == true)
                    dodgeChance = 101;
                
                if (dodgeChance > myStatInfo[2][3])
                {
                    if (arg4 == 0)
                    {
                        if (arg2.myWarrior.buffed == 0 && arg2.myWarrior.alarm[2] == -1)
                        {
                            arg2.myWarrior.mana += arg2.myWarrior.myStatInfo[4][3];
                            
                            if (arg2.myWarrior.mana > arg2.myWarrior.maxmana)
                                arg2.myWarrior.mana = arg2.myWarrior.maxmana;
                        }
                    }
                    
                    gml_Script_scr_playsound(s_swordhit1, 0.9, 1.1, 0.1);
                    _c1 = 255;
                    _c2 = 128;
                    
                    if (critHit == true)
                    {
                        var _beforeCrit = arg0;
                        var _critMulti = arg2.myWarrior.critMulti * (1 + gml_Script_scr_relicEffect(arg2, 0, 7));
                        arg0 *= _critMulti;
                        
                        if (gml_Script_scr_relicEffect(arg2, 0, 26) > 0)
                        {
                            var _r26crit = irandom(99);
                            
                            if ((gml_Script_scr_relicEffect(arg2, 0, 26) * 100) > _r26crit)
                            {
                                global.___struct___144 = function() constructor
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
                        
                        if (arg3 == 1)
                            show_debug_message("Crit damage basic: Original: " + string(_beforeCrit) + " Crit (" + string(_critMulti) + "x): " + string(arg0));
                        
                        if (arg3 == 0)
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
                    
                    if (arg4 == 0)
                    {
                        if (arg2.myWarrior.buffed == 0 && arg2.myWarrior.alarm[2] == -1)
                        {
                            arg2.myWarrior.mana += arg2.myWarrior.myStatInfo[4][3] / 2;
                            
                            if (arg2.myWarrior.mana > arg2.myWarrior.maxmana)
                                arg2.myWarrior.mana = arg2.myWarrior.maxmana;
                        }
                    }
                    
                    _dodgeReduction = gml_Script_scr_relicEffect(player, 1, 8);
                    arg0 *= 0.5;
                    
                    if (_dodgeReduction != 1)
                        arg0 /= _dodgeReduction;
                    
                    gml_Script_scr_playsound(s_dodge, 1, 1.2, 0.1);
                    _c1 = 16777215;
                    _c2 = 12632256;
                }
                
                if (arg1 == 1 && poisonStacks > 0)
                    arg0 *= (1 + gml_Script_scr_relicEffect(arg2, 0, 15));
                
                if (arg2.myWarrior.myStatInfo[5][3] > 0)
                {
                    if (arg4 == 0)
                    {
                        var _healHit = arg0 * (arg2.myWarrior.myStatInfo[5][3] / 100);
                        
                        if (arg3 == 0)
                            _healHit /= 4;
                        
                        with (arg2.myWarrior)
                            gml_Script_scr_player_heal(_healHit);
                    }
                }
            }
            
            if (arg3 == 1 && instance_exists(arg2.myWarrior))
            {
                if (arg2.myWarrior.onHitSpecial > 0)
                    gml_Script_scr_enemy_takeDamage(arg0 * arg2.myWarrior.onHitSpecial, 2, arg2, undefined, undefined, undefined, undefined);
                
                if (arg2.myWarrior.onHitFire > irandom(99))
                {
                    var _onHitFire = arg2.myWarrior.onHitFire;
                    
                    global.___struct___145 = function() constructor
                    {
                        self.player = argument[0];
                        self.warrior = argument[1];
                        self.target = other;
                        self.dmg = argument[2];
                        self.duration = 10;
                        self.fireStacks = 1;
                    };
                    
                    instance_create_depth(x, y, depth, obj_burnStack_new, new function() constructor
                    {
                        self.player = argument[0];
                        self.warrior = argument[1];
                        self.target = other;
                        self.dmg = argument[2];
                        self.duration = 10;
                        self.fireStacks = 1;
                    }(arg2, arg2.myWarrior, arg0 * (_onHitFire / 50)));
                }
            }
        }
        
        if (arg1 == 2)
        {
            arg0 /= (myStatInfo[3][3] / 2);
            
            if (instance_exists(arg2) && instance_exists(arg2.myWarrior))
            {
                if (choose(0, 1) == 0)
                    arg0 *= (1 + gml_Script_scr_relicEffect(arg2, 0, 14));
                
                var _warlord = (arg2.myWarrior.myStatInfo[5][3] / 100) * gml_Script_scr_relicEffect(arg2, 0, 6);
                
                if (_warlord > 0)
                {
                    with (arg2.myWarrior)
                        gml_Script_scr_player_heal(arg0 * _warlord);
                }
                
                if (arg12 == 1)
                {
                    var critChance = irandom(99);
                    var critHit;
                    
                    if (arg2.myWarrior.myStatInfo[7][3] > critChance)
                        critHit = true;
                    else
                        critHit = false;
                    
                    if (critHit == true)
                    {
                        var _beforeCrit = arg0;
                        var _critMulti = arg2.myWarrior.critMulti * (1 + gml_Script_scr_relicEffect(arg2, 0, 7));
                        arg0 *= _critMulti;
                        
                        if (gml_Script_scr_relicEffect(arg2, 0, 26) > 0)
                        {
                            var _r26crit = irandom(99);
                            
                            if ((gml_Script_scr_relicEffect(arg2, 0, 26) * 100) > _r26crit)
                            {
                                global.___struct___146 = function() constructor
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
                        
                        gml_Script_scr_playsound(s_crit, 1, 1.2, 0.1);
                        _c1 = 65535;
                        _c2 = 4235519;
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
            
            if (!audio_is_playing(s_enemyBite))
                gml_Script_scr_playsound(s_enemyBite, 0.9, 1.1, 0.2);
            
            if (instance_exists(arg2) && instance_exists(arg2.myWarrior))
            {
                var _relic16Effect = arg0 * gml_Script_scr_relicEffect(arg2, 0, 16);
                
                if (_relic16Effect > 0)
                {
                    arg0 -= _relic16Effect;
                    
                    if (arg0 < 0)
                        arg0 = 0;
                    
                    gml_Script_scr_enemy_takeDamage(_relic16Effect, 2, arg2, 0, undefined, undefined, arg6);
                }
            }
        }
        
        if (arg9 > 0)
        {
            if (arg3 == 0)
                arg9 /= 2;
            
            if (arg6 == 1)
                arg9 /= 5;
            
            gml_Script_scr_statChange(arg9, -1, 3, undefined, undefined);
        }
        
        var _armorDebuff = gml_Script_scr_relicEffect(arg2, 0, 29);
        
        if (_armorDebuff > arg2.uniqueItemLevel[29])
            _armorDebuff = arg2.uniqueItemLevel[29];
        
        if (arg3 == 0)
            _armorDebuff /= 2;
        
        if (arg6 == 1)
            _armorDebuff /= 5;
        
        gml_Script_scr_statChange(myStatInfo[3][3] * _armorDebuff, -1, 3, undefined, undefined);
        
        if (immune == false)
        {
            if (gml_Script_scr_relicEffect(arg2, 0, 2) > 0)
            {
                var executeHP;
                
                if (type == "demon")
                    executeHP = myStatInfo[8][3] * gml_Script_scr_relicEffect(arg2, 0, 2);
                else
                    executeHP = myStatInfo[8][3] * 0.05;
                
                if (arg3 == 0)
                    executeHP /= 2;
                
                if (arg6 == 1)
                    executeHP /= 5;
                
                executeHP /= tierReduction;
                
                if (executeHP > 0 && hp <= executeHP && dead == false)
                {
                    _dmgDealt = executeHP;
                    arg1 = 4;
                    _executed = true;
                    
                    if (instance_exists(arg2) && arg2 != false)
                    {
                        arg2.combatDamageDealt[arg1] += _dmgDealt;
                        
                        if (instance_exists(arg2.myWarrior))
                        {
                            _ypos = 0;
                            
                            if (ds_grid_value_exists(global.combatStats1, 0, 0, 0, global.raidNumber, arg2.name))
                            {
                                _ypos = ds_grid_value_y(global.combatStats1, 0, 0, 0, global.raidNumber, arg2.name);
                                arg2.myWarrior.statsNumber[1] = _ypos;
                            }
                            
                            ds_grid_add(global.combatStats1, arg1 + 1, _ypos, _dmgDealt);
                            ds_grid_add(global.combatStats1, 1, _ypos, _dmgDealt);
                        }
                    }
                    
                    ds_grid_sort(global.combatStats1, 1, false);
                    gml_Script_scr_playsound(s_executeDemon, 0.9, 1.1, 1);
                    gml_Script_instance_create(x, room_height - 300, obj_execution);
                    
                    with (gml_Script_instance_create(x, float_height, obj_float))
                    {
                        type = 100;
                        value = executeHP;
                        text = "Executed (" + gml_Script_scr_bigNumber(value) + "HP)";
                        c1 = 255;
                        c2 = 128;
                        parent = other.id;
                    }
                    
                    if (instance_exists(arg2.myWarrior))
                        gml_Script_scr_death_enemy(arg2.myWarrior);
                    else
                        gml_Script_scr_death_enemy(-1);
                    
                    return 0;
                }
            }
        }
        
        if (arg0 < 0)
            arg0 = 0;
        
        if (shield < 0)
            shield = 0;
        
        var _dmgDealt = arg0;
        
        if (((hp + shield) - arg0) <= 0)
            _dmgDealt = hp + shield;
        
        var lastHitHP = hp + shield;
        
        if (shield > 0)
        {
            var _lastShield = shield;
            shield -= arg0;
            
            if (shield <= 0)
            {
                shield = 0;
                hp -= (arg0 - _lastShield);
            }
        }
        else
        {
            hp -= arg0;
        }
        
        if (_dmgDealt > 0)
        {
            if (instance_exists(arg2) && arg2 != false)
            {
                if (immune == false)
                {
                    arg2.combatDamageDealt[arg1] += _dmgDealt;
                    
                    if (instance_exists(arg2.myWarrior))
                    {
                        if (arg2.myWarrior.aspdDebuff > 0)
                        {
                            var _aspdDebuff = arg2.myWarrior.aspdDebuff;
                            var _aspdDebuffTimer = arg2.myWarrior.aspdDebuffTimer;
                            gml_Script_scr_statChange(_aspdDebuff, -1, 1, _aspdDebuffTimer, undefined);
                        }
                        
                        if (arg2.myWarrior.onHitTrue > 0 && arg8 == 1)
                        {
                            var _onHitTrue = arg2.myWarrior.onHitTrue;
                            
                            if (arg3 == 0)
                                _onHitTrue *= 0.5;
                            
                            if (arg6 == 1)
                                _onHitTrue *= 0.1;
                            
                            gml_Script_scr_enemy_takeDamage(_onHitTrue, 4, arg2, 0, undefined, 0, undefined, undefined, 0);
                        }
                        
                        if (arg2.myWarrior.onHitHeal > 0 && arg8 == 1)
                        {
                            var _onHitHeal = arg2.myWarrior.onHitHeal;
                            
                            if (arg3 == 0)
                                _onHitHeal *= 0.5;
                            
                            if (arg6 == 1)
                                _onHitHeal *= 0.1;
                            
                            with (arg2.myWarrior)
                                gml_Script_scr_player_heal(_onHitHeal);
                        }
                        
                        if (arg2.myWarrior.basicOnHitTrue > 0 && arg8 == 1)
                        {
                            var _basicOnHitTrue = arg2.myWarrior.basicOnHitTrue;
                            
                            if (arg3 == 0)
                                _basicOnHitTrue = 0;
                            
                            gml_Script_scr_enemy_takeDamage(_dmgDealt * _basicOnHitTrue, 4, arg2, 0, undefined, 0, undefined, undefined, 0);
                        }
                        
                        _ypos = 0;
                        
                        if (ds_grid_value_exists(global.combatStats1, 0, 0, 0, global.raidNumber, arg2.name))
                        {
                            _ypos = ds_grid_value_y(global.combatStats1, 0, 0, 0, global.raidNumber, arg2.name);
                            arg2.myWarrior.statsNumber[1] = _ypos;
                        }
                        
                        ds_grid_add(global.combatStats1, arg1 + 1, _ypos, _dmgDealt);
                        ds_grid_add(global.combatStats1, 1, _ypos, _dmgDealt);
                    }
                }
            }
            
            ds_grid_sort(global.combatStats1, 1, false);
            
            if (hp <= 0 && dead == false)
            {
                hp = 0;
                
                if (instance_exists(arg2) && instance_exists(arg2.myWarrior))
                    gml_Script_scr_death_enemy(arg2.myWarrior);
                else
                    gml_Script_scr_death_enemy(-1);
            }
            
            if (_executed == false)
            {
                with (gml_Script_instance_create(x, float_height, obj_showDamage))
                {
                    type = 2;
                    value = arg0;
                    text = "-" + gml_Script_scr_bigNumber(value);
                    c1 = _c1;
                    c2 = _c2;
                    parent = other.id;
                    alarm[1] = 1;
                }
            }
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
        
        return hp;
    }
};
