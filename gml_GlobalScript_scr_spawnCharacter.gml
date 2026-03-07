self.scr_spawnCharacter = function()
{
    show_debug_message("Creating " + string(argument[0]) + " clone...");
    holder = gml_Script_instance_create(300, 300, obj_playerHolder);
    
    with (holder)
    {
        name = argument[0];
        class = argument[1];
        saveName = argument[2];
        chooseClass = class;
        gml_Script_scr_createCharacter(chooseClass, name);
        instance_destroy();
    }
};
