itemID = irandom_range(1, global.maxSpecialItems);
level = 1;
levelText = "★";
statID[0] = choose(0, 3, 5, 8, 9);
statAmount[0] = round(irandom_range(100 * level, 200 * level) / global.talentValue[statID[0]]) * level;
modifier[0] = irandom_range(global.specialItem[itemID][2] / 5, global.specialItem[itemID][2]) * level;
modifierText[0] = string(modifier[0]) + "% [" + string((global.specialItem[itemID][2] / 5) * level) + "% - " + string(global.specialItem[itemID][2] * level) + "%]";
branches = 1;
var rollText1 = "Special Item Level:";

for (var _i = 0; _i < 5; _i++)
{
    if (irandom(1) == 0)
    {
        level += 1;
        statID[_i] = choose(0, 3, 5, 8, 9);
        statAmount[_i] = round(irandom_range(100 * level, 200 * level) / global.talentValue[statID[_i]]) * level;
        rollText1 += (" +1 level, stat " + string(statID[_i]) + " +" + string(statAmount[_i]));
        modifier[0] = irandom_range(global.specialItem[itemID][2] / 5, global.specialItem[itemID][2]) * level;
        modifierText[0] = string(modifier[0]) + "% [" + string((global.specialItem[itemID][2] / 5) * level) + "% - " + string(global.specialItem[itemID][2] * level) + "%]";
    }
}

rollText1 += (" and mod is: " + string(modifierText[0]));
show_debug_message(rollText1);
branchValue[0] = irandom(level) + 1;
branchValue[1] = 0;
branchID[0] = irandom(4);

if (level >= 3)
{
    branches = 2;
    branchValue[1] = floor(irandom_range(1 + (level / 3), level + 1));
    branchID[1] = irandom(4);
}

if (level == 5)
{
    branches = 3;
    branchValue[2] = floor(irandom_range(1 + (level / 3), level + 1));
    branchID[2] = irandom(4);
}

levelText = string_repeat(levelText, level);
rollText = "";

for (var _i = 0; _i < branches; _i++)
    rollText += string_hash_to_newline("#+" + string(branchValue[_i]) + " [1 - " + string(level + 1) + "] to branch " + string(branchID[_i] + 1));

c1 = 16777215;
playerGot = 0;
sprite_index = spr_specialItem;
image_index = itemID;
image_speed = 0;
name = global.specialItem[itemID][0];
class = global.specialItem[itemID][3];
var _editDescription = global.specialItem[itemID][1];
_editDescription = string_replace(_editDescription, "*", string(modifierText[0]));
description = _editDescription + rollText;
name += (" " + levelText);
