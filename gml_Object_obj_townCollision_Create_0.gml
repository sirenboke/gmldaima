if (place_meeting(x, y, obj_player))
{
    with (instance_place(x, y, obj_player))
    {
        x = 1420;
        y = 480;
        alarm[1] = room_speed;
    }
}

event_inherited();
