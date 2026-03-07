self.scr_move_arena = function()
{
    if (instance_exists(target))
    {
        if (distance_to_object(target) <= rng)
        {
            sprite_index = spr_attack;
            image_index = 0;
            image_speed = 0;
            state = UnknownEnum.Value_2;
            speed = 0;
        }
        else
        {
            move_towards_point(target.x, y, 0.5 * global.roomSpeed);
            
            if (alarm[3] == -1)
            {
                gml_Script_scr_playsound(s_walk1, 0.9, 1.1, 0.3);
                alarm[3] = room_speed / 2.5;
            }
        }
    }
    else
    {
        sprite_index = spr_idle;
        state = UnknownEnum.Value_0;
    }
};

enum UnknownEnum
{
    Value_0,
    Value_2 = 2
}
