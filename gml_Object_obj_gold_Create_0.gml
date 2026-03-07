goto = instance_nearest(x, y, obj_player);
value = obj_build_mine.amount;
alarm[0] = room_speed;
grav = 0.7 * global.roomSpeed;
dir = random_range(-0.2, 0.2) * global.roomSpeed;
image_speed = 0;
type = 0;
sprite_index = spr_gold;
var _gemChance = irandom(obj_build_mine.gemChance);

if (_gemChance == 0)
{
    type = 1;
    sprite_index = spr_underworldIcons;
    image_index = 2;
    image_xscale = 0.5;
    image_yscale = 0.5;
}
