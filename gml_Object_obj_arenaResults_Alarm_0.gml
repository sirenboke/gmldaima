gml_Script_twitch_chat_say("/me " + string(obj_arena_warrior.name) + " won the fight! You won 100 Honor.");

with (obj_warriorDeath)
    sprite_index = spr_warriorRIP;

audio_sound_gain(obj_gameControl.theme, 0.02, 3000);
audio_stop_sound(obj_raid.fightTheme);

with (obj_player)
{
    if (state == UnknownEnum.Value_8)
        state = UnknownEnum.Value_0;
}

global.warriorBonus = 0;
global.rogueBonus = 0;

with (obj_trees)
{
    if (alpha != 1)
        alpha = 1;
}

with (obj_arena_warrior)
    instance_destroy();

instance_destroy();
global.vs0.visible = true;
global.vs1.visible = true;

enum UnknownEnum
{
    Value_0,
    Value_8 = 8
}
