if (instance_exists(player))
{
    if (instance_exists(player.myWarrior))
    {
        if (other.id == target)
        {
            with (other)
            {
                var _target = other.target;
                var _dmg = other.dmg;
                var _player = other.player;
                var _dmgType = other.dmgType;
                gml_Script_scr_enemy_takeDamage(_dmg, _dmgType, _player, 1, undefined, undefined, undefined, undefined, 0);
            }
            
            instance_destroy();
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
