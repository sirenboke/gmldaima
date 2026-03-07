self.scr_relicEffect_9 = function()
{
    var _corruptionMultiplier = player.uniqueItemCorruption[9];
    
    if (object_get_name(object_index) == "obj_warrior")
    {
        if (equippedUniqueItem[9] == 1 || player.myPetEquippedRelic[myPetID][9] == 1)
        {
            with (obj_enemy)
            {
                if (distance_to_object(other) <= 250)
                {
                    var relic9dmg = 0;
                    
                    if (instance_exists(other))
                    {
                        relic9dmg = ((other.myStatInfo[0][3] / 4000) + (other.myStatInfo[9][3] / 4000)) * (other.myStatInfo[4][3] / 10) * (90 + (other.uniqueItemLevel[9] * 10));
                        relic9dmg *= _corruptionMultiplier;
                        
                        with (other)
                            relic9dmg = gml_Script_scr_petRelic(player, relic9dmg, 9);
                        
                        var relic9dmgReduction = round(distance_to_object(other) / 100);
                        
                        if (relic9dmgReduction < 1)
                            relic9dmgReduction = 1;
                        
                        relic9dmg /= relic9dmgReduction;
                        gml_Script_scr_enemy_takeDamage(relic9dmg, 2, other.player, undefined, undefined, undefined, undefined);
                        
                        with (gml_Script_instance_create(x, room_height - 16, obj_kenjiParticles))
                        {
                            color = 16777215;
                            alpha = 0.8;
                            spd = 0.03;
                        }
                        
                        gml_Script_instance_create(x, y - (height / 2), obj_slash);
                    }
                }
            }
        }
    }
    
    if (object_get_name(object_get_parent(object_index)) == "obj_enemy")
    {
        if (equippedUniqueItem[9] == 1)
        {
            with (obj_warrior)
            {
                if (myRaidNumber == 0)
                {
                    var relic9dmg = 0;
                    
                    if (instance_exists(other))
                    {
                        relic9dmg = ((other.myStatInfo[0][3] / 4000) + (other.myStatInfo[9][3] / 4000)) * (other.myStatInfo[4][3] / 10) * (90 + (other.uniqueItemLevel[9] * 10));
                        relic9dmg *= _corruptionMultiplier;
                        
                        with (other)
                            relic9dmg = gml_Script_scr_petRelic(player, relic9dmg, 9);
                        
                        var relic9dmgReduction = round(distance_to_object(other) / 100);
                        
                        if (relic9dmgReduction < 1)
                            relic9dmgReduction = 1;
                        
                        relic9dmg /= relic9dmgReduction;
                        gml_Script_scr_player_takeDamage(relic9dmg, 2, other.player, undefined, undefined, undefined, undefined);
                        
                        with (gml_Script_instance_create(x, room_height - 16, obj_kenjiParticles))
                        {
                            color = 16777215;
                            alpha = 0.8;
                            spd = 0.03;
                        }
                        
                        gml_Script_instance_create(x, y - (height / 2), obj_slash);
                    }
                }
            }
        }
    }
};
