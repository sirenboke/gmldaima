self.scr_underworld_arrival = function()
{
    var _x = 400 + irandom_range(-20, 20);
    var _y = 400 + irandom_range(-20, 20);
    gotoX = _x;
    gotoY = _y;
    state = UnknownEnum.Value_14;
    
    if (path_exists(actionPath))
        path_delete(actionPath);
    
    actionPath = path_add();
    
    if (mp_grid_path(global.underworldGrid, actionPath, x, y, _x, _y, 1))
    {
        path_start(actionPath, moveSpeed * global.roomSpeed, path_action_stop, 0);
        exit;
    }
};

self.scr_player_move = function(arg0 = 1)
{
    state = UnknownEnum.Value_14;
    show_debug_message("X: " + string(x) + " | GotoX: " + string(gotoX));
    
    if (sprite_index != spr_move)
        sprite_index = spr_move;
    
    if (gotoX <= round(x))
        image_xscale = -1;
    
    if (gotoX > round(x))
        image_xscale = 1;
    
    image_speed = (moveSpeed / 10) * global.roomSpeed * arg0;
};

self.scr_player_afk = function()
{
    if (room == r_1)
    {
        if (distance_to_point(obj_build_inn.x, obj_build_inn.y) <= 15)
        {
            if (ds_list_find_index(global.list_afk, name) == -1)
            {
                obj_gameControl.alarm[5] = 1;
                obj_gameControl.showPlayers = 0;
                global.cardTurn = 1;
                global.cardTurnNext = 2;
                ds_list_add(global.list_afk, name);
                ds_list_delete(global.list_notafk, ds_list_find_index(global.list_notafk, name));
                ds_list_sort(global.list_notafk, true);
                obj_build_inn.afks += 1;
            }
            
            state = UnknownEnum.Value_15;
            afkRewardPenalty = 0.2;
            afkdraw = true;
            x = obj_build_inn.x;
            y = obj_build_inn.y - 10;
        }
    }
};

self.scr_player_notafk = function()
{
    if (room == r_1)
    {
        if (afkdraw == true)
        {
            afk = false;
            afkdraw = false;
            
            if (ds_list_find_index(global.list_afk, name) != -1)
            {
                ds_list_delete(global.list_afk, ds_list_find_index(global.list_afk, name));
                ds_list_add(global.list_notafk, name);
                ds_list_sort(global.list_notafk, true);
                obj_build_inn.afks -= 1;
            }
        }
        
        afkRewardPenalty = 1;
        alarm[3] = room_speed * afkTimer;
    }
};

self.scr_player_wait = function(arg0 = -1)
{
    path_end();
    image_speed = 0.1;
    sprite_index = spr_idle;
    image_xscale = 1;
    state = UnknownEnum.Value_13;
};

enum UnknownEnum
{
    Value_13 = 13,
    Value_14,
    Value_15
}
