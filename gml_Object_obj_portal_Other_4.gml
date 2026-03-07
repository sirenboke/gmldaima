if (room == r_underworld_new)
{
    gml_Script_twitch_chat_say("/color BlueViolet");
    
    if (global.portalTower == 1)
        gml_Script_twitch_chat_say_direct("/me You entered the Underworld... Will you find what you came searching for? (Tower " + string(global.portalTower) + ", Floor " + string(global.portalFloor) + ")");
    
    if (global.portalTower == 2)
        gml_Script_twitch_chat_say_direct("/me You entered the Underworld... We conquered a Tower and liberated one of the mythical creatures, are there more of them trapped here? (Tower " + string(global.portalTower) + ", Floor " + string(global.portalFloor) + ")");
    
    if (global.portalTower == 3)
        gml_Script_twitch_chat_say_direct("/me You entered the Underworld... We must liberate all the mythical creatures before their vital energy is drained! (Tower " + string(global.portalTower) + ", Floor " + string(global.portalFloor) + ")");
    
    if (global.portalTower == 4)
        gml_Script_twitch_chat_say_direct("/me You entered the Underworld... It seems like this is the last Tower... lets finish the job! (Tower " + string(global.portalTower) + ", Floor " + string(global.portalFloor) + ")");
    
    if (global.portalTower == 5)
        gml_Script_twitch_chat_say_direct("/me You entered the Underworld... We reached the Underworld Core... What is this!? A hollow version of Finis Vitae is still protecting the Red Portal!");
    
    gml_Script_twitch_chat_say("/color FireBrick");
    
    with (obj_player)
    {
        state = UnknownEnum.Value_0;
        
        if (ds_list_find_index(global.raidListPortalName, string(name)) != -1)
        {
            readyRaid = 1;
            x = 2000;
            y = 450;
        }
    }
    
    with (obj_raidPortal)
    {
        alarm[1] = room_speed * 5;
        alarm[11] = (room_speed * 5) - 1;
    }
}

enum UnknownEnum
{
    Value_0
}
