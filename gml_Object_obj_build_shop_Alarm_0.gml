with (obj_itemBuy)
    instance_destroy();

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

gml_Script_scr_playsound(choose(s_drop1, s_drop2, s_drop3, s_drop4), 0.9, 1.1, 1);
global.globalShopID += 1;
ini_open(string(global.platformDir) + "Village Data/Data.ini");
ini_write_real("Buildings", "Shop ID", global.globalShopID);
ini_close();
alarm[0] = room_speed * 300;
