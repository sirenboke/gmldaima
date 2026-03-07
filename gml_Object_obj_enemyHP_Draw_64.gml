var _totalStatus = 0;

if (instance_exists(obj_enemy))
{
    if ((!instance_exists(obj_transition_in) && !instance_exists(obj_transition_out)) && (!instance_exists(obj_stageTransition) && !instance_exists(obj_raidTransition)))
    {
        with (obj_enemy)
        {
            if (tired == true)
            {
                var _afk = 3;
                draw_sprite_ext(spr_afk, _afk, x, bar_height + 30, 2, 2, 0, c_white, 1);
            }
            
            if ((myNumber == 0 || hp < myStatInfo[8][3]) && class == "basic")
                depth = -2;
            
            draw_set_valign(fa_middle);
            
            if (mana > 0)
            {
                draw_sprite_ext(spr_blackbar, 0, x - 30, bar_height + 5, 60, 1, 0, c_white, 1);
                draw_sprite_ext(spr_manabarsmall, 0, x - 28, bar_height + 5, (mana / maxmana) * 56, 1, 0, c_white, 1);
            }
            else if (myNumber == 0 || (hp + shield) < (myStatInfo[8][3] + omaxshield))
            {
                draw_sprite_ext(spr_blackbar, 0, x - 30, bar_height + 5, 60, 1, 0, c_white, 1);
            }
            
            if (alarm[2] > 1)
                draw_sprite_ext(spr_energybarsmall, 0, x - 28, bar_height + 5, (alarm[2] / room_speed / skillTimer) * 56, 1, 0, c_white, 1);
            
            if (buffed > 0)
                draw_sprite_ext(spr_energybarsmall, 0, x - 28, bar_height + 5, (buffed / skillBuff) * 56, 1, 0, c_white, 1);
            
            if (gml_Script_scr_alarm_get(0) != -1)
                draw_sprite_ext(spr_manabarsmall, 0, x - 28, bar_height + 5, 56 - ((gml_Script_scr_alarm_get(0) / myAbilityInfo[9]) * 56), 1, 0, c_lime, 1);
            
            if (myNumber == 0 || (hp + shield) < (myStatInfo[8][3] + omaxshield))
            {
                if (poisonDmg > 0)
                    draw_sprite_ext(spr_statusDamage_old, 1, x + 20, room_height - 20, 1.5, 1.5, 1, c_white, 1);
                
                draw_set_halign(fa_center);
                draw_set_font(f_special);
                draw_sprite_ext(spr_blackbar, 0, x - 30, bar_height, 60, 1, 0, c_white, 1);
                
                if (type != "demon")
                {
                    if (hp > 0)
                        draw_sprite_ext(spr_enemyhpbarsmall, 0, x - 28, bar_height, (hp / myStatInfo[8][3]) * 56, 1, 0, c_white, 1);
                }
                else if (hp > 0)
                {
                    draw_sprite_ext(spr_xpbarsmall, 0, x - 28, bar_height, (hp / myStatInfo[8][3]) * 56, 1, 0, c_white, 1);
                }
                
                if (shield > 0)
                    draw_sprite_ext(spr_manabarsmall, 0, x - 28, bar_height, (shield / myStatInfo[8][3]) * 56, 1, 0, c_white, 1);
                
                if (tier > 1)
                    draw_sprite(spr_enemyTier, tier - 2, x - 35, bar_height + 1);
            }
            else if (tier > 1)
            {
                draw_sprite(spr_enemyTier, tier - 2, x, bar_height - 8);
            }
            
            if (class == "boss")
            {
                draw_set_halign(fa_center);
                draw_set_valign(fa_middle);
                draw_set_font(f_special);
                
                if (alarm[2] > 1)
                {
                }
                
                if (buffed > 0)
                {
                }
                
                if (gml_Script_scr_alarm_get(0) != -1)
                {
                }
            }
            
            if (class == "alpha")
            {
                if (type == "demon")
                {
                    draw_set_halign(fa_center);
                    draw_set_valign(fa_middle);
                    draw_set_font(f_special);
                    hpLength = length / 2;
                    
                    if (alarm[2] > 1)
                    {
                    }
                    
                    if (buffed > 0)
                    {
                    }
                    
                    if (gml_Script_scr_alarm_get(0) != -1)
                    {
                    }
                }
                else
                {
                    draw_set_halign(fa_center);
                    draw_set_valign(fa_middle);
                    draw_set_font(f_special);
                    draw_set_font(f_special_old);
                    hpLength = length;
                    
                    if (alarm[2] > 1)
                    {
                    }
                    
                    if (buffed > 0)
                    {
                    }
                    
                    if (gml_Script_scr_alarm_get(0) != -1)
                    {
                    }
                }
            }
        }
    }
}
