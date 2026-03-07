self.scr_enemy_ult4 = function()
{
    if (argument[1] <= 0)
        argument[1] = 1;
    
    if (gml_Script_scr_relicEffect(player, 0, 28) > 0 && argument[1] > 0)
        show_debug_message("Wise Hat effect (on " + string(name) + "'s " + string(myAbilityInfo[1]) + "): " + string(argument[1]) + "x.");
    
    canAttack = true;
    gml_Script_scr_playsound(s_enemyBite, 1.3, 1.4, 0.2);
    var _abilityDmg = myStatInfo[0][3] * 1.3 * (1.6 + (level / 1800)) * argument[1];
    
    with (obj_warrior)
    {
        if (myRaidNumber == 0 && immune == false)
        {
            gml_Script_scr_player_takeDamage(_abilityDmg, 1, other.id, 0, 0);
            
            if (other.tier >= 2)
            {
                var _armorDebuff = 0.2 + (other.level / 20000);
                
                if (_armorDebuff > 2)
                    _armorDebuff = 2;
                
                gml_Script_scr_statChange(_armorDebuff, -1, 3, undefined, undefined);
            }
            
            audio_sound_pitch(s_swordhit1, random_range(0.9, 1.1));
            audio_play_sound(s_swordhit1, 0, 0);
        }
    }
};
