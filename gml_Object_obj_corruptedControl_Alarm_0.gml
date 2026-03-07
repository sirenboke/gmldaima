if (gml_Script_live_call())
    return global.live_result;

if (room != r_corrupted)
{
    obj_portal.alarm[10] = room_speed;
    alarm[1] = room_speed * 30;
}
