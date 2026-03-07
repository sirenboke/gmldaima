global.xpGoto[0] = -2;
global.xpGoto[1] = -2;

with (obj_warrior)
{
    sprite_index = spr_move;
    state = UnknownEnum.Value_10;
    alarm[1] = -1;
    alarm[6] = -1;
}

alarm[2] = 1;
obj_raidPortal.alarm[0] = -1;

if (audio_is_playing(s_underworldBoss))
    audio_sound_gain(s_underworldBoss, 0, room_speed * 1000);

enum UnknownEnum
{
    Value_10 = 10
}
