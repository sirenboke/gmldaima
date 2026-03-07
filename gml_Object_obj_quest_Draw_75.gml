draw_sprite(spr_questBody, 2, x, y - 27);
draw_sprite_ext(spr_quest, icon, x + 50, y + 21, 2, 2, 0, c_white, 1);
draw_set_font(f_mid);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_sprite_ext(spr_blackbar, 0, x + 100, y + 49, 382, 2.4, 0, c_white, 1);
gml_Script_scr_textoutline(x + 100, y - 15, questTitle, textColor, 0, 20, 380);
gml_Script_scr_textoutline(x + 100, (y - 15) + 35, "Reward: " + gml_Script_scr_bigNumber(reward) + " + ", 16777215, 0, 20, 380);

if (questType == "mine")
{
    gml_Script_scr_textoutline(x + 100 + string_width(string_hash_to_newline("Reward: " + gml_Script_scr_bigNumber(reward) + " + ")), (y - 15) + 35, gml_Script_scr_bigNumber(ceil(reward * (1 + (global.minerGuildLevel / 10))) - reward), 16776960, 0, 20, 380);
    iconWidth = string_width(string_hash_to_newline("Reward: " + gml_Script_scr_bigNumber(reward) + " + " + gml_Script_scr_bigNumber(ceil(reward * (1 + (global.farmerGuildLevel / 10))) - reward)));
}

if (questType == "kill")
{
    gml_Script_scr_textoutline(x + 100 + string_width(string_hash_to_newline("Reward: " + gml_Script_scr_bigNumber(reward) + " + ")), (y - 15) + 35, gml_Script_scr_bigNumber(ceil(reward * (1 + (global.hunterGuildLevel / 10))) - reward), 16776960, 0, 20, 380);
    iconWidth = string_width(string_hash_to_newline("Reward: " + gml_Script_scr_bigNumber(reward) + " + " + gml_Script_scr_bigNumber(ceil(reward * (1 + (global.minerGuildLevel / 10))) - reward)));
}

if (questType == "farm")
{
    gml_Script_scr_textoutline(x + 100 + string_width(string_hash_to_newline("Reward: " + gml_Script_scr_bigNumber(reward) + " + ")), (y - 15) + 35, gml_Script_scr_bigNumber(ceil(reward * (1 + (global.farmerGuildLevel / 10))) - reward), 16776960, 0, 20, 380);
    iconWidth = string_width(string_hash_to_newline("Reward: " + gml_Script_scr_bigNumber(reward) + " + " + gml_Script_scr_bigNumber(ceil(reward * (1 + (global.hunterGuildLevel / 10))) - reward)));
}

draw_sprite_ext(spr_questIcon, index, x + 100 + iconWidth + 15, y + 32, 1, 1, 0, c_white, 1);

if (obj_build_guildhall.level >= 10)
{
    draw_set_halign(fa_right);
    gml_Script_scr_textoutline(x + 485, (y - 15) + 35, "+" + gml_Script_scr_bigNumber(guildsReward) + "", 65535, 0, 20, 200);
}

draw_sprite_ext(spr_questbar, 0, x + 100, y + 49, (progress / questNumber) * 380, 2, 0, c_white, 1);
draw_sprite_ext(spr_manabarsmall, 0, x + 380 + 100, y + 59, -(alarm[0] / time) * 380, 1, 0, c_white, 1);

if (progress >= questNumber)
{
    if (questType == "farm")
    {
        globalQuestBonus = 1 + (global.farmerGuildLevel / 10);
        
        with (obj_player)
        {
            if (reputationCompleted == true)
                questBonus = 1 + (global.farmerGuildLevel / 10);
            else
                questBonus = 1;
        }
    }
    
    if (questType == "mine")
    {
        globalQuestBonus = 1 + (global.minerGuildLevel / 10);
        
        with (obj_player)
        {
            if (reputationCompleted == true)
                questBonus = 1 + (global.minerGuildLevel / 10);
            else
                questBonus = 1;
        }
    }
    
    if (questType == "kill")
    {
        globalQuestBonus = 1 + (global.hunterGuildLevel / 10);
        
        with (obj_player)
        {
            if (reputationCompleted == true)
                questBonus = 1 + (global.hunterGuildLevel / 10);
            else
                questBonus = 1;
        }
    }
    
    if (rewardType == "gems")
    {
        with (obj_player)
        {
            if (ascended == true)
                global.gems += round(other.reward * questBonus * afkRewardPenalty);
            else
                myGems += round(other.reward * questBonus * afkRewardPenalty);
        }
    }
    
    if (rewardType == "honor")
    {
        with (obj_player)
        {
            if (ascended == false)
                gml_Script_scr_gainHonor(round(other.reward * questBonus), 1);
        }
    }
    
    if (rewardType == "gold")
    {
        with (obj_player)
        {
            var showGold = (other.reward / global.globalGoldBonus) * questBonus;
            gml_Script_scr_player_reward(showGold, 1);
        }
    }
    
    if (rewardType == "food")
    {
        with (obj_player)
        {
            var showFood = other.reward * questBonus;
            gml_Script_scr_player_reward(showFood, 2);
            
            with (gml_Script_instance_create(x, y - height, obj_float))
            {
                type = 7;
                value = round(showFood);
                text = "+" + gml_Script_scr_bigNumber(value);
                c1 = 65280;
                c2 = 32768;
                parent = other.id;
            }
        }
    }
    
    if (rewardType == "XP")
    {
        with (obj_player)
        {
            if (state != UnknownEnum.Value_8)
            {
                showXP = (other.reward / global.globalXPBonus) * questBonus;
                gml_Script_scr_player_reward(showXP, 0);
            }
        }
        
        with (obj_warrior)
        {
            if (alarm[0] == -1)
            {
                if (player.ascended == false)
                    xp += (other.reward * player.questBonus * player.myMultiplier[2]);
            }
        }
    }
    
    gml_Script_scr_playsound(s_questComplete2, 0.9, 1.1, 2);
    var _legendary = "";
    
    if (textColor == 65535)
        _legendary = "Legendary ";
    
    questCompleteText = string(_legendary) + "Quest completed! [+" + gml_Script_scr_bigNumber(round(reward)) + " " + string(rewardType) + " and " + string(guildsReward) + " " + string(questGuild) + "'s Guild XP]";
    obj_questControl.questCompleteText = questCompleteText;
    global.rewardChestProgress += round((10 + (obj_build_guildhall.level / 5)) * (obj_build_guildhall.level / 10));
    gml_Script_instance_create(x, y, obj_quest);
    instance_destroy();
}

enum UnknownEnum
{
    Value_8 = 8
}
