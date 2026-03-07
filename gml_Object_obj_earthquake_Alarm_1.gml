var _spd = irandom_range(-4, 4);

with (obj_ground)
{
    x += (_spd * bgSpd);
    y += ((_spd * bgSpd) / 4);
    
    if (y < (oy - 4))
        y = oy - 4;
    
    if (y > (oy + 4))
        y = oy + 4;
}

with (obj_raidObject)
{
    if (object_index != obj_enemy && object_get_parent(object_index) != obj_enemy)
    {
        x += (_spd * bgSpd);
        y += ((_spd * bgSpd) / 4);
        
        if (y < (oy - 4))
            y = oy - 4;
        
        if (y > (oy + 4))
            y = oy + 4;
    }
}

alarm[1] = room_speed / 10;
