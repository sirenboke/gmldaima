if (room == r_1)
{
    if ((state == UnknownEnum.Value_0 || state == UnknownEnum.Value_7) && afk == false)
    {
        path_end();
        target = instance_find(obj_idleZone, irandom(instance_number(obj_idleZone) - 1));
        actionPath = path_add();
        var w = target.sprite_width / 2;
        var h = target.sprite_height / 2;
        gotoX = random_range(target.x - w, target.x + w);
        gotoY = random_range(target.y - h, target.y + h);
        
        if (mp_grid_path(global.gameGrid, actionPath, x, y, gotoX, gotoY, 1))
        {
            path_start(actionPath, 0.2 * global.roomSpeed, path_action_stop, 0);
            
            if (path_position == 1)
                path_end();
        }
    }
}

enum UnknownEnum
{
    Value_0,
    Value_7 = 7
}
