if (!audio_is_playing(s_xpOrb))
{
    audio_sound_pitch(s_xpOrb, random_range(5, 7));
    audio_play_sound(s_xpOrb, 0, 0);
}

if (type == 0)
{
    global.gold += value;
    global.creditsGold += value;
    
    with (obj_player)
    {
        if (state == UnknownEnum.Value_4)
            gml_Script_scr_addDiaryProgress(-2, other.value);
    }
    
    if (instance_exists(obj_quest))
    {
        if (obj_quest.questType == "mine")
        {
            with (obj_player)
            {
                if (state == UnknownEnum.Value_4)
                    reputation += other.value;
            }
        }
    }
    
    with (gml_Script_instance_create(370, 25, obj_float))
    {
        type = 1;
        value = round(other.value);
        text = "+" + gml_Script_scr_bigNumber(round(value));
        c1 = 65535;
        c2 = 4235519;
        parent = type;
        alarm[1] = 1;
    }
    
    if (instance_exists(obj_quest))
    {
        if (obj_quest.questType == "mine")
            obj_quest.progress += value;
    }
}

if (type == 1)
{
    var _amount = irandom_range(floor(1 + (((global.townLevel / 2) + (obj_build_mine.level / 10)) / 2)), floor(2 + ((global.townLevel / 2) + (obj_build_mine.level / 10))));
    global.gems += _amount;
    gml_Script_twitch_chat_say("/color GoldenRod");
    gml_Script_twitch_chat_say_direct("/me You found gems in the mine! The Town and everyone mining got " + string(_amount) + " room00Gem .");
    gml_Script_twitch_chat_say("/color FireBrick");
    gml_Script_scr_playsound(s_gem, 1, 1.1, 1);
    
    with (obj_player)
    {
        if (state == UnknownEnum.Value_4)
        {
            if (ascended == true)
            {
                global.gems += _amount;
            }
            else
            {
                gml_Script_scr_addDiaryProgress(11, _amount);
                myGems += _amount;
                achievement[25] += _amount;
                ini_open(string(global.platformDir) + string(myAccDir) + "Character Data.ini");
                ini_write_real("Resources", "Gems", myGems);
                ini_close();
                
                with (gml_Script_instance_create(x, y - 50, obj_float))
                {
                    type = 25;
                    value = _amount;
                    text = "+" + string(round(value)) + " gems";
                    c1 = 65535;
                    c2 = 16776960;
                    parent = type;
                }
            }
        }
    }
    
    with (gml_Script_instance_create(370, 55, obj_float))
    {
        type = 13;
        value = round(other.value);
        text = "+" + gml_Script_scr_bigNumber(round(value));
        c1 = 65280;
        c2 = 16776960;
        parent = type;
        alarm[1] = 1;
    }
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
    Value_4 = 4
}
