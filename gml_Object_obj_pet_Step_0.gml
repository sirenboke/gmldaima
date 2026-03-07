if (instance_exists(player))
{
    if ((player.x - x) > 50)
        x = player.x - 50;
    
    motion_add(point_direction(x, y, player.x - 30, player.y - 100), 0.1 * global.roomSpeed);
    
    if (speed > 5)
        speed = 5;
    
    if (player.enteredCombat == true)
    {
        if (player.state != UnknownEnum.Value_9 && player.state != UnknownEnum.Value_10)
        {
            if (attacking)
            {
                if (alarm[1] == -1)
                    alarm[1] = myStatInfo[1][3] * room_speed;
            }
            
            if (mana < maxMana)
            {
                mana += ((manaGain / 10 / room_speed) * 5);
            }
            else
            {
                mana = 0;
                gml_Script_scr_pet_castAbility();
            }
        }
    }
    else
    {
        mana = 0;
    }
}
else
{
    show_debug_message("Pet destroyed");
    instance_destroy();
}

enum UnknownEnum
{
    Value_9 = 9,
    Value_10
}
