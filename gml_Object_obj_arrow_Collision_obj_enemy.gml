if (hitCount > maxHitCount)
    skipDmg = true;

if (skipDmg == true)
    exit;

if (ds_list_find_index(hitList, other.id) == -1)
    ds_list_add(hitList, other.id);
else
    exit;

if (instance_exists(player))
{
    if (instance_exists(warrior))
    {
        var _warrior = warrior;
        var _sprite = sprite_index;
        var _bleedChance = 0;
        var _pierceChance = 0;
        var _healDamage = 0;
        var _push = 0;
        var _pushChance = 0;
        var _split = 0;
        var _globalRes = 0;
        var _physRes = 0;
        var _speRes = 0;
        var _burnChance = 0;
        var _poisonChance = 0;
        var _freezeChance = 0;
        var _armorReduction = armorReduction;
        var _debuffReduction = 0;
        var _frequency = room_speed / 5;
        var _interrupt = 0;
        var _poisonStacks = 0;
        var _cloudSize = 0;
        var _infectChance = 0;
        
        if (specialized == 1)
        {
            if (ability == 0)
            {
                _bleedChance = mySpecialBuff[0] * 100;
                _pierceChance = mySpecialBuff[3] * 100;
            }
            
            if (ability == 1)
            {
                _freezeChance = mySpecialBuff[0] * 100;
                _burnChance = mySpecialBuff[1] * 100;
                _poisonChance = mySpecialBuff[2] * 100;
                _armorReduction = mySpecialBuff[3];
            }
        }
        
        if (specialized == 2)
        {
            _armorReduction = 0.1;
            
            if (ability == 0)
            {
                _bleedChance = 100;
                _pushChance = mySpecialBuff[1] * 100;
                _globalRes = mySpecialBuff[2];
            }
            
            if (ability == 1)
            {
            }
            
            if (ability == 2)
            {
            }
        }
        
        if (specialized == 3)
        {
            _debuffReduction = 0.001;
            
            if (ability == 0)
                _interrupt = mySpecialBuff[0] * 100;
            
            if (ability == 1)
                _frequency = room_speed / (5 + mySpecialBuff[2]);
            
            if (ability == 2)
            {
                _poisonStacks = 10 + mySpecialBuff[1];
                _cloudSize = 300 + mySpecialBuff[0];
                _infectChance = 0.1 + (mySpecialBuff[2] * 100);
            }
        }
        
        if (_bleedChance > irandom(99))
            _bleedChance = 1;
        else
            _bleedChance = 0;
        
        if (pierce == false)
        {
            if (_pierceChance > irandom(99))
            {
                _pierceChance = 1;
                pierce = true;
            }
            else
            {
                _pierceChance = 0;
            }
        }
        
        if (_burnChance > irandom(99))
            _burnChance = 1;
        else
            _burnChance = 0;
        
        if (_poisonChance > irandom(99))
            _poisonChance = 1;
        else
            _poisonChance = 0;
        
        if (_freezeChance > irandom(99))
            _freezeChance = 1;
        else
            _freezeChance = 0;
        
        if (_pushChance > irandom(99))
            _pushChance = 1;
        else
            _pushChance = 0;
        
        if (other.id != target)
        {
            if (pierce == true)
                target = other.id;
        }
        
        if (instance_exists(target))
        {
            if (other.id == target)
            {
                with (target)
                {
                    var _target = other.target;
                    var _dmg = other.dmg;
                    var _poisonDmg = other.poisonDmg;
                    var _fireDmg = other.fireDmg;
                    var _lightningDmg = other.lightningDmg;
                    var _player = other.player;
                    var _duration = other.fireDuration;
                    var _fireStacks = other.fireStacks;
                    var _explosionRange = other.explosionRange;
                    var _explosiveArrow = other.explosiveArrow;
                    var _lightningArrow = other.lightningArrow;
                    var _lightBounces = other.lightBounces;
                    var _bounceRange = other.lightBounceRng;
                    var _arrowType = other.image_index;
                    
                    if (_bleedChance > 0)
                    {
                        global.___struct___203 = function() constructor
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
                        }(_player, _target));
                    }
                    
                    if (_burnChance > 0)
                    {
                        global.___struct___204 = function() constructor
                        {
                            self.player = argument[0];
                            self.warrior = argument[1];
                            self.target = argument[2];
                            self.dmg = argument[3];
                            self.duration = 3;
                            self.fireStacks = 1;
                        };
                        
                        instance_create_depth(x, y, depth, obj_burnStack_new, new function() constructor
                        {
                            self.player = argument[0];
                            self.warrior = argument[1];
                            self.target = argument[2];
                            self.dmg = argument[3];
                            self.duration = 3;
                            self.fireStacks = 1;
                        }(_player, _warrior, id, _dmg));
                    }
                    
                    if (_poisonChance > 0)
                    {
                        global.___struct___205 = function() constructor
                        {
                            self.target = argument[0];
                            self.dmg = argument[1];
                            self.player = argument[2];
                            self.warrior = argument[3];
                            self.stacks = 1;
                        };
                        
                        instance_create_depth(x, y, depth, obj_poisonStack_new, new function() constructor
                        {
                            self.target = argument[0];
                            self.dmg = argument[1];
                            self.player = argument[2];
                            self.warrior = argument[3];
                            self.stacks = 1;
                        }(id, _dmg, _player, _warrior));
                    }
                    
                    if (_freezeChance > 0)
                    {
                        global.___struct___206 = function() constructor
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
                        }(_warrior, id));
                    }
                    
                    if (_pushChance > 0)
                    {
                        with (instance_create_depth(other.x - 10, y, depth, obj_pusher))
                            spd = 8;
                    }
                    
                    if (other.pierce == false)
                        gml_Script_scr_enemy_takeDamage(_dmg, 1, _player, 1, undefined, undefined, undefined, undefined, undefined, _armorReduction);
                    
                    if (other.pierce == true && _armorReduction > 0)
                    {
                        gml_Script_scr_enemy_takeDamage(_dmg, 2, _player, 1, undefined, undefined, undefined, undefined, undefined, _armorReduction, 1, undefined);
                        other.hitCount += 1;
                        
                        if (_globalRes > 0)
                            gml_Script_scr_statChange(_globalRes, 1, 11);
                        
                        show_debug_message("Heavy bolt hit " + string(name));
                    }
                    else if (other.pierce == true)
                    {
                        gml_Script_scr_enemy_takeDamage(_dmg, 2, _player, 0, undefined, undefined, undefined);
                        show_debug_message("Pierce arrow hit " + string(name));
                        other.dmg *= other.arrowdmgReduction;
                        other.hitCount += 1;
                    }
                    
                    if (_debuffReduction > 0)
                        gml_Script_scr_statChange(_debuffReduction / tierReduction, 1, 17);
                    
                    if (_arrowType != 0)
                    {
                        if (_arrowType == 1 || _arrowType == 2)
                        {
                            with (gml_Script_instance_create(x, other.y, obj_elemArrow))
                            {
                                sprite_index = _sprite;
                                image_index = _arrowType;
                                image_angle = other.image_angle;
                                poisonDmg = _poisonDmg;
                                fireDmg = _fireDmg;
                                player = _player;
                                target = _target;
                                type = _arrowType;
                                duration = _duration;
                                fireStacks = _fireStacks;
                                poisonStacks = _poisonStacks;
                                cloudSize = _cloudSize;
                                infectChance = _infectChance;
                                
                                if (instance_exists(target))
                                    depth = target.depth - 1;
                            }
                            
                            if (_arrowType == 1)
                            {
                                with (instance_create_depth(x, y - (height / 2), depth - 1, obj_raidAnimation))
                                {
                                    _explosionRange = 0;
                                    sprite_index = choose(spr_poisonCloud);
                                    image_angle = irandom_range(-15, 15);
                                    image_xscale = 2.5 + (_explosionRange / 100);
                                    image_yscale = 2.5 + (_explosionRange / 100);
                                    spd = room_speed * 1.5;
                                    color = 16777215;
                                    alpha = 0.8;
                                    fade = true;
                                    fadeSpeed = 0.95;
                                }
                            }
                        }
                        
                        if (_explosiveArrow == true)
                        {
                            with (obj_enemy)
                            {
                                if (distance_to_point(other.x, other.y) <= _explosionRange)
                                {
                                    if (_interrupt > irandom(99))
                                        gml_Script_scr_interrupt();
                                    
                                    var _distance = clamp(distance_to_point(other.x, other.y) / 10, 1, 50);
                                    gml_Script_scr_enemy_takeDamage(_dmg / _distance, 3, _player);
                                    
                                    global.___struct___207 = function() constructor
                                    {
                                        self.player = argument[0];
                                        self.warrior = argument[1];
                                        self.target = other;
                                        self.dmg = argument[2];
                                        self.duration = argument[3];
                                        self.fireStacks = argument[4];
                                    };
                                    
                                    instance_create_depth(x, y, depth, obj_burnStack_new, new function() constructor
                                    {
                                        self.player = argument[0];
                                        self.warrior = argument[1];
                                        self.target = other;
                                        self.dmg = argument[2];
                                        self.duration = argument[3];
                                        self.fireStacks = argument[4];
                                    }(_player, _warrior, _dmg / _distance, ceil(_duration / _distance), ceil(_fireStacks / _distance)));
                                }
                            }
                            
                            with (instance_create_depth(x, y - (height / 2), depth - 1, obj_raidAnimation))
                            {
                                sprite_index = choose(spr_explosion2);
                                image_angle = irandom(359);
                                image_xscale = 2.5 + (_explosionRange / 100);
                                image_yscale = 2.5 + (_explosionRange / 100);
                                spd = room_speed / 2;
                                color = 16777215;
                                alpha = 0.9;
                                fade = false;
                                fadeSpeed = 1;
                            }
                        }
                        
                        if (_lightningArrow == true)
                        {
                            if (other.alarm[1] == -1)
                            {
                                other.alarm[1] = room_speed / 5;
                                
                                with (gml_Script_instance_create(x, y - (height / 2), obj_lightningChain))
                                {
                                    target = other.id;
                                    rng = _bounceRange;
                                    bounceTo = -4;
                                    bounces = _lightBounces;
                                    dmg = _lightningDmg;
                                    player = _player;
                                    frequency = _frequency;
                                    
                                    if (instance_exists(target))
                                    {
                                        with (target)
                                        {
                                            gml_Script_scr_enemy_takeDamage(_lightningDmg, 2, _player);
                                            gml_Script_scr_zap(0.2);
                                        }
                                    }
                                }
                            }
                        }
                    }
                    
                    if (other.pierce == true && other.specialized == 0)
                    {
                        if (other.warrior.myAbilityInfo[5] >= 2)
                        {
                            global.___struct___208 = function() constructor
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
                            }(_player, _target));
                        }
                        else
                        {
                            global.___struct___209 = function() constructor
                            {
                                self.player = argument[0];
                                self.bleedHealReduction = 0.2;
                                self.duration = 3;
                                self.target = argument[1];
                            };
                            
                            instance_create_depth(x, y, depth, obj_bleedEffect, new function() constructor
                            {
                                self.player = argument[0];
                                self.bleedHealReduction = 0.2;
                                self.duration = 3;
                                self.target = argument[1];
                            }(_player, _target));
                        }
                    }
                }
                
                if (pierce == false)
                    instance_destroy();
            }
        }
        
        with (warrior)
        {
            if ((mana >= maxmana || (mana + myStatInfo[4][3]) >= maxmana) && (buffed == 0 && alarm[2] == -1))
                gml_Script_scr_castAbility();
        }
    }
    else if (sprite == spr_arrow)
    {
        with (gml_Script_instance_create(x, y, obj_arrowFall))
        {
            sprite_index = other.sprite;
            direction = other.direction;
            image_index = other.image_index;
            image_angle = other.image_angle;
            instance_destroy();
        }
    }
    else
    {
        skipDmg = true;
    }
}
