self.scr_pet_skill1 = function(arg0)
{
    if (instance_exists(player))
    {
        var value = 100;
        value *= arg0;
        
        with (player)
        {
            value += (myStatInfo[8][3] * (arg0 / 200));
            gml_Script_scr_shield(value, undefined, 1);
        }
    }
};
