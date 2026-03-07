event_inherited();

if (instance_exists(obj_warrior))
{
    switch (state)
    {
        case UnknownEnum.Value_0:
            gml_Script_scr_idle_enemy();
            break;
        
        case UnknownEnum.Value_1:
            gml_Script_scr_move_enemy();
            break;
        
        case UnknownEnum.Value_2:
            gml_Script_scr_attack_enemy();
            break;
        
        case UnknownEnum.Value_5:
            gml_Script_scr_rest_enemy();
            break;
    }
}
else if (obj_raid.boss == true)
{
    if (distance_to_point(room_width - 200, y) > ceil(moveSpeed))
    {
        if (sprite_index != spr_move)
            sprite_index = spr_move;
        
        var _dir = sign(x - (room_width - 200));
        image_xscale = _dir * size;
        baseSpeed = ospd / 2;
        x += (moveSpeed * 2);
    }
    else
    {
        x = room_width - 200;
        
        if (sprite_index != spr_idle)
            sprite_index = spr_idle;
        
        image_xscale = size;
        image_speed = 0.1;
        
        if (alarm[2] != -1)
            alarm[2] = -1;
        
        if (buffed > 0)
            buffed = 0;
        
        mana = 0;
        baseSpeed = ospd;
        
        if (alarm[3] == -1 && hp < myStatInfo[8][3])
            alarm[3] = room_speed / 5;
    }
}
else
{
    target = -1;
    x -= moveSpeed;
    
    if (sprite_index != spr_move)
        sprite_index = spr_move;
    
    if (x < -sprite_width)
        instance_destroy();
}

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2,
    Value_5 = 5
}
