self.scr_clearDeathRain = function()
{
    if (part_emitter_exists(global.over_partsys, global.deathrainpart_emitter))
        part_emitter_destroy(global.over_partsys, global.deathrainpart_emitter);
    
    if (instance_exists(obj_deathRain))
    {
        with (obj_deathRain)
            instance_destroy();
    }
};
