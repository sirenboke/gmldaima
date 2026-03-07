alpha = 0;
in = true;
ended = false;
alarm[1] = 1;

if (instance_exists(obj_combatGraphs))
{
    with (obj_combatGraphs)
    {
        if (alarm[0] != -1)
            alarm[0] = room_speed;
    }
}
