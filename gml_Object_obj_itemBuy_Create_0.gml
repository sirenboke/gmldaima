alarm[0] = room_speed;
itemType = 0;
amount = 1;
rot = 0;
upgChance = 0;
var beUnique = 0;

if (irandom_range(0, 50 - obj_build_shop.level) <= 0)
    beUnique = true;

if (beUnique == true)
    itemType = 1;

if (itemType == 0)
{
    _itemType = irandom(9);
    sprite_index = spr_newItems;
    image_index = _itemType;
    tierText = "";
    status = obj_build_shop.level * 6 * (1 + (obj_build_shop.level / 5));
    status += (global.hunterGuildLevel * 10);
}

if (itemType == 1)
{
    sprite_index = spr_uniqueItem;
    image_index = irandom_range(1, global.maxUniqueItems);
    name = "Relic " + string(image_index);
    amount = choose(1, 2) + round(random_range(0, obj_build_shop.level / 10));
}

alarm[1] = 1;
number = instance_number(obj_itemBuy);
image_speed = 0;
