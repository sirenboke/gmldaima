if (alpha >= 0.1)
{
    var _player = player;
    var _dmg = dmg;
    
    if (instance_exists(_player))
    {
        with (other)
            gml_Script_scr_enemy_takeDamage(_dmg, 2, _player, 1);
    }
    
    alarm[0] = 1;
}
