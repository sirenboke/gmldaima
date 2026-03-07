var _slow = slow;
var _healing = healing / 5;
var _rng = rng;

if (alarm[1] != -1)
{
    if (instance_exists(player) && instance_exists(player.myWarrior) && player.myWarrior.myRaidNumber == 0)
    {
        if (instance_exists(obj_enemy))
        {
            with (instance_nearest(x, y, obj_enemy))
            {
                if (distance_to_object(other) <= _rng)
                {
                    other.target = id;
                    
                    if (other.target == other.lastTarget)
                        other.multiplier += 0.2;
                    else
                        other.multiplier = 1;
                    
                    var _dmg = other.dmg;
                    _dmg *= other.multiplier;
                    show_debug_message("Death Ray damage: " + string(_dmg) + " (" + string(other.multiplier) + "x)");
                    var _player = other.player;
                    
                    if (alarm[0] == -1)
                    {
                        var _oldHP = hp;
                        var _newHP = gml_Script_scr_enemy_takeDamage(_dmg, 2, _player);
                        var _dmgDealt = _oldHP - _newHP;
                        
                        if (_healing > 0 && _dmgDealt > 0)
                        {
                            with (_player.myWarrior)
                                gml_Script_scr_player_heal(_dmgDealt * _healing);
                            
                            show_debug_message("Death Ray healing: " + string(_dmgDealt * _healing));
                        }
                    }
                    
                    if (_slow > 0)
                        gml_Script_scr_statChange(_slow / 5, -1, 10, other.alarm[1] / room_speed, undefined);
                    
                    other.lastTarget = other.target;
                    
                    if (irandom(99) < 10)
                        gml_Script_scr_interrupt();
                }
                else
                {
                    other.alarm[1] = 1;
                    exit;
                }
            }
        }
    }
    else
    {
        alarm[1] = 1;
    }
    
    image_yscale = random_range(1, 2);
    alpha = random_range(0.5, 0.9);
    alarm[0] = room_speed / 5;
}
