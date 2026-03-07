if (room != r_1)
    instance_destroy();

depth = obj_raid.depth + 1;
audio_sound_gain(obj_raid.fightTheme, 0, 10000);
global.xpGoto[0] = -2;
global.xpGoto[1] = -2;
global.raidHonor = global.stage;
lastStage = global.stage;
rewardedTalent = 0;
rewardedGems = 0;

with (obj_warrior)
{
    sprite_index = spr_move;
    state = UnknownEnum.Value_9;
    alarm[1] = -1;
    alarm[6] = -1;
}

alarm[2] = 1;
global.raidGold *= (1 + (global.stage / 20));
global.raidXP *= (1 + (global.stage / 200));
global.forgePitch = 0.5;

if (obj_raid.alarm[4] <= (room_speed * 60) && obj_raid.alarm[4] != -1)
    obj_raid.alarm[4] = room_speed * 100;

if (global.finalWar == true)
    obj_raid.alarm[4] = -1;

alarm[1] = 1;
obj_raid.alarm[0] = -1;

enum UnknownEnum
{
    Value_9 = 9
}
