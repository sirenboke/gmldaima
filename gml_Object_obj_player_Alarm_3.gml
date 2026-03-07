if (room == r_1 && state == UnknownEnum.Value_0)
{
    if (afk == false)
    {
        afk = true;
        
        if (state != UnknownEnum.Value_8 && state != UnknownEnum.Value_12 && toPortal == false)
        {
            path_end();
            state = UnknownEnum.Value_15;
            target = obj_build_inn;
            actionPath = path_add();
            gotoX = target.x;
            gotoY = target.y;
            
            if (mp_grid_path(global.gameGrid, actionPath, x, y, gotoX, gotoY, 1))
                path_start(actionPath, moveSpeed * global.roomSpeed, path_action_stop, 0);
        }
    }
}
else
{
    alarm[3] = room_speed * 10;
}

enum UnknownEnum
{
    Value_0,
    Value_8 = 8,
    Value_12 = 12,
    Value_15 = 15
}
