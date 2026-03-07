if (hp > 0)
{
    if (image_xscale == 1)
        x -= (0.2 * global.roomSpeed);
    
    if (image_xscale == -1)
        x += (0.2 * global.roomSpeed);
}

with (obj_trees)
{
    if (depth < other.depth)
    {
        if (distance_to_object(obj_goldenBunny) < 50)
            alpha = 0.2 + (distance_to_object(obj_goldenBunny) / 50);
    }
}

if (hp <= 0)
{
    gml_Script_twitch_chat_say("/color GoldenRod");
    gml_Script_twitch_chat_say_direct("/me " + string(_playerName) + " succesfully tamed the wild " + string(name) + "! Type " + string(global.cmdPrefix) + "setpet " + string(type) + " when you get back to town to make it follow you on your adventures!");
    gml_Script_twitch_chat_say("/color FireBrick");
    gml_Script_scr_playsound(s_goldenBunnyLoot1, 1, 1.2, 1);
    gml_Script_scr_playsound(s_levelUp3, 1, 1.2, 1);
    
    with (obj_player)
    {
        if (name == other._playerName)
        {
            if (diaryQuest[46][0] == 0)
                gml_Script_scr_addDiaryProgress(10, 1);
            
            gotPet[other.type] = 1;
            ini_open(string(global.platformDir) + string(myCharDir) + "Data.ini");
            ini_write_real("Pets", "Got Pet " + string(other.type), 1);
            ini_write_real("Pets", "My Pet " + string(other.type) + " Level", 1);
            ini_write_real("Pets", "My Pet " + string(other.type) + " XP", 0);
            ini_close();
        }
    }
    
    instance_destroy();
}
