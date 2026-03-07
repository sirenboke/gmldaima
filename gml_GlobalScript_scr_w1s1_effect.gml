self.scr_w1s1_effect = function()
{
    var _r28 = -1;
    
    if (is_undefined(argument[0]))
    {
        show_debug_message("Argument0 undefined, set to default");
        _r28 = 0;
    }
    else
    {
        _r28 = argument[0];
        show_debug_message("Argument0 is defined as " + string(argument[0]));
    }
    
    if (_r28 <= 0)
        _r28 = 1;
    
    canAttack = false;
    var enemiesHit = 0;
    var _dmg = myStatInfo[0][3] * 10 * (1 + mySpecialBuff[4]) * _r28;
    var _armorDebuff = 0.2 * _r28;
    var _player = player;
    image_speed = 0;
    sprite_index = spr_attack;
    image_index = image_number - 1;
    image_xscale *= -1;
    
    with (instance_create_depth(x, y - (height / 2), depth - 1, obj_slash))
    {
        image_xscale = 0.5;
        image_yscale = choose(-8, 8);
        image_angle += 90;
        image_alpha = 0.6;
        parent = other;
    }
    
    enemiesHit = 0;
    
    with (obj_enemy)
    {
        if (distance_to_object(other) <= 200)
        {
            enemiesHit += 1;
            instance_create_depth(x, y - (height / 2), depth - 1, obj_slash);
            audio_sound_pitch(s_swordhit1, random_range(0.9, 1.1));
            audio_play_sound(s_swordhit1, 0, 0);
            _armorDebuff += (myStatInfo[3][3] * 0.005);
            
            if (_armorDebuff > 0)
                gml_Script_scr_statChange(_armorDebuff, -1, 3, undefined, undefined);
            
            if ((other.mySpecialBuff[2] * 100) > irandom(99))
                gml_Script_scr_stun(0.5);
            
            gml_Script_scr_enemy_takeDamage(_dmg, 1, _player, 0, undefined, undefined, 1);
        }
    }
    
    show_debug_message("spinning: hit " + string(enemiesHit) + " for " + string(_dmg) + " each");
    
    if (alarm[2] != -1)
    {
        gml_Script_scr_alarm_start(1, spinSpeed, gml_Script_scr_w1s1_effect, _r28);
    }
    else
    {
        if (x > maxPos)
            x = maxPos;
        
        canAttack = true;
        image_xscale = 2;
    }
};
