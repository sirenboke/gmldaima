self.scr_playerNextFloor = function()
{
    immune = true;
    x += (0.5 * global.roomSpeed);
    global.xpGoto[0] = -2;
    global.xpGoto[1] = -2;
    
    if (instance_exists(obj_rangedLegs))
    {
        with (obj_rangedLegs)
            instance_destroy();
        
        with (obj_rangedTorso)
            instance_destroy();
    }
    
    with (obj_warrior)
    {
        if (sprite_index != spr_move)
        {
            sprite_index = spr_move;
            image_index = irandom(image_number - 1);
        }
        
        image_speed = 0.024 * global.roomSpeed;
        
        if (x > (room_width + sprite_width))
        {
            with (player)
            {
                readyRaid = 0;
                kills += other.fightKills;
                gml_Script_scr_addDiaryProgress(2, other.fightKills);
            }
            
            instance_destroy();
        }
    }
};
