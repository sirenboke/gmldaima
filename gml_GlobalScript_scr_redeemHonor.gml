self.scr_redeemHonor = function()
{
    var redeem = argument[0];
    var amount = argument[1];
    
    if (redeem > 9)
        amount = 1;
    
    if (global.honorItem[redeem][0] == "none")
    {
        gml_Script_twitch_chat_say("/me " + string(name) + " Honor Shop Item " + string(redeem) + " does not exist! NotLikeThis");
        exit;
    }
    
    show_debug_message("Reedem script starting");
    
    if (honorLevel < global.honorItem[redeem][2])
    {
        show_debug_message("Reedem script cancelled");
        gml_Script_twitch_chat_say("/me " + string(name) + " You need " + string(global.honorItem[redeem][2] - honorLevel) + " more Honor Levels to unlock " + string(global.honorItem[redeem][0]) + " (Item nº" + string(redeem) + ") from the Honor Shop!");
        exit;
    }
    
    if (honorPoints >= (global.honorItem[redeem][1] * amount))
    {
        show_debug_message("Reedem starting");
        
        if (redeem == 1)
        {
            skillPoints += (50 * amount);
            totalSkillPoints += (50 * amount);
        }
        
        if (redeem == 2)
            myGems += (50 * amount);
        
        if (redeem == 3)
        {
            gml_Script_twitch_chat_say_direct("/me " + string(name) + " Honor Shop item nº" + string(redeem) + " (" + string(global.honorItem[redeem][0]) + ") is currently disabled.");
            exit;
        }
        
        ini_open(string(global.platformDir) + string(myCharDir) + "Data.ini");
        
        if (redeem == 5)
        {
            alarm[9] += room_speed * 86400 * amount;
            gml_Script_scr_alarm_start(1, gml_Script_scr_alarm_get(1) + (room_speed * 86400 * amount), gml_Script_scr_updateStats);
            ini_write_real("Temporary Bonuses", "XP Bonus", gml_Script_scr_alarm_get(1));
        }
        
        if (redeem == 4)
        {
            alarm[8] += room_speed * 86400 * amount;
            gml_Script_scr_alarm_start(0, gml_Script_scr_alarm_get(0) + (room_speed * 86400 * amount), gml_Script_scr_updateStats);
            ini_write_real("Temporary Bonuses", "Resource Bonus", gml_Script_scr_alarm_get(0));
        }
        
        if (redeem == 6)
        {
            gml_Script_scr_alarm_start(2, gml_Script_scr_alarm_get(2) + (room_speed * 86400 * amount), gml_Script_scr_updateStats);
            ini_write_real("Temporary Bonuses", "VP Bonus", gml_Script_scr_alarm_get(2));
        }
        
        if (redeem == 7)
        {
            gml_Script_scr_alarm_start(3, gml_Script_scr_alarm_get(3) + (room_speed * 21600 * amount), gml_Script_scr_updateStats);
            ini_write_real("Temporary Bonuses", "DMG Bonus", gml_Script_scr_alarm_get(3));
        }
        
        if (redeem == 8)
        {
            gml_Script_scr_alarm_start(4, gml_Script_scr_alarm_get(4) + (room_speed * 21600 * amount), gml_Script_scr_updateStats);
            ini_write_real("Temporary Bonuses", "RES Bonus", gml_Script_scr_alarm_get(4));
        }
        
        if (redeem == 9)
        {
            gml_Script_scr_alarm_start(5, gml_Script_scr_alarm_get(5) + (room_speed * 21600 * amount), gml_Script_scr_updateStats);
            ini_write_real("Temporary Bonuses", "Stats Bonus", gml_Script_scr_alarm_get(5));
        }
        
        if (redeem == 10)
        {
            if (sub == 1 || fullDiary == 1)
            {
                gml_Script_twitch_chat_say("/me " + string(name) + " you already own " + string(global.honorItem[redeem][0]) + " (Item nº" + string(redeem) + " at the Honor Shop)");
                exit;
            }
            else
            {
                fullDiary = 1;
                
                for (var i = 0; i < global.totalDiaryQuests; i += 1)
                    diaryQuest[i][2] = 1;
                
                ini_close();
                ini_open(string(global.platformDir) + string(myAccDir) + "Character Data.ini");
                ini_write_real("Kenji's Diary", "Missing Pages", 1);
                ini_close();
                ini_open(string(global.platformDir) + string(myCharDir) + "Data.ini");
            }
        }
        
        if (redeem == 11)
        {
            show_debug_message("Reedem 11 starting");
            
            if (canAutoAction[0] == 1)
            {
                show_debug_message("Reedem 11 already owned");
                gml_Script_twitch_chat_say("/me " + string(name) + " you already own " + string(global.honorItem[redeem][0]) + " (Item nº" + string(redeem) + " at the Honor Shop)");
                exit;
            }
            else
            {
                show_debug_message("Reedem 11 successful");
                canAutoAction[0] = 1;
                autoAction[0] = 1;
            }
        }
        
        if (redeem == 12)
        {
            if (canAutoAction[1] == 1)
            {
                gml_Script_twitch_chat_say("/me " + string(name) + " you already own " + string(global.honorItem[redeem][0]) + " (Item nº" + string(redeem) + " at the Honor Shop)");
                exit;
            }
            else
            {
                canAutoAction[1] = 1;
                autoAction[1] = 1;
            }
        }
        
        if (redeem == 13)
        {
            if (canAutoAction[2] == 1)
            {
                gml_Script_twitch_chat_say("/me " + string(name) + " you already own " + string(global.honorItem[redeem][0]) + " (Item nº" + string(redeem) + " at the Honor Shop)");
                exit;
            }
            else
            {
                canAutoAction[2] = 1;
                autoAction[2] = 1;
            }
        }
        
        if (redeem == 14)
        {
            if (canAutoAction[3] == 1)
            {
                gml_Script_twitch_chat_say("/me " + string(name) + " you already own " + string(global.honorItem[redeem][0]) + " (Item nº" + string(redeem) + " at the Honor Shop)");
                exit;
            }
            else
            {
                canAutoAction[3] = 1;
                autoAction[3] = 1;
            }
        }
        
        show_debug_message("Reedem successful");
        ini_close();
        honorPoints -= (global.honorItem[redeem][1] * amount);
        ini_open(string(global.platformDir) + string(myAccDir) + "Account Data.ini");
        ini_write_real("Honor", "Honor Points", honorPoints);
        ini_close();
        gml_Script_scr_playsound(s_buy1, 0.9, 1.1, 0.5);
        gml_Script_twitch_chat_say_direct("/me " + string(name) + " redeemed " + string(amount) + "x " + string(global.honorItem[redeem][0]) + " (Item nº" + string(redeem) + ") from the Honor Shop for " + gml_Script_scr_bigNumber(global.honorItem[redeem][1] * amount) + " honor points! (" + string(honorPoints) + " Honor Points left).");
    }
    else if (honorPoints >= global.honorItem[redeem][1])
    {
        amount = floor(honorPoints / global.honorItem[redeem][1]);
        
        if (amount > 0)
            gml_Script_scr_redeemHonor(redeem, amount);
    }
    else
    {
        show_debug_message("Reedem script missing honor");
        gml_Script_twitch_chat_say("/me " + string(name) + " You need " + string(global.honorItem[redeem][1] - honorPoints) + " more Honor Points to unlock " + string(global.honorItem[redeem][0]) + " (Item nº" + string(redeem) + ") from the Honor Shop!");
    }
    
    gml_Script_scr_updateStats();
};
