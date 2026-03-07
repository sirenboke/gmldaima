image_speed = 0.015 * global.roomSpeed;

if (x < (room_width / 2))
    image_xscale = -1;

if (x > (room_width / 2))
    image_xscale = 1;

hp = 1;
word = string(irandom_range(10000, 99999));
gml_Script_scr_playsound(s_goldenBunny, 1, 1.2, 2);
lootGold = round(((1000 * (global.townLevel * 10)) + power(11, 1 + (global.townLevel / 2))) * global.globalGoldBonus);
lootFood = 0;

if (lootGold >= global.maxNumber || lootGold <= 0)
    lootGold = global.maxNumber;

lootPoints = 50 + round((global.townLevel * 10) + power(11, global.townLevel / 10));
lootGems = 10 + round((global.townLevel * 2) + power(11, global.townLevel / 20));
gml_Script_twitch_chat_say("/color GoldenRod");
gml_Script_twitch_chat_say_direct("/me A golden bunny has appeared! Find it and type the numbers you see above it!");
gml_Script_twitch_chat_say("/color FireBrick");
alarm[0] = room_speed * 90;
