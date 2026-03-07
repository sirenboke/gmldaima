var _dmg = dmg;
var _player = player;

if (_dmg > 0 && _player != -1)
{
    with (obj_enemy)
    {
        if (distance_to_object(other) <= 100)
        {
            var _falloff = clamp(distance_to_object(other) / 10, 1, 5);
            gml_Script_scr_enemy_takeDamage(_dmg / _falloff, 1, _player, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 1);
        }
    }
}
