if (alarm[0] > -1)
{
    y -= grav;
    grav -= (0.01 * global.roomSpeed * global.roomSpeed);
    x += dir;
}
else if (!instance_exists(obj_raidResults))
{
    if (alarm[3] == -1)
    {
        if (set == false)
        {
            if (point_distance(x, y, myPos, (room_height - 250) + sprite_height) <= 10)
            {
                speed = 0;
                x = myPos;
                y = (room_height - 250) + sprite_height;
                global.displayRaidItems += 1;
                set = true;
            }
            else
            {
                speed = 1;
                move_towards_point(myPos, (room_height - 250) + sprite_height, 10);
            }
        }
    }
}
else
{
    visible = true;
    x = (((room_width / 2) - ((50 * global.raidItems) / 2)) + (myPos2 * 50)) - 25;
    y = room_height - 40;
    
    if (alarm[2] == -1)
        alarm[2] = room_speed * (9 - ((tier / 2) + (subTier / 10)));
    
    if (alarm[3] == -1)
        alarm[3] = room_speed * 100;
    
    if (equipped == false)
    {
        if (!instance_exists(obj_build_forge))
            alarm[4] = room_speed / 3;
    }
}

if (alarm[3] != -1)
{
    if (equipped == false)
    {
        if (instance_exists(obj_build_forge))
        {
            move_towards_point(obj_build_forge.x, obj_build_forge.y, 9);
            depth = -1000;
            
            if (position_meeting(x, y, obj_build_forge))
            {
                gml_Script_scr_playsound(s_xpOrb, global.forgePitch, global.forgePitch, 0.5);
                global.forgePitch += 0.5;
                obj_build_forge.forgeItem[0][0] += ((tier * 2) + subTier + (obj_build_forge.level * 2));
                
                if (obj_build_forge.forgeItem[0][0] > obj_build_forge.forgeItem[0][1])
                {
                    obj_build_forge.forgeItem[0][0] = obj_build_forge.forgeItem[0][1];
                    
                    if (obj_build_forge.alarm[0] == -1)
                    {
                        obj_build_forge.alarm[0] = room_speed * 1801;
                        gml_Script_twitch_chat_say_direct("/me The blacksmith collected enough materials to start forging your items! Type !forge(item ID)*(upgrade times) to increase your items' power (" + string(clamp(round(obj_build_forge.level / 3), 1, 6)) + " uses per character).");
                    }
                    else
                    {
                        if (obj_build_forge.alarm[0] < (room_speed * 1800))
                            obj_build_forge.alarm[0] += ((((tier * 2) + subTier + (obj_build_forge.level * 2)) * room_speed) / obj_build_forge.forgeItem[0][1]) * room_speed;
                        
                        if (obj_build_forge.alarm[0] >= (room_speed * 1800))
                            obj_build_forge.alarm[0] = room_speed * 1800;
                    }
                }
                
                instance_destroy();
            }
        }
    }
}
