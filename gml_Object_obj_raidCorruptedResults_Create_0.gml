global.xpGoto[0] = -2;
global.xpGoto[1] = -2;
reward = [];
rewardText = [];
rewardValue = [];

with (obj_warrior)
{
    sprite_index = spr_move;
    state = UnknownEnum.Value_10;
    alarm[1] = -1;
    alarm[6] = -1;
}

alarm[2] = 1;
obj_raidCorrupted.alarm[0] = -1;

if (audio_is_playing(s_underworldBoss))
    audio_sound_gain(s_underworldBoss, 0, 3000);

if (instance_exists(obj_challengeMeteors))
{
    with (obj_challengeMeteors)
    {
        if (alarm[1] > room_speed)
            alarm[1] = room_speed;
    }
}

layer = layer_get_id("Cleared");
ds_list_clear(global.corruptedCardVoting);

enum UnknownEnum
{
    Value_10 = 10
}
