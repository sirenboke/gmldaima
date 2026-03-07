self.scr_clearFavor = function()
{
    if (part_emitter_exists(global.light_partsys, global.xprainpart_emitter))
        part_emitter_destroy(global.light_partsys, global.xprainpart_emitter);
    
    if (part_emitter_exists(global.light_partsys, global.bonanzapart_emitter))
        part_emitter_destroy(global.light_partsys, global.bonanzapart_emitter);
    
    if (part_emitter_exists(global.light_partsys, global.heavenpower_emitter))
        part_emitter_destroy(global.light_partsys, global.heavenpower_emitter);
};
