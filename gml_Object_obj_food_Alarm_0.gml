if (!audio_is_playing(s_xpOrb))
{
    audio_sound_pitch(s_xpOrb, random_range(5, 7));
    audio_play_sound(s_xpOrb, 0, 0);
}

global.creditsFood += value;
global.food += value;

if (global.tutorialStep == 0)
{
    if (instance_exists(obj_tutorial))
    {
        if (global.food >= 2000)
        {
            if (obj_tutorial.alarm[1] > room_speed)
                obj_tutorial.alarm[1] = room_speed;
        }
    }
}

with (obj_player)
{
    if (state == UnknownEnum.Value_3)
        gml_Script_scr_addDiaryProgress(-3, other.value);
}

if (instance_exists(obj_quest))
{
    if (obj_quest.questType == "farm")
    {
        with (obj_player)
        {
            if (state == UnknownEnum.Value_3)
                reputation += other.value;
        }
    }
}

with (gml_Script_instance_create(520, 25, obj_float))
{
    type = 7;
    value = round(other.value);
    text = "+" + gml_Script_scr_bigNumber(round(value));
    c1 = 65280;
    c2 = 32768;
    parent = type;
    alarm[1] = 1;
}

if (instance_exists(obj_quest))
{
    if (obj_quest.questType == "farm")
        obj_quest.progress += value;
}

with (gml_Script_instance_create(x, y, obj_smokeAnimation))
{
    sprite_index = spr_smokeBomb;
    image_xscale = 0.2;
    image_yscale = 0.2;
}

instance_destroy();

enum UnknownEnum
{
    Value_3 = 3
}
