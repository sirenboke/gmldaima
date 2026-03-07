if (global.tutorialStep == 0 && global.food >= 2000)
{
    global.tutorialStep = 1;
    gml_Script_twitch_chat_say_direct("/me [Tutorial (1/" + string(tipsList) + ")]: Good job! You now have a great amount of food stored and won't have to worry about it for a while.");
}

if (global.tutorialStep == 1 && obj_build_inn.level > 1)
{
    global.tutorialStep = 2;
    gml_Script_twitch_chat_say_direct("/me [Tutorial (2/" + string(tipsList) + ")]: Great! You can now store more resources and the Town gained some XP and max HP too! Make sure to upgrade your Inn every now and then so you can keep expanding your Town.");
}

if (global.tutorialStep == 2 && obj_build_mine.level >= 10)
{
    global.tutorialStep = 3;
    gml_Script_twitch_chat_say_direct("/me [Tutorial (3/" + string(tipsList) + ")]: Finally! Gold and gems are key resources in Town progression. You should now focus on constructing all the remaining buildings so you can benefit from their effects.");
}

if (global.tutorialStep == 3 && global.academyBuilt == 1)
{
    global.tutorialStep = 4;
    gml_Script_twitch_chat_say_direct("/me [Tutorial (4/" + string(tipsList) + ")]: Good! You can now start customizing your character's build by increasing your desired stats.");
}

if (global.tutorialStep == 4 && global.guildsBuilt == 1)
{
    global.tutorialStep = 5;
    gml_Script_twitch_chat_say_direct("/me [Tutorial (5/" + string(tipsList) + ")]: Well done! Time to start completing quests! You will also receive big daily rewards after upgrading the Guild Hall to level 10!");
}

text = q[global.tutorialStep];
gml_Script_twitch_chat_say_direct("/me " + string(text));
ini_open(string(global.platformDir) + "Village Data/Data.ini");
ini_write_real("Tutorial", "Step", global.tutorialStep);
ini_close();

if (global.tutorialStep < 5)
    alarm[1] = room_speed * 120;
