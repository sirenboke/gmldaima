self.scr_moveTown = function()
{
    if (sprite_index != spr_move)
        sprite_index = spr_move;
    
    if (gotoX <= round(x))
        image_xscale = -1;
    
    if (gotoX > round(x))
        image_xscale = 1;
    
    image_speed = (moveSpeed / 10) * global.roomSpeed;
};
