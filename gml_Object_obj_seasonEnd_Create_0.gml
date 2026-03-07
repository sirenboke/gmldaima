show_debug_overlay(false);
instance_destroy(obj_raidObject, 0);
alarm[1] = room_speed * 3;
hours = 0;
minutes = 0;
seconds = 0;
showText = 1;
maxShowText = 14;
godsChoice = 0;
audio_stop_all();

with (obj_fog)
    instance_destroy();

audio_sound_gain(s_intermission, 0, 0);
audio_sound_gain(s_intermission, 0.4, 10000);
audio_play_sound(s_intermission, 1, 1);
campaignScore = (global.creditsGold / 2) + (global.creditsXP / 2) + (global.creditsFood / 2) + global.creditsHonor + (global.creditsKills * 10000) + (real(global.creditsStage) * 1000000);

if (is_nan(campaignScore))
    campaignScore = global.maxNumber;

campaignScore /= 1000;
campaignScore = round(campaignScore);

if (campaignScore <= 1)
    campaignScore = 1;

ini_open(string(global.platformDir) + "Core Data/Permanent.ini");
lastCampaignScore = ini_read_real("Last Campaign", "Score", 0);
ini_write_real("Last Campaign", "Score", campaignScore);
ini_write_string("Honor Ranking", "String", ds_grid_write(global.honorRanking));
global.godXP = ini_read_real("God", "XP", 0);
vgodXP = 0;
startXP = global.godXP;
ini_close();
godsQuote = "";

if ((lastCampaignScore / 2) >= campaignScore)
{
    godsChoice = 0;
    godsQuote = "Gods feel embarrased by your actions... [No Bonus]";
}

if (lastCampaignScore <= campaignScore)
{
    godsChoice = 1;
    godsQuote = "Gods smile at you... [2x Bonus]";
}

if ((lastCampaignScore * 2) <= campaignScore)
{
    godsChoice = 2;
    godsQuote = "You impressed the Gods with your actions! [4x Bonus]";
}

showCreditsGold = gml_Script_scr_bigNumber(round(global.creditsGold));
showCreditsXP = gml_Script_scr_bigNumber(round(global.creditsXP));
showCreditsFood = gml_Script_scr_bigNumber(round(global.creditsFood));
showCreditsHonor = gml_Script_scr_bigNumber(round(global.creditsHonor));
showCreditsKills = gml_Script_scr_bigNumber(round(global.creditsKills));
showCreditsDeaths = gml_Script_scr_bigNumber(round(global.creditsDeaths));
showCampaignScore = gml_Script_scr_bigNumber(round(campaignScore));
showCampaignTime = obj_seasonControl.timePlayedString;
file_rename(string(global.platformDir) + "Campaign Data/Credits.ini", "Campaign Data/Past Campaigns/Campaign #" + string(global.season - 1) + "/Credits.ini");
file_delete(string(global.platformDir) + "Campaign Data/Credits.ini");
file_delete(string(global.platformDir) + "Core Data/Active Players.ini");
ini_open(string(global.platformDir) + "Core Data/Permanent.ini");
ini_key_delete("God", "Favor Max");
ini_key_delete("God", "Favor Stacks");
ini_key_delete("God", "Favor Progress");
ini_close();

with (obj_raidBackground)
    instance_destroy();

with (obj_raidObject)
    instance_destroy();
