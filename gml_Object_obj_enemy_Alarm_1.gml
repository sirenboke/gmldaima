if (class == "boss")
{
    if (myStatInfo[1][3] < 25)
        myStatInfo[1][3] += 0.005;
}

if (attackType == "ranged")
    gml_Script_instance_create(x, y, obj_enemyOrb);

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
        gml_Script_scr_playsound(choose(s_attack2, s_attack3), 0.9, 1.1, 0.2);
        var _player = id;
        
        with (target)
            gml_Script_scr_player_takeDamage(other.myStatInfo[0][3], 1, _player, 0, 1);
    }
}
