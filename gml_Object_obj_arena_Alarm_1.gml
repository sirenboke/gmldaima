global.inArena = true;

with (global.vs0)
{
    targetX = 1450;
    targetY = 450;
    state = UnknownEnum.Value_8;
    actionPath = path_add();
    
    if (mp_grid_path(global.gameGrid, actionPath, x, y, targetX, targetY, 1))
    {
        path_start(actionPath, 0.5 * global.roomSpeed, path_action_stop, 0);
        
        if (path_position == 1)
            visible = false;
    }
    
    myWarrior = gml_Script_instance_create(x, y, obj_arena_warrior);
    
    with (myWarrior)
    {
        vs = 0;
        global.vs0ID = id;
        sprite_index = other.sprite_index;
        class = other.class;
        name = other.name;
        saveName = other.saveName;
        player = other.id;
        player.honor -= 100;
        x = 400;
    }
}

with (global.vs1)
{
    targetX = 1450;
    targetY = 450;
    state = UnknownEnum.Value_8;
    actionPath = path_add();
    
    if (mp_grid_path(global.gameGrid, actionPath, x, y, targetX, targetY, 1))
    {
        path_start(actionPath, 0.5 * global.roomSpeed, path_action_stop, 0);
        
        if (path_position == 1)
            visible = false;
    }
    
    myWarrior = gml_Script_instance_create(x, y, obj_arena_warrior);
    
    with (myWarrior)
    {
        vs = 1;
        global.vs1ID = id;
        sprite_index = other.sprite_index;
        class = other.class;
        name = other.name;
        saveName = other.saveName;
        player = other.id;
        player.honor -= 100;
        image_xscale = -2;
        x = room_width - 400;
    }
}

alarm[2] = room_speed * 60;

enum UnknownEnum
{
    Value_8 = 8
}
