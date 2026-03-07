self.scr_rogue_skill1_spec1 = function()
{
    var _range = 600;
    var _nextTarget = -1;
    var _recastSpeed = room_speed / 2;
    
    if (instance_exists(target) && distance_to_object(target) <= _range)
    {
        canAttack = false;
        canMove = false;
        
        if (visible == true)
        {
            with (instance_create_depth(x, y - (sprite_height / 2), depth - 1, obj_raidAnimation))
            {
                sprite_index = spr_shadowClone_out;
                image_xscale = 2;
                image_yscale = 2;
                spd = room_speed / 5;
                color = 0;
                alpha = 1;
                fade = true;
                fadeSpeed = 0.95;
            }
        }
        
        var _animation = instance_create_depth(target.x + 20, target.y, target.depth + 1, obj_raidAnimation);
        
        with (_animation)
        {
            sprite_index = spr_rogue_attack;
            image_xscale = -2;
            image_yscale = 2;
            image_index = irandom(image_number - 2);
            spd = room_speed * 10;
            color = 0;
            alpha = 1;
            fade = true;
            fadeSpeed = 0.98;
        }
        
        visible = false;
        var levelScaling = global.maxAbilityLevel / 2;
        var _abilityDmg = myStatInfo[0][3] * (1.2 + ((levelScaling / 3) * (1 + (levelScaling / 20)))) * (1 + (myStatInfo[0][3] / 10000));
        var _player = player;
        var _target = target;
        var _targetH = _target.sprite_height / 2;
        var _targetX = _target.x;
        var _targetY = _target.y;
        
        with (target)
        {
            show_debug_message("placholder final target = " + string(id));
            
            if (gml_Script_scr_enemy_takeDamage(_abilityDmg, 2, other.player, undefined, undefined, undefined, undefined) <= 0)
            {
                other.visible = false;
                
                if (instance_number(obj_enemy) <= 0)
                    other.visible = true;
                
                other.mana = 0;
                audio_sound_pitch(s_swordhit2, random_range(0.9, 1.1));
                audio_play_sound(s_swordhit2, 0, 0);
                
                if (instance_exists(obj_enemy))
                {
                    var _max = instance_number(obj_enemy);
                    var list = gml_Script_scr_ds_list_create();
                    
                    with (obj_enemy)
                    {
                        if ((x - other.x) <= _range)
                            ds_list_add(list, id);
                    }
                    
                    var _rand = irandom(ds_list_size(list) - 1);
                    _nextTarget = ds_list_find_value(list, _rand);
                    gml_Script_scr_ds_list_destroy(list);
                    
                    if (instance_exists(_nextTarget))
                    {
                        with (other)
                        {
                            targetFixed = true;
                            target = _nextTarget;
                            canAttack = false;
                            canMove = false;
                            visible = false;
                            show_debug_message("placholder next target = " + string(_nextTarget));
                            gml_Script_scr_alarm_start(4, _recastSpeed, gml_Script_scr_rogue_skill1_spec1);
                            
                            with (instance_create_depth(_targetX + 20, _targetY - sprite_get_height(spr_rogue_attack), depth - 1, obj_raidAnimation))
                            {
                                sprite_index = spr_frostNova2;
                                image_xscale = 1.5;
                                image_yscale = 1.5;
                                spd = room_speed / 2;
                                color = 0;
                                alpha = 1;
                                fade = true;
                                fadeSpeed = 1;
                            }
                            
                            if (distance_to_object(_nextTarget) <= _range)
                            {
                                with (instance_create_depth(_nextTarget.x + 20, _nextTarget.y - (_nextTarget.sprite_height / 2), depth - 1, obj_raidAnimation))
                                {
                                    sprite_index = spr_shadowClone_in;
                                    image_xscale = 2;
                                    image_yscale = 2;
                                    spd = room_speed / 5;
                                    color = 0;
                                    alpha = 1;
                                    fade = true;
                                    fadeSpeed = 0.95;
                                }
                            }
                        }
                    }
                    else
                    {
                        other.visible = true;
                        other.canAttack = true;
                        other.canMove = true;
                        other.targetFixed = false;
                    }
                }
            }
            else
            {
                other.visible = true;
                other.canAttack = true;
                other.canMove = true;
                other.targetFixed = false;
            }
            
            global.___struct___173 = function() constructor
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
            instance_create_depth(x, y - (height / 2), depth - 1, obj_slash);
            audio_sound_pitch(s_swordhit1, random_range(0.9, 1.1));
            audio_play_sound(s_swordhit1, 0, 0);
        }
    }
    else
    {
        targetFixed = false;
        canAttack = true;
        canMove = true;
        visible = true;
    }
};
