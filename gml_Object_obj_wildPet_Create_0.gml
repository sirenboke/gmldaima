image_speed = 0.015 * global.roomSpeed;

if (x < (room_width / 2))
    image_xscale = -1;

if (x > (room_width / 2))
    image_xscale = 1;

type = irandom_range(1, 3);

if (type == 1)
    c_pet = 16776960;

if (type == 2)
    c_pet = 65280;

if (type == 3)
    c_pet = 255;

if (type == 4)
    c_pet = 65535;

name = string_lower(global.globalPetInfo[type][1]);
destroy = 0;

if (ds_list_size(global.rewardList) > 0)
{
    _playerName = ds_list_find_value(global.rewardList, irandom_range(0, ds_list_size(global.rewardList) - 1));
}
else
{
    instance_destroy();
    exit;
}

with (obj_player)
{
    if (name == other._playerName)
    {
        if (ascended == true)
        {
            with (other)
                destroy = 1;
        }
        
        if (gotPet[other.type] == 1)
        {
            show_debug_message("pet already owned");
            
            with (other)
                destroy = 1;
        }
    }
}

if (destroy == 1)
{
    instance_destroy();
    exit;
}

hp = 1;
word = string(global.cmdPrefix) + "tame " + string(name);
gml_Script_scr_playsound(s_goldenBunny, 1, 1.2, 2);
gml_Script_twitch_chat_say("/color GoldenRod");
gml_Script_twitch_chat_say_direct("/me A wild " + string(name) + " has appeared! It is looking at " + string(_playerName) + " straight in the eyes... You might have a chance to " + string(global.cmdPrefix) + "tame it now!");
gml_Script_twitch_chat_say("/color FireBrick");
alarm[0] = room_speed * 90;
