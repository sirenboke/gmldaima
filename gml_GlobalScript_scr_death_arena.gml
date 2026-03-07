self.scr_death_arena = function()
{
    with (gml_Script_instance_create(x, y, obj_warriorDeath))
    {
        image_xscale = other.image_xscale;
        image_yscale = other.image_yscale;
        sprite_index = other.spr_dead;
        image_speed = 0.02 * global.roomSpeed;
    }
    
    visible = true;
    
    with (obj_player)
    {
        if (name == other.name)
        {
            raidAction = "defeated";
            honor -= 100;
            hp = 1;
            energy = 0;
            state = UnknownEnum.Value_0;
        }
    }
    
    gml_Script_twitch_chat_say("/me We have a winner!");
    
    with (obj_arena)
    {
        alarm[0] = room_speed * 10;
        alarm[2] = -1;
    }
    
    with (gml_Script_instance_create(room_width / 2, room_height - 300, obj_arenaResults))
    {
        result = 1;
        global.raidHonor = 0;
        alarm[0] = room_speed * 11;
    }
    
    instance_destroy();
};

enum UnknownEnum
{
    Value_0
}
