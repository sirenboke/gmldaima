var _dmg = dmg;
var _player = player;

if (instance_exists(player) && instance_exists(player.myWarrior))
{
    if (instance_exists(bounceTo))
    {
        with (bounceTo)
        {
            gml_Script_scr_enemy_takeDamage(_dmg, 2, _player);
            
            if (irandom(99) < 10)
                gml_Script_scr_zap(1.5);
        }
    }
}
