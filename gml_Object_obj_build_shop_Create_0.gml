event_inherited();
text = string(global.cmdPrefix) + "buy#";
name = "Shop";
height = sprite_height;
alarm[0] = room_speed * 300;
ini_open(string(global.platformDir) + "Village Data/Data.ini");
level = ini_read_real("Buildings", name + " Level", 1);
cost = ini_read_real("Buildings", name + " Cost", 2000);
oCost = ini_read_real("Buildings", name + " Original Cost", 2000);
cost2 = ini_read_real("Buildings", name + " Cost 2", 0);
oCost2 = ini_read_real("Buildings", name + " Original Cost 2", 0);
ini_close();
costText = gml_Script_scr_bigNumber(cost);

for (i = 1; i <= 4; i += 1)
{
    itemRealType[i] = 0;
    itemAmount[i] = 0;
    itemCost[i] = 0;
    itemLevel[i] = 0;
    itemType[i] = "";
    itemTier[i] = 0;
    itemSubTier[i] = 0;
    itemTierText = "";
}

if (level <= 4)
{
    repeat (level)
        instance_create_depth((x - 141) + 35.25 + (70.5 * instance_number(obj_itemBuy)), y - 40, depth - 10, obj_itemBuy);
}
else
{
    repeat (4)
        instance_create_depth((x - 141) + 35.25 + (70.5 * instance_number(obj_itemBuy)), y - 40, depth - 10, obj_itemBuy);
}

mp_grid_add_instances(global.gameGrid, self, 1);

with (obj_shop)
    instance_destroy();
