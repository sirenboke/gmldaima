if (instance_exists(player))
{
    if (instance_exists(player.myWarrior))
    {
        if (other.id != target)
        {
            if (pierce == true)
            {
                target = other.id;
                hit = false;
                dmg *= arrowdmgReduction;
            }
            else
            {
                instance_destroy();
            }
        }
        
        if (bounces <= 0)
            instance_destroy();
        
        if (hit == false)
        {
            bounces -= 1;
            
            if (instance_exists(target))
            {
                with (target)
                {
                    var _target = other.target;
                    var _dmg = other.dmg;
                    var _player = other.player;
                    var _dmgType = other.dmgType;
                    
                    if (other.pierce == false)
                        gml_Script_scr_enemy_takeDamage(_dmg, _dmgType, _player, 1, undefined, undefined, undefined, undefined, 0);
                    else
                        gml_Script_scr_enemy_takeDamage(_dmg, _dmgType, _player, 1, undefined, undefined, undefined, undefined, 0);
                }
            }
            
            if (pierce == false)
                instance_destroy();
            
            hit = true;
        }
    }
    else
    {
        with (gml_Script_instance_create(x, y, obj_axeFall))
        {
            direction = other.direction;
            image_index = other.image_index;
            instance_destroy();
        }
    }
}
