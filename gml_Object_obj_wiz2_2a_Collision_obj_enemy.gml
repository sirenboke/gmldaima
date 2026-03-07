if (alarm[0] <= 1)
    exit;

var _dmg = dmg;
var _shield = shield;
var _interrupt = interrupt;

if (instance_exists(other) && instance_exists(player))
{
    if (alarm[1] == -1)
    {
        if (distance_to_point(other.x, other.y - (other.height / 2)) <= 1)
        {
            var _dmgDealt;
            
            with (other)
            {
                var _depth = depth;
                var _width = length;
                var _height = height;
                
                with (gml_Script_instance_create(x + irandom_range(-_width / 3, _width / 3), (y - (height / 2)) + irandom_range(-_height / 3, _height / 3), obj_raidAnimation))
                {
                    sprite_index = spr_spark_electrical;
                    image_index = 0;
                    image_angle = irandom(359);
                    image_xscale = 0.5;
                    image_yscale = 0.5;
                    depth = _depth - 2;
                    spd = room_speed / 3;
                    color = 16711935;
                }
                
                if (irandom(99) < _interrupt)
                    gml_Script_scr_interrupt();
                
                var _oldhp = hp;
                var _newhp = gml_Script_scr_enemy_takeDamage(_dmg, 2, other.player, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 1);
                _dmgDealt = 0;
                
                if (!is_undefined(_newhp) && !is_undefined(_newhp))
                    _dmgDealt = _oldhp - _newhp;
                
                if (instance_exists(other.player.myWarrior))
                {
                    if (_shield > 0 && _dmgDealt > 0)
                    {
                        with (other.player.myWarrior)
                            gml_Script_scr_shield(_dmgDealt * _shield, undefined, 1);
                    }
                }
            }
            
            show_debug_message("Arcane Missile: Hit for " + string(_dmgDealt) + " and shielded for " + string(_dmgDealt / 2));
            alarm[0] = 1;
        }
    }
}
