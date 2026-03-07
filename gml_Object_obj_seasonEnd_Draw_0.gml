draw_set_font(f_big);
draw_set_valign(fa_middle);
draw_set_halign(fa_center);

if (showText >= 1)
    gml_Script_scr_textoutlineBIG(room_width / 2, 120, "Campaign #" + string(global.season - 1) + " stats:", 16777215, 0, 60, 1920);

if (showText >= 2)
    gml_Script_scr_textgradient(room_width / 2, 170, "XP: " + string(showCreditsXP), 16711935, 8388736, undefined, 60, 1920);

if (showText >= 3)
    gml_Script_scr_textgradient(room_width / 2, 210, "Gold: " + string(showCreditsGold), 65535, 4235519, undefined, 60, 1920);

if (showText >= 4)
    gml_Script_scr_textgradient(room_width / 2, 250, "Food: " + string(showCreditsFood), 65280, 32768, undefined, 60, 1920);

if (showText >= 5)
    gml_Script_scr_textgradient(room_width / 2, 290, "Honor: " + string(showCreditsHonor), 12632256, 4210752, undefined, 60, 1920);

if (showText >= 6)
    gml_Script_scr_textgradient(room_width / 2, 330, "Kills: " + string(showCreditsKills), 255, 128, undefined, 60, 1920);

if (showText >= 7)
    gml_Script_scr_textgradient(room_width / 2, 370, "Golden Bunnies: " + string(global.creditsBunnies) + "/" + string(global.totalBunnies), 65535, 4235519, undefined, 60, 1920);

if (showText >= 8)
    gml_Script_scr_textgradient(room_width / 2, 410, "Final War Stage: " + string(global.creditsStage), 4235519, 128, undefined, 60, 1920);

if (showText >= 9)
    gml_Script_scr_textgradient(room_width / 2, 450, "Total Campaign Score:", 16777215, 8421504, undefined, 60, 1920);

if (showText >= 10)
    gml_Script_scr_textgradient(room_width / 2, 490, string(showCampaignScore), 16776960, 16711680, undefined, 60, 1920);

if (showText >= 12)
    gml_Script_scr_textoutline(room_width / 2, 580, string(godsQuote), 16777215, 0, 60, 1920);

if (showText >= 13)
{
    if (godsChoice == 1)
    {
        campaignScore *= 2;
        godsChoice = -1;
        showCampaignScore = gml_Script_scr_bigNumber(round(campaignScore));
        gml_Script_scr_playsound(s_favorTrigger, 0.9, 1.1, 1);
    }
    
    if (godsChoice == 2)
    {
        campaignScore *= 4;
        godsChoice = -1;
        showCampaignScore = gml_Script_scr_bigNumber(round(campaignScore));
        gml_Script_scr_playsound(s_favorTrigger, 0.9, 1.1, 1);
    }
    
    draw_sprite_ext(spr_bluebarsmall, 1, (room_width / 2) - 200, 690, 400, 3, 0, c_white, 1);
    
    if (global.godLevel < 50)
    {
        draw_sprite_ext(spr_bluebarsmall, 0, (room_width / 2) - 200, 690, (global.godXP / global.godMaxXP) * 400, 3, 0, c_white, 1);
        gml_Script_scr_textoutline(room_width / 2, 660, "Gods Level: " + gml_Script_scr_bigNumber(global.godLevel), 16777215, 0, 60, 1920);
        draw_set_font(f_special_old);
        gml_Script_scr_textoutline(room_width / 2, 710, "XP: " + gml_Script_scr_bigNumber(global.godXP) + "/" + gml_Script_scr_bigNumber(global.godMaxXP), 16777215, 0, 60, 1920);
    }
    else
    {
        draw_sprite_ext(spr_bluebarsmall, 0, (room_width / 2) - 200, 690, 400, 3, 0, c_white, 1);
        gml_Script_scr_textoutline(room_width / 2, 660, "Gods Level: 50", 16777215, 0, 60, 1920);
        draw_set_font(f_special_old);
        gml_Script_scr_textoutline(room_width / 2, 710, "Max level reached!", 16777215, 0, 60, 1920);
    }
}

if (showText >= 14)
{
    if (vgodXP < campaignScore && campaignScore > 0)
    {
        if (global.godLevel < 50)
        {
            vgodXP += (campaignScore / (room_speed * 10));
            global.godXP += (campaignScore / (room_speed * 10));
            gml_Script_scr_playsound(s_click1, 0.9, 1.1, 0.1);
        }
        else
        {
            vgodXP = campaignScore;
        }
    }
    else
    {
        if (alarm[0] == -1)
        {
            gml_Script_scr_playsound(s_favorEnd, 0.9, 1.1, 1);
            alarm[0] = room_speed * 60 * 480;
            alarm[11] = room_speed;
            gml_Script_twitch_chat_say("/color GoldenRod");
            gml_Script_twitch_chat_say_direct("/me Campaign #" + string(global.season - 1) + " Stats: XP: " + string(showCreditsXP) + " | Gold: " + string(showCreditsGold) + " | Food: " + string(showCreditsFood) + " | Honor: " + string(showCreditsHonor) + " | Kills: " + string(showCreditsKills) + " | Golden Bunnies: " + string(global.creditsBunnies) + "/" + string(global.totalBunnies) + " | Final War Stage: " + string(global.creditsStage) + " | Campaign Score: " + string(showCampaignScore) + ". GG room00Raid (Time played: " + string(showCampaignTime) + ")");
            gml_Script_twitch_chat_say("/color FireBrick");
            ini_open(string(global.platformDir) + "Core Data/Permanent.ini");
            ini_write_real("God", "Level", global.godLevel);
            ini_write_real("God", "XP", global.godXP);
            ini_close();
        }
        
        draw_set_font(f_big);
        gml_Script_scr_textoutlineBIG(room_width / 2, room_height - 160, "Campaign #" + string(global.season - 1) + " lasted " + string(showCampaignTime), 16777215, 0, 60, 1920);
        gml_Script_scr_textoutlineBIG(room_width / 2, room_height - 120, "Campaign #" + string(global.season) + " starting in " + string(7 - hours) + "h " + string(59 - minutes) + "m " + string(59 - seconds) + "s...", 16777215, 0, 60, 1920);
        gml_Script_scr_textoutlineBIG(room_width / 2, room_height - 80, "Thank you for playing.", 16777215, 0, 60, 1920);
    }
    
    if (global.godLevel < 50)
    {
        if (global.godXP >= global.godMaxXP)
        {
            global.godLevel += 1;
            startXP = 0;
            campaignScore -= (global.godMaxXP - startXP);
            global.godXP -= global.godMaxXP;
            global.godMaxXP = global.godLevel * 500000000000;
            gml_Script_scr_playsound(s_levelUp, 0.9, 1.1, 1);
        }
    }
}
