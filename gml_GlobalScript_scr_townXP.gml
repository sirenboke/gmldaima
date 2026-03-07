self.scr_townXP = function(arg0 = 0, arg1 = 0)
{
    arg0 = min(arg0 * global.globalXPBonus, global.maxNumber);
    
    if (room == r_1)
    {
        global.townXP += round(arg0 / 10);
        
        if (global.townXP >= global.townMaxXP)
        {
            global.townLevel += 1;
            global.campaignPoints += 1;
            global.totalCampaignPoints += 1;
            global.townMaxHP += 200;
            global.townXP -= global.townMaxXP;
            global.townMaxXP = min(global.townMaxXP * 3, global.maxNumber);
            gml_Script_twitch_chat_say("/me The Town reached level " + string(global.townLevel) + "!");
            ini_open(string(global.platformDir) + "Core Data/Permanent.ini");
            ini_write_real("Meta", "Campaign Points", global.campaignPoints);
            ini_write_real("Meta", "Total Campaign Points", global.totalCampaignPoints);
            ini_close();
        }
    }
    
    if (room == r_underworld_new)
    {
        global.underworldXP += round(arg0 / 10);
        
        if (global.underworldXP >= global.underworldMaxXP)
        {
            global.underworldLevel += 1;
            global.campaignPoints += 1;
            global.totalCampaignPoints += 1;
            global.underworldXP -= global.underworldMaxXP;
            global.underworldMaxXP *= 1.2;
            gml_Script_twitch_chat_say("/me The Underworld reached level " + string(global.underworldLevel) + "! (+" + string(round((global.underworldLevel - 1) * 0.05 * (1 + (global.underworldLevel / 5)) * 100)) + "%[x] enemy HP)");
            ini_open(string(global.platformDir) + "Core Data/Permanent.ini");
            ini_write_real("Meta", "Campaign Points", global.campaignPoints);
            ini_write_real("Meta", "Total Campaign Points", global.totalCampaignPoints);
            ini_close();
        }
    }
    
    if (arg1 == 0)
    {
        with (gml_Script_instance_create(100, 55, obj_float))
        {
            type = 0;
            value = round(arg0 / 10);
            text = "+" + gml_Script_scr_bigNumber(round(value)) + "xp";
            c1 = 16711935;
            c2 = 8388736;
            parent = type;
        }
    }
};
