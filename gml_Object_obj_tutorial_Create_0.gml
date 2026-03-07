gml_Script_twitch_chat_say_direct("/me [Tutorial]: Welcome to Dungeon Raiders! If you are new to the game, consider visiting https://dungeon-raiders.netlify.app to learn the basics. You can check your " + string(global.cmdPrefix) + "?Town information at the top of the screen. From left to right: Town Level, Resources, God " + string(global.cmdPrefix) + "!Favors, Population and Campaign Information.");
q[0] = "Gather 2,000 food from the " + string(global.cmdPrefix) + "farm. Food will allow you to heal and regenerate energy when tired. Make sure you always have some available!";
q[1] = "Upgrade the Inn to increase your maximum resource storage capacity, necessary to upgrade more expensive buildings (" + string(global.cmdPrefix) + "upg inn). You can obtain gold from the !mine.";
q[2] = "Upgrade the " + string(global.cmdPrefix) + "mine to level 10 to increase its gold yield. It's recommended to focus on your Town's economy early on since you can level up so many buildings quite fast!";
q[3] = "Build the " + string(global.cmdPrefix) + "!Academy to unlock the ability to spend your " + string(global.cmdPrefix) + "!talent points ( room00Talent ), increasing your character stats at your liking. The Town gains XP when you spend gold on it (buying items, forging, upgrading buildings...).";
q[4] = "Build the " + string(global.cmdPrefix) + "!Guild Hall to receive quests periodically, allowing you to obtain additional rewards passively while you complete tasks like mining, farming or raiding. The Town gains XP when you spend gold in it (buying items, forging, upgrading buildings...).";
q[5] = "[Tutorial]: Congratulations, you completed the Town tutorial! You will still receive personal character guiding tagged with [Tutorial] at the start of the message. You can enable or disable being pinged in guide messages with the " + string(global.cmdPrefix) + "tutorial command.";
tipsList = array_length(q) - 1;

for (var i = 0; i < tipsList; i++)
    q[i] = string_insert("[Tutorial (" + string(i + 1) + "/" + string(tipsList) + ")]: ", q[i], 1);

text = q[irandom(tipsList)];
p[0] = "You have some room00Talent ready to be spent! You can increase your character' stats by typing " + string(global.cmdPrefix) + "talent (stat ID)*(" + string(global.cmdPrefix) + "!talent points to spend).";
p[1] = "You have not equipped any " + string(global.cmdPrefix) + "!Relic yet, you can do so with the !setrelic (Relic Slot):(Relic ID) command. Check your available Relics with " + string(global.cmdPrefix) + "myrelics, and your equipped ones with " + string(global.cmdPrefix) + "?relics.";
p[2] = "You are not projecting any " + string(global.cmdPrefix) + "!Aura, you can do so with the !setaura (Aura ID) command. Check your available Auras with " + string(global.cmdPrefix) + "myauras.";
p[3] = "You do not have any " + string(global.cmdPrefix) + "!Pet set as your companion. You can do so with the !setpet (Pet ID) command. Check your tamed Pets with " + string(global.cmdPrefix) + "mypets, and your equiped Pet's Relics with " + string(global.cmdPrefix) + "?pet.";
personalTipsList = array_length(p) - 1;

for (var i = 0; i < personalTipsList; i++)
{
    p[i] = string_insert("[Tutorial]: ", p[i], 1);
    p[i] = string_insert(" [Type !tutorial to toggle personal help messages]", p[i], string_length(p[i]));
}

text = p[irandom(personalTipsList)];
cyclePersonalTip = 0;
alarm[1] = room_speed * 10;
alarm[2] = room_speed * 120;
