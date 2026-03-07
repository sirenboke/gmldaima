if (instance_exists(player) && instance_exists(player.myWarrior))
{
    if (instance_exists(target))
    {
        with (target)
        {
            var _dmg = other.dmg;
            var _player = other.player;
            gml_Script_scr_enemy_takeDamage(other.dmg, 2, other.player);
            
            if (irandom(99) < 10)
                gml_Script_scr_zap(0.5);
            
            if (hp <= 0)
            {
                if (instance_exists(other.player.myWarrior))
                {
                    if (other.tier >= 2)
                    {
                        var skill_level = other.level;
                        
                        with (gml_Script_instance_create(x, room_height - 20, obj_smallThunder))
                        {
                            level = skill_level;
                            dmg = _dmg / (((global.maxAbilityLevel / 2) + 1) - level);
                            player = _player;
                            move_towards_point(x - 1, y, 1 * global.roomSpeed);
                        }
                        
                        with (gml_Script_instance_create(x, room_height - 20, obj_smallThunder))
                        {
                            level = skill_level;
                            dmg = _dmg / (((global.maxAbilityLevel / 2) + 1) - level);
                            player = _player;
                            move_towards_point(x + 1, y, 1 * global.roomSpeed);
                        }
                    }
                }
            }
        }
    }
}
