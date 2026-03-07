globalQuestBonus = 0;
textColor = 16777215;
depth = obj_gameControl.depth - 1;
x = room_width - 500;
y = room_height - 470;
draw_set_font(f_special);
var quest1 = "Kill a total of ? enemy levels.";
var quest2 = "Dig ? gold from the mine.";
var quest3 = "Harvest ? food from the farm.";
var title = choose(quest1, quest2, quest3);

if (string_pos("Kill", title) != 0)
{
    questType = "kill";
    questGuild = "Hunters";
}

if (string_pos("Harvest", title) != 0)
{
    questType = "farm";
    questGuild = "Farmers";
}

if (string_pos("Dig", title) != 0)
{
    questType = "mine";
    questGuild = "Miners";
}

if (questType == "kill")
    questNumber = round(irandom_range(10, 25) + (1 + global.totalPlayers) + (global.ostage * (2 + (global.ostage / 4.5))));

if (questType == "mine")
    questNumber = obj_build_mine.oamount * random_range(15, 30);

if (questType == "farm")
    questNumber = obj_build_farm.oamount * random_range(15, 30);

rewardType = choose("XP", "gold", "food");

if (rewardType == "XP")
{
    reward = round((global.ostage + (global.ostage * (irandom_range(4, 7) + (global.ostage / 6)))) * global.globalXPBonus);
    index = 0;
}

if (rewardType == "gold")
{
    reward = round((irandom_range(10, 25) + (global.ostage * (1 + (global.ostage / 12)))) * global.globalGoldBonus);
    index = 2;
}

if (rewardType == "food")
{
    reward = round((irandom_range(10, 25) + ((global.ostage / 100) * (1 + (global.ostage / 10)))) * global.globalFoodBonus);
    index = 1;
}

reward = round(reward * (1 + (global.ostage / 100) + (global.ostage / 200)));
icon = 0;
guildsReward = round((1 + (obj_build_guildhall.level / 5)) * (obj_build_guildhall.level / 10));
time = room_speed * 480;
var _legendary = 0;
_legendary = obj_build_guildhall.level / 20;

if ((irandom(99) + 1) <= _legendary)
{
    textColor = 65535;
    questNumber *= 20;
    questNumber /= (1 + (global.ostage / 2000));
    guildsReward *= 30;
    reward *= 30;
    icon = 1;
    var _type = irandom(3);
    
    if (_type == 0)
    {
        reward = round(2 + (_legendary * (1 + (_legendary * 8))));
        rewardType = "gems";
        index = 3;
    }
}

var title2 = string_replace_all(title, "?", gml_Script_scr_bigNumber(round(questNumber)));
questTitle = title2;
questText = string(questTitle) + " [" + gml_Script_scr_bigNumber(round(reward)) + " " + string(rewardType) + " and " + gml_Script_scr_bigNumber(guildsReward) + " " + string(questGuild) + "'s Guild XP]";

if (textColor == 65535)
    obj_questControl.legendary = "Legendary ";
else
    obj_questControl.legendary = "";

obj_questControl.questText = questText;
obj_questControl.alarm[0] = 2;
draw_set_font(f_mid);
width = string_width(string_hash_to_newline(questTitle));
height = string_height_ext(string_hash_to_newline(questTitle), 20, 380);
progress = 0;
alarm[0] = time;

with (obj_player)
{
    reputation = 0;
    guildTick = false;
    questReputation = other.questNumber / (10 + global.totalPlayers);
    reputationCompleted = false;
}

with (obj_warrior)
{
    reputation = 0;
    guildTick = false;
}

questReputation = questNumber / (10 + global.totalPlayers);
questCompleteText = "";
