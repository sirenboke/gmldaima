if (challenge == false)
    draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, angle, c_white, alpha);
else
    draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, angle, c_maroon, alpha);

x -= 5;
y += grav;
angle += spin;
var _expand = expand;
var _slow = slow;
var _duration = duration;

if ((y + (sprite_height / 2)) > (room_height - 15))
{
    with (gml_Script_instance_create(x, room_height - 30, obj_meteorCrash))
    {
        dmg = other.dmg;
        fireStacks = other.fireStacks;
        player = other.player;
        image_xscale = choose(-other.image_xscale, other.image_xscale);
        xscale = image_xscale * sign(image_xscale);
        size = (40 * xscale) / 2;
        expand = _expand;
        slow = _slow;
        duration = room_speed * 3 * _duration;
        challenge = other.challenge;
    }
    
    if (challenge == false)
    {
        if (instance_exists(player) && instance_exists(player.myWarrior))
        {
            if (instance_exists(obj_enemy))
            {
                with (obj_enemy)
                {
                    if (distance_to_object(other) <= 20)
                    {
                        var _dmg = other.dmg;
                        var _player = other.player;
                        gml_Script_scr_enemy_takeDamage(_dmg, 2, _player);
                    }
                }
            }
        }
    }
    else if (instance_exists(obj_warrior))
    {
        with (obj_warrior)
        {
            if (distance_to_object(other) <= 20)
            {
                var _dmg = myStatInfo[8][3] * other.dmg;
                var _player = other.player;
                gml_Script_scr_player_takeDamage(_dmg, 4, _player);
            }
        }
    }
    
    instance_destroy();
}

if (surface_exists(global.raidFog))
{
    surface_set_target(global.raidFog);
    gml_Script_draw_set_blend_mode(bm_subtract);
    
    if (y > (room_height - 270))
    {
        part_emitter_region(global.over_partsys, global.burn_partemitter, x - size - global.partBgPos, (x + size) - global.partBgPos, y - size, y + size, 1, 1);
        part_emitter_burst(global.over_partsys, global.burn_partemitter, global.burn_part, 1);
        part_emitter_region(global.over_partsys, global.burn_partemitter, x - size - global.partBgPos, (x + size) - global.partBgPos, y - size, y + size, 1, 1);
        part_emitter_burst(global.over_partsys, global.burn_partemitter, global.firesmoke_part, 2);
    }
    
    draw_ellipse_colour(x - 30, y - 30, x + 30, y + 30, c_orange, c_black, 0);
    gml_Script_draw_set_blend_mode(bm_normal);
    surface_reset_target();
}
