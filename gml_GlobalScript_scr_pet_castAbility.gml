self.scr_pet_castAbility = function()
{
    if (instance_exists(player))
    {
        gml_Script_scr_playsound(s_skillReady, 0.9, 1.1, 0.02);
        mana = 0;
        
        with (gml_Script_instance_create(x, y - 25, obj_float))
        {
            type = 20;
            value = string(global.globalPetInfo[other.type][3]) + "!";
            text = value;
            c1 = 65535;
            c2 = 4235519;
            parent = other.id;
        }
        
        script_execute(ability, level);
    }
};
