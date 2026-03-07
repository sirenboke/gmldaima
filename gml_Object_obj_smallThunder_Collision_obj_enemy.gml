if (instance_exists(player) && instance_exists(player.myWarrior))
{
    if (alarm[0] == 1)
    {
        with (other)
        {
            var _dmg = other.dmg;
            var _player = other.player;
            
            if (irandom(99) < 10)
                gml_Script_scr_zap(0.5);
            
            gml_Script_scr_enemy_takeDamage(_dmg / 15, 2, _player, undefined, undefined, undefined, 1);
        }
    }
}
