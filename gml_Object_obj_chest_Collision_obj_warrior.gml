if (other.state != UnknownEnum.Value_9)
{
    if (image_index == 0 && instance_exists(obj_warrior))
    {
        image_index = 1;
        
        if (global.finalWar == false)
        {
            var loot;
            
            if (room == r_1)
                loot = choose(obj_goldDrop2, obj_item, obj_scroll, obj_gem);
            
            if (room == global.room_underworld)
                loot = choose(obj_scroll, obj_hpOrb);
            
            if (loot == obj_item)
            {
                with (gml_Script_instance_create(x, y, loot))
                    status = global.stage * 10;
            }
            
            if (loot == obj_scroll || loot == obj_gem)
            {
                repeat (irandom_range(1, global.townLevel + 3))
                {
                    with (gml_Script_instance_create(x, y, loot))
                        status = 1;
                }
            }
            
            if (loot == obj_goldDrop2)
            {
                repeat (irandom_range(1, 3))
                    gml_Script_instance_create(x, y, loot);
            }
            
            if (loot == obj_hpOrb)
            {
                repeat (irandom_range(2, 10))
                    gml_Script_instance_create(x, y, loot);
            }
        }
        else
        {
            var loot = obj_hpOrb;
            
            repeat (irandom_range(2, 10))
                gml_Script_instance_create(x, y, loot);
        }
        
        gml_Script_scr_playsound(s_chestOpen, 0.9, 0.1, 0.4);
    }
}

enum UnknownEnum
{
    Value_9 = 9
}
