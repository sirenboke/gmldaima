if (alpha < 1 && in == true)
{
    alpha += (1 / (room_speed * 3));
}
else if (alarm[0] == -1 && ended == false)
{
    audio_stop_all();
    alarm[0] = room_speed * 3;
}

if (in == false && alpha > 0)
{
    alpha -= (1 / (room_speed * 5));
    
    if (room == r_1 && room != lastRoom)
    {
        with (obj_player)
        {
            if (inPortal == true)
            {
                show_debug_message(string(name) + " was in portal.");
                path_end();
                path_delete(actionPath);
                x = 1420;
                y = 480;
                state = UnknownEnum.Value_0;
                state = UnknownEnum.Value_5;
                target = obj_build_inn;
                actionPath = path_add();
                readyRaid = 0;
                var w = 20;
                var h = 15;
                gotoX = irandom_range(target.x - w, target.x + w);
                gotoY = target.y;
                
                if (mp_grid_path(global.gameGrid, actionPath, x, y, gotoX, gotoY, 1))
                    path_start(actionPath, moveSpeed * global.roomSpeed, path_action_stop, 0);
            }
            else
            {
                show_debug_message(string(name) + " was not in portal.");
                
                if (variable_instance_exists(id, "lastX"))
                    x = lastX;
                
                if (variable_instance_exists(id, "lastY"))
                    y = lastY;
                
                if (variable_instance_exists(id, "lastPath"))
                    actionPath = lastPath;
                
                if (variable_instance_exists(id, "lastState"))
                    state = lastState;
            }
            
            inPortal = false;
        }
    }
}

if (in == false && alpha <= 0)
    instance_destroy();

lastRoom = room;

enum UnknownEnum
{
    Value_0,
    Value_5 = 5
}
