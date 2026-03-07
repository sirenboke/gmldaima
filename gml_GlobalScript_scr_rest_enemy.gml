self.scr_rest_enemy = function()
{
    if (stamina >= maxStamina)
    {
        stamina = maxStamina;
        state = UnknownEnum.Value_0;
    }
    
    sprite_index = spr_idle;
    image_speed = 0;
};

enum UnknownEnum
{
    Value_0
}
