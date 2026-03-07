with (obj_warrior)
    alarm[11] = room_speed * 60;

if (thirdAttack > 3)
    thirdAttack = 0;

thirdAttack += 1;

if (castingAbility == false)
{
    if (instance_exists(target) && distance_to_object(target) <= rng)
    {
        if ((mana >= maxmana || (mana + myStatInfo[4][3]) >= maxmana) && (buffed == 0 && alarm[2] == -1))
            gml_Script_scr_castAbility();
        
        if (buffed > 0)
        {
            buffed -= 1;
            
            if (buffed <= 0)
            {
                alarm[2] = 1;
                
                with (obj_tempStat)
                {
                    if (player == other.id)
                        alarm[0] = 1;
                }
            }
        }
        
        if (mana < maxmana)
        {
            if (instance_exists(target))
            {
                var _depth = target.depth;
                var _width = target.length;
                var _height = target.height;
                
                if (class == "mage")
                {
                    if (specialized == 0 || specialized == 1)
                    {
                        with (gml_Script_instance_create(x + 45, y - height - 10, obj_allyOrb))
                        {
                            c1 = 16776960;
                            c2 = 16711680;
                            
                            if (instance_exists(other.target))
                            {
                                tx = other.target.x;
                                ty = random_range(other.target.y - (other.target.height / 3), other.target.y - (other.target.height / 1.5));
                            }
                            else
                            {
                                tx = x;
                                ty = y;
                            }
                        }
                    }
                    
                    if (specialized == 2)
                    {
                        with (gml_Script_instance_create(target.x + irandom_range(-_width / 3, _width / 3), (target.y - (target.height / 2)) + irandom_range(-_height / 3, _height / 3), obj_raidAnimation))
                        {
                            sprite_index = spr_swoosh1;
                            image_index = 0;
                            image_angle = irandom(359);
                            image_xscale = 0.5;
                            image_yscale = 0.5;
                            depth = _depth - 1;
                            spd = room_speed / 2;
                        }
                    }
                    
                    if (specialized == 3)
                    {
                        with (gml_Script_instance_create(x, y - height - 20, obj_raidAnimation))
                        {
                            sprite_index = choose(spr_spark_electrical2);
                            image_index = 0;
                            image_angle = irandom(359);
                            image_xscale = 0.5;
                            image_yscale = 0.5;
                            depth = _depth - 1;
                            spd = room_speed / 2;
                        }
                        
                        with (gml_Script_instance_create(target.x + irandom_range(-_width / 3, _width / 3), (target.y - (target.height / 2)) + irandom_range(-_height / 3, _height / 3), obj_raidAnimation))
                        {
                            sprite_index = choose(spr_spark_electrical);
                            image_index = 0;
                            image_angle = irandom(359);
                            image_xscale = 0.5;
                            image_yscale = 0.5;
                            depth = _depth - 1;
                            spd = room_speed / 2;
                        }
                    }
                }
            }
            
            if (spr_attack == spr_warrior2_attack)
            {
                with (gml_Script_instance_create(x, y - (height / 1.5), obj_warrior2_attack))
                {
                    if (instance_exists(other.target))
                    {
                        xx = x;
                        yy = y;
                        tx = other.target.x;
                        ty = clamp(other.target.y - (other.target.height / 1.5), room_height - 300, room_height - 20);
                        show_debug_message("XX: " + string(xx) + " TX:" + string(tx));
                    }
                    else
                    {
                        tx = x;
                        ty = y;
                    }
                }
            }
            
            gml_Script_scr_playsound(s_attack, 0.9, 1.1, 0.2);
            var _player = player;
            
            if (class == "warrior" && specialized == 1)
            {
                if (myAbilityInfo[0] == 1 && alarm[2] != -1)
                {
                    if (mySpecialBuff[0] > 0)
                        gml_Script_scr_statChange(myStatInfo[0][2] * mySpecialBuff[0], undefined, 0, 5, undefined, 1);
                    
                    if (mySpecialBuff[1] > 0)
                        gml_Script_scr_statChange(myStatInfo[3][2] * mySpecialBuff[1], undefined, 3, 5, undefined, 1);
                    
                    if (mySpecialBuff[2] > 0)
                        gml_Script_scr_statChange(myStatInfo[5][2] * mySpecialBuff[2], undefined, 5, 5, undefined, 1);
                }
            }
            
            if (class == "mage" && specialized == 2)
            {
                if (thirdAttack == 3)
                {
                    var _int = myStatInfo[0][3] + (myStatInfo[9][3] / 2);
                    
                    with (instance_create_depth(x, y - (height / 2), depth - 2, obj_wiz2_basic))
                    {
                        dmg = _int;
                        player = _player;
                        target = _player.myWarrior;
                        depth = other.depth - 2;
                        distance = 1.05;
                    }
                }
            }
            
            if (multipleHit == true)
            {
                var _multipleHitDmg = multipleHitDmg;
                var _enemiesHit = 0;
                
                with (obj_enemy)
                {
                    if (distance_to_object(other) <= 200)
                    {
                        _enemiesHit += 1;
                        instance_create_depth(x, y - (height / 2), depth - 1, obj_slash);
                        audio_sound_pitch(s_swordhit1, random_range(0.9, 1.1));
                        audio_play_sound(s_swordhit1, 0, 0);
                        gml_Script_scr_enemy_takeDamage(_multipleHitDmg / _enemiesHit, 1, _player, 1, undefined, undefined, undefined);
                    }
                }
            }
            
            var _hitDmg = myStatInfo[0][3];
            
            if (class == "mage" && specialized == 2)
                _hitDmg = myStatInfo[0][3] + (myStatInfo[9][3] / 2);
            
            with (target)
            {
                if (other.multipleHit == false)
                {
                    if (gml_Script_scr_enemy_takeDamage(_hitDmg, 1, _player, 1, undefined, undefined, undefined) <= 0)
                    {
                    }
                }
            }
        }
    }
}
